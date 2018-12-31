Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E625C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 17:25:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE06120652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iT+YfaH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43T42D5HtxzDqKy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 04:25:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iT+YfaH+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.dk
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="iT+YfaH+"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43T3wk3RrpzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jan 2019 04:20:22 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id h3so13412355pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nb2eVXWKZAJmf0jz58cAXJqYCHFAQuo+JzLOod8kYm4=;
 b=iT+YfaH+k8PoUjmfSscp9pHfMA4ph63dkhC1/ufWA81TAAN/3wx8789Zp2KR+mNlVh
 5GkprpHSRWWtmXKRcGF/X67IrVA4+39T+zAJmeIcdWEk0qeGpK874hECGgt9POjhiSxl
 8SD40lXtAy+ZccEYwD4eqxyvwxGvol0ITjvWzEWriME8qb7Dv8yWQWBlI85aw1znssdB
 MU6hyrwycQdokZCaXSJEVHUUc2EvZkfTOXryM0Gm32lp/gHLVYUQTxCa5MKkuySP7Y3l
 Y66YUgE6S9teg8BKrmghcXNCYyFiiC/ar+rB9z/7GzqAIcA4EQWJCuZdGSBBkPMexN5e
 tNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nb2eVXWKZAJmf0jz58cAXJqYCHFAQuo+JzLOod8kYm4=;
 b=rg8RKa59QSbURPznB1AtA8cfzT/a0yFP8yZ5gCuu2wV6jorwrU/F/ge2QHrdiIL7y8
 dBRT5IrNUHJCMf76crfSzoBZtsg5bDRbHONi+hsEO7QYD3qLXBAyF1M4bnbgdBfsKQ61
 d3nvXL2JsDofUo8hh2S6rCfScF17pvFcVuOBsIc/YfDaIqZ3Daqbtq1m7MLEKuD6sCZn
 02AbGRtjfkLU6Gp5BsPRGTZ/q3n9wYghqmhyYrlLuOLyta/EJwZ30h16b11iIficIuPY
 fYI72YkusKx/iJFRUOyUjH9cMsY4uSYUYgSkYPcUX+eDIqfHgKqZgUcSdYBt13YVyOxr
 HoKA==
X-Gm-Message-State: AJcUukd0WOIbI/8kz1/w1IG4NY5oI9GHOjBu0hunx9VgHrn3LF8Djly8
 hM2s9Hd7NoUytKaynvQItqPKiMjSk/DEZQ==
X-Google-Smtp-Source: ALg8bN5NtjBGQY/Af5MitsQfwaPXyGWw+TXoYAE1Fg4yKcLBUxsmJNR5fp4dTLI3jNqvIZAyW2sJ2g==
X-Received: by 2002:a63:2586:: with SMTP id l128mr8301096pgl.104.1546276820383; 
 Mon, 31 Dec 2018 09:20:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
 by smtp.gmail.com with ESMTPSA id i193sm76888608pgc.22.2018.12.31.09.20.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 09:20:19 -0800 (PST)
Subject: Re: [PATCH] block/swim3: Fix -EBUSY error when re-opening device
 after unmount
To: Finn Thain <fthain@telegraphics.com.au>
References: <177ead1d637f617792aa5ca2ee294d61e3d0cea2.1546235049.git.fthain@telegraphics.com.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <75422eb4-a0d7-c71d-643f-24496d86c74b@kernel.dk>
Date: Mon, 31 Dec 2018 10:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <177ead1d637f617792aa5ca2ee294d61e3d0cea2.1546235049.git.fthain@telegraphics.com.au>
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
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/30/18 10:44 PM, Finn Thain wrote:
> When the block device is opened with FMODE_EXCL, ref_count is set to -1.
> This value doesn't get reset when the device is closed which means the
> device cannot be opened again. Fix this by checking for refcount <= 0
> in the release method.

Applied, thanks.


-- 
Jens Axboe

