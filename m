Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ABBC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 05:05:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4C52082A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 05:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsOh+L3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4C52082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pLGJ5qxczDrTH
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:05:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WsOh+L3X";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WsOh+L3X"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pGg76q14zDrPq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 13:22:56 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id z17-v6so3487916pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 18:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:from:to:cc:subject:mime-version:content-disposition
 :user-agent; bh=BE0uneAliIQj15grJEVBKhotfSmzBF425o7pPM7Pdi0=;
 b=WsOh+L3X85l+AVl8iWwhF61y56BMomC7JcfybqEb18fTsiPW9eVeoFq9tlOMuGyKpZ
 wIatB6Q9wisJOHNOUwohP66/9xIZUVIUTL3Vq7ABv74pJbiUL78Ip29L/oWFQ0pZVqgf
 QRL8sNObfnj78kq8r6vIRAJDQvB648C6J3G2TSzWFPIdko8fPaTUbQSSrpVhz4eiRh0S
 iNB1Hzl1zZ3OOYUFooHRo3McQ+Cbl3/Uios4jIf7xj23UxlwrCfoEJfx11BS6CcfItXw
 WTDlhoE9X44kyf3XvBIQxh4r24S9EeybiKL1+mM/DbApGVcwc2kUZyLGjf7RVVOgaETA
 Mkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
 :content-disposition:user-agent;
 bh=BE0uneAliIQj15grJEVBKhotfSmzBF425o7pPM7Pdi0=;
 b=gm7GDOUWLvN1zd5xgd4MwXNwvZptLWlSXsGqpQyF7+0ozojCUAXoUeq+SIblSiTJML
 YGSvo9oqFQOa4fuQAdRqIDvkTiMae0umFyrZIIuvEhuxVoeJuOjUNl8X6mTqkGR+1TrR
 h8YzSAn4l+mSFcxyy15qOIi5huoVZUL9S/DM3wxBY2omTfNXWRVupoY2/cfil2Vqld2q
 WdCnt1HFgeGvKlX3zuhXEsIUTZH+3hL8h2++hzA/J+Q4WgH/U4/IcQXkM4MSGLRJaQeh
 yOB1BeYV4Ss9imYiyjFpVQk3pbqR97Ph36ZJwSVngz8sYhxNNRtPGOaXxWktEW42dWwx
 fSDw==
X-Gm-Message-State: AGRZ1gKKvxKeJt0YTNNDX4lMS8pLvMtzTSx+qIRzhbv7UAj0lbeQO1cL
 eLpm5ks7iCuMTKSkyWTWeok=
X-Google-Smtp-Source: AJdET5dr//wPfB84hiFTbmIBg9mCDUjMeAJli08gGvf5l5f2cy6EuyRU249AetEVAn3RMrVkkCxGDQ==
X-Received: by 2002:a63:ed09:: with SMTP id
 d9-v6mr18341226pgi.305.1541384574644; 
 Sun, 04 Nov 2018 18:22:54 -0800 (PST)
Received: from sabyasachi ([45.116.191.235])
 by smtp.gmail.com with ESMTPSA id a189-v6sm11349126pfa.116.2018.11.04.18.22.52
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 04 Nov 2018 18:22:53 -0800 (PST)
Message-ID: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
X-Google-Original-Message-ID: <20181105022248.GA4159@sabyasachi.linux@gmail.com>
Date: Mon, 5 Nov 2018 07:52:48 +0530
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] arch/powerpc: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Mon, 05 Nov 2018 16:00:35 +1100
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
Cc: brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/sysdev/fsl_rmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index 88b35a3d..8b0ebf3 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -756,15 +756,13 @@ fsl_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 	}
 
 	/* Initialize outbound message descriptor ring */
-	rmu->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
+	rmu->msg_tx_ring.virt = dma_zalloc_coherent(priv->dev,
 				rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
 				&rmu->msg_tx_ring.phys, GFP_KERNEL);
 	if (!rmu->msg_tx_ring.virt) {
 		rc = -ENOMEM;
 		goto out_dma;
 	}
-	memset(rmu->msg_tx_ring.virt, 0,
-			rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE);
 	rmu->msg_tx_ring.tx_slot = 0;
 
 	/* Point dequeue/enqueue pointers at first entry in ring */
-- 
2.7.4

