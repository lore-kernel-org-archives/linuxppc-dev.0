Return-Path: <linuxppc-dev+bounces-18549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA31094471
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 12:18:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdJPX1QcQz2yZN;
	Sat, 21 Mar 2026 23:18:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.58.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774093340;
	cv=none; b=gIUJxnXPomMoOvegR695uxBRrFtfrqB/I1fWt5dEnXZREeXoXw7Ui6zRgQnhKDy5UGJMPFoVA6iaVVyrW+2VmSwxDCSXUcM5jzx6X7QtkNdZp96/kcsSHsbupa/8d/fItyOhFjbW7RQQ99NzLcb4xImvGRCsYll8ZwhpNKMRcMUk8xnvl4PdiGRFPmfULax362erX6tUmYb799W6EbOxQq2Aj3PUdU4JhL+sQF+SsLezQqjKSAW7i72CybnNKhegJTkYz877E/Zk6oTV8eG7QRYsWSz1pC0uDcQBjESbTYSFm/jFtmq8rVrXDQwXACZcKp+ScufWxvNI1f5ySEzzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774093340; c=relaxed/relaxed;
	bh=MpRbcYRDdY2DD4XTZv5ptcgOH3A3CX6WIWM+E+X7HKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dX5av9aV6QNw9J7g1tw8Tj2/DUH8sa4Whq7ZaAfa903cBwXCvLIdwYwnQ8wR5N78p/lgbV/GI5MjPX9EGdQPM89bvcYHdr6HHkLe++AKz8+Ru2MmXJrZbw5qP2VeSLddwRACmg5pN64plALSPhInAUN9WdDegJb02DTrzCOcQbGBV3gQsVQ3tipuzF3waL5jhZ2k3oBZ9ySdu622qfmf/oRZTMLUGA829ZnwcnzyOLVqqf15k96k2MdyMdhcgCJGooM8wcaEdIUrJEClHjLPQYMCNBuRdT6Q9FQAdIfm/PNqzJ9hFa9KE6RFxsmTQqQly7tijGoq3wB+KNpjb3aPWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=0pfvCRtX; dkim-atps=neutral; spf=pass (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=0pfvCRtX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=smail.nju.edu.cn (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 2633 seconds by postgrey-1.37 at boromir; Sat, 21 Mar 2026 22:42:10 AEDT
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdHbQ31cRz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:42:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774093279;
	bh=MpRbcYRDdY2DD4XTZv5ptcgOH3A3CX6WIWM+E+X7HKo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=0pfvCRtXcWvrfeGQd0FLdIgaz/dPvr87LKKhy1NKa47TzNeJ97JJ8m1BGuqG4sllq
	 GSrSCFy5cizS9oosW4IoqeYbhqAL/t89ezbRdNuDdQMnJMBBMF7jcI1GfXwfdW8VrW
	 xHHfer90XU3no51mwQ1YyEeN1izdT4Jp+CiYmNzE=
X-QQ-mid: esmtpsz16t1774093276t12b87290
X-QQ-Originating-IP: ymC8t1IzwDI1Nkc8CKB2K+5dPkYBlabU7RGxjqi6S04=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 19:41:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10421773967410276307
EX-QQ-RecipientCnt: 16
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH v2] ASoC: update outdated comments for removed snd_soc_new_pcms()
Date: Sat, 21 Mar 2026 19:41:13 +0800
Message-Id: <20260321114113.9244-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NvWYEgjCCjcVTRVjKnxJlE3+Nk+4rAk43FD1sVVbhqm8YtK8AYhDJFFh
	tLmWCaVfSgLwW2ZePaDohjOflpO17cyhyBx6KqpgocBjF4tuARzA3uy+caNDc+loFzN9qsB
	C8vXt1WIb291ViU57a5EEBkpvJ1/lDPgD+0LDhPj3ZqWiesugaG+a33j4Zg7npZT2n5ETTt
	meuWL5ofnnak/nc558WFjCZ6+09Q93/8kmZJQe7dGYLV5I8wtWEupoHL+aXm5ps/M3wi8YP
	L2Op2BMdzKIEAgCTuiVsoiIeWm98DRlbKpTgZ3C9Eus31LhjKx8F3ThmQ9jKl0QOajJ1+ij
	ZzJXuu+WnR2ASVlH2Di5J6ypgVEG6TuJ2KYYBUE86j31Q45NlPmegfG68DuMqlAjFdfVkRS
	lQTeAH6GM72mVuoNlW2/wQkZVLsHWXwy3+Ux/GmTjF7yqQmUg34Q3MoEL1dvjcjbRX7c38k
	BQUfGB1rm47Vtu2Fa2eXaaOzEt/SbSED+ywiX9s8lpmLvAWF9JQ64zhYvauyYns/25MYCQh
	kLPehekrrloohVrmqxYCQ/EAC8mNlFli7ajEkRtUiMIK+VMPZZNI0WZ+jdZNaYT6vU+X91W
	KXefgizih2a0n/t2YnU/tfvC3ALCKKw4BNpGtIgT44ab4eX6VaqWeFRh6gALT5CaWIxxZ1k
	pJzbHPSsfGQAV5VbDRj5+Xl61GFk3GybQZex50moDGpckNBf2cRh70vrPfe/E7RmYNDB3/P
	N1KFO4qMitQJVI5KDCcwRipQEdNEiol3l3lhO85eDxp5RPkAWIOEXCXBrDyT7YFOTM8oclF
	w3uemm1ZywnnUJMIcbCoa7OaY+Wqirud8iHPUwi/uY0V6zhWeHoCBzo4+b0wdhEn96zINVF
	DaBmsMQtmODoBelIKtMg0QNbvXTTn1T23/R320fiurzJP6MQOpIHfXzOViRkBwGop+g/aBm
	nCbgCk11JG/v4U2hFPeNAd/7+PTWSQ9aR7TvnctR6mwtmMGhc/t8MP3o/G5+Q534rKULhJQ
	COCySMZ3XIGl6snZxZioqdsH2vxXdkJbo6f5lr1nLSo6KnUodqpK9wRC2CugKm0vi4lJ3cK
	PSZExi1261+4OY8jthfaD4=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The function snd_soc_new_pcms() was removed during the
multi-component refactoring in commit f0fba2ad1b6b ("ASoC:
multi-component - ASoC Multi-Component Support").  Its PCM creation
role is now handled by soc_new_pcm(), which was later moved to
sound/soc/soc-pcm.c by commit ddee627cf6bb ("ASoC: core - Separate
out PCM operations into new file.").

In fsl_dma.c, update the comment to reference soc_new_pcm() and the
pcm_construct callback.  Also remove the stale paragraph about
snd_dma_alloc_pages() always allocating in lowmem, since commit
e159704f7920 ("ASoC: fsl_dma: Use managed buffer allocation")
replaced that call with snd_pcm_set_fixed_buffer_all().

In siu_pcm.c, remove the stale comment referencing
snd_soc_new_pcms() and the no-longer-existing socdev structure.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 sound/soc/fsl/fsl_dma.c     | 9 ++-------
 sound/soc/renesas/siu_pcm.c | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 26ddbe867b58..ec378e32ea71 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -267,15 +267,10 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 /**
  * fsl_dma_new: initialize this PCM driver.
  *
- * This function is called when the codec driver calls snd_soc_new_pcms(),
- * once for each .dai_link in the machine driver's snd_soc_card
+ * This function is called by soc_new_pcm() via the pcm_construct
+ * callback, once for each DAI link in the machine driver's snd_soc_card
  * structure.
  *
- * snd_dma_alloc_pages() is just a front-end to dma_alloc_coherent(), which
- * (currently) always allocates the DMA buffer in lowmem, even if GFP_HIGHMEM
- * is specified. Therefore, any DMA buffers we allocate will always be in low
- * memory, but we support for 36-bit physical addresses anyway.
- *
  * Regardless of where the memory is actually allocated, since the device can
  * technically DMA to any 36-bit address, we do need to set the DMA mask to 36.
  */
diff --git a/sound/soc/renesas/siu_pcm.c b/sound/soc/renesas/siu_pcm.c
index f15ff36e7934..189d7e6f9750 100644
--- a/sound/soc/renesas/siu_pcm.c
+++ b/sound/soc/renesas/siu_pcm.c
@@ -483,7 +483,6 @@ siu_pcm_pointer_dma(struct snd_soc_component *component,
 static int siu_pcm_new(struct snd_soc_component *component,
 		       struct snd_soc_pcm_runtime *rtd)
 {
-	/* card->dev == socdev->dev, see snd_soc_new_pcms() */
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct siu_info *info = siu_i2s_data;
-- 
2.25.1


