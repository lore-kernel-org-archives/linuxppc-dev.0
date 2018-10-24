Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E671C67863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:43:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA627207DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fodj09h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA627207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g2LW0CfrzDqfZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fodj09h9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="fodj09h9"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g29y6Kr9zDqpy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 18:36:06 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id l6-v6so4401123wrt.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A5Z9mDmZr70ZT7ypbSYKGrs97PhIJ2vzNiVI7OmFr58=;
 b=fodj09h9Pku7e/ANPAexyKeKmq1WEbSVSe/bQetmYFTGTcbtYqMgcz1wWUB6sKcJlm
 58BrUJvm+Mg6Xuzr4S3u5Q4BpsN1zTU/BEDrJqh1B0nTQH2EW6M+e/NUcJnAwjF6Lez/
 L2WuyfDUDFe6KotgeYu/YCRMGuwFFKnuZpGTG6B+izzGrEFzBG6tr3UkLVnB6JIC5zvt
 ukHGTsvj09obVMYggD75ohTbbf4e6iDzIQ85269WpfFDSr8GQYJiuWoe0rwF48h+r2lu
 x5JLIdYkfRNrs2mRzdheqMd1ZM429MxGuQeuqEJLmzj9CsHivJOMH5Ry4dvR+9vaCl9e
 fSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=A5Z9mDmZr70ZT7ypbSYKGrs97PhIJ2vzNiVI7OmFr58=;
 b=M6umPH2YC9wN8Dzd+ww/Cm0GKmZG4sI2KoZbTeHRx5G+wxF3UzKIDCz1wIdiegBsHo
 mHcpjKk5sDMLfVWvKnhd9XqmRoWkmowlloc8Zbr80Q6R0/qKKGLmIrlbtMFZXu7yuLYx
 h3M0hAFLill5vNjyf9fgGrNDk2fkPpy7HCYcM7Kvg0THRhY+c/vl2TjLc3lgu13JrxHy
 REt5pK/oODt/R8K+Uj9U300NpK7tLUR/5qx9XEnPrkZkFjXNE+cTtZ9sxiNfejsz1nIS
 gett0iXqgWw85/ECd6/Exx3d4ADPgjVpcnWkR9+P7bzBTpXgJCHzSsJI6BKXSGBXV/QI
 mUMg==
X-Gm-Message-State: AGRZ1gJb12heCpUK8p62nXKE/z58L2WklAySEZWS+mz2+nefurISHGZO
 NRE03PpvNr9PAAwvw6q1fj0neg==
X-Google-Smtp-Source: AJdET5eFmEqWQwogkuhV7lSNG3CGjJl17VKamhdQ4Ryx/OwWhSBNqX/ByT11V9PrnME9xaRuZvgCfw==
X-Received: by 2002:adf:e70b:: with SMTP id
 c11-v6mr711874wrm.195.1540366562849; 
 Wed, 24 Oct 2018 00:36:02 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id
 b139-v6sm6254351wmd.36.2018.10.24.00.36.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 24 Oct 2018 00:36:02 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 matthias.bgg@gmail.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net,
 mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Subject: [PATCH v3 1/7] powerpc: rename setbits32/clrbits32 to
 setbits_be32/clrbits_be32
Date: Wed, 24 Oct 2018 07:35:47 +0000
Message-Id: <1540366553-18541-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-mediatek@lists.infradead.org,
 Corentin Labbe <clabbe@baylibre.com>, linux-amlogic@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since setbits32/clrbits32 work on be32, it's better to remove ambiguity on
the used data type.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/include/asm/fsl_lbc.h            |  2 +-
 arch/powerpc/include/asm/io.h                 |  4 +-
 arch/powerpc/platforms/44x/canyonlands.c      |  4 +-
 arch/powerpc/platforms/4xx/gpio.c             | 28 +++----
 arch/powerpc/platforms/512x/pdm360ng.c        |  6 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c  |  6 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     | 12 +--
 arch/powerpc/platforms/82xx/ep8248e.c         |  2 +-
 arch/powerpc/platforms/82xx/km82xx.c          |  6 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c     | 10 +--
 arch/powerpc/platforms/82xx/pq2.c             |  2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c  |  4 +-
 arch/powerpc/platforms/82xx/pq2fads.c         | 10 +--
 arch/powerpc/platforms/83xx/km83xx.c          |  6 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c  |  4 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c        |  6 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c       |  6 +-
 arch/powerpc/platforms/85xx/t1042rdb_diu.c    |  6 +-
 arch/powerpc/platforms/85xx/twr_p102x.c       |  2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c    |  6 +-
 arch/powerpc/platforms/8xx/adder875.c         |  2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c       |  4 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c  |  4 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c  | 28 +++----
 .../platforms/embedded6xx/flipper-pic.c       |  6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c |  8 +-
 arch/powerpc/platforms/embedded6xx/wii.c      | 12 +--
 arch/powerpc/sysdev/cpm1.c                    | 26 +++----
 arch/powerpc/sysdev/cpm2.c                    | 16 ++--
 arch/powerpc/sysdev/cpm_common.c              |  4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c         | 16 ++--
 arch/powerpc/sysdev/fsl_lbc.c                 |  2 +-
 arch/powerpc/sysdev/fsl_pci.c                 | 12 +--
 arch/powerpc/sysdev/fsl_pmc.c                 |  2 +-
 arch/powerpc/sysdev/fsl_rcpm.c                | 74 +++++++++----------
 arch/powerpc/sysdev/fsl_rio.c                 |  4 +-
 arch/powerpc/sysdev/fsl_rmu.c                 |  9 ++-
 arch/powerpc/sysdev/mpic_timer.c              | 12 +--
 41 files changed, 190 insertions(+), 189 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index c7240a024b96..4d6a56b48a28 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -276,7 +276,7 @@ static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u8 pat_offset)
  */
 static inline void fsl_upm_end_pattern(struct fsl_upm *upm)
 {
-	clrbits32(upm->mxmr, MxMR_OP_RP);
+	clrbits_be32(upm->mxmr, MxMR_OP_RP);
 
 	while (in_be32(upm->mxmr) & MxMR_OP_RP)
 		cpu_relax();
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 0a034519957d..bc2fc014fd4f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -882,8 +882,8 @@ static inline void * bus_to_virt(unsigned long address)
 #endif /* CONFIG_PPC32 */
 
 /* access ports */
-#define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
-#define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
+#define setbits_be32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
+#define clrbits_be32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
 
 #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
 #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
index 157f4ce46386..6aeb4ca64d09 100644
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -113,8 +113,8 @@ static int __init ppc460ex_canyonlands_fixup(void)
 	 * USB2HStop and gpio19 will be USB2DStop. For more details refer to
 	 * table 34-7 of PPC460EX user manual.
 	 */
-	setbits32((vaddr + GPIO0_OSRH), 0x42000000);
-	setbits32((vaddr + GPIO0_TSRH), 0x42000000);
+	setbits_be32((vaddr + GPIO0_OSRH), 0x42000000);
+	setbits_be32((vaddr + GPIO0_TSRH), 0x42000000);
 err_gpio:
 	iounmap(vaddr);
 err_bcsr:
diff --git a/arch/powerpc/platforms/4xx/gpio.c b/arch/powerpc/platforms/4xx/gpio.c
index 2238e369cde4..8436da0617fd 100644
--- a/arch/powerpc/platforms/4xx/gpio.c
+++ b/arch/powerpc/platforms/4xx/gpio.c
@@ -82,9 +82,9 @@ __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
 
 	if (val)
-		setbits32(&regs->or, GPIO_MASK(gpio));
+		setbits_be32(&regs->or, GPIO_MASK(gpio));
 	else
-		clrbits32(&regs->or, GPIO_MASK(gpio));
+		clrbits_be32(&regs->or, GPIO_MASK(gpio));
 }
 
 static void
@@ -112,18 +112,18 @@ static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	spin_lock_irqsave(&chip->lock, flags);
 
 	/* Disable open-drain function */
-	clrbits32(&regs->odr, GPIO_MASK(gpio));
+	clrbits_be32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Float the pin */
-	clrbits32(&regs->tcr, GPIO_MASK(gpio));
+	clrbits_be32(&regs->tcr, GPIO_MASK(gpio));
 
 	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
 	if (gpio < 16) {
-		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->osrl, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->tsrl, GPIO_MASK2(gpio));
 	} else {
-		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->osrh, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
 	spin_unlock_irqrestore(&chip->lock, flags);
@@ -145,18 +145,18 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	__ppc4xx_gpio_set(gc, gpio, val);
 
 	/* Disable open-drain function */
-	clrbits32(&regs->odr, GPIO_MASK(gpio));
+	clrbits_be32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Drive the pin */
-	setbits32(&regs->tcr, GPIO_MASK(gpio));
+	setbits_be32(&regs->tcr, GPIO_MASK(gpio));
 
 	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
 	if (gpio < 16) {
-		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->osrl, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->tsrl, GPIO_MASK2(gpio));
 	} else {
-		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->osrh, GPIO_MASK2(gpio));
+		clrbits_be32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
 	spin_unlock_irqrestore(&chip->lock, flags);
diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
index dc81f05e0bce..06b95795267a 100644
--- a/arch/powerpc/platforms/512x/pdm360ng.c
+++ b/arch/powerpc/platforms/512x/pdm360ng.c
@@ -38,7 +38,7 @@ static int pdm360ng_get_pendown_state(void)
 
 	reg = in_be32(pdm360ng_gpio_base + 0xc);
 	if (reg & 0x40)
-		setbits32(pdm360ng_gpio_base + 0xc, 0x40);
+		setbits_be32(pdm360ng_gpio_base + 0xc, 0x40);
 
 	reg = in_be32(pdm360ng_gpio_base + 0x8);
 
@@ -69,8 +69,8 @@ static int __init pdm360ng_penirq_init(void)
 		return -ENODEV;
 	}
 	out_be32(pdm360ng_gpio_base + 0xc, 0xffffffff);
-	setbits32(pdm360ng_gpio_base + 0x18, 0x2000);
-	setbits32(pdm360ng_gpio_base + 0x10, 0x40);
+	setbits_be32(pdm360ng_gpio_base + 0x18, 0x2000);
+	setbits_be32(pdm360ng_gpio_base + 0x10, 0x40);
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 565e3a83dc9e..edfe619d67bf 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -314,13 +314,13 @@ int mpc5200_psc_ac97_gpio_reset(int psc_number)
 
 	/* enable gpio pins for output */
 	setbits8(&wkup_gpio->wkup_gpioe, reset);
-	setbits32(&simple_gpio->simple_gpioe, sync | out);
+	setbits_be32(&simple_gpio->simple_gpioe, sync | out);
 
 	setbits8(&wkup_gpio->wkup_ddr, reset);
-	setbits32(&simple_gpio->simple_ddr, sync | out);
+	setbits_be32(&simple_gpio->simple_ddr, sync | out);
 
 	/* Assert cold reset */
-	clrbits32(&simple_gpio->simple_dvo, sync | out);
+	clrbits_be32(&simple_gpio->simple_dvo, sync | out);
 	clrbits8(&wkup_gpio->wkup_dvo, reset);
 
 	/* wait for 1 us */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 17cf249b18ee..833cc33ebf91 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -142,7 +142,7 @@ static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gpt->lock, flags);
-	setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
+	setbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
 	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
@@ -152,7 +152,7 @@ static void mpc52xx_gpt_irq_mask(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gpt->lock, flags);
-	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
+	clrbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
 	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
@@ -308,7 +308,7 @@ static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	dev_dbg(gpt->dev, "%s: gpio:%d\n", __func__, gpio);
 
 	raw_spin_lock_irqsave(&gpt->lock, flags);
-	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK);
+	clrbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK);
 	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 
 	return 0;
@@ -482,7 +482,7 @@ int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
 		return -EBUSY;
 	}
 
-	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
+	clrbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
 	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 	return 0;
 }
@@ -639,8 +639,8 @@ static int mpc52xx_wdt_release(struct inode *inode, struct file *file)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gpt_wdt->lock, flags);
-	clrbits32(&gpt_wdt->regs->mode,
-		  MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
+	clrbits_be32(&gpt_wdt->regs->mode,
+		     MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
 	gpt_wdt->wdt_mode &= ~MPC52xx_GPT_IS_WDT;
 	raw_spin_unlock_irqrestore(&gpt_wdt->lock, flags);
 #endif
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 8fec050f2d5b..18626cd3db16 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -262,7 +262,7 @@ static void __init ep8248e_setup_arch(void)
 	/* When this is set, snooping CPM DMA from RAM causes
 	 * machine checks.  See erratum SIU18.
 	 */
-	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
+	clrbits_be32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
 
 	ep8248e_bcsr_node =
 		of_find_compatible_node(NULL, NULL, "fsl,ep8248e-bcsr");
diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 28860e40b5db..27d16d1a89f5 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -157,9 +157,9 @@ static void __init init_ioports(void)
 	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
 
 	/* Force USB FULL SPEED bit to '1' */
-	setbits32(&cpm2_immr->im_ioport.iop_pdata, 1 << (31 - 10));
+	setbits_be32(&cpm2_immr->im_ioport.iop_pdata, 1 << (31 - 10));
 	/* clear USB_SLAVE */
-	clrbits32(&cpm2_immr->im_ioport.iop_pdata, 1 << (31 - 11));
+	clrbits_be32(&cpm2_immr->im_ioport.iop_pdata, 1 << (31 - 11));
 }
 
 static void __init km82xx_setup_arch(void)
@@ -172,7 +172,7 @@ static void __init km82xx_setup_arch(void)
 	/* When this is set, snooping CPM DMA from RAM causes
 	 * machine checks.  See erratum SIU18.
 	 */
-	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
+	clrbits_be32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
 
 	init_ioports();
 
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index d23c10a96bde..75338e9e8acc 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -164,13 +164,13 @@ static void __init mpc8272_ads_setup_arch(void)
 #define BCSR3_FETHIEN2		0x10000000
 #define BCSR3_FETH2_RST		0x08000000
 
-	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
-	setbits32(&bcsr[1], BCSR1_FETH_RST);
+	clrbits_be32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
+	setbits_be32(&bcsr[1], BCSR1_FETH_RST);
 
-	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
-	setbits32(&bcsr[3], BCSR3_FETH2_RST);
+	clrbits_be32(&bcsr[3], BCSR3_FETHIEN2);
+	setbits_be32(&bcsr[3], BCSR3_FETH2_RST);
 
-	clrbits32(&bcsr[3], BCSR3_USB_nEN);
+	clrbits_be32(&bcsr[3], BCSR3_USB_nEN);
 
 	iounmap(bcsr);
 
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index c4f7029fc9ae..92f2b4a5dcc8 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -25,7 +25,7 @@
 void __noreturn pq2_restart(char *cmd)
 {
 	local_irq_disable();
-	setbits32(&cpm2_immr->im_clkrst.car_rmr, RMR_CSRE);
+	setbits_be32(&cpm2_immr->im_clkrst.car_rmr, RMR_CSRE);
 
 	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
 	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 8b065bdf7412..060400ec3ebb 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -47,7 +47,7 @@ static void pq2ads_pci_mask_irq(struct irq_data *d)
 		unsigned long flags;
 		raw_spin_lock_irqsave(&pci_pic_lock, flags);
 
-		setbits32(&priv->regs->mask, 1 << irq);
+		setbits_be32(&priv->regs->mask, 1 << irq);
 		mb();
 
 		raw_spin_unlock_irqrestore(&pci_pic_lock, flags);
@@ -63,7 +63,7 @@ static void pq2ads_pci_unmask_irq(struct irq_data *d)
 		unsigned long flags;
 
 		raw_spin_lock_irqsave(&pci_pic_lock, flags);
-		clrbits32(&priv->regs->mask, 1 << irq);
+		clrbits_be32(&priv->regs->mask, 1 << irq);
 		raw_spin_unlock_irqrestore(&pci_pic_lock, flags);
 	}
 }
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 6c654dc74a4b..84b637e019ed 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -140,18 +140,18 @@ static void __init pq2fads_setup_arch(void)
 
 	/* Enable the serial and ethernet ports */
 
-	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
-	setbits32(&bcsr[1], BCSR1_FETH_RST);
+	clrbits_be32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
+	setbits_be32(&bcsr[1], BCSR1_FETH_RST);
 
-	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
-	setbits32(&bcsr[3], BCSR3_FETH2_RST);
+	clrbits_be32(&bcsr[3], BCSR3_FETHIEN2);
+	setbits_be32(&bcsr[3], BCSR3_FETH2_RST);
 
 	iounmap(bcsr);
 
 	init_ioports();
 
 	/* Enable external IRQs */
-	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_siumcr, 0x0c000000);
+	clrbits_be32(&cpm2_immr->im_siu_conf.siu_82xx.sc_siumcr, 0x0c000000);
 
 	pq2_init_pci();
 
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index d8642a4afc74..d036b179dc65 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -101,19 +101,19 @@ static void quirk_mpc8360e_qe_enet10(void)
 		 * UCC1: write 0b11 to bits 18:19
 		 * at address IMMRBAR+0x14A8
 		 */
-		setbits32((base + 0xa8), 0x00003000);
+		setbits_be32((base + 0xa8), 0x00003000);
 
 		/*
 		 * UCC2 option 1: write 0b11 to bits 4:5
 		 * at address IMMRBAR+0x14A8
 		 */
-		setbits32((base + 0xa8), 0x0c000000);
+		setbits_be32((base + 0xa8), 0x0c000000);
 
 		/*
 		 * UCC2 option 2: write 0b11 to bits 16:17
 		 * at address IMMRBAR+0x14AC
 		 */
-		setbits32((base + 0xac), 0x0000c000);
+		setbits_be32((base + 0xac), 0x0000c000);
 	}
 	iounmap(base);
 	of_node_put(np_par);
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index fd44dd03e1f3..83a5e27e2f63 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -118,7 +118,7 @@ static void __init mpc836x_mds_setup_arch(void)
 			 * IMMR + 0x14A8[4:5] = 11 (clk delay for UCC 2)
 			 * IMMR + 0x14A8[18:19] = 11 (clk delay for UCC 1)
 			 */
-			setbits32(immap, 0x0c003000);
+			setbits_be32(immap, 0x0c003000);
 
 			/*
 			 * IMMR + 0x14AC[20:27] = 10101010
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index d7e440e6dba3..52b4fb179c9e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -262,7 +262,7 @@ static void __init mpc85xx_mds_qe_init(void)
 			 * and QE12 for QE MII management signals in PMUXCR
 			 * register.
 			 */
-				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
+				setbits_be32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
 						  MPC85xx_PMUXCR_QE(3) |
 						  MPC85xx_PMUXCR_QE(9) |
 						  MPC85xx_PMUXCR_QE(12));
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
index f05325f0cc03..926d0f9dc29d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
@@ -60,9 +60,9 @@ static void mpc85xx_freeze_time_base(bool freeze)
 
 	mask = CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
 	if (freeze)
-		setbits32(&guts->devdisr, mask);
+		setbits_be32(&guts->devdisr, mask);
 	else
-		clrbits32(&guts->devdisr, mask);
+		clrbits_be32(&guts->devdisr, mask);
 
 	in_be32(&guts->devdisr);
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 10069503e39f..fdea28dd90dd 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -115,7 +115,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 			* and QE12 for QE MII management singals in PMUXCR
 			* register.
 			*/
-				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
+				setbits_be32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
 						MPC85xx_PMUXCR_QE(3) |
 						MPC85xx_PMUXCR_QE(9) |
 						MPC85xx_PMUXCR_QE(12));
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 9fb57f78cdbe..a2fbe4a592f0 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -405,11 +405,11 @@ void p1022ds_set_pixel_clock(unsigned int pixclock)
 	pxclk = clamp_t(u32, pxclk, 2, 255);
 
 	/* Disable the pixel clock, and set it to non-inverted and no delay */
-	clrbits32(&guts->clkdvdr,
-		  CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
+	clrbits_be32(&guts->clkdvdr,
+		     CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
 
 	/* Enable the clock and set the pxclk */
-	setbits32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
+	setbits_be32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
 
 	iounmap(guts);
 }
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 276e00ab3dde..7eaec20faa95 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -75,11 +75,11 @@ void p1022rdk_set_pixel_clock(unsigned int pixclock)
 	pxclk = clamp_t(u32, pxclk, 2, 255);
 
 	/* Disable the pixel clock, and set it to non-inverted and no delay */
-	clrbits32(&guts->clkdvdr,
-		  CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
+	clrbits_be32(&guts->clkdvdr,
+		     CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
 
 	/* Enable the clock and set the pxclk */
-	setbits32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
+	setbits_be32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
 
 	iounmap(guts);
 }
diff --git a/arch/powerpc/platforms/85xx/t1042rdb_diu.c b/arch/powerpc/platforms/85xx/t1042rdb_diu.c
index dac36ba82fea..dffe44451fb9 100644
--- a/arch/powerpc/platforms/85xx/t1042rdb_diu.c
+++ b/arch/powerpc/platforms/85xx/t1042rdb_diu.c
@@ -114,11 +114,11 @@ static void t1042rdb_set_pixel_clock(unsigned int pixclock)
 	pxclk = clamp_t(u32, pxclk, 2, 255);
 
 	/* Disable the pixel clock, and set it to non-inverted and no delay */
-	clrbits32(scfg + CCSR_SCFG_PIXCLKCR,
-		  PIXCLKCR_PXCKEN | PIXCLKCR_PXCKDLY | PIXCLKCR_PXCLK_MASK);
+	clrbits_be32(scfg + CCSR_SCFG_PIXCLKCR,
+		     PIXCLKCR_PXCKEN | PIXCLKCR_PXCKDLY | PIXCLKCR_PXCLK_MASK);
 
 	/* Enable the clock and set the pxclk */
-	setbits32(scfg + CCSR_SCFG_PIXCLKCR, PIXCLKCR_PXCKEN | (pxclk << 16));
+	setbits_be32(scfg + CCSR_SCFG_PIXCLKCR, PIXCLKCR_PXCKEN | (pxclk << 16));
 
 	iounmap(scfg);
 }
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 360f6253e9ff..5c385ebf6cac 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -95,7 +95,7 @@ static void __init twr_p1025_setup_arch(void)
 			 * and QE12 for QE MII management signals in PMUXCR
 			 * register.
 			 * Set QE mux bits in PMUXCR */
-			setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
+			setbits_be32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
 					MPC85xx_PMUXCR_QE(3) |
 					MPC85xx_PMUXCR_QE(9) |
 					MPC85xx_PMUXCR_QE(12));
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index a5d73fabe4d1..ddd5a525dd3f 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -261,11 +261,11 @@ void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 	pxclk = clamp_t(u32, pxclk, 2, 31);
 
 	/* Disable the pixel clock, and set it to non-inverted and no delay */
-	clrbits32(&guts->clkdvdr,
-		  CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
+	clrbits_be32(&guts->clkdvdr,
+		     CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
 
 	/* Enable the clock and set the pxclk */
-	setbits32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
+	setbits_be32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
 
 	iounmap(guts);
 }
diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index bcef9f66191e..7bfae1617cfa 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -77,7 +77,7 @@ static void __init init_ioports(void)
 	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
 
 	/* Set FEC1 and FEC2 to MII mode */
-	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
+	clrbits_be32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
 }
 
 static void __init adder875_setup(void)
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index f1c805c8adbc..ebdc3754b99f 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -103,7 +103,7 @@ void __init mpc8xx_calibrate_decr(void)
 
 	/* Force all 8xx processors to use divide by 16 processor clock. */
 	clk_r2 = immr_map(im_clkrst);
-	setbits32(&clk_r2->car_sccr, 0x02000000);
+	setbits_be32(&clk_r2->car_sccr, 0x02000000);
 	immr_unmap(clk_r2);
 
 	/* Processor frequency is MHz.
@@ -204,7 +204,7 @@ void __noreturn mpc8xx_restart(char *cmd)
 
 	local_irq_disable();
 
-	setbits32(&clk_r->car_plprcr, 0x00000080);
+	setbits_be32(&clk_r->car_plprcr, 0x00000080);
 	/* Clear the ME bit in MSR to cause checkstop on machine check
 	*/
 	mtmsr(mfmsr() & ~0x1000);
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 8d02f5ff4481..88c611ecee0a 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -87,7 +87,7 @@ static void __init init_ioports(void)
 	cpm1_clk_setup(CPM_CLK_SCC1, CPM_CLK2, CPM_CLK_RX);
 
 	/* Set FEC1 and FEC2 to MII mode */
-	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
+	clrbits_be32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
 }
 
 static void __init mpc86xads_setup_arch(void)
@@ -112,7 +112,7 @@ static void __init mpc86xads_setup_arch(void)
 		return;
 	}
 
-	clrbits32(bcsr_io, BCSR1_RS232EN_1 | BCSR1_RS232EN_2 | BCSR1_ETHEN);
+	clrbits_be32(bcsr_io, BCSR1_RS232EN_1 | BCSR1_RS232EN_2 | BCSR1_ETHEN);
 	iounmap(bcsr_io);
 }
 
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index a0c83c1905c6..17e10250830b 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -123,7 +123,7 @@ static void __init init_ioports(void)
 	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK6, CPM_CLK_RX);
 
 	/* Set FEC1 and FEC2 to MII mode */
-	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
+	clrbits_be32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
 }
 
 static void __init mpc885ads_setup_arch(void)
@@ -148,33 +148,33 @@ static void __init mpc885ads_setup_arch(void)
 		return;
 	}
 
-	clrbits32(&bcsr[1], BCSR1_RS232EN_1);
+	clrbits_be32(&bcsr[1], BCSR1_RS232EN_1);
 #ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
-	setbits32(&bcsr[1], BCSR1_RS232EN_2);
+	setbits_be32(&bcsr[1], BCSR1_RS232EN_2);
 #else
-	clrbits32(&bcsr[1], BCSR1_RS232EN_2);
+	clrbits_be32(&bcsr[1], BCSR1_RS232EN_2);
 #endif
 
-	clrbits32(bcsr5, BCSR5_MII1_EN);
-	setbits32(bcsr5, BCSR5_MII1_RST);
+	clrbits_be32(bcsr5, BCSR5_MII1_EN);
+	setbits_be32(bcsr5, BCSR5_MII1_RST);
 	udelay(1000);
-	clrbits32(bcsr5, BCSR5_MII1_RST);
+	clrbits_be32(bcsr5, BCSR5_MII1_RST);
 
 #ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
-	clrbits32(bcsr5, BCSR5_MII2_EN);
-	setbits32(bcsr5, BCSR5_MII2_RST);
+	clrbits_be32(bcsr5, BCSR5_MII2_EN);
+	setbits_be32(bcsr5, BCSR5_MII2_RST);
 	udelay(1000);
-	clrbits32(bcsr5, BCSR5_MII2_RST);
+	clrbits_be32(bcsr5, BCSR5_MII2_RST);
 #else
-	setbits32(bcsr5, BCSR5_MII2_EN);
+	setbits_be32(bcsr5, BCSR5_MII2_EN);
 #endif
 
 #ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
-	clrbits32(&bcsr[4], BCSR4_ETH10_RST);
+	clrbits_be32(&bcsr[4], BCSR4_ETH10_RST);
 	udelay(1000);
-	setbits32(&bcsr[4], BCSR4_ETH10_RST);
+	setbits_be32(&bcsr[4], BCSR4_ETH10_RST);
 
-	setbits32(&bcsr[1], BCSR1_ETHEN);
+	setbits_be32(&bcsr[1], BCSR1_ETHEN);
 
 	np = of_find_node_by_path("/soc@ff000000/cpm@9c0/serial@a80");
 #else
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index db0be007fd06..658f972d277a 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -53,7 +53,7 @@ static void flipper_pic_mask_and_ack(struct irq_data *d)
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 	u32 mask = 1 << irq;
 
-	clrbits32(io_base + FLIPPER_IMR, mask);
+	clrbits_be32(io_base + FLIPPER_IMR, mask);
 	/* this is at least needed for RSW */
 	out_be32(io_base + FLIPPER_ICR, mask);
 }
@@ -72,7 +72,7 @@ static void flipper_pic_mask(struct irq_data *d)
 	int irq = irqd_to_hwirq(d);
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
-	clrbits32(io_base + FLIPPER_IMR, 1 << irq);
+	clrbits_be32(io_base + FLIPPER_IMR, 1 << irq);
 }
 
 static void flipper_pic_unmask(struct irq_data *d)
@@ -80,7 +80,7 @@ static void flipper_pic_unmask(struct irq_data *d)
 	int irq = irqd_to_hwirq(d);
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
-	setbits32(io_base + FLIPPER_IMR, 1 << irq);
+	setbits_be32(io_base + FLIPPER_IMR, 1 << irq);
 }
 
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 8112b39879d6..a5431ad4a529 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -50,7 +50,7 @@ static void hlwd_pic_mask_and_ack(struct irq_data *d)
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 	u32 mask = 1 << irq;
 
-	clrbits32(io_base + HW_BROADWAY_IMR, mask);
+	clrbits_be32(io_base + HW_BROADWAY_IMR, mask);
 	out_be32(io_base + HW_BROADWAY_ICR, mask);
 }
 
@@ -67,7 +67,7 @@ static void hlwd_pic_mask(struct irq_data *d)
 	int irq = irqd_to_hwirq(d);
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
-	clrbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
+	clrbits_be32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
 
 static void hlwd_pic_unmask(struct irq_data *d)
@@ -75,10 +75,10 @@ static void hlwd_pic_unmask(struct irq_data *d)
 	int irq = irqd_to_hwirq(d);
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
-	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
+	setbits_be32(io_base + HW_BROADWAY_IMR, 1 << irq);
 
 	/* Make sure the ARM (aka. Starlet) doesn't handle this interrupt. */
-	clrbits32(io_base + HW_STARLET_IMR, 1 << irq);
+	clrbits_be32(io_base + HW_STARLET_IMR, 1 << irq);
 }
 
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index ecf703ee3a76..a7a62871e68f 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -134,8 +134,8 @@ static void __init wii_setup_arch(void)
 	hw_gpio = wii_ioremap_hw_regs("hw_gpio", HW_GPIO_COMPATIBLE);
 	if (hw_gpio) {
 		/* turn off the front blue led and IR light */
-		clrbits32(hw_gpio + HW_GPIO_OUT(0),
-			  HW_GPIO_SLOT_LED | HW_GPIO_SENSOR_BAR);
+		clrbits_be32(hw_gpio + HW_GPIO_OUT(0),
+			     HW_GPIO_SLOT_LED | HW_GPIO_SENSOR_BAR);
 	}
 }
 
@@ -145,7 +145,7 @@ static void __noreturn wii_restart(char *cmd)
 
 	if (hw_ctrl) {
 		/* clear the system reset pin to cause a reset */
-		clrbits32(hw_ctrl + HW_CTRL_RESETS, HW_CTRL_RESETS_SYS);
+		clrbits_be32(hw_ctrl + HW_CTRL_RESETS, HW_CTRL_RESETS_SYS);
 	}
 	wii_spin();
 }
@@ -159,13 +159,13 @@ static void wii_power_off(void)
 		 * set the owner of the shutdown pin to ARM, because it is
 		 * accessed through the registers for the ARM, below
 		 */
-		clrbits32(hw_gpio + HW_GPIO_OWNER, HW_GPIO_SHUTDOWN);
+		clrbits_be32(hw_gpio + HW_GPIO_OWNER, HW_GPIO_SHUTDOWN);
 
 		/* make sure that the poweroff GPIO is configured as output */
-		setbits32(hw_gpio + HW_GPIO_DIR(1), HW_GPIO_SHUTDOWN);
+		setbits_be32(hw_gpio + HW_GPIO_DIR(1), HW_GPIO_SHUTDOWN);
 
 		/* drive the poweroff GPIO high */
-		setbits32(hw_gpio + HW_GPIO_OUT(1), HW_GPIO_SHUTDOWN);
+		setbits_be32(hw_gpio + HW_GPIO_OUT(1), HW_GPIO_SHUTDOWN);
 	}
 	wii_spin();
 }
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 4f8dcf124828..7fcbf8c059eb 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -60,14 +60,14 @@ static void cpm_mask_irq(struct irq_data *d)
 {
 	unsigned int cpm_vec = (unsigned int)irqd_to_hwirq(d);
 
-	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+	clrbits_be32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
 }
 
 static void cpm_unmask_irq(struct irq_data *d)
 {
 	unsigned int cpm_vec = (unsigned int)irqd_to_hwirq(d);
 
-	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+	setbits_be32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
 }
 
 static void cpm_end_irq(struct irq_data *d)
@@ -188,7 +188,7 @@ unsigned int cpm_pic_init(void)
 	if (setup_irq(eirq, &cpm_error_irqaction))
 		printk(KERN_ERR "Could not allocate CPM error IRQ!");
 
-	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
+	setbits_be32(&cpic_reg->cpic_cicr, CICR_IEN);
 
 end:
 	of_node_put(np);
@@ -317,14 +317,14 @@ static void cpm1_set_pin32(int port, int pin, int flags)
 		      &mpc8xx_immr->im_cpm.cp_pedir;
 
 	if (flags & CPM_PIN_OUTPUT)
-		setbits32(&iop->dir, pin);
+		setbits_be32(&iop->dir, pin);
 	else
-		clrbits32(&iop->dir, pin);
+		clrbits_be32(&iop->dir, pin);
 
 	if (!(flags & CPM_PIN_GPIO))
-		setbits32(&iop->par, pin);
+		setbits_be32(&iop->par, pin);
 	else
-		clrbits32(&iop->par, pin);
+		clrbits_be32(&iop->par, pin);
 
 	if (port == CPM_PORTB) {
 		if (flags & CPM_PIN_OPENDRAIN)
@@ -335,14 +335,14 @@ static void cpm1_set_pin32(int port, int pin, int flags)
 
 	if (port == CPM_PORTE) {
 		if (flags & CPM_PIN_SECONDARY)
-			setbits32(&iop->sor, pin);
+			setbits_be32(&iop->sor, pin);
 		else
-			clrbits32(&iop->sor, pin);
+			clrbits_be32(&iop->sor, pin);
 
 		if (flags & CPM_PIN_OPENDRAIN)
-			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
+			setbits_be32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
 		else
-			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
+			clrbits_be32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
 	}
 }
 
@@ -732,7 +732,7 @@ static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
-	setbits32(&iop->dir, pin_mask);
+	setbits_be32(&iop->dir, pin_mask);
 	__cpm1_gpio32_set(mm_gc, pin_mask, val);
 
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
@@ -750,7 +750,7 @@ static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
-	clrbits32(&iop->dir, pin_mask);
+	clrbits_be32(&iop->dir, pin_mask);
 
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 07718b9a2c99..e8c7a0117eed 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -335,22 +335,22 @@ void cpm2_set_pin(int port, int pin, int flags)
 	pin = 1 << (31 - pin);
 
 	if (flags & CPM_PIN_OUTPUT)
-		setbits32(&iop[port].dir, pin);
+		setbits_be32(&iop[port].dir, pin);
 	else
-		clrbits32(&iop[port].dir, pin);
+		clrbits_be32(&iop[port].dir, pin);
 
 	if (!(flags & CPM_PIN_GPIO))
-		setbits32(&iop[port].par, pin);
+		setbits_be32(&iop[port].par, pin);
 	else
-		clrbits32(&iop[port].par, pin);
+		clrbits_be32(&iop[port].par, pin);
 
 	if (flags & CPM_PIN_SECONDARY)
-		setbits32(&iop[port].sor, pin);
+		setbits_be32(&iop[port].sor, pin);
 	else
-		clrbits32(&iop[port].sor, pin);
+		clrbits_be32(&iop[port].sor, pin);
 
 	if (flags & CPM_PIN_OPENDRAIN)
-		setbits32(&iop[port].odr, pin);
+		setbits_be32(&iop[port].odr, pin);
 	else
-		clrbits32(&iop[port].odr, pin);
+		clrbits_be32(&iop[port].odr, pin);
 }
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index b74508175b67..8f4fba3067c9 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -165,7 +165,7 @@ static int cpm2_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	spin_lock_irqsave(&cpm2_gc->lock, flags);
 
-	setbits32(&iop->dir, pin_mask);
+	setbits_be32(&iop->dir, pin_mask);
 	__cpm2_gpio32_set(mm_gc, pin_mask, val);
 
 	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
@@ -183,7 +183,7 @@ static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 
 	spin_lock_irqsave(&cpm2_gc->lock, flags);
 
-	clrbits32(&iop->dir, pin_mask);
+	clrbits_be32(&iop->dir, pin_mask);
 
 	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
 
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index c27058e5df26..cf80b8dc3366 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -124,24 +124,24 @@ static int mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
 
 	switch (ways) {
 	case LOCK_WAYS_EIGHTH:
-		setbits32(&l2ctlr->ctl,
-			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_EIGHTH);
+		setbits_be32(&l2ctlr->ctl,
+			     L2CR_L2E | L2CR_L2FI | L2CR_SRAM_EIGHTH);
 		break;
 
 	case LOCK_WAYS_TWO_EIGHTH:
-		setbits32(&l2ctlr->ctl,
-			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_QUART);
+		setbits_be32(&l2ctlr->ctl,
+			     L2CR_L2E | L2CR_L2FI | L2CR_SRAM_QUART);
 		break;
 
 	case LOCK_WAYS_HALF:
-		setbits32(&l2ctlr->ctl,
-			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_HALF);
+		setbits_be32(&l2ctlr->ctl,
+			     L2CR_L2E | L2CR_L2FI | L2CR_SRAM_HALF);
 		break;
 
 	case LOCK_WAYS_FULL:
 	default:
-		setbits32(&l2ctlr->ctl,
-			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_FULL);
+		setbits_be32(&l2ctlr->ctl,
+			     L2CR_L2E | L2CR_L2FI | L2CR_SRAM_FULL);
 		break;
 	}
 	eieio();
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 5340a483cf55..0264f8c67a96 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -192,7 +192,7 @@ static int fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl,
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
 	/* clear event registers */
-	setbits32(&lbc->ltesr, LTESR_CLEAR);
+	setbits_be32(&lbc->ltesr, LTESR_CLEAR);
 	out_be32(&lbc->lteatr, 0);
 	out_be32(&lbc->ltear, 0);
 	out_be32(&lbc->lteccr, LTECCR_CLEAR);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 918be816b097..9290d8a7335b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1196,12 +1196,12 @@ static int fsl_pci_pme_probe(struct pci_controller *hose)
 	pci = hose->private_data;
 
 	/* Enable PTOD, ENL23D & EXL23D */
-	clrbits32(&pci->pex_pme_mes_disr,
-		  PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
+	clrbits_be32(&pci->pex_pme_mes_disr,
+		     PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
 
 	out_be32(&pci->pex_pme_mes_ier, 0);
-	setbits32(&pci->pex_pme_mes_ier,
-		  PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
+	setbits_be32(&pci->pex_pme_mes_ier,
+		     PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
 
 	/* PME Enable */
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pms);
@@ -1218,7 +1218,7 @@ static void send_pme_turnoff_message(struct pci_controller *hose)
 	int i;
 
 	/* Send PME_Turn_Off Message Request */
-	setbits32(&pci->pex_pmcr, PEX_PMCR_PTOMR);
+	setbits_be32(&pci->pex_pmcr, PEX_PMCR_PTOMR);
 
 	/* Wait trun off done */
 	for (i = 0; i < 150; i++) {
@@ -1254,7 +1254,7 @@ static void fsl_pci_syscore_do_resume(struct pci_controller *hose)
 	int i;
 
 	/* Send Exit L2 State Message */
-	setbits32(&pci->pex_pmcr, PEX_PMCR_EXL2S);
+	setbits_be32(&pci->pex_pmcr, PEX_PMCR_EXL2S);
 
 	/* Wait exit done */
 	for (i = 0; i < 150; i++) {
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 232225e7f863..ff29fa6af01c 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -37,7 +37,7 @@ static int pmc_suspend_enter(suspend_state_t state)
 {
 	int ret;
 
-	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
+	setbits_be32(&pmc_regs->pmcsr, PMCSR_SLP);
 	/* At this point, the CPU is asleep. */
 
 	/* Upon resume, wait for SLP bit to be clear. */
diff --git a/arch/powerpc/sysdev/fsl_rcpm.c b/arch/powerpc/sysdev/fsl_rcpm.c
index 9259a94f70e1..fce703c400e6 100644
--- a/arch/powerpc/sysdev/fsl_rcpm.c
+++ b/arch/powerpc/sysdev/fsl_rcpm.c
@@ -33,10 +33,10 @@ static void rcpm_v1_irq_mask(int cpu)
 	int hw_cpu = get_hard_smp_processor_id(cpu);
 	unsigned int mask = 1 << hw_cpu;
 
-	setbits32(&rcpm_v1_regs->cpmimr, mask);
-	setbits32(&rcpm_v1_regs->cpmcimr, mask);
-	setbits32(&rcpm_v1_regs->cpmmcmr, mask);
-	setbits32(&rcpm_v1_regs->cpmnmimr, mask);
+	setbits_be32(&rcpm_v1_regs->cpmimr, mask);
+	setbits_be32(&rcpm_v1_regs->cpmcimr, mask);
+	setbits_be32(&rcpm_v1_regs->cpmmcmr, mask);
+	setbits_be32(&rcpm_v1_regs->cpmnmimr, mask);
 }
 
 static void rcpm_v2_irq_mask(int cpu)
@@ -44,10 +44,10 @@ static void rcpm_v2_irq_mask(int cpu)
 	int hw_cpu = get_hard_smp_processor_id(cpu);
 	unsigned int mask = 1 << hw_cpu;
 
-	setbits32(&rcpm_v2_regs->tpmimr0, mask);
-	setbits32(&rcpm_v2_regs->tpmcimr0, mask);
-	setbits32(&rcpm_v2_regs->tpmmcmr0, mask);
-	setbits32(&rcpm_v2_regs->tpmnmimr0, mask);
+	setbits_be32(&rcpm_v2_regs->tpmimr0, mask);
+	setbits_be32(&rcpm_v2_regs->tpmcimr0, mask);
+	setbits_be32(&rcpm_v2_regs->tpmmcmr0, mask);
+	setbits_be32(&rcpm_v2_regs->tpmnmimr0, mask);
 }
 
 static void rcpm_v1_irq_unmask(int cpu)
@@ -55,10 +55,10 @@ static void rcpm_v1_irq_unmask(int cpu)
 	int hw_cpu = get_hard_smp_processor_id(cpu);
 	unsigned int mask = 1 << hw_cpu;
 
-	clrbits32(&rcpm_v1_regs->cpmimr, mask);
-	clrbits32(&rcpm_v1_regs->cpmcimr, mask);
-	clrbits32(&rcpm_v1_regs->cpmmcmr, mask);
-	clrbits32(&rcpm_v1_regs->cpmnmimr, mask);
+	clrbits_be32(&rcpm_v1_regs->cpmimr, mask);
+	clrbits_be32(&rcpm_v1_regs->cpmcimr, mask);
+	clrbits_be32(&rcpm_v1_regs->cpmmcmr, mask);
+	clrbits_be32(&rcpm_v1_regs->cpmnmimr, mask);
 }
 
 static void rcpm_v2_irq_unmask(int cpu)
@@ -66,26 +66,26 @@ static void rcpm_v2_irq_unmask(int cpu)
 	int hw_cpu = get_hard_smp_processor_id(cpu);
 	unsigned int mask = 1 << hw_cpu;
 
-	clrbits32(&rcpm_v2_regs->tpmimr0, mask);
-	clrbits32(&rcpm_v2_regs->tpmcimr0, mask);
-	clrbits32(&rcpm_v2_regs->tpmmcmr0, mask);
-	clrbits32(&rcpm_v2_regs->tpmnmimr0, mask);
+	clrbits_be32(&rcpm_v2_regs->tpmimr0, mask);
+	clrbits_be32(&rcpm_v2_regs->tpmcimr0, mask);
+	clrbits_be32(&rcpm_v2_regs->tpmmcmr0, mask);
+	clrbits_be32(&rcpm_v2_regs->tpmnmimr0, mask);
 }
 
 static void rcpm_v1_set_ip_power(bool enable, u32 mask)
 {
 	if (enable)
-		setbits32(&rcpm_v1_regs->ippdexpcr, mask);
+		setbits_be32(&rcpm_v1_regs->ippdexpcr, mask);
 	else
-		clrbits32(&rcpm_v1_regs->ippdexpcr, mask);
+		clrbits_be32(&rcpm_v1_regs->ippdexpcr, mask);
 }
 
 static void rcpm_v2_set_ip_power(bool enable, u32 mask)
 {
 	if (enable)
-		setbits32(&rcpm_v2_regs->ippdexpcr[0], mask);
+		setbits_be32(&rcpm_v2_regs->ippdexpcr[0], mask);
 	else
-		clrbits32(&rcpm_v2_regs->ippdexpcr[0], mask);
+		clrbits_be32(&rcpm_v2_regs->ippdexpcr[0], mask);
 }
 
 static void rcpm_v1_cpu_enter_state(int cpu, int state)
@@ -95,10 +95,10 @@ static void rcpm_v1_cpu_enter_state(int cpu, int state)
 
 	switch (state) {
 	case E500_PM_PH10:
-		setbits32(&rcpm_v1_regs->cdozcr, mask);
+		setbits_be32(&rcpm_v1_regs->cdozcr, mask);
 		break;
 	case E500_PM_PH15:
-		setbits32(&rcpm_v1_regs->cnapcr, mask);
+		setbits_be32(&rcpm_v1_regs->cnapcr, mask);
 		break;
 	default:
 		pr_warn("Unknown cpu PM state (%d)\n", state);
@@ -114,16 +114,16 @@ static void rcpm_v2_cpu_enter_state(int cpu, int state)
 	switch (state) {
 	case E500_PM_PH10:
 		/* one bit corresponds to one thread for PH10 of 6500 */
-		setbits32(&rcpm_v2_regs->tph10setr0, 1 << hw_cpu);
+		setbits_be32(&rcpm_v2_regs->tph10setr0, 1 << hw_cpu);
 		break;
 	case E500_PM_PH15:
-		setbits32(&rcpm_v2_regs->pcph15setr, mask);
+		setbits_be32(&rcpm_v2_regs->pcph15setr, mask);
 		break;
 	case E500_PM_PH20:
-		setbits32(&rcpm_v2_regs->pcph20setr, mask);
+		setbits_be32(&rcpm_v2_regs->pcph20setr, mask);
 		break;
 	case E500_PM_PH30:
-		setbits32(&rcpm_v2_regs->pcph30setr, mask);
+		setbits_be32(&rcpm_v2_regs->pcph30setr, mask);
 		break;
 	default:
 		pr_warn("Unknown cpu PM state (%d)\n", state);
@@ -172,10 +172,10 @@ static void rcpm_v1_cpu_exit_state(int cpu, int state)
 
 	switch (state) {
 	case E500_PM_PH10:
-		clrbits32(&rcpm_v1_regs->cdozcr, mask);
+		clrbits_be32(&rcpm_v1_regs->cdozcr, mask);
 		break;
 	case E500_PM_PH15:
-		clrbits32(&rcpm_v1_regs->cnapcr, mask);
+		clrbits_be32(&rcpm_v1_regs->cnapcr, mask);
 		break;
 	default:
 		pr_warn("Unknown cpu PM state (%d)\n", state);
@@ -196,16 +196,16 @@ static void rcpm_v2_cpu_exit_state(int cpu, int state)
 
 	switch (state) {
 	case E500_PM_PH10:
-		setbits32(&rcpm_v2_regs->tph10clrr0, 1 << hw_cpu);
+		setbits_be32(&rcpm_v2_regs->tph10clrr0, 1 << hw_cpu);
 		break;
 	case E500_PM_PH15:
-		setbits32(&rcpm_v2_regs->pcph15clrr, mask);
+		setbits_be32(&rcpm_v2_regs->pcph15clrr, mask);
 		break;
 	case E500_PM_PH20:
-		setbits32(&rcpm_v2_regs->pcph20clrr, mask);
+		setbits_be32(&rcpm_v2_regs->pcph20clrr, mask);
 		break;
 	case E500_PM_PH30:
-		setbits32(&rcpm_v2_regs->pcph30clrr, mask);
+		setbits_be32(&rcpm_v2_regs->pcph30clrr, mask);
 		break;
 	default:
 		pr_warn("Unknown cpu PM state (%d)\n", state);
@@ -226,7 +226,7 @@ static int rcpm_v1_plat_enter_state(int state)
 
 	switch (state) {
 	case PLAT_PM_SLEEP:
-		setbits32(pmcsr_reg, RCPM_POWMGTCSR_SLP);
+		setbits_be32(pmcsr_reg, RCPM_POWMGTCSR_SLP);
 
 		/* Upon resume, wait for RCPM_POWMGTCSR_SLP bit to be clear. */
 		result = spin_event_timeout(
@@ -253,9 +253,9 @@ static int rcpm_v2_plat_enter_state(int state)
 	switch (state) {
 	case PLAT_PM_LPM20:
 		/* clear previous LPM20 status */
-		setbits32(pmcsr_reg, RCPM_POWMGTCSR_P_LPM20_ST);
+		setbits_be32(pmcsr_reg, RCPM_POWMGTCSR_P_LPM20_ST);
 		/* enter LPM20 status */
-		setbits32(pmcsr_reg, RCPM_POWMGTCSR_LPM20_RQ);
+		setbits_be32(pmcsr_reg, RCPM_POWMGTCSR_LPM20_RQ);
 
 		/* At this point, the device is in LPM20 status. */
 
@@ -291,9 +291,9 @@ static void rcpm_common_freeze_time_base(u32 *tben_reg, int freeze)
 
 	if (freeze) {
 		mask = in_be32(tben_reg);
-		clrbits32(tben_reg, mask);
+		clrbits_be32(tben_reg, mask);
 	} else {
-		setbits32(tben_reg, mask);
+		setbits_be32(tben_reg, mask);
 	}
 
 	/* read back to push the previous write */
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 5011ffea4e4b..891e11d12222 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -668,10 +668,10 @@ int fsl_rio_setup(struct platform_device *dev)
 			out_be32(priv->regs_win
 				+ RIO_CCSR + i*0x20, 0);
 			/* Set 1x lane */
-			setbits32(priv->regs_win
+			setbits_be32(priv->regs_win
 				+ RIO_CCSR + i*0x20, 0x02000000);
 			/* Enable ports */
-			setbits32(priv->regs_win
+			setbits_be32(priv->regs_win
 				+ RIO_CCSR + i*0x20, 0x00600000);
 			msleep(100);
 			if (in_be32((priv->regs_win
diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index 88b35a3dcdc5..b4f49049d75d 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -355,7 +355,7 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
 				dmsg->sid, dmsg->tid,
 				dmsg->info);
 		}
-		setbits32(&fsl_dbell->dbell_regs->dmr, DOORBELL_DMR_DI);
+		setbits_be32(&fsl_dbell->dbell_regs->dmr, DOORBELL_DMR_DI);
 		out_be32(&fsl_dbell->dbell_regs->dsr, DOORBELL_DSR_DIQI);
 	}
 
@@ -909,10 +909,11 @@ fsl_open_inb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 	out_be32(&rmu->msg_regs->imr, 0x001b0060);
 
 	/* Set number of queue entries */
-	setbits32(&rmu->msg_regs->imr, (get_bitmask_order(entries) - 2) << 12);
+	setbits_be32(&rmu->msg_regs->imr,
+		     (get_bitmask_order(entries) - 2) << 12);
 
 	/* Now enable the unit */
-	setbits32(&rmu->msg_regs->imr, 0x1);
+	setbits_be32(&rmu->msg_regs->imr, 0x1);
 
 out:
 	return rc;
@@ -1015,7 +1016,7 @@ void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
 	rmu->msg_rx_ring.virt_buffer[buf_idx] = NULL;
 
 out1:
-	setbits32(&rmu->msg_regs->imr, RIO_MSG_IMR_MI);
+	setbits_be32(&rmu->msg_regs->imr, RIO_MSG_IMR_MI);
 
 out2:
 	return buf;
diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
index 87e7c42777a8..5cc8216a85e5 100644
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -154,7 +154,7 @@ static int set_cascade_timer(struct timer_group_priv *priv, u64 ticks,
 
 	tcr = casc_priv->tcr_value |
 		(casc_priv->tcr_value << MPIC_TIMER_TCR_ROVR_OFFSET);
-	setbits32(priv->group_tcr, tcr);
+	setbits_be32(priv->group_tcr, tcr);
 
 	tmp_ticks = div_u64_rem(ticks, MAX_TICKS_CASCADE, &rem_ticks);
 
@@ -253,7 +253,7 @@ void mpic_start_timer(struct mpic_timer *handle)
 	struct timer_group_priv *priv = container_of(handle,
 			struct timer_group_priv, timer[handle->num]);
 
-	clrbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+	clrbits_be32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
 }
 EXPORT_SYMBOL(mpic_start_timer);
 
@@ -269,7 +269,7 @@ void mpic_stop_timer(struct mpic_timer *handle)
 			struct timer_group_priv, timer[handle->num]);
 	struct cascade_priv *casc_priv;
 
-	setbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+	setbits_be32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
 
 	casc_priv = priv->timer[handle->num].cascade_handle;
 	if (casc_priv) {
@@ -340,7 +340,7 @@ void mpic_free_timer(struct mpic_timer *handle)
 		u32 tcr;
 		tcr = casc_priv->tcr_value | (casc_priv->tcr_value <<
 					MPIC_TIMER_TCR_ROVR_OFFSET);
-		clrbits32(priv->group_tcr, tcr);
+		clrbits_be32(priv->group_tcr, tcr);
 		priv->idle |= casc_priv->cascade_map;
 		priv->timer[handle->num].cascade_handle = NULL;
 	} else {
@@ -508,7 +508,7 @@ static void timer_group_init(struct device_node *np)
 
 	/* Init FSL timer hardware */
 	if (priv->flags & FSL_GLOBAL_TIMER)
-		setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
+		setbits_be32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
 
 	list_add_tail(&priv->node, &timer_group_list);
 
@@ -531,7 +531,7 @@ static void mpic_timer_resume(void)
 	list_for_each_entry(priv, &timer_group_list, node) {
 		/* Init FSL timer hardware */
 		if (priv->flags & FSL_GLOBAL_TIMER)
-			setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
+			setbits_be32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
 	}
 }
 
-- 
2.18.1

