Return-Path: <linuxppc-dev+bounces-26274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C9C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:13:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYPvb685Fz2y2f;
	Mon, 31 Aug 2026 20:13:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788171195;
	cv=none; b=VDqzSwSVRXNNB5uUM5y0gfZXfvysNUdDZ4Yc90cAdC4HxonND/0Yj/fXTpykuzjZwvbo9T6Xn41w5tV5+aGBoNG7UDsDbJMednpVhOPWAVTNdTGE+ljaDtsFQGPUPCAM9q5eP8dQfYAB2VbeG0p5072HetmZfYPqeAV8mNS5l3VEKKGEk8WPfYSSKSwkuUjYgco8WLt35ID5TAUTNwOOKxR1GIL9zHcsxfASlOeLxxlg2hqGzTXpLywnH/EGqxMLUL+MqHPGx/hfgtraB3ODrcM77huJ1lVZHXOVet0XOcjIDZxfK/u4afOTu3c88cU7FBnZ+uCd4PUtofqm7DEQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788171195; c=relaxed/relaxed;
	bh=67t2MAwM/CJHQTc19wvE+OmwIIUNA6nz2MWrmdq+rUg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lX0ISV3kRbnqyVlE60qEKT0jlVeDrBO7FjkaynO8qyWSzI5RZhBvTiMm3/I0mOJZk8D+OBW7NrnWs//SnrI4D3P1yjfoIsvw6AA1M/tjwqmPWRb+w2MppXAyQefuJ2QQlmuFdIbr/vQIf8/Wj/xS8YDxUIFypRWVCmJKKNpRseYpWZH0jZk4PWycyiq3UUjwUVMC3LDUnVaKLCATiGheOC3dOwKvpJpFw/peMPlw/FM58XTjGfWtUW9lxBsDuXZadXKIRlBPSc5gkfHvp4tngBDQiDdaNLt2FCgaPnPGA1rUnq7MPqqj5qb7fKVQ1Kju/pL3U6FH70cczyT4pkLRDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3Aekmyo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3Aekmyo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYPvZ5CSLz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 20:13:14 +1000 (AEST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c2531f453eeso500414366b.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788171191; x=1788775991; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67t2MAwM/CJHQTc19wvE+OmwIIUNA6nz2MWrmdq+rUg=;
        b=e3AekmyozmEEUGcLAL8lab9WnkrVLn7+SF6YgYYzVgLF9wbPR3SVp67PVPiWEFXwsZ
         mCD7SkmE1tlYwkwp9DH5X6SDlJmU0Q+R3evSaU0u0CwyxByDf8PjpbCvfA4xW1t46HAN
         LOJs4KVwP8jXSdwYiYd9zvedCGDPVGLX2DfCtXHHbovYTpXPEHQbPSz6pYPvOgDRTDtu
         guEeI9kk/e/ouV9hWyqDab8TtUi8O5OGA6hd+jSxo43cZuu8EryvIv0LIRkKuhhZ0LLB
         2/dWeNjI9rE4cQnD6nNXtcMutmjpyXs+pFU/WR6SyRpyzWSAAQDbvfkDVLt4SLlSntB3
         AwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788171191; x=1788775991;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67t2MAwM/CJHQTc19wvE+OmwIIUNA6nz2MWrmdq+rUg=;
        b=IXvAU6lJjbVQQ4WPZJ84W6vCI36Lb+HUSzdSJQvegc2AXC9cDqwF5VDLrbn7Akuzh/
         i3eJBHVqK7nDiX37q1AaiRs8dC6Mu63dOxkQ93noXprM1W7eWIu+yVabb5+e9CAFtWuW
         FX4m6SLvNwPKDwKCVbIpVY+qmysM+L9wjx3dDiOLEgz8CfClvJIoHx21S7GjCdrpp0C4
         3wVY5gghAjNI0RdHxF3WJeF6jrfGUt37aMENU2ndcJyIE7+x+zCsJfjwQeTXTsgOcRk0
         jneM+WZmtjimvsTRzN/xm1G+mEjcN6EEUKYYytJeiOy51G5A9GCaHFxV6RRm641KNFkK
         pvuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdKPx0RIn8Y/MTd029LcjcTdSjhhrvyVfZUtOEImSg9EjmlntNgCZhit/EbeNuMUGQaTtxE8aQoUJ0y2M=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mjGO6GZqHyXi2qJdYnBPx+fGNi5g5jKoKeQP6flzoZ9PXKk4Mi
	7uSxQbMgSI9RTWwar5r2koALAr3n1ipakPmtPwjgP4kACkqN0FaW7tFr
X-Gm-Gg: AR+sD13cjBhXKs0OEDTPeBN7wF4F3hLDgEn8wVJaCKG19YRP+PlAkr8ifdTXnVQkptF
	yrrDvgsBEuzhk96RzRGA9OwnzSJh77gTfXYyUOCTH9b4RGALESZu6MNGlyzEHDC6Z59tHQeSCFl
	Lxp7sopkBArfA8HbwXbJm2PyLkG+L/JQpkJKRcTVgr1UbaKWCLLdiOHid9xASl8NgMwkE9U/8ze
	IV3loobiUJ6mZH4wl58Lwhv4udOjeIvszhh7co1RXi+iim4WxSrlc8nH2jnC2akw76R9GwrPtDx
	EqWxj037VSxhMVg0Od/PDbqtnxMu6p8zKM+NJ3B9Vu+QP5w8rF2nKT0L5+h0R9clxK34Zr69sI2
	4/b1x4igxIAc/SsddrNgEpiZHZUYeUkwMTUU09iPozj1DURvau6Ombt6m+YQnZVDv4NDZOYgglA
	Lg8XjH1GToQNHq8zukWTnBS8fXemJqNB/wvDiNazLUCFdAeFp8KnU6PuYC65+/9Ik5qOJugofGV
	ge+joQtlS+sjkrleu5Gx7qS
X-Received: by 2002:a17:906:1013:10b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c25aee558cfmr69135566b.11.1788171190678;
        Mon, 31 Aug 2026 03:13:10 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b28f6sm385832566b.39.2026.08.31.03.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 03:13:10 -0700 (PDT)
Message-ID: <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
Date: Mon, 31 Aug 2026 12:13:08 +0200
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
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
Content-Language: en-US
In-Reply-To: <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2026 9:47, Mike Rapoport (Microsoft) wrote:
> fifo_init() allocates the buffers backing the software FIFO and
> endpoint_alloc() allocates the transfer buffers of a USB endpoint.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.

Except that they are a bit large.

fifo_init() may be requested to allocate up to 256 MB of buffer memory. 
This memory resource is split into an array of buffers (fifo->mem[i]), 
each 64 kiB (or less, if there's trouble obtaining segments of this size).

Citing Documentation/core-api/memory-allocation.rst:

"The maximal size of a chunk that can be allocated with `kmalloc` is 
limited. The actual limit depends on the hardware and the kernel 
configuration, but it is a good practice to use `kmalloc` for objects 
smaller than page size."

Regards,
    Eli

