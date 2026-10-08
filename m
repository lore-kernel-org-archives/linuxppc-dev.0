Return-Path: <linuxppc-dev+bounces-29057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975AECA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 12:26:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0q3d4Td3z2y8r;
	Thu, 08 Oct 2026 23:26:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791462381;
	cv=none; b=Z4pN3rh0UpGUKEdxVYY6PUBtXcjqlDvKozpnivsQoytnvdAfPJTdlqgVXAsaNk4PRii0tjYZhkwP/Unuqeu19sutfzDv+u8p1jpPN3jlRiT66kQ7rLw8fCjm4tvghEbyeq+9Dti15L/ns+oXNgPGe+R1PsOHeSa3VhPVwb1S5/4LpSnpwIk98+zeCzcAFGbpdwGvPLj3R6hgvvwWxt1jQ6WwN8YEjoJBL/pd88oxiMcmu3JcR6C/vcsIzEmLiMu9gVDkZfBg2hZ4CpmIYErDV57o+lhovI78Dd+cbN1RzFashZpUrPJ/z8qnLMNyD3ahNxacSMtuhqN1t7dwUlUbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791462381; c=relaxed/relaxed;
	bh=/GfpWXwAOilJ4rkEDqTPKgUj9LGTGNX3kHGPlnWrKC0=;
	h=Message-ID:From:Date:Subject:To:Cc; b=UIVe/tHuTXje4EHL89XySMLgfBSWJPEtY6b4xDcxzivqQ0exs7xZsFD62+zrUV51R2zU3VgnnEtwJfzbeuJDqHPtt37DfbU8I3eRoD4A4RpGiHlxOr2Z7I/frGSs+MZeszVjDYgJCHBylOAGDwZpDqTdpivgJ5u5CsW5ndQq/rp687PqHBmxPJ7ma/v7ViAo5rPqzWady0IBlLtPwoGttwFMd4ETtHcVMvPhfkrb87AcdleCzRc1A370KdbvDeptEWKWiJopYrHIMhk2sz+isjY9KII+PPv+4+V7l49XJru5hWx2upEAfuxSZPoqghPNd+xb5sm9QUfGiZkt01ZzjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0q3b4w2xz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 23:26:19 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 12987390;
	Thu, 08 Oct 2026 14:26:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0BE12609B7A5; Thu,  8 Oct 2026 14:26:02 +0200 (CEST)
Message-ID: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 8 Oct 2026 14:26:00 +0200
Subject: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexdeucher@gmail.com>, Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, Jason Perlow <jperlow@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Alex is seeing a probe failure of the amdgpu driver after the Root Port
above an AMD Navi10 GPU has been reset.  The reset was performed to
recover from a Firmware First reported Fatal Error.

However all status registers in the Root Port's AER Extended Capability
are blank, so apparently the platform firmware raised a false alarm.

The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
Errors causes code paths to be exercised in platform firmware which
were never validated before.

Skip error recovery on false alarms, i.e. if no unmasked errors were
actually signaled.

Note that this will also skip recovery if both the Status and Mask
registers are "all ones", as would be the case for inaccessible devices.
However that seems justified because it would imply either a hot-unplug
event or a Surprise Down Error further up in the hierarchy.  Interfering
with recovery from that seems uncalled for.

Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
Reported-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222095
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 When applied to pci/for-linus, this will cause a conflict during the
 merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
 Fix memory leak in aer_recover_work_func() when pci_dev is missing").
 
 To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
 and move the pci_dev_put() out of the if-clause (so that it gets
 called if pdev != NULL but err == 0).
 
 If this is all too complicated and/or late, I can respin on top of
 pci/aer or v7.4-rc1.
 
 drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..922a726a52a5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_recover_entry,
 
 static void aer_recover_work_func(struct work_struct *work)
 {
+	struct aer_capability_regs *regs;
 	struct aer_recover_entry entry;
 	struct pci_dev *pdev;
+	u32 err;
 
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
@@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		pci_print_aer(pdev, entry.severity, entry.regs);
 
+		regs = entry.regs;
+		if (entry.severity == AER_CORRECTABLE)
+			err = regs->cor_status & ~regs->cor_mask;
+		else
+			err = regs->uncor_status & ~regs->uncor_mask;
+
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
 		 * allocated from the ghes_estatus_pool to protect it from
@@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
+		if (err) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+		}
 		pci_dev_put(pdev);
 	}
 }
-- 
2.53.0


