Return-Path: <linuxppc-dev+bounces-26364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC83C624C6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 08:44:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYzth0pCBz2y2S;
	Tue, 01 Sep 2026 18:44:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788252268;
	cv=none; b=iOMM1YFf4zEg2jLq0Gs2cckf9/+evN37WdzpdtrJ9dq6wY/i4ox0VruLqMx99Ch6Y9xdWLrwHFGEyccKXhDXuvkpAMKme1ysJ7C2395JcKbjNwR/z+3S9Hz2eFBUJIaVuKQ2VbEQrAi3xV3Up7jUAFEN4CBWaxXP9ZF1N0NxdXKLEI93s7xr4UHooUNevMfssRfUIehSa/W1J/ZSLgCxEN14ROVlf6X+4Hzm7bjpCCSBwyyFhAmx7mJZAdcTjuEztR5j7j9vKuppKcibC0H6j3EMx6f1bD6ZuNQ/A7cye+qNvS+AxgAgEeDzOB9U+yc+lnqH8TJxas1bfDtIWX2U0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788252268; c=relaxed/relaxed;
	bh=kfkumJrDF1tZTAVRjvzgDO3hMk1gGG9KZ2g7tgv7l7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ1nvvfvkyXHGUjddy5vs2wSeOjAgAPCLpVkgMF4Q6D43id4xChxuCJ8CCpuWm3HtES+t1xTYh039CxjurEDhDcyN3tTVFzx/mPzJ/kV6OBRX8Um13QmSvtcGf6i0i7g31KnT81wEahhjHdyBWP/VDnx1f8GdyayxXz6Hl5EIKN96XMy3ThonGQuis3EBj7BVmT8Fs574NIjD4B2aWW7L6+QFLSnGa5U3nGQQ9JA791OQDiDeguZJVhJPG6eiC5K0riUqmqfOu1BEMhhskNtlH7zNeaYEacKApazYJNUZm+EhITBEFqxQGMD1+iM9ulES1FztNhSkWoINSEhSwG7eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=THcLOMbE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=THcLOMbE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYztf3PxCz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 18:44:26 +1000 (AEST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c252e703fa3so657279366b.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252263; x=1788857063; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfkumJrDF1tZTAVRjvzgDO3hMk1gGG9KZ2g7tgv7l7Y=;
        b=THcLOMbEXA09TjV2GiazQa+nwAKFv5vS5QTYwapiwbwFXrYT8wnhcr42wFv9onAZhg
         3csrAIgUZ+qrl52z1EtvW0eTrBhHBZAuSphXaFxO9zEFnrXrsPkLj8Xwc7sy+jJf7Cae
         dTm8sblTb1yUZFqyIbNMDLgoGIvSpUjmeXVuvRapcQYuoVHInIeSQTksL7undtIEnv0v
         bWcry8bppM9FLn84QM4lH9W3Aqn35H4NBrWQKw4rtEveI1W19HvIhC9prfmOEzzKbZiH
         F+0PupgeaHb+LAi/Xa2JztnyWAVBDzcPTlGl7ao1qxYeOUoyDze9hsbDHR25FoFeMwcc
         YnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252263; x=1788857063;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfkumJrDF1tZTAVRjvzgDO3hMk1gGG9KZ2g7tgv7l7Y=;
        b=RytsvN9ES059GQHy7ePEqi67c6X17Q7YrDc2TubtymZdIXkoheglV2WQFegbc1V84g
         t1pYpPrwJt7VjSJPig6pWBBewBFoaP5o3jcp3P5230IVW+UZ0ycqAh+LArdmE+Z0Me6J
         ntFdqIbn+KruJrNHUr5JTTxH9Ph+ZLJL1mMa/XTKet1td2QKymquhijGsVZ4NUg0G876
         TojEGIU79yZLFT3OYtAMCbFy4OoB2Er++ko6obxPBoUdmxwYqsfu4HqP7nTsB2KSLA5U
         WBQ9wxKUhp+CIDjcOG5EIH1ws8zk3e3capnGKJHGRbrIgFhI42/2y1TdcoyxLCIcCiLD
         qZ6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpAIt6PF4k1RJPaEbrGiPerblqT1BBbK6j+6XJKl8Dcc+Sj3iN5NSndj0MhxnuZvRloKQIuNJ5HRUFadKQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nTycI7wyfADemCS3cU57DYL89hg+VIBiR/lk6GRjPH0Wc4YnJt
	gJ8vyLFsnw7+jCXZ4MLXVhxSWAFHNY7VOm4jOUeAoMwPMV6j2CBzEOj1p55gJ0Yk
X-Gm-Gg: AR+sD13Jo4LnR9PfztRyY34jGZJsOzpw9lv1VPKqo79Aqo+DIMTjD3X6nRBSlUdXwxy
	KJpfl+aWOQ3Mh9PvpYtg4IP9L64hYxNbkE+XIX9ftBj/70nreMztWNqnz2hzCIVbMIWJLBY/VMY
	mTrXugAHvvHriGkrqnZNKLCTO90YMJBBHEcqOGRDMPO6F3Y2pRSRs7LAU9lZzjm7Vbut2P1qxpW
	Yc3zP7xaRBA9i1HMk9m03S47bR4pJnsZwnskottxcapAtbmM4FQueXBMZaxcULSCdczYLotyWnr
	3/EdCh+y5rYQB6QbpGNf4qgBSTKapGnkWhLz5BATx4sS9gYF/OB2DZM8m2ed5wEbU52Uwp0WSBz
	qK+vEgGxL/D4J57IK1i/lQnB6Plo/0ZEMlnARfSh00f7bBaF4VlyYklFZ0EZDVmVVgoTagI86uh
	seciSX8vxvM91zuA3wj0Yv4eO9zxFr6BHTOj5EcRB8ahnMUqmdsrNBVItAOFJYiyjB5FvBFhV7r
	SS5D7r7dvfn64unCFsUTgg=
X-Received: by 2002:a17:906:f582:b0:c24:c22c:6372 with SMTP id a640c23a62f3a-c25b3affecdmr382949666b.5.1788252262902;
        Tue, 01 Sep 2026 01:44:22 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255eacf6bbsm527267366b.0.2026.09.01.01.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 01:44:22 -0700 (PDT)
Message-ID: <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
Date: Tue, 1 Sep 2026 10:44:20 +0200
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
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>,
 David Laight <david.laight.linux@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
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
From: Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <apaF1HUtJnstuUN4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2026 9:59, Mike Rapoport wrote:
>> Would it really make sense to allocate the four buffers separately?
>> And/or use vmalloc().
> My understanding is that the buffers don't need to be physically
> contiguous and vmalloc()ing the entire fifo->mem in one go should work.

vmalloc() is an interesting point.

fifo_init(), fifo_write(), fifo_read() and fifo_mem_release() implement 
a FIFO in software that the XillyUSB driver uses internally.

The memory for this FIFO is allocated in fifo_init() by calling 
__get_free_pages() with requests for up to 64 kiB. With the maximal 
total buffer size of 256 MiB, we have a possibility of 4096 allocations 
into an array of buffers. And if __get_free_pages() fails, the size of 
each buffer is halved in the following attempt, which tries to allocate 
8192 buffers, each 32 kiB, in this example. And so on.

This mechanism with an array of buffers complicates the implementation 
of the other functions as well.

So why not replace this with a single call to vmalloc(), possibly asking 
for 256 MiB in one call? That would mean simplifying all four functions.

When I wrote this driver back in 2020, I avoided vmalloc() because Linus 
wrote "vmalloc() is NOT SOMETHING YOU SHOULD EVER USE!". (See [1]). He 
also noted that vmalloc() is a restricted resource. But that's from 
2003, so maybe things have changed since?

Questions that arise in this context:

* Does vmalloc() guarantee that non-pageable physical RAM is allocated 
when it returns?
* Can copy_to/from_user() be used with memory allocated with vmalloc().
* Is vmalloc() guaranteed to successfully allocate memory in the same 
situation that __get_free_pages() could have been used to obtain the 
same amount of memory (in smaller chunks, as with fifo_init() )? Maybe 
they allocate memory from separate memory pools?

And most important: In what way, if at all, is memory obtained with 
vmalloc() practically different from memory allocated by 
__get_free_pages(), if it's never used for DMA?

Does the API offer clear answers to these questions?

Thanks in advance,
    Eli

[1] https://lwn.net/Articles/57804/

