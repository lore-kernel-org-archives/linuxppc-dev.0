Return-Path: <linuxppc-dev+bounces-18660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9C5F532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 04:22:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffxhY5xy1z2yj3;
	Tue, 24 Mar 2026 15:22:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.77.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774326141;
	cv=none; b=RHdmQOAf0HkH7VUB+8cCrqiWmWAysCT/S8Hjvy9ehAFBqgcY5GunhcaGeS0GnDTWe8R5EBRDN0tqHkn3z3bnmYqElzfMaaHNBbMBdCJKQRIda7xmNrwpS53CnkTcb8RSbxqQ9Gisz/Gr3/mGY77/KVk5WEoEtOKm+OdAIBEDThLVLEAPIyBxVPhE+hRKcaWkoTMBfJYxeej4qtWrjghPizvt7nYkDQhf7a4p59Owcs5REquIufLFYlchbisktVW66Px/iqSXxokoHr1W7eYLNTSfwQ53E3yAPM64oD+hJHDYFLiGBp3EC9Dl2utbaL3dIm8/YQgq90IPlTBjgKUVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774326141; c=relaxed/relaxed;
	bh=aWjpVefODVGfVXeL4Actfzq6NNc7ecramkA8bo/aSVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5lno6PyLoNvNBjkCMJVII5MsYd4UataOUZ5bHfK8lDkEMaZGHXdp8dt1J4QpLcivT8VhasXSB6FB87yHB9ZhVRvRTJTBtxZYW1UGkU7bfuF/Y7boJRTnt9h8zVOAjMXryhGcUtm67jxkT7Kv6KSe4KQVSzJEKOTVGGNYH+AE1UVxOFlWb9NIgTtdfr5gKWLfYxiG7gmpF/mH2Sh0vmH/izCS+1l2S4C40ePjnVH0B2memUVebp0yEaSHPEnDnIEZzDmV8b9WIkrwzx+ApvkhNbiizzR2Jt7i7hNetwOM1foyn9yTJ5iwPH4TPBPkMLv+cmUcfKTGIBx0SmHREVH4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=d0+L5eJr; dkim-atps=neutral; spf=pass (client-ip=114.132.77.159; helo=bg1.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=d0+L5eJr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=smail.nju.edu.cn (client-ip=114.132.77.159; helo=bg1.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffxhQ0RmBz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 15:22:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774326110;
	bh=aWjpVefODVGfVXeL4Actfzq6NNc7ecramkA8bo/aSVM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=d0+L5eJro8pKveucK3YjowvGDm1C7hfxtWEWq7QU/iBjW0QtiTnwGBKZEM31EPhOf
	 DL0e4gqxfeHRGWgVYMvSv/jZyFJ5OKns6JhbBwFBE4GUEGisrZpe0ycJJKVANRcAAy
	 +esYB0wjWt96gCmIaaF5cffbN+PafxuJhxzp4F6Y=
X-QQ-mid: esmtpgz12t1774325682t71fc2e62
X-QQ-Originating-IP: y39DWRFR+KvMsH7cahujPSS/bVwFdVvQK2xZT0ODzzY=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Mar 2026 12:14:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5138743655956083736
EX-QQ-RecipientCnt: 17
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: broonie@kernel.org,
	lgirdwood@gmail.com
Cc: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	kuninori.morimoto.gx@renesas.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH v3] ASoC: update outdated comments for removed snd_soc_new_pcms()
Date: Tue, 24 Mar 2026 12:14:00 +0800
Message-Id: <20260324041400.16217-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8c20f43f-be8e-4a03-af80-9c91a4a233c6@sirena.org.uk>
References: <8c20f43f-be8e-4a03-af80-9c91a4a233c6@sirena.org.uk>
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
X-QQ-XMAILINFO: Mom5ezI3X1cDlFd9Wlpm9yQYl6IUs67iGO2GVx0vSXqQuZtOMRLC1MJu
	09sFGrdWlNzRp7HoGlMwczUOzMHZuqIR87UDoRTRatFVpnfaEFFQRpy0u9BTaDGEtjbjKlO
	hfYZQQDqm6SeuXJreWecNLVf+3uvp/HdMkroHQbq0NClQDjfaSe/kvZ69ddWunxegnTh+h1
	Fw/N22qkE5NtlKQr/PQbpLD1AhV2FeB+BFZdsVVIg9qMD+VdJCA2Io4MaAXpxO7DIqaoCjn
	rRcqA+9+UUqVNVAn3lsvkJezRLm7nT708bTNEVyhECOrQjaStZx6kxa5Oo8dYwqQ0crewQP
	wF1K7NwtRIx4BqUWSXnV6uICC1FofmuK8jNNJIBNFQYN3soBjFFCZ+0G+xwZihBiU8gcG1y
	3RMH4cwmVpHqqXGB4wVXKAy1hmmoY6iENtYe1uLzvrxXp/uvBv64D+nZUjA2p7Sf2CBviZb
	pt4clOgkKcVT0cZBBcxOwzYOrjx0aPqeIIpkOfNGY13GUVznANiYicDlhpcO8DWRKfJhWda
	566aQykquw6GOojLqPe5w3g7LeG/9L3E8Qu9mi7obWHBtHJocCi8d7BhDLTO9LJ53UAxUAT
	N4DatAgsW8rnjmUZOILq6sG+GnMcwWL35ZGf4M8LEPqoOO+TxLyjTG/vJ33n8Bq0L47xag7
	WLRoMIESA+M1YAhNUPgNNo7xNureZ4mtVwTtV+jOxdNdg8FdlljD1zH5Y9n33D4faL4sIw1
	NnHTTa2KOueM71Js11ZHBF7eIQhiWH5XW33K4pMOQB8kmWd0t8D9k+ACBsRgJm/3TpVJ/3W
	ejfL3Ru9SlFG4WI7p4p5L3Gu2eK1NNKSbAFmSDMrRKFRoqtWzsQryy/2uF1N2yvItSyrJ5q
	74RoeRBKc6daU3evuTc6AJ5wa7tAn+zZNLd+WaTXCFooJf+MT4UvX59+62RjEDr8+PR4rHI
	MrqAxmII2CQGHt+wbElWZL/07t6D9NE6ZxyyL88jM5hWxv0BlAq3DAEB+za1gxdkSgNeQ+l
	tiU0W7jVE2D/UDssxHx3WFPbdqckjudkaHQrv70qyThrVHnqLF
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

The function snd_soc_new_pcms() was removed during the
multi-component refactoring in commit f0fba2ad1b6b ("ASoC:
multi-component - ASoC Multi-Component Support").  Its PCM creation
role is now handled by soc_new_pcm(), which was later moved to
sound/soc/soc-pcm.c by commit ddee627cf6bb ("ASoC: core - Separate
out PCM operations into new file.").

In fsl_dma.c, update the comment to reference soc_new_pcm().  Also
remove the stale paragraph about snd_dma_alloc_pages() always
allocating in lowmem, since commit e159704f7920 ("ASoC: fsl_dma:
Use managed buffer allocation") replaced that call with
snd_pcm_set_fixed_buffer_all().

In siu_pcm.c, remove the stale comment referencing
snd_soc_new_pcms() and the no-longer-existing socdev structure.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
v3:
 - Drop "via the pcm_construct callback" from fsl_dma.c comment (Mark Brown)

v2:
 - Also fix the stale comment in siu_pcm.c

 sound/soc/fsl/fsl_dma.c     | 10 ++--------
 sound/soc/renesas/siu_pcm.c |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 26ddbe867b58..1facb7bf0b77 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -267,14 +267,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 /**
  * fsl_dma_new: initialize this PCM driver.
  *
- * This function is called when the codec driver calls snd_soc_new_pcms(),
- * once for each .dai_link in the machine driver's snd_soc_card
- * structure.
- *
- * snd_dma_alloc_pages() is just a front-end to dma_alloc_coherent(), which
- * (currently) always allocates the DMA buffer in lowmem, even if GFP_HIGHMEM
- * is specified. Therefore, any DMA buffers we allocate will always be in low
- * memory, but we support for 36-bit physical addresses anyway.
+ * This function is called by soc_new_pcm(), once for each DAI link
+ * in the machine driver's snd_soc_card structure.
  *
  * Regardless of where the memory is actually allocated, since the device can
  * technically DMA to any 36-bit address, we do need to set the DMA mask to 36.
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


