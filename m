Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E8C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 14:59:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EAE217FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 14:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EAE217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44klkt0Qz4zDqMr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 00:59:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=yuehaibing@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44klj36WglzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 00:57:59 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2CB14854AF18FB4DA879;
 Wed, 17 Apr 2019 22:57:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 22:57:48 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <geoff@infradead.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Subject: [PATCH -next] ALSA: ps3: Remove set but not used variables
 'start_vaddr' and 'pcm_index'
Date: Wed, 17 Apr 2019 22:57:22 +0800
Message-ID: <20190417145722.20448-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
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
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warnings:

sound/ppc/snd_ps3.c: In function 'snd_ps3_program_dma':
sound/ppc/snd_ps3.c:236:8: warning: variable 'start_vaddr' set but not used [-Wunused-but-set-variable]
sound/ppc/snd_ps3.c: In function 'snd_ps3_pcm_open':
sound/ppc/snd_ps3.c:529:6: warning: variable 'pcm_index' set but not used [-Wunused-but-set-variable]

They are never used and can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/ppc/snd_ps3.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 521236e..f77a0d5 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -233,7 +233,6 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
 	int fill_stages, dma_ch, stage;
 	enum snd_ps3_ch ch;
 	uint32_t ch0_kick_event = 0; /* initialize to mute gcc */
-	void *start_vaddr;
 	unsigned long irqsave;
 	int silent = 0;
 
@@ -257,7 +256,6 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
 	fill_stages = 4;
 	spin_lock_irqsave(&card->dma_lock, irqsave);
 	for (ch = 0; ch < 2; ch++) {
-		start_vaddr = card->dma_next_transfer_vaddr[0];
 		for (stage = 0; stage < fill_stages; stage++) {
 			dma_ch = stage * 2 + ch;
 			if (silent)
@@ -526,9 +524,7 @@ static int snd_ps3_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_ps3_card_info *card = snd_pcm_substream_chip(substream);
-	int pcm_index;
 
-	pcm_index = substream->pcm->device;
 	/* to retrieve substream/runtime in interrupt handler */
 	card->substream = substream;
 
-- 
2.7.4


