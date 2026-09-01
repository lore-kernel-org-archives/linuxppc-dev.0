Return-Path: <linuxppc-dev+bounces-26398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5FCC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 15:07:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ8N84xDCz2xmh;
	Wed, 02 Sep 2026 01:07:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788275224;
	cv=none; b=WhfOnibD4twkOoJD2ON30LKvMcqEVGNCuX8z+IIOsyIqbnOz00tSszkGd7/7mzGWJ15syPPr8l574KB+M6Qi2oGiTTs1JxeEAL59C5l95XbAcMxTW/i2R2DhAEabYxOq9Y55KSaEdKOGVQNWkUOV2zx3Ax2YosRbg6Uqb9bjmpthcZ1E2NdRFtCj/Dg1pP7PKp7cvzvnO6mSNhqJ6SDXVEYpMZxku7dWAy05My35g3CqC0r7W/XUTXiLIxtDR5kEAY7Jk1zVHFcggAInSaBDvD8fweKYZFfO5vNSkbGp3vCULnc8mZBUM+oxXSneIgtNiKr0LdKIlssQcLJHLOC2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788275224; c=relaxed/relaxed;
	bh=PIhxiLKzSpy+3m2603jhfgBC54nQi3N4mrjaoTx15Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaVFI6nw3kHeYIyHGmzrHv58OmDtq18rclIvLEEuAJtQHGJeqdGuLLfL7fS/CG9GoNN1KA4yykUfoY5bjbFeGL2C52Yr++0Ri/za1ogsprY4caqFbksh/nePu914wOhtzkQ4y3B87pNc7mkiZLAOwZsWBUKENmAJv0jG55OhrQTPS4Y7ddRTuuDOhOFOU1fa1uPo+tlzjaEtilJ0VkUMh2ApITfRv+gB/H60R+bENIWS72lOINtapPe9YkXO2PTAhOytfVKkZqyXpCv2dmgLiWEKB5E/lS/z25iSVL7dKH2Ivc+WEt6kfc4RFcvAhqp1AXF55KCjGwf20iVKUFRxMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsKhmNhR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsKhmNhR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ8N66GqZz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 01:07:01 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49b8f86c6deso29133605e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275213; x=1788880013; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIhxiLKzSpy+3m2603jhfgBC54nQi3N4mrjaoTx15Vk=;
        b=WsKhmNhR3401HZfLTvgj5SldNWGmOqQT/yP1YhSfxjJ2MmlILhlpT6FVeQSYPfoH83
         pL8AHcc5NbwAcMTz7Q3mCWcXv4ao2kzZGpywhIJPdLP8dlsFMewoNwI9CrQ5D8D5PlP3
         XXsl27yTwTuqNG8mImsY8GyOZIm9Wo2cy3xVaKnQoADgxPmKxYWd+PXhI4FGRZRBJ47O
         k9rXBSxPcehBVbg6fuhjEGu0P9PV4pZtS1KwinJSFTnen4i28xEE8c8uY9iHKaelaRqc
         CftSG41urrNqvwQNM9q+F9h5RS2W+3gxyKfOTcwPA9D//fgBtSiCrLCTWmFR987BVpi0
         iGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275213; x=1788880013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIhxiLKzSpy+3m2603jhfgBC54nQi3N4mrjaoTx15Vk=;
        b=lekNIiSLvDm6hIF/4F7gkJ8nAa2HDBrvHjC8rvSxY6C2UHUrVbQzdZlFPNuysBX0E7
         +Br6GaZnzYsQXHt/DtoqnC8Y/6UQ9gbDi5thyLnQUnCkjjY/QrnlwswUL2OGJB7efCrm
         /TyZ+0YO9uVGqGkan7an8JXqKVMQNbVgZ4PYBVFLGj8Bs9Sebpms8Dg9j9bfuu2V+7k4
         BIgO7BxOZOFT3eYt/GRELiBVI0/tUSWX4/nB44h01rQDlHFi7FtH7LqLjTqkICWI7AJm
         GgTPHd3xSxRsORqa5NSl342Pi6NvHYAB1ipR92UYMp7lNCVbV+itPOdq0ZSAb81uzrWG
         L6rA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1PNfW1wQ2zvaecKVP+C4K7/CF6tOuu9XINST1AisaETE16hBW1jgVZ52nzRDWMaeR7/QqswRU5S2BuLQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k2dzh788QiBPs568xwgeabGz3L0yVVbKquEOSjpO+hlSEv6/9g
	pm75mfHA8hLPKuQHZLwHd4+5pDXf9usjCrq67kBE9GNwR0X2DK89ZrBm
X-Gm-Gg: AR+sD12lOfkPTYGd+0ue2SRO2S8VIonCobw5/neWCaHqkJcGIQnJCPQF33NObrCDiyT
	+2C0ci2DwEIjWZPpFhpkvvZuPvNQ6BF2kbY2+eQmfad0N0/i6oUXnouZimFtWI2Nef/93NZpCyu
	LmGn2wjqy7Wk4qG8vPrOTcrRK43TLpChR5i5S23I5KTZNYCb43/5JmoZE8q+tGSU27XpkmJf704
	wnvp+TAJA9HVO6zt0DxdxdOqvjIX3wU5rhozMoVVS4q2Bi2SE3GDNC96VC6cFOKuh8FIGfHb9qh
	VjUsYsNjcr5Bxwn3gfnNopvp+3qLmCq01eLUzonJV/F6Ci9h+NzYliD4VBdBcApue/PONQ1MxUM
	NrR+hnLcJdm0N4aZZ0duePFXqhKnJSrm6Vpevx1z2sYbn8s959Pp2YxHVB8QXtVRtGnucVwyVvN
	3aPPskevpEg7C3YJLx4u2lvj/uNNhP9QY0qCR+bys2cVm4TDk4jm4upGbgUORqc+7P4hcrtnrYB
	YsC9gPZC19MK3PIG8Lco3QrVss53vBLFhMl/f84Fq64aRPIsqNN
X-Received: by 2002:a05:600c:45d4:b0:499:7219:122f with SMTP id 5b1f17b1804b1-49b91c1ebd7mr491856785e9.4.1788275210457;
        Tue, 01 Sep 2026 08:06:50 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b955e7906sm303172635e9.1.2026.09.01.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:06:49 -0700 (PDT)
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
Cc: kernel-janitors@vger.kernel.org,
	linusw@kernel.org,
	kees@kernel.org,
	colin.i.king@gmail.com,
	rosenp@gmail.com,
	joao@joaoff.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] powerpc: remove dead 440SP code
Date: Tue,  1 Sep 2026 16:06:45 +0100
Message-ID: <20260901150645.1199097-1-julianbraha@gmail.com>
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

The only board using CONFIG_440SP was IBM LUAN, which was commented out by
commit f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in
arch/powerpc") then removed by commit ff5f483f3091 ("powerpc: 4xx: remove
commented out Kconfig entries").

Let's remove support for 440SP, since nobody can be using it anyway.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1:
- cleaned up preprocessor condition
- added historic details to description 

Link to v1:
https://lore.kernel.org/all/20260816125615.985387-1-julianbraha@gmail.com/
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


