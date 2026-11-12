Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A03606A32E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SRinRKR7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ5Gz5S0Gz2yNj;
	Thu, 12 Nov 2026 14:19:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794453595;
	cv=none; b=J9DglaSimTw4zLjHMc/1oFF9u5PG8urSP2lk/mZsK/y0yNKM4rzkq6q3TMH4KIGOE7fRsDWblHx5rwGJvdj+JjqtVtzLIbOX8COv6OLhMF2mdT7EW/YswFevhdOlb1nsVuudahtsss0aY9Px4i8HcvO9QMMXqv+Nc2Ri8jyXggx1yEbPT0c66O/RY2MJrjzQV/aR6b3VkqpZ1kkNsOXJmftGK/w/QLsGmNHE2OrA/LDx/qMxq07glvcSFOob6rIqKB8kwFTi+YozWRJJeqnA22Idwx1ttmJqnvV3LsCScJPEXw+mPnt5mIArDeZ/aIg1PI2QnWRdiee5EoyOeLNfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794453595; c=relaxed/relaxed;
	bh=giw4mW93rfat/G8zkpSBcz6EEoZBAskBreXvXku5LzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2nHufDLoyydzzfPp08mU1vZ6+MXdWeSbvyf9m0LsLlVyDJQndPRQcvM3feLLUg20+nAn0g0A0eNmJpsqrmC7dTunFa6g0Pq8dVQrz5tcOKSkvx2lQIaZstWTdsGIIeRHRSSE2pigKjoSLBvPb/YDRkKOs8u0Lq2pw+XYvqnnbHoRduHpDXi2Ek985aS7EhJFwWiqmyDrdNwRuahGODpmJewE9WD5+nevQGSDH0PagoRCXPlwBoehg/QdiGeKaknqVGg1ShWvOXMHCCSKKd4qAIzW9jVUxUJyEoz1qXkHT5jenkeVnGacNGHTpTFLH7VNCkD2DIfrJ4xyhwfKNV90A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SRinRKR7; dkim-atps=neutral; spf=pass (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SRinRKR7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ5Gv5Tb2z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 14:19:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gi
	w4mW93rfat/G8zkpSBcz6EEoZBAskBreXvXku5LzI=; b=SRinRKR7nIce2Ni26y
	l8XPA5iXwihcVcA4oO9OR0VLgmr+2cbMfm2ZIq+9UZp5udLtKDyhJ/q812dHGkle
	oYmSllFLBT6/hYNdbNvjw2w4n/HAlzWwl1Tpk55s09GnjQveLaoJJAHR3PeFFnv3
	DiTwTD1B0L6NkmArV0IXua3VU=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXD8o6MPVqh72fHQ--.23678S4;
	Thu, 12 Nov 2026 11:19:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 2/2] PCI/AER: Use pci_clear/set_config_dword to simplify code
Date: Thu, 12 Nov 2026 11:19:21 +0800
Message-ID: <20261112031921.1255661-3-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112031921.1255661-1-18255117159@163.com>
References: <20261112031921.1255661-1-18255117159@163.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXD8o6MPVqh72fHQ--.23678S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDAFyxZr15CrWUGw1rZwb_yoW5Xw1xpF
	W3AFWfAr4UJF15ZrWkWa4kJwn5AF97t34fKr93Kwn5XF4UuFZrJ3savw1UJ345KFZ5Xryf
	Jws5Ka1rZF4UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMyxRUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x4z1mr1MD4jTwAA3t
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace manual read-modify-write sequences in multiple functions with
pci_clear/set_config_dword helper to reduce code duplication.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8708ca3257bb..7ce1cda8bc80 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -201,14 +201,12 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 static int disable_ecrc_checking(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 reg32;
 
 	if (!aer)
 		return -ENODEV;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
-	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
+	pci_clear_config_dword(dev, aer + PCI_ERR_CAP,
+			       PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
 
 	return 0;
 }
@@ -1272,15 +1270,12 @@ static bool find_source_device(struct pci_dev *parent,
 void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 mask;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
-	mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+	pci_clear_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+			       PCI_ERR_UNC_INTN);
 
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
-	mask &= ~PCI_ERR_COR_INTERNAL;
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+	pci_clear_config_dword(dev, aer + PCI_ERR_COR_MASK,
+			       PCI_ERR_COR_INTERNAL);
 }
 
 /*
@@ -1682,23 +1677,19 @@ static irqreturn_t aer_irq(int irq, void *context)
 static void aer_enable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+			     ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 static void aer_disable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Disable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_clear_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+			       ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 static int clear_status_iter(struct pci_dev *dev, void *data)
-- 
2.43.0


