Return-Path: <linuxppc-dev+bounces-25585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397AAC2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:45:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGllb2Ktpz3c4Y;
	Fri, 07 Aug 2026 23:45:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.217 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786110331;
	cv=pass; b=XLK5rKIeCRmnwRw7Rr9Ji9LzneuguMi5ewk7N0vS9WEheOzHzG7F39aVbcVNsYaL9nFSL5Bio/SBWopjsyWm+pomfGfNt7Ql4cPbp44mspDOoANxzzMZ5jrPkPrwSWjw7WXhhpnBRHb0UBvUSHTTJqVIqyDba6KvYZhMnsD+3RZ27L/59T7zbjsuO4javMgn5BZEVRXtZJq8UlitcIuAPjVw+43wL7Y3pafMxFumpbvlIJPtBrd+ui8QpI5w4tFRzJbXoPvUnztUJK6ZpU19G8e8FbROLKO6SezGfrfnf9H1Etv7ncbvxKhjk3f9Ud5xqPZgJxUgzzh0fDCDulAMcA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786110331; c=relaxed/relaxed;
	bh=wTlvYcrBn4DzCykG7O27vUrWWe1916ayovF69/mczJY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=Hqx9NLnqUCAcGsvii6cnFGOdepB1g1CAKLPQZmTODXZAei5tJxzDW8AGBTtn247PwGS6mjngIx5GgtfpmvEKvkD8IT9hyE1mmCMfXS/hJMx7bYAxWjZ1ZmzfNrVnwkGEcUNYiHs4jcjH3hyUjJ1D1D8IfiAwwF2yPuWuTA12qjR7wurty2oP0w8hskwV5CJQ9PWQI7WVA2jzay8LDNs91bQtasz7hUtTXHAhf3vvwef4NsahY7aXSDBXf2ChRO+omAklk7wifqN5dIV9ioShr2Y5IpaZntotQ5cYUq/21D7NhbaT+1Qovln27Kfm6JgEosT5Om+ZqmEavQ+KpFiw0Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=DS37FhrP; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XJO2TxIH; dkim-atps=neutral; spf=pass (client-ip=81.169.146.217; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=DS37FhrP;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XJO2TxIH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.217; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGllT2SSDz3c4P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 23:45:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1786110302; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fcyN7auE6/TwZu+kd2wlaOckgyOMj8iRl50TsNymcEUk8Wr4J7usp+KPJgI+98Qqgv
    8cL8PrDOnwY2GNFJNAsa35J8DWx/p0KWdMBpS03ujQaf0GUKL65dVxPxOT6OziWR1e7C
    Iw5co90DJIES+U0pBAVIatJCfmxYrtgYHzGhg8Ln6iQbq7KMpWdBsXGcQel2qBAe9wmT
    WnShX3v1gX/pznlOAW8NGo39O4ioddiAt91dGAt6LzMwcUs/JkLT7EExuOg7e7DC3GDZ
    8XV+ewTR8ys4d5etgEUUPTDD6wAOnwLl4qRIXpukEV2b4EoDxYTDABlbDiA7GoOQVXAv
    6EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786110302;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wTlvYcrBn4DzCykG7O27vUrWWe1916ayovF69/mczJY=;
    b=RkH4eqvtY6Ae4lXlftjTDY4m9eJ4Jeb8XE/Bwtf+jyRSwEU6FurXnfvhObynJbEYGn
    1qh/FqeZtQmxAIvruav2LIrS1qpGwFn+B85WRe7yzw9/Pkppfy7dWf87D2teDToJy2ZG
    l8Jn+MeRm84RxRoEDdARE6KS0Bi+1txmCs8x1Uq352KMYi5kLcok0+9dNqTJzmgpXXy4
    fIKWcjrMp2KZuV2TuZzw5JzDQFGuugBPThUErVkxisq7/oaFmnvjt0mRQN/UHDktSCr9
    zh1/HTsI6u4xf17uVBVeGYTimDJ565Y08lpGgeH1MtwNdXKMmDxYtP3sp6liMS/gm9oP
    T6LQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786110302;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wTlvYcrBn4DzCykG7O27vUrWWe1916ayovF69/mczJY=;
    b=DS37FhrPX/eDeI++aJa8EQeN2WfyTzBqePe3VQL5KufRd5vq8LeLZARwZWc563Dhhk
    jmziGydWpvXYIk/L7Rz3zuRcFeq00KFIFbsNgF/RhNWqDpQKee4ZaJDO7cvCWcRZLoAU
    wy0qJ87HMzB4u1bHODSjMRI8puvHYeRhxgs68oOAg4UXHlAli0TRRxM1drS+lGkJqeuc
    IGy2FgbGj9LPGiXILhZnIEj3UMrt3Ys7HKu5xbs0brt96MfHsHfayBJ1iLgD7qla/+uo
    sHp2wNcfm2JcIqkvHT/3h7Y0UjShfId4lPHOi+mH02in9WMaIOUFarvZtb/9HaotH+h4
    7izA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786110302;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wTlvYcrBn4DzCykG7O27vUrWWe1916ayovF69/mczJY=;
    b=XJO2TxIHWZXqrWdcQ540foySaYCqb63DUPNpXr8dNNTMqGjGBW2Lj6OSbBT59krEtD
    ovwR4EfsI5HzSb9vadCQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5i2sy/EAHm8EU/B/pzcgcExl53fcmia6PjBx04="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id eed0ee277Dj1N9z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 7 Aug 2026 15:45:01 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Mime-Version: 1.0 (1.0)
Subject: Re: [linuxppc-dev] Patch notification: 1 patch updated
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <178610760414.26045.11804778585802359017@legolas.ozlabs.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christophe Leroy <chleroy@kernel.org>, Trevor Dickinson <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au
Date: Fri, 7 Aug 2026 15:44:50 +0200
Message-Id: <DB88E48F-F1CE-4A74-B7CD-A65ACE97EE53@xenosoft.de>
References: <178610760414.26045.11804778585802359017@legolas.ozlabs.org>
To: Patchwork <patchwork@patchwork.ozlabs.org>
X-Mailer: iPhone Mail (23F84)

Hello,

I believe Patchwork did not fully associate the latest revision of my patch s=
eries with the previous one.

Please use the following latest patch.

Thanks,
Christian

=E2=80=94-
The Nemo board requires the PCIe ports to be initialized before the
SB600 ISA bridge can be accessed.

Since pas_pci_init() is now called later during boot, the i8259
initialization in pas_init_IRQ() happens too early and accesses
registers that are not yet mapped, preventing the board from booting.

Move the Nemo-specific i8259 initialization to pas_add_bridge(),
after the ISA bridge has been discovered.

Suggested-by: Darren Stevens <darren at stevens-zone.net>
Tested-by: Christian Zigotzky <chzigotzky at xenosoft.de>
Signed-off-by: Christian Zigotzky <chzigotzky at xenosoft.de>
---
 arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
 arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
 arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms=
/pasemi/pasemi.h
index 6f6743b8e48d..c37e5c684bb9 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -7,6 +7,12 @@ extern void pas_pci_init(void);
 struct pci_dev;
 extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
=20
+#ifdef CONFIG_PPC_PASEMI_NEMO
+extern void __init nemo_init_IRQ(void);
+#else
+static inline void __init nemo_init_IRQ(void) { }
+#endif
+
 void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)=
;
=20
 extern void __init pasemi_map_registers(void);
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pa=
semi/pci.c
index 2df955274652..fb53782da7ec 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *de=
v)
 	 */
 	isa_bridge_find_early(hose);
=20
+	/*
+	 * ISA bridge is now active, add the i8259 cascade (if needed)
+	 */
+	nemo_init_IRQ();
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/=
pasemi/setup.c
index d03b41336901..c410e29414ee 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
=20
-static void __init nemo_init_IRQ(struct mpic *mpic)
+void __init nemo_init_IRQ(void)
 {
 	struct device_node *np;
 	int gpio_virq;
+	struct mpic *mpic;
+
 	/* Connect the SB600's legacy i8259 controller */
 	np =3D of_find_node_by_path("/pxp at 0,e0000000");
 	i8259_init(np, 0);
@@ -228,14 +230,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
=20
+	mpic =3D irq_get_chip_data(gpio_virq);
 	irq_set_default_domain(mpic->irqhost);
 }
=20
-#else
-
-static inline void nemo_init_IRQ(struct mpic *mpic)
-{
-}
 #endif
=20
 static __init void pas_init_IRQ(void)
@@ -298,8 +296,6 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
=20
-	nemo_init_IRQ(mpic);
-
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
--=20
2.43.0=


