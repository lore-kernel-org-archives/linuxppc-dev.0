Return-Path: <linuxppc-dev+bounces-23308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FCCC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 13:03:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr0ZD2p1hz2xKh;
	Wed, 01 Jul 2026 23:03:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.167 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782911012;
	cv=pass; b=mQ82eQUY4wSM/UowUsCw10YTzC5+pBeM08LwyH67J4P6jVkJGrgtPXUz/ABaDXgFebNhe+J9tijpQElLJCC4IP097ufSVCJh3gmILLGoAJqM82rgnzJpSmUTREoEtP7tlhPFF8stWdhClcW9h1Xk5NcrKo1HfSz1VSnLMlcpM/Jzxh9190JcKdQq3JvmK7jnqF73ua60dBklvST6/Rly3A3HKvvz9tbEpSEFd5Owo+xRBOilCais1woCD2oca2W+BhZC7D5wuJDmt6GvpeBNHRewluR2GZuIxiWfmWAw7jNJPtUnVDN0HyE/LLg1wOASMTxelZ/3RYUAvIbHXqFRGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782911012; c=relaxed/relaxed;
	bh=OqS7JdQx7tTfTDLzYeyQS7i7uzlya/tTdulabjgUEaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3f65L0l0B92vNcL7M0UPDD4E6zrfcyz6nVjT/w7op/vVnxkJtj1vuAoGefZurovKYs/N9jxtpi1lze2uYEvPY8Jy9lU6xxO4GSaZRnEKrZjQFBNv+9HeJFA9WSPnJj2Lto/5qoUw/OX5LT1E15IPmcmOO9V6SzMZqtKbE40ueFx4Xic/qGO6LyUYKmE6S3GPgFWGNBd6UDHZjrDtWGYzQjx3+IWKS+8Qmd6/bdvhz09DT1Q37vwtZDfr23utZGZhl0GKHrxMp6LwnKZBoia8wE0TCaYuxn7vbFDF543W5wnM5cFnog2N+TiiInkOlf7GSbnz1ZxfimVzu2sgT+xDg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ozks6cbO; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Sgmlng3o; dkim-atps=neutral; spf=pass (client-ip=81.169.146.167; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ozks6cbO;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Sgmlng3o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.167; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr0Z763dyz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 23:03:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1782910811; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h3bTaYIBgAgvrsHq0mc1hGetI3lk6+bXva78BsSp/PPJawlSbtYKhxnFGNlivI7Gys
    DW5eTCz0s3MeM6XFqHR+tte6FEAQvEuvwwNhg/rYGCtC1Ot2ItRSGVO+wm1rA52cfp+S
    EbdFKN3q7p37dalriDTOf1IU/eb0UuWpCxQF9ZbTlTWLnljCNBKS63GaUP3/Imc261On
    5p3BjULCml/3SKWWpRZOt6yI+KBJfPkYjNJlYQtC7BUra9V9RrOnyl4wVCI4ZLlflUYe
    P8/qjOOV1VoAjjMcc22FxTSQHaQ1vdH46u92H4jRIbOm4n6NawogAyFpIMsfBpX3/ycM
    02IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782910811;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=OqS7JdQx7tTfTDLzYeyQS7i7uzlya/tTdulabjgUEaE=;
    b=BYqYoHiRvwJDsXGLKtjMxf8WKrQS+2WOy5u0lY8NQ3DECxA/fiF8NcSY05oBKtttjh
    DnxoeVYW9YhttCWE+JZHXMreJFYnvITJeMN7nSw5DmpJgYPu6NggolRcTbjR+9PUteRw
    ZdV5ufxemlKwBiFQYlha0mSatFCYkek+CYK85PkVjbeL3aO4JZqTcGJXskK5YElOJBT1
    AHn1ocsK/32HN5Lcar7auU8kEVoedQ6W+8hxlF6UDFEQniuX7M7csOf1CMhscUy9Sf8Z
    82FokQYLxnyNLS4VZ/AyrV2HuW3GwmAErSROyVtDshjQagKjDFd6B+zIjNGSlUnZaKth
    0lGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782910811;
    s=strato-dkim-0002; d=xenosoft.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=OqS7JdQx7tTfTDLzYeyQS7i7uzlya/tTdulabjgUEaE=;
    b=Ozks6cbO7VEAlLXMp3bRygSmKiUISOeruE7Eky98n/otZEGm02VK4QwBg9YfhEW55K
    hOkUazK63oZCECOHQ/fH4VM3i0fIp0Bb/VOhrGtvZWZ3l/asA1vYSKXbMPaGEEWDFYZg
    PFBSKgRD+3Hh8SUNBhDqccwiiPRH4fI2ElY6A119kNwZedHtcUCtnLMMnvpbMdhjG4Bw
    t6YUIIgbMWyoWqyhxoIqFQSdhbT3AfX0DZvwUHUSyq2CdvsSdUGD8QV1C7caOuc+hzl9
    BO5eJ1RLL866AQ8TFtVR+XWFPVVfKTmBwsP/GExGs96qoiaQlacargiwrq1lHwpPaPeT
    oiQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782910811;
    s=strato-dkim-0003; d=xenosoft.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=OqS7JdQx7tTfTDLzYeyQS7i7uzlya/tTdulabjgUEaE=;
    b=Sgmlng3oEAc9wPSxXQThFy3WGVtv4egVPHh/GWBPwLjuitfzdjsQDrCZVfx6f5K+QH
    Ttgf1yzRF9GP75l4jADQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6PxsY+ZPjaJwNagAH4FDfQ=="
Received: from INTER8676
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id e4c84d261D0AQp3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 1 Jul 2026 15:00:10 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's pci.c than in pasemi's setup.c. 
Date: Wed,  1 Jul 2026 14:59:35 +0200
Message-ID: <20260701125941.906-2-chzigotzky@xenosoft.de>
X-Mailer: git-send-email 2.55.0.windows.1
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

Hello,

Here is the email without HTML (Sorry):

The Nemo board [1] doesn’t boot without this patch. Darren explained it really well:

Originally we initialised the PCI-e ports in setup arch, this is quite early, and it seems uses some kernel functions that were not recommended (They changed a whole lot of different platforms at the same time for the same reason)

After this we added the ISA bridge, then the kernel would init the IRQ contollers.

The patch that broke booting on the X1000 moved the pas_pci_init to a node in the machine description, where it called later in the boot sequence. Unfortunately this is after we've tried to add the i8259 contoller from the pas_init_IRQ. Since our ISA bridge can't be found until we've connected the PCI-e ports the system tries to write to registers that aren't yet mapped - result a kernel panic, but before console I/O has been initialised so it appears to be a hang. We had a similar problem when they were introducing Radix support.

My patch changes our code so that it works with the new kernel code in place. Basically I moved the code that adds the i8259 cascade to after we've scanned for the ISA bridge where I know it will work.

Hopefully this makes sense, shout out if it doesn't.

Regards
Darren

[1] https://en.wikipedia.org/wiki/AmigaOne_X1000

Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/platforms/pasemi/pci.c   | 7 +++++++
 arch/powerpc/platforms/pasemi/setup.c | 7 ++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 2df955274652..7208c325bfc5 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -25,6 +25,8 @@
 
 #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
 
+extern void nemo_init_IRQ(void);
+
 static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
 {
 	/* Device 0 Function 0 is special: It's config space spans function 1 as
@@ -265,6 +267,11 @@ static int __init pas_add_bridge(struct device_node *dev)
 	 */
 	isa_bridge_find_early(hose);
 
+	/*
+	 * ISA brigde is now active, add the i8259 cascade (if needed)
+	 */
+	nemo_init_IRQ();
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d03b41336901..eec74611be46 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static void __init nemo_init_IRQ(struct mpic *mpic)
+void nemo_init_IRQ(void)
 {
 	struct device_node *np;
 	int gpio_virq;
+        struct mpic *mpic;
+
 	/* Connect the SB600's legacy i8259 controller */
 	np = of_find_node_by_path("/pxp@0,e0000000");
 	i8259_init(np, 0);
@@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 
+	mpic = irq_get_chip_data(gpio_virq);
 	irq_set_default_domain(mpic->irqhost);
 }
 
@@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
-	nemo_init_IRQ(mpic);
-
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
-- 
2.55.0.windows.1


