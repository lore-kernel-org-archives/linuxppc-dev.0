Return-Path: <linuxppc-dev+bounces-22089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A6FCD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlSy2z4Xz3brB;
	Fri, 05 Jun 2026 12:17:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585333;
	cv=none; b=D0xOnmKfAqMQQjKXvpA8u+hSGW7wku2nmrBmhTsW/6z1YS8tkL1LYCAWzOo+5KwbUNRzsRQRRdEB78VW7kRQW0YLV/Yylkjbq0r3/Nww3mL+7lfkPT33daoN0R0wl/zLDFLE8TdbodhzI3KTG8xpzPyPUc0siHWtxVQnHhIq8vaW8hNoVuQXkfj51VBVVz6KWL1tmTsDRUl2a3pmfO0DBWEDDquxbr4/e+TADDu+ujdWsniOoYt4wb4TokzkamnkvUOlvynuGZlmx22DLTwFyNeCGO9rTOisYYI4VYd/N1Wf2G5D5XZD1JyW96pdooEpHrATr2NeZprsd4yfg0wN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585333; c=relaxed/relaxed;
	bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5tnDiASofAyX+4QHwpOgvItsc1t4iBdNq8Z6Z3BxIwOE0oyHRU4ua6E7l3NGlX2IjoBXbUfq6ewxxbrK2hESXCRHX+HZDQZz1CaRekoCx36+BDcpuVQ21CiQBZU2EutZWBlHMTTKUAYuZVAP4U4z8l+aZzvqjORaiDV7qCX0cwyNAt6/7ZjGugLpVScoCe2rDc8noASuFe3jcljtTGWPVJn9wx+bv2nfqIo14n1dbMAkxeONiIEtB1KyNyRSO1OqZimniJuRPGNjHdeOydYVwKu9JikqF0lF+NrGj3uLdGL7Ck/1xD52n2M7uRvgH0A+/Zhgjny3MRhunH6KdiyJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z2An/deN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z2An/deN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTc2CzSz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:12 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso6078695ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585330; x=1781190130; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
        b=Z2An/deNVa839wXMut9cSmz+ZyRa9dqJErSLqlR18Cl062th7UBdMI86+d+06nGJ9W
         dJWMqljRERW6dJA9zjfrSQ0pR7BSzTCi17Molh16TVeppumDgCRiq4GAowzP8oHJc3Us
         MAZ1uz1I8LWGl+YWJ+kyybOlbCMYRc7UVtHzk8AUu+Qo6mVsY2vfJ8gokkYBLWnKA3YC
         e7GXE3LYCaEf2uDGNsozHvWmPSugcrRWQuDjzbL80lSDLAQcNUJvNZTcJg7CfIegS64D
         CTvdhadddTRgIn0/F4Rx4KYEVEmVk0VOpX+0rCktUXIVtcB1tJh4IApe/D73I5/V2FMr
         m37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585330; x=1781190130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
        b=fBPcQzZv5+xUDHBeWnWrzHcvTVizEFDwfCxSCs2kgfQ+rx+G+NfZw9Lc6Dpyuly7ze
         bc8apu4uOzmR9r8rMtJ9pWCwwsuDLJEVNkJV1NY2ybbK65LcWs6uAyH0U6pt9CewIvnR
         HWq+Y2KZtj7fEMxiIuaGP7znfweb7oFz7T91M+ApEh0T37nQE6HRiQoU2eNTCEzR8T1B
         ZSEt0qU5J5ByW9OA/1kMa4/DTCIabi1RZ6oGDLiFIG83N6u/QBphQIe+AVxMvDvdtLNr
         gTjbP17yrzUOw0yweWcFgANxr4NY8w1AZPNyXLEoFZEfaFQwZIAg3xkqSK1KaUMSVE5R
         bi5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+rdkzoxgQyo7Ak31WES0gbpUuHsS766B6hK5tADuG6wVdhUhMKPSBmW1rZo232baZO5Coop75y07a3uJs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoAO7Q02DiaR7D5NjpHRVKRBk9wcw5a4Sa14k6UuwYxtJfk/dB
	AMJpJXbyXNoaPBc5I/iXiOxqcNNSfIwDPIAqok8r624wQOtUWsIs8yDF
X-Gm-Gg: Acq92OHZZQ5y93LD3c3tJJzVf1rgz053Pdl0I9FpD8vx5qtZeavpDN9rlUHsEiQtbqw
	8PRkMx2kYcfhcBOSx6h+XkV+WCLyhvm0QkjzihxoirYna04fu1UCEDLmpJWIhiZ6v82otcwcbAf
	hpjFwk7eZXotie1RfjvtcJSym/nXgj9erMXZHzCvAJbcuK1ULYLqeEM2K21QziTgC+BvxoidaaK
	Ivx5mNCesej6PK5C4HwfRqBLu4eEkUYhNHAR/zJs747Qb2sbYffz7LFn1WvDDGT/FyDbfvAXPqN
	/XRpEUGBv0BuPxDjoxuJMYF3oWQYfoWD4OXDV+2i/xO+hsWstBTQPasen35nQ5HKZkNrBo51h8u
	IwjuqAB3dgklzIsTMj0oBw+BzqsxUdmxvHuZePbC2FnJgeXC11bb9NeYwE+xTD/veD4kAFkciwa
	0ORni64uP1opgkHDFioL2VqgBHbgZIg3pFI+XYF3RQVknQFynN
X-Received: by 2002:a17:903:1b07:b0:2c0:eee2:fc45 with SMTP id d9443c01a7336-2c163a28b9fmr86640905ad.4.1780585329440;
        Thu, 04 Jun 2026 08:02:09 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df79sm62219485ad.42.2026.06.04.08.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:08 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 09/12] PCI: Add helper to compute VF Routing ID to pci.h
Date: Thu,  4 Jun 2026 08:01:50 -0700
Message-ID: <20260604150153.3619662-10-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

The VF RID computation is identical for SR-IOV and SIOV. Add a common
helper so we can share the logic across both.

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/iov.c |  8 ++++----
 drivers/pci/pci.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4aed4f6a42c3..5d65413ce98d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -25,16 +25,16 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
 	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
-	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
-				    dev->sriov->stride * vf_id) >> 8);
+	return pci_virtfn_routing_id(dev, dev->sriov->offset,
+				  dev->sriov->stride, vf_id) >> 8;
 }
 
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
 	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
-	return (dev->devfn + dev->sriov->offset +
-		dev->sriov->stride * vf_id) & 0xff;
+	return pci_virtfn_routing_id(dev, dev->sriov->offset,
+				  dev->sriov->stride, vf_id) & 0xff;
 }
 EXPORT_SYMBOL_GPL(pci_iov_virtfn_devfn);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 73b913bcb87a..45411960fd2e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1017,6 +1017,18 @@ static inline int pci_resource_num_to_vf_bar(int resno)
 }
 #endif /* CONFIG_PCI_IOV */
 
+#if defined(CONFIG_PCI_IOV) || defined(CONFIG_PCI_SIOV)
+/*
+ * Compute the Routing ID (bus/devfn) for a VF or SDI under @pf, given the
+ * capability's offset and stride.
+ */
+static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
+				     u16 stride, int id)
+{
+	return (pf->bus->number << 8) + pf->devfn + offset + stride * id;
+}
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
-- 
2.52.0


