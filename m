Return-Path: <linuxppc-dev+bounces-18548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B051094471
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 12:18:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdJP24TsMz2yZN;
	Sat, 21 Mar 2026 23:18:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.77.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774091081;
	cv=none; b=GchPdX8nOYy7nBAhYqCSHQOUAFdL4kGK1kpldXO0c4J6SiLt7Jmskr0ozgUIHQkdrTh9gu5qROuR30juhOJzuKF2huNqMgiaNkNFfhx9FAUd3i9cAhKqd7URABvIlo988sPk98yU2LK52i4Y/ks8f2hJTXNt2MMlHD5Z/gP8ktr9C1Omyam+gEqOkM0JT7Z72HiPYkVh6NUkebRMzfhB3ycE2ULH5mHs6KGMPUtJbVcyqf64ozORjXVlaPWjNIf06n4g+WnUDBeV0UqgCI7IUL0/nXTMG0HmmCF+zx8UyLotTgcd8fZEn8i4ZBjU0HOw+yLMo2Hg52JCdiGVsrCZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774091081; c=relaxed/relaxed;
	bh=HIHEzaF/nPqHffBHVVWRyOkZRwX0b63WHjLr9Uc+nEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tab+jA8mFrQ/Bg/01Ex2MFHmMfkeZdaqVPxxzlvRingQ81qGOBdEQbJ5haVGOJYvgGF++d55mm6cI8F6gQa6UBiiKRk2D1FU0T4x5wCVF+Cx6ubHJfMeZ0is4bM/tda2IimXU62KaA0YHlrC+pBcMC9qFiBIj2uzNYSzqa88Rxn+V/LaWtdo5ndmy8YWgRgjOJiR2ZO8dQWuy/7xL8X4vAkvHY9ca2D9SMXLwjaT5jviGTwfpe7e2KvkK4+KEHDLw7FMeOvcvy26bjA9s4mqnk3AeqlKtD6vNESQL6SS5hY5bAHgfiBqYAjYVCWLWt14aU7rWkiU6/7zDRRlBDdluQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=eE6iwN+Y; dkim-atps=neutral; spf=pass (client-ip=114.132.77.159; helo=bg1.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=eE6iwN+Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=smail.nju.edu.cn (client-ip=114.132.77.159; helo=bg1.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 183 seconds by postgrey-1.37 at boromir; Sat, 21 Mar 2026 22:04:39 AEDT
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdGm72KYwz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774091018;
	bh=HIHEzaF/nPqHffBHVVWRyOkZRwX0b63WHjLr9Uc+nEM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=eE6iwN+Y/0x0sNaWuIRpOltWA61/vOEVQOBKjI5MIxPlEv1MQqOnmSvMtiYWTd27I
	 1GfyI+VcK5z3IdJJX8yGP6Svp6PB1ok2GlkKAMvorBlL0tq9ntHHR8+95YUHOtrAOV
	 q6eYaVUX9yzPHFIuYCGjn+PUhXH2sdnh1shbpwxs=
X-QQ-mid: esmtpgz10t1774090615t736d5583
X-QQ-Originating-IP: lnfkjvlq7iaGG7WgKVTtD6UhUhtO2uG/Q9+eCbsmz9Y=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:56:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17690428264591340367
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
Subject: [PATCH] ASoC: update outdated comments for removed snd_soc_new_pcms()
Date: Sat, 21 Mar 2026 18:56:52 +0800
Message-Id: <20260321105652.5904-1-kexinsun@smail.nju.edu.cn>
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
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MoEtoil6yR/CSJLQ69IBvqA3ruw+bCAIrtC1eEqHhcCjZYOegjyRXeQr
	x6A+ibf4gCk+A2vIM8OzRBbvs5ZmHEr4uqNW4pkFRU61+Vc8xeoiKsQ7LRDENmkbk/X8aWO
	P8SH9a4avNQLsCvV48ENyvh/daJ74J6ky3TWCK7isPYwWaaDdVlysvhHYC7ntRIFuvN+C5Q
	WWz4Z1LmIlM+LVlIkUpvQG6qSNutMOqll42wFmvgpHH/S7rcQrO0uxqNlJVr/br5oBvjXN1
	LSl02sgyS9ikSkm81EkALPCMtcEyF3lFHa5I01jpQrrWYURkOR4jIA2hlydwp3zgJSMwoY7
	4X37Fo5V5xURsRVemGC1Y0PPd+GPmST72to/czYPWY+LX/eZ7W2uyALW8Tys6Ws2hrY3u7d
	pV+mxnWcxVM0ZijGAKMApKQSkjz1K4JnMtxdfm+UYuH7M1Jr6r/sIdCVRQp2M577MJjDIf1
	vcnwE2BlFXUH1VYt3C5kIYV0SRS13kmdw9FNT4tS9K2fqC2Hju+qFhBuLT9VpQ524Meac+u
	TGabv+3qH6MJ5FK43Tgcq0BaSsg+MHIkr7Kv8uCjyKNd16UOHSppwgTz+jzaooUM2j910Pk
	/kgAbEtv3cYpYFRSO7ZR58bDaf2V8hBEJVeO3cBbMY0tO78hQ19nh5KHcHyIrJlgTYS2j0I
	KehgoICQgW2PsAN88uZ1EYd0LE8xeMd+zVP+5EfTKRgNrddZgw9zvNEG9t4xKmGgjdfuFEh
	Es+oekmy+0wxbEgOGI+qWslVrS+TRDUWc53mBc10xyPJOhQ4PLaGQD7CxpOknhW7KyN7S+h
	s6wMDWDg6karZp8qO5Jm+NQ5iSY0eRKDItwdV4K5PE73esPdVy49DLeplwEpMTfzl6TaHYu
	jM9YtyHVjzIrUaOYX0cVE+dRTDKGKxcRxzJ3FFjLBUo2hMThrf5gxx4W83tqPXouTSK/QHV
	Fbj/EYK4/8lGT1OAn2H9Kan4ulsRgOzzjEmmJ8pe1yDL3gwdlhi7hwaShXFaQoA29e8iZUf
	DKxi4AgJD9H0uNxApqArAaAc3BSbqy1kB+qzGBKzAJXNVwwwn7
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
 sound/soc/fsl/fsl_dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

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
-- 
2.25.1


