Return-Path: <SRS0=HlSn=IJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 15:12:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5272A64FD6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 15:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5272A64FD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DxC9k4NcMz3dFh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 02:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=Fcy+PPYq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::d35;
 helo=mail-io1-xd35.google.com; envelope-from=axboe@kernel.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=Fcy+PPYq; dkim-atps=neutral
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DxC9F2Y8Vz3bd4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Mar 2021 02:12:14 +1100 (AEDT)
Received: by mail-io1-xd35.google.com with SMTP id o9so22267100iow.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2021 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8uzWR98tr30jTjAvujuKHcBKWh4iZ4wgejl+7WugCPs=;
 b=Fcy+PPYqjKJEoxOQ2vElnvB1kN93O7t/tAbO2fozxIuJSzwELE6AeFpO8Fqz2FQE7s
 m4FICO3nlvO00TFPAkSntfmWcCl0QIGQ4gTWf7aOcF1fliF86HnKTAoF8YMVYGkTzpeM
 gi8WZ6pOBLsF5MYtqBJDo/zx/GLLTQz9cUn/dMDEHgnBsOI0O2gp7Ivvh0/svwbLCPGv
 0VVBMwCegLfiFBAjGOMuE2r99gwnqqa8KuvxJcPS0c9+3xoFQY6vyHsiKqIwfV/F34n7
 0/ZYJQfT/af/RTrovanNMwfVJBDYSA0uXkwIMtrX3ehf/LKEnOcj7sm/MNnqAIpRZFZI
 jtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8uzWR98tr30jTjAvujuKHcBKWh4iZ4wgejl+7WugCPs=;
 b=C2HGBsMFA4MyqYSZnuvltBcyCw5qzWsCKZPssSgx6AmJZVTf0hrvZ3WUmG7RsvTmDa
 fTEQmcW3+p3RwHiEx+3//1r5cKEX8y4ypBRsso5yFSLglvwmoIW1+YD3qW/De2G9rGhv
 0IujROq4j4X5ZCx8odM8lEFOtqLlWywqivpjm+AgNExdtZHMxh1hgrTyHWaJyXnrDZ+J
 zM+VZUCxsYuD3KZJce26wc8WsviEegREcIzAt9FdtvYM3KzPziYYLRDYrF5rBQ69m5wO
 9g2TXuNHaOu/i3DU4+FSlHY75L0t+8HRPQrxLeLfo8ILtlOjXGcSuZRh6hHev8eMBW7R
 TX4A==
X-Gm-Message-State: AOAM531RMuubCxWzfVqk/y1wsU6Y2c4nOEXoa9VECM/1tTUYLHkQX07p
 jSKvM7ok0A+ztX6FvShRDhauDQ==
X-Google-Smtp-Source: ABdhPJz1TleSAlCcpEHwXGi4dk1lb/CpLc/h59zEp0RM2ifcqF9OCZ03Hcn2cdJEzumDie7ZXCG3zw==
X-Received: by 2002:a02:cb48:: with SMTP id k8mr4118806jap.52.1615475531036;
 Thu, 11 Mar 2021 07:12:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id m15sm1369443ilh.6.2021.03.11.07.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Mar 2021 07:12:10 -0800 (PST)
Subject: Re: [PATCH] ide: fix warning comparing pointer to 0
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, davem@davemloft.net
References: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <034a3feb-27b3-a349-6dcf-75cb36a34e23@kernel.dk>
Date: Thu, 11 Mar 2021 08:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/11/21 2:48 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/ide/pmac.c:1680:38-39: WARNING comparing pointer to 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ide/pmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index ea0b064..d5171e0 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -1677,7 +1677,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>  	/* We won't need pci_dev if we switch to generic consistent
>  	 * DMA routines ...
>  	 */
> -	if (dev == NULL || pmif->dma_regs == 0)
> +	if (!dev || pmif->dma_regs)
>  		return -ENODEV;

This looks utterly broken - the warning is most definitely about
dma_regs, not dev, and you swapped the condition (failing on dma_regs
being set, not NULL).

I'd just leave this one alone, drivers/ide/ should be going away soon.

-- 
Jens Axboe

