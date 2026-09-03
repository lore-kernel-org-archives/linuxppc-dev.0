Return-Path: <linuxppc-dev+bounces-26491-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1F3C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 12:30:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbJq61TTkz2y2Q;
	Thu, 03 Sep 2026 22:30:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788438658;
	cv=none; b=RDs3px6PwFoYqlJR2JyrCrSjmdrY38rY72K2IfNEUuDhTJvc4oeAcRQ6tSPwJmeirx+QNa8kHNHlfwxRybulGJoPjA9P9LfwiCt7BHCFXhbpHz6ViDvM4DR7MqWw4sk8Lqkd4jPgJ/hY5gmBlBUBrSJj8VCfLzOdHJlvc4q9cyXonLl2helz58BwkWToUfmtG0yPNJtsH7cIcMSTSA6aAtn9oO6XjpGY5jwxMuujQ9f0iTrheEuUHNl4A32pwQGiIpjzahZoUs1eJstWZc+BhgYwFsPnAvIiWW/Q2zRjFB9902SF05M3sqpYKj5Mbe+DA+ngPFTdGRyY2VjfZogH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788438658; c=relaxed/relaxed;
	bh=444nNZztaKWrtZLx1q7kQKh1w+9LbHm/QlTHTnrzmNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IZp1ACrIvJ4Lc9X+aB9p7PjI+9rdsQ5ygAgm/gefCmP4HHK4s+HgU4oWUzn0JNANyiHhhPHuD8Z6v8WRRor1hqXl3PSBQBUF7GJ2NaRRrnqCI/1cxlFzU3CID2AvxQIFsQdaZH7nuPsfYR2W9ilP1jWzZAzPykXFbA1MTCUueBeP2CFOULVJc4As0+LBI0TZYKP2hqh2vhJSCSDmojUAE1etMtD8uO83GFHxInMX5hphmcye8HWn4QvBdDFqeN4fYfuH2510uqw1UPNGWeSw4W7E7TxDTMf8IK1kS2wXtOz9b47bPsKfU+f6/KMMlo5q+/uV+2K4i0cWIH+lzcf4Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On25nqAc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On25nqAc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbJq46lSvz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 22:30:55 +1000 (AEST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c20ce3c118aso204181166b.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788438650; x=1789043450; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=444nNZztaKWrtZLx1q7kQKh1w+9LbHm/QlTHTnrzmNI=;
        b=On25nqAcN60dO1d9KD0HsnJ+PJUiLyHsa1Mzp7YbhQPkkaNIrVFCqBkORI+KHWdHjR
         nFLaduQfQi3VdIC8rcFKOjWECkMnmF2+FimNFgujwvR8Rvo31E60TdlgShlA4MEIBIr3
         Umlkv27RcvRUUDRjfbKvlzLHWBE8/Z0SGOSRAU7mzeaJMBsAPFoqxQRxMoD5KMgc9vVx
         Du7OqHU4h0buYrNt1pjIqVO1FQ8JkWXwakwRAA3nrHE5zyUoGOi2o35koocS/P/9l+7L
         tqDZfnjj74dYWSJ5Mr/Z+FT2A/hXAGAOSaayeORbDCuXjzQsFwi3WQ2iCfnmI9CaaqZn
         0f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438650; x=1789043450;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=444nNZztaKWrtZLx1q7kQKh1w+9LbHm/QlTHTnrzmNI=;
        b=ErCBV5W/hLzx2eQFmmCJJtNHLChQxhO6L8nKfn3qcsFFHYSvHBKvygF9NS63/UPC73
         bqPZKrLy8JI8zvYW6uPtfghrDx2PnnxRVOApUpek4hpaT+Tk54fd82ccozJ2J4HDf7w8
         8Qdgn6oB9HRXS+uY2CWYvirg4jw4qJn8Dg3CPhBVvmL606aN8kmoOXdWH0wMrBwTmmQw
         uj5FG3DxYspvbScw+1vG9n9Mn0v1cdwEA8hBLv+kopkPX4d1jU/YNta3Gg45E+xIKtL4
         34OGnQhzTe1NtJuKdM+foB894wAT/DE4k9L6xBkOiJJEFZ6U6pUdUZ9wU8LHTHlz8Sjl
         VKRw==
X-Forwarded-Encrypted: i=1; AKwUvBxbB7Hp5gL52bEJdL1jzZsHXrEMMJVo0J7qMVUs4Y1x8H0apx4/xIPhJM4yp04SyPcMq43rQhYu3u/uQUs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++leRx3J1tLxp1GQiQYN58ih3beySYXiJVK6N8+6LqtclbDu39ZX
	W9Gc+oh3bRvYmMp+KD75vJ63QyisXlf3KxcIB7Fqe26Ug5d1LblC6bnK
X-Gm-Gg: AYBFou0UnbILRTovJ0bCP5xPPnb9HYgSsPyv57lCQCEoqlCFJhKUAyk0NFE6Kf3F2BC
	/ykq6FlVBC1NzDPLx7GTshHZ0yBBJgBR4r34xts44pZ1jw0iDjMbisJPde2cWXbNl1x34DkT4UV
	UNkiNNILuoTZOp2OagsQ4zZuec7DX2YJd3FkLK/NXHyfo+0MwXM+nw4Ktr03oY7yvk1+WGEjI01
	uXkQJCbf/u4ZyqZ68k/43uDn8aE7p+f6CUsi5VX7lazEk9OhH9Y8Wu5fAGzKkQ4rqMP8tqWpZMh
	zJ+pH2I7daeTWhOuvpXZ5Pk+/MUhOuIU25FfNTCorrvZwZnvaOQaOcjiPQLve5yXdHGI8/EZYqq
	xtQMw6/M2vWAS28N2mhbZegZnIAqk8x1nv2m5FIeG1HkvY/iFLWyh7KH7BwE1kiSIzqFhS5+MAb
	TxyvZENPR5pp446jo/8KPyngonknpY38+1UXu/ZXwtaZyPyokQw/0U4Pd0iBEV1H4xpp1+nidOo
	K3DgGCgFLCj4T1d0oWTUAM=
X-Received: by 2002:a17:907:8323:b0:c25:f7dc:2e0 with SMTP id a640c23a62f3a-c25f7dc0985mr85901366b.33.1788438650154;
        Thu, 03 Sep 2026 05:30:50 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895d68sm2265294a12.4.2026.09.03.05.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 05:30:49 -0700 (PDT)
Message-ID: <1d7f8806-f4a0-fda0-a361-a011460ef308@outbound.gmail.com>
Date: Thu, 3 Sep 2026 14:30:46 +0200
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
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
To: Mike Rapoport <rppt@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin> <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
 <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
 <apgSCyj-h2xVc2ss@kernel.org>
Content-Language: en-US
In-Reply-To: <apgSCyj-h2xVc2ss@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2026 14:09, Mike Rapoport wrote:
>> So using vmalloc() may result in a malfunction in the data transport where
>> the __get_free_pages() would have been successful. This outweighs the
>> benefit of a somewhat higher probability of success in allocating very large
>> buffers, and surely the improved aesthetics of the kernel code.
> kmalloc() still works, just like __get_free_pages()
>   

After these few days of discussion, this is what I make of this topic.

The memory allocation in fifo_init() is somewhat ugly, but this driver 
has been out there for five years, and no complaints from users.

The vmalloc() option may be successful sometimes where the current 
allocation will not. On the other hand, there is a possibility that it 
will cause real trouble with page faults. Plus, a large allocation with 
vmalloc() may be a weak spot on a platform to which the kernel is 
partially or poorly ported.

With __get_free_pages(), there is no doubt that usable memory is 
allocated right away, and that it will work that way on every single 
esoteric platform. vmalloc() leaves us with "we're pretty sure there is 
probably no problem".

So I vote against vmalloc().

As for replacing __get_free_pages() with kmalloc(), it's a matter of 
taste. I think that if you're after a buffer that has a power-of-two 
number of pages, __get_free_pages() is the natural choice, and using it 
makes it easier for the reader to understand what you're doing. 
Replacing it with a kmalloc() is confusing in my opinion, and requires 
that the reader is aware that kmalloc() falls back to __get_free_pages() 
in this case. So we actually want __get_free_pages(), but call kmalloc() 
instead and let it fall back to __get_free_pages() so we don't have a 
cast and don't need to save the order, and assume that everyone knows 
that this is equivalent.

So I vote against the kmalloc() thing as well.

If this patch is part of a larger kernel cleanup, I suppose my votes 
don't count for much. But for the record, this is my opinion.

Thanks and regards,
    Eli

