Return-Path: <linuxppc-dev+bounces-15382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954FCCE9D48
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Jan 2026 12:16:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmRq93JHCz2xbQ;
	Wed, 07 Jan 2026 23:16:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767773758;
	cv=none; b=F0QvTP8A/aPYzNrqWDOu2+NtInPrvYpQhuv581lKTFpD0oc30VD59YJU+W53qAH9wYPicNJCb4WpNiLAoninSZCnHVp+NBEBJeUWc+XywPCbfkBm+cUV7DWsQJh4eOvNwbDoLn/fgiCW1XwFbt+LUajQcw4CetiSLVAATfRvksSIS2nDZnNt+0pY0ev/Wcrfq6lAJnX3bhbfpioxaslgB6pGhXVECAoXq/HheQDVi4p4K7Nvami8C0RnmnXWOHv2UbjOZ4gZG2DUDlAhHsNe33Kp8+QzzGedUKIRCSd2hdsIJe3hC8a60oClX+Y5g2RYsbXyxjGJcXWuuwXNdThQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767773758; c=relaxed/relaxed;
	bh=bskqrEZI3mWJPk0/2+jknOdH1/nKT2h7hO8FoQ5vtvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxkDyCm+NvM1APr1aoyFQw2pd2zIuUbDrCAU1vwWKSTyyEyqTBD17K90Dg4Z5ci36LcNm3h2cUOOhnUsv9v+Y4aWLBQeFhy7TN+Xh4NMv6g2gCgtGRQH5rZJGqtIkThkCH9SgMurjr0aCW6NGZ0mq3izTTPD+YC6UMPNmNdCWreBpkiX9E/PhC+zl3W9/aAWjlcj74QnCZQ9xwyTFCLcaE+q+dl2Pc1U//ukcEIAeDIjY30glmxYe6LxT7HP9CNkUvuIKirKmEme76ExulS9a2TZf+m7Rg/B3WqXhmOfO2L+UCl8gK3acajqyTrf0suaS26+u+EoQ3Rd8ShBUuIk4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fxUQ3Hd+; dkim-atps=neutral; spf=pass (client-ip=209.85.214.176; helo=mail-pl1-f176.google.com; envelope-from=atharvatiwarilinuxdev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fxUQ3Hd+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.176; helo=mail-pl1-f176.google.com; envelope-from=atharvatiwarilinuxdev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmLT9140cz2xLR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jan 2026 19:15:56 +1100 (AEDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0bae9aca3so15573625ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jan 2026 00:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767773694; x=1768378494; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bskqrEZI3mWJPk0/2+jknOdH1/nKT2h7hO8FoQ5vtvY=;
        b=fxUQ3Hd+lofY0pKZklPI6CUdywGR1MhFBmdK7rynplLn+noRN8gYuoObux9e9V2uye
         G4Rcb/n9eym9R1iKKYXJUqheY7oqM+KGALuNFow74RmH3HQSZ6xV3/O9WrTwyrmar8qw
         FmzgXpg66jF9bvu01G4ulermSKxemw4ZNTPAjNkbLYSistEcE3ta6Iv+Hhu0h8HL0c5S
         qp0HEKwISvtdr/rNwcTtcL1xrxm4881r6dPr7UcCaDN3zxmOUDgddte6SldLqP4/rIP8
         Ddo4fNdyTl0yy/Sk9KeRyJM010CYbdvNvXH50NuAjcHQlYMNJFHMuCjh68KzBV4Fb81Y
         Sn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767773694; x=1768378494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bskqrEZI3mWJPk0/2+jknOdH1/nKT2h7hO8FoQ5vtvY=;
        b=c8aDT/ZQ6tADsVRVBIkgdonUyHKpH4SQsWbw2Ldq82Z7LUpHWXxG1uQgEuyny3TyLI
         L3Ec8i+3pKMaou97VUTDH8+U1oZ9Bq7/p8dAbCifBqIrP94At2p2Ae70faWyy45L0lKb
         O0whgLlHzB/zsmV5XvzhEm5LdUWZyCtFKhXx+xxgM7W4TdqDYMoOWtoSadbxoeDHTX8a
         VzQFT2Oqutx/lGOLdiO9lpcVi58iov3JRW+LQvDtiDvOs8vgDDoefgzcwq/bQqNPK0MZ
         XJvaipAO8/kDBQid2YPrclvhbStC5Zbxc3BvPNTwWvS4jjKImnyeewzehnygi0f3fbuw
         h8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWZFmVz0ncp6kbU7LW2zFqzVveJ4GWwGp3rgSyOGVWA20nhVACUQrz2uo7oK1xIDhTe/YdHJV1dqWqSbGs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVhwjYLobzMNGxN5/namqYxLOEQTA8nj0rfodpxhi99E2UbVTU
	JciFgaBc1dli/n57gz2KCd3SX77O7UcSKW/H/IrG9fvaiQy+VEk/Icc=
X-Gm-Gg: AY/fxX7Tj7eL/DW07olK4q/PXCgd9lZHCzQUNmpsBJyYuS5hPbQ6pAVcgv9dLFIrVBg
	8Ve4UhJBPAiR0lXAlolRDoEqZ9O3/Rcgi8lwQHyPfWQidOrZpo7DG4PGYqxZ5FSFaNpx7cEywJX
	zCXzwG7zCuWyaAPYzgpMSl6HSSvHDQ1UUgdDOeCvChP3RU/jgZ8bUeaAu3z6H8kNJYRBqhbJJb9
	MhCLGB3C1Fj13ImQotzqlx0n4l/DTKn/Rfjdkvw7PzFwSsk9NXO5oeksgg3dZ7zKOQKC7V0vPaj
	aHldq2pWtUnTrzXNsTO21jxexyPfKFDSTToBdfBcbsheaRIN3F7lU2XB7pePv3zzqWcZvux64MT
	2jTxUyHV4ZFco1MRkQl4e9dGAp2GPzOHTZVUE4NstRJ4reaeG9jXrVBpkaV2n0KplBGNwxD4oa5
	oIAJUeKTashvLTxZ8=
X-Google-Smtp-Source: AGHT+IEVoP6pHkawjtR7Y9FSmOyxuGs7jEFf4OAW54GqLy+VY1n5OQILdfH/RXZEFEu7/SXDZastkQ==
X-Received: by 2002:a17:902:e806:b0:2a0:ba6d:d0ff with SMTP id d9443c01a7336-2a3ee452490mr16514365ad.16.1767773693586;
        Wed, 07 Jan 2026 00:14:53 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2acdsm42335445ad.89.2026.01.07.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:14:53 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Wed,  7 Jan 2026 08:14:35 +0000
Message-ID: <20260107081445.1100-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit

Changes since v1:
	Transferred logic to drivers/pci/quicks.c

Disable AER for Intel Titan Ridge 4C 2018
(used in T2 iMacs, where the warnings appear)
that generate continuous pcieport warnings. such as:

pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
pcieport 0000:07:00.0:    [ 7] BadDLLP

(see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)

macOS also disables AER for Thunderbolt devices and controllers in their drivers.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/pci/pcie/aer.c     | 3 +++
 drivers/pci/pcie/portdrv.c | 2 +-
 drivers/pci/quirks.c       | 9 +++++++++
 include/linux/pci.h        | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e0bcaa896803..45604564ce6f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -389,6 +389,9 @@ void pci_aer_init(struct pci_dev *dev)
 {
 	int n;
 
+	if (dev->no_aer)
+		return;
+
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!dev->aer_cap)
 		return;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9..ab904a224296 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -240,7 +240,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || host->native_aer) && !dev->no_aer)
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..d36dd3f8bbf6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6340,4 +6340,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+static void pci_disable_aer(struct pci_dev *pdev)
+{
+	pdev->no_aer = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EA, pci_disable_aer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EB, pci_disable_aer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EC, pci_disable_aer);
+
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..f447f86c6bdf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -440,6 +440,7 @@ struct pci_dev {
 	unsigned int	multifunction:1;	/* Multi-function device */
 
 	unsigned int	is_busmaster:1;		/* Is busmaster */
+	unsigned int	no_aer:1;		/* May not use AER */
 	unsigned int	no_msi:1;		/* May not use MSI */
 	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
-- 
2.43.0


