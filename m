Return-Path: <linuxppc-dev+bounces-25194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3538C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 04:36:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBqrd0qXCz2y8p;
	Sat, 01 Aug 2026 14:36:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.50 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785558977;
	cv=pass; b=EsCp0leuyH1nJE/r7k+BagndgqebQYcArYFWG3s7LZaXzfFjh8FRrCLgAQ5TMys3jwK63fGwfZqZbg3firXwBUkW7h8usdMsdC5fjyFcpD35rkgB+ZceZyaKZIWkkPSM2A3hMopLvzRxY+zlIxolX55JMADNAcAD7Eufsc9AnF5OZoQrtYbsrEM8lMSPnyYONLfLKRWtwcKZHuDZP8nJN8BjYq4fv3CIKe/+t0Gmxtj66metdhrZAHFZlNOKAmy58DQ56V6WD5fYNl1dzcUnXpb7/nzHz2Aj1JLbnS9mrToUzLmigJ6yZObAIxf/0xK4yY2kspNJzueNbAyq4Pye3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785558977; c=relaxed/relaxed;
	bh=CrIZ4lfbVAOfl0bHgkaDGWiuEYn17BG18OIfUXCSans=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L5oFp87WfQsdHHklnaU2qJ9lbkdelCKGljF6Ruu8RFkk66foo0uMdv22ObKU5I1mtzUmyR+JFQ9RDtvQFGhjbYZDzSyvJPOLze/XG8As2M5+mMRQMVYdjd7roblFAmPbk+C0NEepwF5DalKIB4O/kBxH0LsPAjBEYpiDoZoJD0yrYC18XnynYh6AoghyTGS7se43vRkd6btbfIYMRpYnfWmvbr040qhdCC+kTS/Njy1drB+pXb78jqiE+KlCQY5835pAA8zq8AVDuRg33LJnYdr5+HrtKn4rjPUkmjRPFLUa6y+Nm67f0zqmLV/XMO4fDQ5lLl/XsaVwMqA0TQ3q+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RWgV5jg+; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mdsSVkqZ; dkim-atps=neutral; spf=pass (client-ip=85.215.255.50; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RWgV5jg+;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mdsSVkqZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.50; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBqrV6fWvz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 14:36:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785558936; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q9sQ+EQ25mRuPUrWSHj6Ts9PHyjC9GwQDO6HBsZpib9wfKUUjY5nzbnnF3XOOxR1V6
    DR9KKdWGQ6YUseR3YROnB9RvaarerHYCiQABToFXeEZ44lpMNH9dAQybVtquNUO28Efr
    TWK8Mh57bpXo0iVtMOWs0bDDU+++uHTLdiCiuBNclVDv6/qLM/srTLYaFuzMTZrB9Tb7
    Fa4AcGXeKNUYiQwAVigY+pKrwANwaLPli++5EUuCRa1Cj3fECVRzpJr/cadYyvM0U6hr
    Gnj5WOeb3oNtvwEC5T2Y7PxpU0/vzN+hc954WtpHbpu84eklXrpIUVYt81UZidX3ACfF
    4L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785558936;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=CrIZ4lfbVAOfl0bHgkaDGWiuEYn17BG18OIfUXCSans=;
    b=FjgJYiEpN82rSOygOXWkIX92T0QyqrnfD04o/668lf+DLFipluYn34h5Jzz/xFnPGN
    LwRV6F3OMiozg1G1P5U8qR6y6wiRj/hZ/wfM9ue/fkoSudP4ymY+NEqZ9Iwyt5ahYvJH
    Ze8d7ndJuPd/D6K4vTx96nDjVHW9lN/I7mHTVKpRiPDucvoGhUxQjB/r7Rw93xwVo2jP
    aZPGi2P0+VHPR7zzQKJlBp1mDVkPwA95E5r6DwIgLuMHQJzRnBpxDTFw5h0So/GrW9TC
    Eex5CTXgqV0TLVz1rjO8BXqI8kVg5Bz+ZJwYKKAu7psG+TFqTrWt0/njZmgkOByb9PJ4
    D69w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785558936;
    s=strato-dkim-0002; d=xenosoft.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=CrIZ4lfbVAOfl0bHgkaDGWiuEYn17BG18OIfUXCSans=;
    b=RWgV5jg+lEfpYEt/KhKNXnW5eVyqY9MH6xqc12fnL3RhjjNo0WjJiJsYqEdBi/nOlr
    Iaf/vXNd0qLYMSbk1Na4JUDoejneiTybLnqYdpyThy3cgvuXcDg4X4kTEotJD36rC/MU
    bHnzTqGaOrTylRNWnhWA/KjIKri5K9SCiJrnOl4IJ33ahKoyY/2OHRtk3ChN+xI9aCCc
    ilWCCYlMI82pBJNVqiLNAKs93erD3c0zz/WyisBnmUBnAgTDDyi+7jdRuQuJ8s73yjmN
    ODfWPs7TPo5Zr3OHxy3GIMjf/7CtNe9g+x4HZxNz1tYj2fSOjpd4gcOXxh2qXKQvwMP5
    MrfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785558936;
    s=strato-dkim-0003; d=xenosoft.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=CrIZ4lfbVAOfl0bHgkaDGWiuEYn17BG18OIfUXCSans=;
    b=mdsSVkqZjN8s3A9O8hnd8eh7LOuhRWNjwRaTE6Na02snngXfBPWAXe6MdAo9+SLfa/
    CHUrbZgqlzk1L1Ik/pAg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6P1rfO5KiO55fErqluWEaK7+IG9ypOCR69ab3jJKg0X4SHBrTHz54Q=="
Received: from buildhost.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id eed0ee2714ZZmxP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Aug 2026 06:35:35 +0200 (CEST)
From: chzigotzky@xenosoft.de
To: chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: rtd2@xtra.co.nz,
	madskateman@gmail.com,
	info@xenosoft.de,
	hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] powerpc/pasemi: Move Nemo i8259 initialization to pci.c
Date: Sat,  1 Aug 2026 06:34:58 +0200
Message-ID: <20260801043458.12500-1-chzigotzky@xenosoft.de>
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
Content-Type: text/plain; charset="us-ascii"

From: Christian Zigotzky A-EON Open Source <info@xenosoft.de>

The Nemo board requires the PCIe ports to be initialized before the
SB600 ISA bridge can be accessed.

Since pas_pci_init() is now called later during boot, the i8259
initialization in pas_init_IRQ() happens too early and accesses
registers that are not yet mapped, preventing the board from booting.

Move the Nemo-specific i8259 initialization to pas_add_bridge(),
after the ISA bridge has been discovered.

Suggested-by: Darren Stevens <darren@stevens-zone.net>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
 arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
 arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 6f6743b8e48d..c37e5c684bb9 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -7,6 +7,12 @@ extern void pas_pci_init(void);
 struct pci_dev;
 extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+extern void __init nemo_init_IRQ(void);
+#else
+static inline void __init nemo_init_IRQ(void) { }
+#endif
+
 void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
 
 extern void __init pasemi_map_registers(void);
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 2df955274652..fb53782da7ec 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *dev)
 	 */
 	isa_bridge_find_early(hose);
 
+	/*
+	 * ISA bridge is now active, add the i8259 cascade (if needed)
+	 */
+	nemo_init_IRQ();
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d03b41336901..c410e29414ee 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static void __init nemo_init_IRQ(struct mpic *mpic)
+void __init nemo_init_IRQ(void)
 {
 	struct device_node *np;
 	int gpio_virq;
+	struct mpic *mpic;
+
 	/* Connect the SB600's legacy i8259 controller */
 	np = of_find_node_by_path("/pxp@0,e0000000");
 	i8259_init(np, 0);
@@ -228,14 +230,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 
+	mpic = irq_get_chip_data(gpio_virq);
 	irq_set_default_domain(mpic->irqhost);
 }
 
-#else
-
-static inline void nemo_init_IRQ(struct mpic *mpic)
-{
-}
 #endif
 
 static __init void pas_init_IRQ(void)
@@ -298,8 +296,6 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
-	nemo_init_IRQ(mpic);
-
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
-- 
2.43.0


