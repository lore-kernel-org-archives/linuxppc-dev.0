Return-Path: <linuxppc-dev+bounces-29162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D963CA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 22:52:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1hvS3J15z30VV;
	Sat, 10 Oct 2026 09:52:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::26"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791573753;
	cv=none; b=U7AOkTvJYTyBx4cOGy8d5SwvfVCuiQO5BZBwAB4UTHvTF4E/onkgBkgtTxTfuv7MNzc/zdxkRgMkSQSngw7T2NCY0LFWNd6hRQZJIlf0RKcFaisHUNybeW/Cx+NSTs6yCx3V3HT6GkD+L7zaVrVqVNQx+FlBg17+21QECxCR1Xwm/pvEgt3fkOfQMOGtkqAilF22tHm/CFK7zdp265RsSTX51KCp9EWvAFE3kiOlIXBqITseH0NzWmgxN/3FU9EHyplEuBJ1bHbRHxpQnVuKyzTAp6XL4ZX6XhnSDIBEtMV/4r+4PJHF8KvzG+sgjqI1cKBkga0DjiFRy18XCaEhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791573753; c=relaxed/relaxed;
	bh=u6yeEapMgwycRzSyEC0seM4mKDlXEyJ4M4qX+KA0qE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+XB8P9kKFf5oum2e9KQkb9+YDaSGcSXsHAN598oJK3Q51kPZwGg6zv5HLfVcLyUtfb4N1yWYfKcMTwRYEtgSBzbEi1m+NkjfRp4MVcNck0muBFuN5Xw9iXdxcekbl+9MpJQAC0vh/oXiu4Oom/NCYl9wtDH8iRBVr/cWoEmAJgKAuzU0ZelnvdJGsIGSD3+VmEhIe+4O5NnfFQTV2eJQqfyznjNc/7CAzqu6FcqRe9mw7WJG2BORI8oiMsCEmnHHyQFQgJx3HlQfW4Mn9PyumHL5y0nC0YPFpoygtrQg+vzqhi4OstzB1XTHajC0qVLLLphXZ/wgfMQExmQIRUwmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u6JysYzL; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::26; helo=mta1.migadu.com; envelope-from=aditya.garg@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u6JysYzL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::26; helo=mta1.migadu.com; envelope-from=aditya.garg@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 78 seconds by postgrey-1.37 at boromir; Sat, 10 Oct 2026 06:22:29 AEDT
Received: from mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1cFK0F1tz2xwZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 06:22:28 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=oOwGbuDH4is48yWx6pl2bm046cUQPMcDmLWPHdbtGuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791573730; v=1; x=1792178530;
 b=u6JysYzL3h69gsv3dMDzI6611i7zEIoC643C2hJte6mhG/B8FU8GLPjsEbYmpE7IR/DBxckq
 b5s4UWPubttP50qyoHkw8smmgp6rq3+cbBCtP3UFBxldcnPHOw+K+dW7jUdo5pinHjdTRUCglXn
 e98ugNWuzuDgmNWdS4DQ+v+0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 7f7139aa950e2d35;
	Fri, 09 Oct 2026 19:20:36 +0000
X-Mizu-Trace-ID: 7f7139aa950e2d35
X-Migadu-Flow: FLOW_OUT
Message-ID: <497eb268-656f-49ab-8df0-83ede5b36a81@linux.dev>
Date: Sat, 10 Oct 2026 00:50:29 +0530
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org,
 Jason Perlow <jperlow@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas> <ash0Rn78gwlQ87Fg@wunner.de>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <ash0Rn78gwlQ87Fg@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

> I think the firmware on the T2 is upgradable in principle, but Apple isn't
> going to do us the favor to fix it.  So we don't have any other option
> than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> the first device on that blacklist and maybe others to follow.
> 
> I was going to work on this for the remainder of the week, but if you feel
> the feature needs another cycle to mature, I have no objections to
> reverting eddba19b8b5f for v7.3 and re-applying it together with the two
> required fixes to pci/aer.  (The two required fixes being the one for Alex
> and the one for the T2.)
> 
> Thanks,
> 
> Lukas

It would be nice if someone could test this patch:

-->8--

From 88c681d745931ad8b0199a490dc0278bf2a3df9b Mon Sep 17 00:00:00 2001
From: Aditya Garg <aditya.garg@linux.dev>
Date: Fri, 9 Oct 2026 19:17:02 +0000
Subject: [PATCH] Quirk

---
 drivers/pci/pcie/aer.c  |  3 ++-
 drivers/pci/quirks.c    | 12 ++++++++++++
 include/linux/pci.h     |  1 +
 include/linux/pci_ids.h |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 922a726a5..cab195f7c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
 	 * 7.8.4.6).
 	 */
-	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
+	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
+		!dev->no_aer_anfe)
 		pci_clear_and_set_config_dword(dev,
 					       dev->aer_cap + PCI_ERR_COR_MASK,
 					       PCI_ERR_COR_ADV_NFAT, 0);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda..acca89532 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6422,4 +6422,16 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+/*
+ * Unmasking Advisory Non-Fatar Errors on Apple T2 Secure Enclave
+ * processor leads to the Mac shutting down spontaneously. Avoid
+ * doing that.
+ */
+static void quirk_no_aer_anfe(struct pci_dev *dev)
+{
+	dev->no_aer_anfe = 1;
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_T2_SEP, quirk_no_aer_anfe);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..83ffa5058 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -514,6 +514,7 @@ struct pci_dev {
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
+	unsigned int	no_aer_anfe:1;		/* Don't unmask */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2b..103024f74 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1007,6 +1007,7 @@
 #define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
 #define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
+#define PCI_DEVICE_ID_APPLE_T2_SEP	0x1802
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
 #define PCI_DEVICE_ID_YAMAHA_724	0x0004
-- 
2.55.0

-->8--


