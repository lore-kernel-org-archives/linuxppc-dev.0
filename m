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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB4C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 05:07:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283D020685
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 05:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flV+iVsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283D020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pLJs1pc7zDrj2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:07:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="flV+iVsR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="flV+iVsR"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pJ6k4V8QzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 14:28:30 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id q19-v6so733345pll.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 19:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:from:to:cc:subject:mime-version:content-disposition
 :user-agent; bh=wYFxU3IgUhH7Pg9xyygtwXTqyyinwl8/Zz4uYWqkSjM=;
 b=flV+iVsRR0fS+JvDKGdjZC17a+0ab2sA9mrg/ownHRB1YGDS+KKYNcF4ktpjVFm5q6
 jyJXdBbBYv4FHBZnV/Vie2CuIuVI7R7pC6HeWOQKQahjQu/gGTEKAsrpAGyWcPwpeHWp
 ORVGdi1Qrzd2Rq91lFr4V22ovcz+I/rrV5xBk0DUfPxFW8rgwRvUmu2Ke0Z7c4ZhroFY
 DjXBgOmQndPnVRN02olXNHW1YXaIhTq92UxgNfPr3HhZGbDiFxnkgoDt0j5kGqX2CSBW
 m6sk86PgOKapT/irSk9/+EptlMz/tU5ifF4XRjbYK2CrxWJaYyVtFH60Wgl6qkTPdE6F
 P6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
 :content-disposition:user-agent;
 bh=wYFxU3IgUhH7Pg9xyygtwXTqyyinwl8/Zz4uYWqkSjM=;
 b=liNESQCbLbLTr/rHMmt8Uwl5YbQw+l5cNCu+BFrz5JFCazaFICTr9wNjhRcqNYdgTw
 iImvyHEEEX8fnUzhv3cLycXvMCyydZivbc97Hg0GhYDZd1haTatWOQ0U6h7vCoH2aXIk
 kzMv1ZoB+vTlPM/VWFUpiciaiMqrgyExjs5JT/FIJYwprIjZA0+vjPNz0u8Nm7OdgIqF
 grkwTNVSDHdyT21WWwVagOOVlepe2ndVAN9L2pIJG2PXDvRdThU6HWSmM/jj2vjDSPWj
 j+t4XD9nbSBN8zFGpt7/YqyNwj8k1GuxFjMRHdzL0eYNUxwrXHg0zxtN39wTTQX1/7Oq
 GkbA==
X-Gm-Message-State: AGRZ1gIOle7KZ+iZjU4OpELYP5cBU0yRCB4DMpTywet9hZqoiw6J8a4Q
 Z0lAaMJsxzTgoIY4Scqiy6g=
X-Google-Smtp-Source: AJdET5c2enpqGILU2L4gaIWZulXIPLzP5lJZbt5P6hNRj8/1XfZsPqhKeDvURoW9x67UxqpRbH9S2Q==
X-Received: by 2002:a17:902:8306:: with SMTP id
 bd6-v6mr20455502plb.321.1541388508206; 
 Sun, 04 Nov 2018 19:28:28 -0800 (PST)
Received: from sabyasachi ([45.116.191.235])
 by smtp.gmail.com with ESMTPSA id a19-v6sm25626919pfi.138.2018.11.04.19.28.26
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 04 Nov 2018 19:28:27 -0800 (PST)
Message-ID: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
X-Google-Original-Message-ID: <20181105032823.GA4558@sabyasachi.linux@gmail.com>
Date: Mon, 5 Nov 2018 08:58:23 +0530
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joe@perches.com, darren@stevens-zone.net, christophe.leroy@c-s.fr,
 geoff@infradead.org
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
Cc: linuxppc-dev@lists.ozlabs.org, jrdr.linux@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/platforms/pasemi/dma_lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 53384eb..d18d164 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
 
 	chan->ring_size = ring_size;
 
-	chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
+	chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
 					     ring_size * sizeof(u64),
 					     &chan->ring_dma, GFP_KERNEL);
 
 	if (!chan->ring_virt)
 		return -ENOMEM;
 
-	memset(chan->ring_virt, 0, ring_size * sizeof(u64));
-
 	return 0;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_ring);
-- 
2.7.4

