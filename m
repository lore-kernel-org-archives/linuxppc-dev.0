Return-Path: <linuxppc-dev+bounces-24938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E759C54F4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 12:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8b1F2j1Dz2ygm;
	Tue, 28 Jul 2026 22:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.53 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785243057;
	cv=pass; b=QDyCJ2X9bKGUynoT9uzXlRebkOumdnOc8QXWwwJrw5Bddqibkb76OVGExWHwcZvlf1pilsxWkBxyydRtDIqrJSOcUdEJjVcYCzyou6eL6XUNNF1Tv6Eq+RBbS0uiD+PIQ4f/QHEt4eyTl4RDew3zijaYAs5pR+hVMAi6BCKrrQ/na4hoAVv/39+8Wp7nGFVByVQfSBofJYmZHuRFgQ4Zm95UdUO+QXjrbvxhO/bDwPu/nMCzRV4EBo7WaFarXqz3n+t05M3F5RPIiG0k4kkDI1N8MqjFnG5aU+VmxVW9oVlxS6nRxpZXPpEonKOy9ixBCOdVYcn6yLp1akAbKOjWZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785243057; c=relaxed/relaxed;
	bh=iWZz2i8JhyKcjU7uV9AvajZg2gmBVrrjukI2EI12+yg=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FaXEdzs6btSU2t1z4M0kdHyN7P/64YOCXeJHYuryaDNLN0+JCvHU78EBCsNaw0U4/tHPXvrJPBnNuHXNqCOmBuy0RAPRFk/3tfmRKJ74FJErnUaus3DDfNpMk9oolMURkLeGeZXWYumnJzGDQH/xxGrmvtQlCB0REnP2mGvDTrh3y4z2SnwBer4f8C/wiYR/OYNpyM/WGj4NcOes3Tih2+aTvnTXY4aKvw0iNjXpibkYHp4X6A9uVvpSLuemm5WZJ2vVZdxDudKJu5Q+TIIa0y2QxNdOuWy/BoedDutU1rW75CJlMRoTJsex0GsS0rldNex8CxRm/1lrLlOqTLz7nQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bIQisLPA; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2cfhalPf; dkim-atps=neutral; spf=pass (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bIQisLPA;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2cfhalPf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8b175k9Jz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 22:50:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785243006; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bu7+qmmzS/DHHbO5g8ZdZehMa7DDsAcJZpw69RALJBWAhir7EogG9MBEiUqEcSZ73J
    OZlZwN1849ovCMBFNK/I+q/5R0Msumd4MCNebsgpSDCTjWSKWIY1hsZmv4lweMm7329R
    4JIuejmfEpg3rRtBfgQgKK3KKvGwYCRowqOHpjIj7zrB+i/VQ9yaLU86cADUWo30H5/9
    pd3Mf/TR9rl/UdzQVCBTzvUC0O4MK0kcN3whRfYGeHLyFxboxQtYXxTmRevS5gYCnVGB
    PDTR3Qf6YcwXTCVnKEkbAA5/Kz87MaygFIdIHM1SHTevtIYfYtBAQ9UYSMxYls+ULj9e
    QIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785243006;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=iWZz2i8JhyKcjU7uV9AvajZg2gmBVrrjukI2EI12+yg=;
    b=fg7KE/mN4+HI12vYDZfDjFqklje8gdmIOpUwmMiTxGiVXIHPhVQ8uquK+6fCZTnzMe
    PlapH59cvrNB9KHjCqTFreB1ahlNOt4PrcWsUUiUAatzaS5qYiRthQQzuldQfcWjdhca
    Jjzi5jwCR9XhkOICjX1TDduogdlYQDzi/nFOhT7ei+Ig5sPf0tGwwP0gh64wIvIrwHLU
    w2TLZlZN68K4sVGm0iQhbtWG3FdGZdHJ/JSPumYTJfDYTY1RpjeTgXItOrvs6Ed4Es35
    4jtmdg4kj6M5ww0YmfwimD5fLULQ5ovKQNyCV5W+5X7vJo5mF6ZVOWYfxPfvuiUsZhZy
    iGDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785243006;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=iWZz2i8JhyKcjU7uV9AvajZg2gmBVrrjukI2EI12+yg=;
    b=bIQisLPAQjsEM0+uVWrx46H9IIOtp//qMRhfcPCU7XtojYo2U4IrlYFnxgl7+Ks0jp
    lCxXe3qXFQytrECsS0o14MPMs25BaSxwzgcdgZoE5ud0uVs4DWENHCuK8RL7xSCVb50C
    Hj4NyTDE8C4fehImZIB4yT3xQPIy1FayCx5kL6iWCHLYP4zzp43Gmm0eH7B49Q56XZvH
    MN0zetjv1knksVInH6vBpiydOVFVaPCFNF4dQFJVZRc7+I3vLx8cEK+yNMlYZKlD+w6f
    avFZ6+J45W2IiGFrDSeJQjbef2gTg/QcRKE0hAmwUHwbksekSRjjvyJ3ZgIO7vqGWI6t
    TrSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785243006;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=iWZz2i8JhyKcjU7uV9AvajZg2gmBVrrjukI2EI12+yg=;
    b=2cfhalPfcmyQgR9YWGD8hFenDHspGqQwh+VFr8cQeY2voIiylfA5jff1INuT6MY5Dx
    vGAaxeMdYCMFE2aP7CAg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+t73c="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id eed0ee26SCo5Ysg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jul 2026 14:50:05 +0200 (CEST)
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in
 pasemi's pci.c than in pasemi's setup.c.
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
References: <20260701125941.906-2-chzigotzky@xenosoft.de>
 <656742f7-ff8f-43f5-829d-5b5f0f6c8c95@kernel.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <f5ed5a79-4235-31b6-5bd9-c68d1a6b50cf@xenosoft.de>
Date: Tue, 28 Jul 2026 14:50:04 +0200
X-Mailer: BrassMonkey/34.2.2
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
In-Reply-To: <656742f7-ff8f-43f5-829d-5b5f0f6c8c95@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/07/26 15:43, Christophe Leroy (CS GROUP) wrote:
 >
 > Should be better in arch/powerpc/platforms/pasemi/pasemi.h
 >

Hello Christophe,

Thank you for your answer. I modified the patch today. The Nemo board 
boots without any problems if I compile the RC5 of kernel 7.2 with this 
patch.

Could you please check the following modified patch?

Thanks,
Christian

---

powerpc/pasemi: Move Nemo i8259 initialization to pci.c

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
v2:
- Move Nemo i8259 initialization out of pas_init_IRQ() and into
   pas_add_bridge() after the ISA bridge has been discovered.
- Change nemo_init_IRQ() to no longer depend on the MPIC instance passed
   from the IRQ setup path.
- Move the nemo_init_IRQ() declaration to pasemi.h and add a no-op stub
   for non-Nemo builds.
- Fix missing prototype warning reported by Christophe Leroy.
- Fix indentation and clean up the commit message.

diff -rupN a/arch/powerpc/platforms/pasemi/pasemi.h 
b/arch/powerpc/platforms/pasemi/pasemi.h
--- a/arch/powerpc/platforms/pasemi/pasemi.h    2026-07-26 
23:45:48.000000000 +0200
+++ b/arch/powerpc/platforms/pasemi/pasemi.h    2026-07-28 
07:44:31.924168227 +0200
@@ -7,6 +7,12 @@ extern void pas_pci_init(void);
  struct pci_dev;
  extern void pas_pci_dma_dev_setup(struct pci_dev *dev);

+#ifdef CONFIG_PPC_PASEMI_NEMO
+extern void __init nemo_init_IRQ(void);
+#else
+static inline void __init nemo_init_IRQ(void) { }
+#endif
+
  void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int 
offset);

  extern void __init pasemi_map_registers(void);
diff -rupN a/arch/powerpc/platforms/pasemi/pci.c 
b/arch/powerpc/platforms/pasemi/pci.c
--- a/arch/powerpc/platforms/pasemi/pci.c    2026-07-26 
23:45:48.000000000 +0200
+++ b/arch/powerpc/platforms/pasemi/pci.c    2026-07-28 
07:34:37.036634023 +0200
@@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct
       */
      isa_bridge_find_early(hose);

+    /*
+     * ISA bridge is now active, add the i8259 cascade (if needed)
+     */
+    nemo_init_IRQ();
+
      return 0;
  }

diff -rupN a/arch/powerpc/platforms/pasemi/setup.c 
b/arch/powerpc/platforms/pasemi/setup.c
--- a/arch/powerpc/platforms/pasemi/setup.c    2026-07-26 
23:45:48.000000000 +0200
+++ b/arch/powerpc/platforms/pasemi/setup.c    2026-07-28 
07:54:54.147863161 +0200
@@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct ir
      chip->irq_eoi(&desc->irq_data);
  }

-static void __init nemo_init_IRQ(struct mpic *mpic)
+void __init nemo_init_IRQ(void)
  {
      struct device_node *np;
      int gpio_virq;
+    struct mpic *mpic;
+
      /* Connect the SB600's legacy i8259 controller */
      np = of_find_node_by_path("/pxp@0,e0000000");
      i8259_init(np, 0);
@@ -228,14 +230,10 @@ static void __init nemo_init_IRQ(struct
      irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
      mpic_unmask_irq(irq_get_irq_data(gpio_virq));

+    mpic = irq_get_chip_data(gpio_virq);
      irq_set_default_domain(mpic->irqhost);
  }

-#else
-
-static inline void nemo_init_IRQ(struct mpic *mpic)
-{
-}
  #endif

  static __init void pas_init_IRQ(void)
@@ -297,9 +295,7 @@ static __init void pas_init_IRQ(void)
          irq_set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
          mpic_unmask_irq(irq_get_irq_data(nmi_virq));
      }
-
-    nemo_init_IRQ(mpic);
-
+
      of_node_put(mpic_node);
      of_node_put(root);
  }




