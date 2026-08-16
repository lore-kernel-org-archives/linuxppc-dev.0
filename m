Return-Path: <linuxppc-dev+bounces-25888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26515C5DF6E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 12:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNGDv1MdXz2xwM;
	Sun, 16 Aug 2026 22:56:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786884991;
	cv=none; b=XQicCjDMZqlKryd55LB8ZmX2g84b5Vikdz0MUqpH6x3eSXTx2gVIAdg4OcV6tbWhLen94uEXp70kQ8hLGEUiKkSA87UfCASeLpk4b2ci+t0AP2cbR6IRVKHNjRaYN0Nzdm3v2Yxv9hwO1b/PXHFsAS0Wh70lXTONJEOLQ668AxbONKJ+/khv4/dFo29S+sOic80kjl7mOcTKx2Dg/FKWPujEve7hCmZ/7Gc9Aq+eJKrKexfb1a1Ok6uXHMWi04ad55g65TyaFrSS0UwbaglqZN1145zQlt/vfvRZoGHPzLbOzl9oprq5X90+f/ZZJQm9Mx95WRhTxb++rhahR3rg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786884991; c=relaxed/relaxed;
	bh=Vrd+QFouPQzWgEI6eWzCwSjjj2vAhx5C8gTbTzA/yUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUbwbnJaDuLRzIEr0/22Xsm5pkF4aDDHe9pGWBGB0Rt4z+leQs5ULK9aAQJNMLzIMpnk8Gpk1i4FTCxt/I8u+qHW0W8W8Mut1rIoiXei3corTd5CMEGtNobWsaW9MnCUUw4VEawUaCFwf9B//zJUsu1yxXWPACipX1tnyCxxrjLf4SFaS7NN1whRBe4ACU7UdH1cj3NPGlHus4p+A0cQaVJ9875R+LSkG0ucav3BaCIrOmspSFMu9eHPu3gZnvNEhsyvwFK42OYs2QshpbBl3BodzhnrNuysQlTtAz1JIJ7wS2nQwxB6Qqw47+Z7Sn6QDmT9oMg9QhBY40Oxag8oTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QONV25mT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QONV25mT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNGDs0SvVz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 22:56:27 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1380133f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786884979; x=1787489779; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vrd+QFouPQzWgEI6eWzCwSjjj2vAhx5C8gTbTzA/yUI=;
        b=QONV25mT5qLE88366Om9MhLgWWiKR2LZscEjb0ghFtWWoNnk8S0RAForEtb2tpeMCj
         i46iPmdabCkKryZOHDb5alVbaUf1T0smi4q1mOMjPcvfGw8/iKsdG/b1+e6VkE3y9Lx6
         uRlqxQhznCAoePH1DFQNCcP38OU4rrnk8W1jeq5ahzcHAFq3zq2wTNignDt2RaivdICF
         VTK6huy043sLnE9vyo7dNZYpzVJeypTf94COjY3KqxewbIOUCT+9cgC1I3Np8TCPuSgU
         WgLeiv73jCVTAL3rQmYR0VuTjCQYb1hzocqebaTzCz1VLdTDGcUzWkZzkHCFfNRoEz/b
         EjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786884979; x=1787489779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vrd+QFouPQzWgEI6eWzCwSjjj2vAhx5C8gTbTzA/yUI=;
        b=W0MUme4AE5qnSRtdwOPeqVN+SG4i1w3cyDmu5UxWeqE748LQAAckI9A571+/4tHYK2
         /thLd+O0UTm/MkzymOQJePhD2oMYff1t2gfsW7fkQi+OrP5yqoSRDQJyBZ1dj0WF/Ozw
         c9lG9mGlhphlBpOFwQYmIB6D9fUoSzYDHkVzI6fXA0CcmB5302w/tw8JGbkjTyU6SjVn
         w2/u1Lu9Qs76G8uFpV2CkvD96GHcI/vW/abbFX0+7pF8YsNjVO3/rHIb15sQ8qWvRmoD
         2XgxXUC7+sH78fkfMboXStAuCLazKfetsTyUPwDdCMrgPLpJcfkWbz6YUADYSpoP5abT
         eBEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHaNlwqvLEhh9Fzgj1sEoW4ej7oziHH0hteKD6BpAzqaDDYg7htg9+kOUtX4rjkgeT48MsZTsUslB2xnQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTAhJH4/4T4cODYMTbGo6ofqyWVRgfXxV5Y9+8Rk/2r4xDjQz+
	nLqlf2fezi6aqYOT9lrt7swQ+5qTcMYL5p/RYhTxuHUgdRzakwxZDxOT
X-Gm-Gg: AR+sD10ZOlCq8eZkjDTAWhxQgS7I3fqfHnitvwlMTREKyszPt85BLavkFJG8729HUAb
	MqfJ/PRig3xGcpEvETUiPGZq72zQ2+XAi7ZIqPLSp+0cDdkYAg1QGfiqcfbN9I5lHb0BCQ3jtzz
	+FmCCc7aKxWybbLUxXJOMpUJ2r34dZKf3H7mMiqTZf9mkSrmz4+Q4YBsBPrp8LOXdVI+N+3uEKL
	zTJW3Vj93nn4UuSmUnobDLIaN8QYPEtGoZsDWF7R01SYEEuQimuv0UXpmzCQRlMcnPr6GS/1EiD
	MB9YHnPk6L7bT/cMxlVE7P20KIN9zXvJwmTwcaflX8B1i/mAoqKeONyHMhToX26WOrrYuSS63MP
	co5mQRKq9M1KLRW0d5DnROn6kcwnAWdCcMf2XRABamk8VB/saJlEsAL2y8Jz32F73Ws49l577bB
	39urWNhXOJUGaTpUiEgU+sqkA+0a7WEt4hqvh45gE1HJJu9/uXCxN8crpCgrQcmL+TUalHh38cT
	O2DE/BRyGUfMUneuR2AxXS4UBIm11SvKxscnw2LN6f0TOjTJtVW
X-Received: by 2002:a05:600c:17d1:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-49987948adamr180850505e9.8.1786884979064;
        Sun, 16 Aug 2026 05:56:19 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610e381sm63085105e9.9.2026.08.16.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 05:56:18 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	Frank.Li@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linusw@kernel.org,
	kees@kernel.org,
	colin.i.king@gmail.com,
	rosenp@gmail.com,
	joao@joaoff.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] powerpc: remove dead 440SP code
Date: Sun, 16 Aug 2026 13:56:15 +0100
Message-ID: <20260816125615.985387-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The 440SP config option can never be enabled, making all references to it
dead code.

Let's remove support for 440SP, since nobody can be using it anyway.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/powerpc/boot/cuboot-katmai.c   |  2 +-
 arch/powerpc/include/asm/async_tx.h |  2 +-
 arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
 arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
 arch/powerpc/platforms/44x/Kconfig  |  3 ---
 drivers/dma/Kconfig                 |  2 +-
 drivers/dma/ppc4xx/adma.c           |  9 ---------
 drivers/dma/ppc4xx/adma.h           |  2 +-
 drivers/dma/ppc4xx/dma.h            |  9 ---------
 drivers/net/ethernet/ibm/emac/mal.h |  2 +-
 10 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-katmai.c b/arch/powerpc/boot/cuboot-katmai.c
index 034a748fde24..fcd71e76309f 100644
--- a/arch/powerpc/boot/cuboot-katmai.c
+++ b/arch/powerpc/boot/cuboot-katmai.c
@@ -31,7 +31,7 @@ static void katmai_fixups(void)
 {
 	unsigned long sysclk = 33333000;
 
-	/* 440SP Clock logic is all but identical to 440GX
+	/* 440SPe Clock logic is all but identical to 440GX
 	 * so we just use that code for now at least
 	 */
 	ibm440spe_fixup_clocks(sysclk, 6 * 1843200, 0);
diff --git a/arch/powerpc/include/asm/async_tx.h b/arch/powerpc/include/asm/async_tx.h
index a14758426dd5..1ff5b2ca3ed1 100644
--- a/arch/powerpc/include/asm/async_tx.h
+++ b/arch/powerpc/include/asm/async_tx.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_POWERPC_ASYNC_TX_H_
 #define _ASM_POWERPC_ASYNC_TX_H_
 
-#if defined(CONFIG_440SPe) || defined(CONFIG_440SP)
+#if defined(CONFIG_440SPe)
 extern struct dma_chan *
 ppc440spe_async_tx_find_best_channel(enum dma_transaction_type cap,
 	struct page **dst_lst, int dst_cnt, struct page **src_lst,
diff --git a/arch/powerpc/include/asm/dcr-regs.h b/arch/powerpc/include/asm/dcr-regs.h
index 5c1a4973f46a..e39a55e527da 100644
--- a/arch/powerpc/include/asm/dcr-regs.h
+++ b/arch/powerpc/include/asm/dcr-regs.h
@@ -25,11 +25,11 @@
  * of the driver main register set
  */
 
-/* CPRs (440GX and 440SP/440SPe) */
+/* CPRs (440GX and 440SPe) */
 #define DCRN_CPR0_CONFIG_ADDR	0xc
 #define DCRN_CPR0_CONFIG_DATA	0xd
 
-/* SDRs (440GX and 440SP/440SPe) */
+/* SDRs (440GX and 440SPe) */
 #define DCRN_SDR0_CONFIG_ADDR 	0xe
 #define DCRN_SDR0_CONFIG_DATA	0xf
 
@@ -159,18 +159,18 @@
 #define  L2C_SNP_ESR		0x00000800
 
 /*
- * DCR register offsets for 440SP/440SPe I2O/DMA controller.
+ * DCR register offsets for 440SPe I2O/DMA controller.
  * The base address is configured in the device tree.
  */
 #define DCRN_I2O0_IBAL		0x006
 #define DCRN_I2O0_IBAH		0x007
 #define I2O_REG_ENABLE		0x00000001	/* Enable I2O/DMA access */
 
-/* 440SP/440SPe Software Reset DCR */
+/* 440SPe Software Reset DCR */
 #define DCRN_SDR0_SRST		0x0200
 #define DCRN_SDR0_SRST_I2ODMA	(0x80000000 >> 15)	/* Reset I2O/DMA */
 
-/* 440SP/440SPe Memory Queue DCR offsets */
+/* 440SPe Memory Queue DCR offsets */
 #define DCRN_MQ0_XORBA		0x04
 #define DCRN_MQ0_CF2H		0x06
 #define DCRN_MQ0_CFBHL		0x0f
diff --git a/arch/powerpc/kernel/cpu_specs_44x.h b/arch/powerpc/kernel/cpu_specs_44x.h
index 69c4cdc0cdee..41ed2c16d8cc 100644
--- a/arch/powerpc/kernel/cpu_specs_44x.h
+++ b/arch/powerpc/kernel/cpu_specs_44x.h
@@ -172,18 +172,6 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
-	{ /* 440SP Rev. A */
-		.pvr_mask		= 0xfff00fff,
-		.pvr_value		= 0x53200891,
-		.cpu_name		= "440SP Rev. A",
-		.cpu_features		= CPU_FTRS_44X,
-		.cpu_user_features	= COMMON_USER_BOOKE,
-		.mmu_features		= MMU_FTR_TYPE_44x,
-		.icache_bsize		= 32,
-		.dcache_bsize		= 32,
-		.machine_check		= machine_check_4xx,
-		.platform		= "ppc440",
-	},
 	{ /* 440SPe Rev. A */
 		.pvr_mask               = 0xfff00fff,
 		.pvr_value              = 0x53400890,
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 150813cea945..b481ef2b0f4c 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -260,9 +260,6 @@ config 440GX
 	select IBM_EMAC_ZMII if IBM_EMAC #test only
 	select IBM_EMAC_TAH if IBM_EMAC  #test only
 
-config 440SP
-	bool
-
 config 440SPe
 	bool
 	select IBM_EMAC_EMAC4 if IBM_EMAC
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ae6a682c9f76..f0f61b4932f5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -77,7 +77,7 @@ config AMBA_PL08X
 
 config AMCC_PPC440SPE_ADMA
 	tristate "AMCC PPC440SPe ADMA support"
-	depends on 440SPe || 440SP
+	depends on 440SPe
 	select DMA_ENGINE
 	select DMA_ENGINE_RAID
 	select ARCH_HAS_ASYNC_TX_FIND_CHANNEL
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 279a431ccae3..ecbf4c84a318 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4349,14 +4349,9 @@ static ssize_t poly_show(struct device_driver *dev, char *buf)
 	ssize_t size = 0;
 	u32 reg;
 
-#ifdef CONFIG_440SP
-	/* 440SP has fixed polynomial */
-	reg = 0x4d;
-#else
 	reg = dcr_read(ppc440spe_mq_dcr_host, DCRN_MQ0_CFBHL);
 	reg >>= MQ0_CFBHL_POLY;
 	reg &= 0xFF;
-#endif
 
 	size = sysfs_emit(buf, "PPC440SP(e) RAID-6 driver "
 			"uses 0x1%02x polynomial.\n", reg);
@@ -4368,10 +4363,6 @@ static ssize_t poly_store(struct device_driver *dev, const char *buf,
 {
 	unsigned long reg, val;
 	int err;
-#ifdef CONFIG_440SP
-	/* 440SP uses default 0x14D polynomial only */
-	return -EINVAL;
-#endif
 
 	if (!count || count > 6)
 		return -EINVAL;
diff --git a/drivers/dma/ppc4xx/adma.h b/drivers/dma/ppc4xx/adma.h
index f8a5d7c1fb40..0ec35382d274 100644
--- a/drivers/dma/ppc4xx/adma.h
+++ b/drivers/dma/ppc4xx/adma.h
@@ -19,7 +19,7 @@
 #define tx_to_ppc440spe_adma_slot(tx) \
 		container_of(tx, struct ppc440spe_adma_desc_slot, async_tx)
 
-/* Default polynomial (for 440SP is only available) */
+/* Default polynomial */
 #define PPC440SPE_DEFAULT_POLY	0x4d
 
 #define PPC440SPE_ADMA_ENGINES_NUM	(XOR_ENGINES_NUM + DMA_ENGINES_NUM)
diff --git a/drivers/dma/ppc4xx/dma.h b/drivers/dma/ppc4xx/dma.h
index b5725481bfa6..17cbb2d1ee1c 100644
--- a/drivers/dma/ppc4xx/dma.h
+++ b/drivers/dma/ppc4xx/dma.h
@@ -70,20 +70,11 @@
 
 #define DMA_CUED_XOR_BASE	(0x10000000)
 #define DMA_CUED_XOR_HB		(0x00000008)
-
-#ifdef CONFIG_440SP
-#define DMA_CUED_MULT1_OFF	0
-#define DMA_CUED_MULT2_OFF	8
-#define DMA_CUED_MULT3_OFF	16
-#define DMA_CUED_REGION_OFF	24
-#define DMA_CUED_XOR_WIN_MSK	(0xFC000000)
-#else
 #define DMA_CUED_MULT1_OFF	2
 #define DMA_CUED_MULT2_OFF	10
 #define DMA_CUED_MULT3_OFF	18
 #define DMA_CUED_REGION_OFF	26
 #define DMA_CUED_XOR_WIN_MSK	(0xF0000000)
-#endif
 
 #define DMA_CUED_REGION_MSK	0x3
 #define DMA_RXOR123		0x0
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index e0ddc41186a2..6cdd40bca2cd 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -26,7 +26,7 @@
  * We call MAL 1 the version in 405GP, 405GPR, 405EP, 440EP, 440GR and
  * NP405H.
  *
- * We call MAL 2 the version in 440GP, 440GX, 440SP, 440SPE and Axon
+ * We call MAL 2 the version in 440GP, 440GX, 440SPE and Axon
  *
  * The driver expects a "version" property in the emac node containing
  * a number 1 or 2. New device-trees for EMAC capable platforms are thus
-- 
2.55.0


