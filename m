Return-Path: <SRS0=844/=ZV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB60C432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 16:06:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B57215A5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ixA6CFkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B57215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47PfX06NlJzDr39
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Nov 2019 03:06:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=axboe@kernel.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="ixA6CFkE"; 
 dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47PfTD6xpzzDr8r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Nov 2019 03:04:13 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id y21so13428008pjn.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=55yYEkm6RHJrPbGEbz5YaTrG6Snd2G6eoPVI+U2I9sw=;
 b=ixA6CFkEosFzfEFCuAMfiMcqA4yRfzWdPkgAQy+nlXnxzy72RoRXy12bxu7vVQRGW4
 q2Urr/WgXBsoiltbaiFdJaW+2Ic6va6kdHryTK502qDrAKETHoB0ztHiluS9AhqYclxX
 ftLioSXEjsN+i39I0lBJtS40Xs7f7kdq2eGx4xJL4uq3bMnocnEaf0kNUylJUjVZ68wo
 2gt9Bp68qEiH2AuFun6lNbK3qj9MugJ+4QALqXdBC9vvd9wljCgh85MKJK0cGK+PmaKZ
 4+wUSu9VMHM2G8xjmQL/g6EqfZX3IavR0EP16J317lBJzIRC88cftXSovW1ooylDjU1+
 DPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=55yYEkm6RHJrPbGEbz5YaTrG6Snd2G6eoPVI+U2I9sw=;
 b=JqVVWoDKuXAQHERk8BM02Al9XgYjSjid5zhV4XPcluUgfMvkEx842pbmow+ucneI8k
 mfb7xLtkfIpg4pZI//HpmdcM3tKYIJYkglMnKrNYP0weGl1j9U92r+IrD/X1iz/sStBp
 77jw1Ysz7I/Dk2aZQaL3fkdRZPBy6PHLQ3rlqDzUusUn30rbXTZAmj6n+fwbsaH8GZST
 kuljZzdulTZvr/d+qvay8N/+HCX5E8n65bFiZ7yKlzHUfSS9NiQKWFt0q07y+2R6lifI
 vQTbSywmAEx69dKYDY73EG5/3utrJw7SDMFoj2mS1wChhKIK7yei5/QcVoMJArOxTfi5
 DBBw==
X-Gm-Message-State: APjAAAUVn83PpxGs13bwdjOpHN1OqdY+Di8JWs2Qi8djQ9tTwi9QSAoH
 rhDIWGgIHD6+uLwPE74ZyUkoPQ==
X-Google-Smtp-Source: APXvYqzLZT3KWZYjNqWSQy2mj7zlWghNfW8U+ubCCK8iIBbW4a8KCTN325YznK1PmfsXvxdONXDJng==
X-Received: by 2002:a17:902:b90a:: with SMTP id
 bf10mr15393104plb.45.1575043450234; 
 Fri, 29 Nov 2019 08:04:10 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:99f0:a6fb:215a:45a7?
 ([2605:e000:100e:8c61:99f0:a6fb:215a:45a7])
 by smtp.gmail.com with ESMTPSA id ay16sm13351352pjb.2.2019.11.29.08.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 08:04:08 -0800 (PST)
Subject: Re: Build failure on latest powerpc/merge (311ae9e159d8 io_uring: fix
 dead-hung for non-iter fixed rw)
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <71cf82d5-5986-43b7-cf1c-acba429a89d6@c-s.fr>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3a95d445-1f5c-7750-f0de-ddc427800b3b@kernel.dk>
Date: Fri, 29 Nov 2019 08:04:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <71cf82d5-5986-43b7-cf1c-acba429a89d6@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/29/19 6:53 AM, Christophe Leroy wrote:
>     CC      fs/io_uring.o
> fs/io_uring.c: In function ‘loop_rw_iter’:
> fs/io_uring.c:1628:21: error: implicit declaration of function ‘kmap’
> [-Werror=implicit-function-declaration]
>       iovec.iov_base = kmap(iter->bvec->bv_page)
>                        ^
> fs/io_uring.c:1628:19: warning: assignment makes pointer from integer
> without a cast [-Wint-conversion]
>       iovec.iov_base = kmap(iter->bvec->bv_page)
>                      ^
> fs/io_uring.c:1643:4: error: implicit declaration of function ‘kunmap’
> [-Werror=implicit-function-declaration]
>       kunmap(iter->bvec->bv_page);
>       ^
> 
> 
> Reverting commit 311ae9e159d8 ("io_uring: fix dead-hung for non-iter
> fixed rw") clears the failure.
> 
> Most likely an #include is missing.

Huh weird how the build bots didn't catch that. Does the below work?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2c2e8c25da01..745eb005fefe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -69,6 +69,7 @@
  #include <linux/nospec.h>
  #include <linux/sizes.h>
  #include <linux/hugetlb.h>
+#include <linux/highmem.h>
  
  #define CREATE_TRACE_POINTS
  #include <trace/events/io_uring.h>

-- 
Jens Axboe

