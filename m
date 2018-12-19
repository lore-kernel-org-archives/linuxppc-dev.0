Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE622C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:16:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B6121850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A74uoSdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B6121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KW5C6wDVzDqlD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 21:16:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A74uoSdg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="A74uoSdg"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KW2H1bT0zDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 21:13:59 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id z5so18849536wrt.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 02:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RiG9R+pTBJ+wo09muSLvkbd/uyR8IeV+vfYTak13++I=;
 b=A74uoSdgG/dDBRk0pHhIWzth1/lN2pNwM85hymlWQRETjQMl8p44kAIEFqMeyZosNh
 Ra+nS0MsRF8YzCmFOkEMm9y5ItVDcQ/K98ihZLMWntG7lFFdDsfmq6D1KCIArFQxGy5X
 xANSaOuwSqIJw6t/0CJnIVIsuLmk06YN6wFBmG0ObEcqp33YQr3Ua0jBXh0E7R1wORT7
 a1Dl9RWEGgd1iqhiQJxOtH1Pky//qxwXhJS6lN/eqQrPRv8w7hKHtu6I7Weigq0YzAqs
 bzGiJH6EbLDKXjc6M6YXpjB5wA0fejqLbRt9Vcojjf+n9EI77Wnwlq/PysQpQaD7Wza3
 uybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RiG9R+pTBJ+wo09muSLvkbd/uyR8IeV+vfYTak13++I=;
 b=mj/djfBhCJmafjgIT+0zs6gO6P4l4m6bd+1tMUeLHFsCNAwjbi2+2DIswO4Sp/SI8G
 umO6sIOVd98JGUJIhy/wqulPs2LBIzdbOOh46sB65HiUoRCRjEd9DqDz7Bx3HVGkbC/w
 CKdFFAk1lfL/V5Md5XWuPf1/yJ+dHoRmmmroIzCCF1CTdCMD2ePJVKLuRZ2f4Ljm6oED
 xwW7OrE0V4Ak2Z5qfpekAolvG0fVDTWAGR9J/K+/0KprVO4mLsKJnJBWyFrsWQOlR7Vp
 U/WGmqqTEYxlxJkV03FlKVtFfMAp2KzDj7cOMVlePOGNySd9S9D1MtK99jZU/bItp2Tt
 g0Iw==
X-Gm-Message-State: AA+aEWZzowxAH8st5KxjhFc8I9//Yfu5UTdg6O/6RzAoz3eTYtRff2wt
 HVSNwze6pvTFVJEoDeXi83I=
X-Google-Smtp-Source: AFSGD/XMhqkui+fC2OWG4sICqm+XoDzXqNsC99MCq+CPzVEqfR+iWRehRkkEkrQ5ndw9pRgYNqptzg==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr17938679wrt.180.1545214435647; 
 Wed, 19 Dec 2018 02:13:55 -0800 (PST)
Received: from debian64.daheim (p4FD09F04.dip0.t-ipconnect.de. [79.208.159.4])
 by smtp.gmail.com with ESMTPSA id
 c13sm6574545wrb.38.2018.12.19.02.13.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 02:13:55 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gZYrS-0001b7-GA; Wed, 19 Dec 2018 11:13:54 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/8] crypto4xx_core: don't abuse __dma_sync_page
Date: Wed, 19 Dec 2018 11:13:54 +0100
Message-ID: <31539448.CJ9vbHY1ld@debian64>
In-Reply-To: <20181216171951.31306-4-hch@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-4-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sunday, December 16, 2018 6:19:46 PM CET Christoph Hellwig wrote:
> This function is internal to the DMA API implementation.  Instead use the
> DMA API to properly unmap.  Note that the DMA API usage in this driver
> is a disaster and urgently needs some work - it is missing all the unmaps,
> seems to do a secondary map where it looks like it should to a unmap
> in one place to work around cache coherency and the directions passed in
> seem to be partially wrong.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
I've loaded the series (+dir -> direction patch) onto a cross-compiled
vanilla 4.20-rc7. I can report that the box didn't crash, though I would
have liked to test with DMA_DEBUG.

Tested-by: Christian Lamparter <chunkeey@gmail.com>

> ---
>  drivers/crypto/amcc/crypto4xx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
> index 6eaec9ba0f68..63cb6956c948 100644
> --- a/drivers/crypto/amcc/crypto4xx_core.c
> +++ b/drivers/crypto/amcc/crypto4xx_core.c
> @@ -596,7 +596,7 @@ static void crypto4xx_aead_done(struct crypto4xx_device *dev,
>  					  pd->pd_ctl_len.bf.pkt_len,
>  					  dst);
>  	} else {
> -		__dma_sync_page(sg_page(dst), dst->offset, dst->length,
> +		dma_unmap_page(dev->core_dev->device, pd->dest, dst->length,
>  				DMA_FROM_DEVICE);
>  	}
>  
> 




