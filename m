Return-Path: <linuxppc-dev+bounces-22723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BACCD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 16:31:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfsvH5Z3cz3c52;
	Wed, 17 Jun 2026 02:31:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781627499;
	cv=none; b=Zrs1Nxl77sWvASrsfh3RDB4e/B3gksU+ohrraqe7I+Iu5cEDl+EynHIEJxpnZCk7ybf+8g0TEaRL+Mh+FAz/nvcAl7omHF2E+cqOdPSmTn13cRnADiBsCDgQ8vtip62Xf8VptSCj7m0Y27xUc1t4+EYNiAjWS5c5D1wtJRDDlSQpGX6UtHFg40stgdbBC5eS78nVwk1/fHmAflb5GWVqBBJyHe9DViN6I39E2IdLFESnz4ToUeKryj0cCQSvkUSvGBsomNtXGFJBRKBoHAWj9CaSStOdBFRNiKEB5VA0sqciJDq4yixMcYvkoU6CKj6bhfhDN1fiA62vTfpvCevGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781627499; c=relaxed/relaxed;
	bh=rfOBWu4WGt30uIecGlCElGeir0L2JNoVF0lc9QokdN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcAoALu7ftDDiyULbSaIyj2MJj/4qzqYLXbO+kYegKLMEdYzBjnVvCj/FSoHF0j6mmkOz7rjEIzA12YBopslkiK5N13E4/wnOzBS/KaAywGKTV8fNnj00UD4xSpAu/bDJb3yVGE1ofbm62oPb7rpXIRmcwzwnivfnFvrgaTf7MUj6NCJTMKcYtvO15bVQVSqgl9OJfIVADmtiiQiJ+azHCMZr0FU8hW4E2Otiwke8JhNUDiBOu0kfA/xxrS0a7Dts1HRd+vE8Nx8iJ+ldBG1Lj6gH62mEf3No6njGVurxSlyNa4Jau7PqnbY59ZrV7gbQ/fuehubCKGOE4dAu/SfMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/MOK4O6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/MOK4O6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfsvH07W1z3c3l
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 02:31:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D77DD404DC;
	Tue, 16 Jun 2026 16:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA8E1F00A3D;
	Tue, 16 Jun 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627496;
	bh=rfOBWu4WGt30uIecGlCElGeir0L2JNoVF0lc9QokdN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/MOK4O67K2skWmmisnBHBY2zXyU2PEUqFqnMpM3Ssx/4ta+m1Z64wnKK20cj7xSx
	 zoGibbH8IrTbIqXUXh/CoULhJRb6+2U42n08leeoyCgsRgSqHT3XYOX2FJh36iQEpx
	 SaXwoV2yCASCywmxxilxS/4cmUD3sB/PkJtP2z0hNqeZyjdJiIfxdmORa80a/2zb6M
	 Xj8vwybQcgHTuGSR9e93u5KkOXOsTOkW0zTVgUi9JVia4FjORIZOclxSa1vSt5DTws
	 BFHMYnUHcK9AZeEVMW8fC1SPJOS1TTV/cVjt6PNBwXAIY1qk/yx9dFXhOL8QepIyIn
	 mJhvf+DlTMa2w==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/sysfs: Fix read byte order in pci_read_legacy_io()
Date: Tue, 16 Jun 2026 16:31:31 +0000
Message-ID: <20260616163131.2763281-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616163131.2763281-1-kwilczynski@kernel.org>
References: <20260616163131.2763281-1-kwilczynski@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_read_legacy_io() passes the sysfs buffer directly to pci_legacy_read():

  return pci_legacy_read(bus, off, (u32 *)buf, count);

The PowerPC implementation stores the result as a native-endian integer:

  *((u16 *)val) = in_le16(addr);

On big-endian PowerPC this stores the bytes in the wrong order, so
a 2-byte read of a device register returns different bytes than two
1-byte reads at the same addresses.  The same applies to 4-byte
reads.  On little-endian the native byte order already matches PCI
I/O port byte order, so the conversion is a no-op.

Thus, let pci_legacy_read() store into a local u32 variable, then
copy the I/O port value to the sysfs buffer using put_unaligned_le16()
and put_unaligned_le32() for the 2 and 4 byte cases, converting from
the native integer to little-endian byte order matching PCI I/O port
space.

No changes are needed for the Alpha platform.

The legacy_io file is root-only and exists only on Alpha and PowerPC,
the two architectures that define HAVE_PCI_LEGACY.

Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b56000ba3a33..2354d09fd3fa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -908,12 +908,30 @@ static ssize_t pci_read_legacy_io(struct file *filp, struct kobject *kobj,
 				  char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	u32 val = 0;
+	int ret;
 
 	/* Only support 1, 2 or 4 byte accesses */
 	if (count != 1 && count != 2 && count != 4)
 		return -EINVAL;
 
-	return pci_legacy_read(bus, off, (u32 *)buf, count);
+	ret = pci_legacy_read(bus, off, &val, count);
+	if (ret < 0)
+		return ret;
+
+	switch (count) {
+	case 1:
+		buf[0] = *(u8 *)&val;
+		break;
+	case 2:
+		put_unaligned_le16(*(u16 *)&val, buf);
+		break;
+	case 4:
+		put_unaligned_le32(val, buf);
+		break;
+	}
+
+	return ret;
 }
 
 /**
-- 
2.54.0


