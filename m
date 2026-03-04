Return-Path: <linuxppc-dev+bounces-17655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F413EDEC03
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 02:42:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQcR14Pncz3bt7;
	Wed, 04 Mar 2026 13:42:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772592173;
	cv=none; b=Qz/3yXbwCh6qd3Zh8n9zhckx77U4KNOU16sh/7n8MzXp9qoqMh6P+tMFxahCBV9ilctwtYcPZyh1DF8mTPj9Z6FWUrxW2v4oUS1GbwMOk2sDvg1oBWcHa4rPWeqKM13Hgan186EnN7X4B2X3oYbDxIXxjUb780LBlhIPe4/ZGLT9hPFtFATLRUFrb1HhAj5K8biy/QjqsC+YWsJUYN67OazX5PrWPQx1nuQwceBvVUSdrG5JzbjOOupQB5Pq7oMv/BWMYT04B+2ocfRiW0RSi7ahViSG7oj8T53ClYD65h/QMUrAyKESLcpEaCCQMR2VG8QTgL5t5Z9KDYBHQnZyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772592173; c=relaxed/relaxed;
	bh=W7dycZCW1i0wVXbu5i6p68JSQ3h2ubeTDMrk86ISU5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4z0ZaHgSOh0PX5dSZh8yRJeul1BIoJPH0ojdEN6+SkvylJuk6dGmW/U4R3jNHYhrpGkdFUxZRYMlk50COQT5jxTf/ehrUQ0Ozoifbc0bj6sfzud2lbFBccYB4lTHmtTNfmhJYP3p82Z7YRU34nC2jfOHkQddAAd0hXw5sOAR+2piPZliTDB6PpsLhakIk4P7u4kHTzBRaq9ZuFPpEVGReESsFNVaEsNZTFGoj+EICL23QSWT1hYI2Vm9MSL/W9juvJAxDprjqjrCiNpXkxEcN/IL/pSUBzv4Bi57oMLFeJdY7Y5mKNClGwPA8cYwpfejXXTzg4h09tgfCrDkx51+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk; dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BjTNoxaK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=axboe@kernel.dk; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.dk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BjTNoxaK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=axboe@kernel.dk; receiver=lists.ozlabs.org)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQcQz44pTz2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 13:42:49 +1100 (AEDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7d18d0e6d71so4951765a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 18:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772592167; x=1773196967; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7dycZCW1i0wVXbu5i6p68JSQ3h2ubeTDMrk86ISU5M=;
        b=BjTNoxaKMvGAXW9IhzE+YKArfvuFqVLuw/d4YleXt1hj5kAr9RHAPit9XqXWZEydBb
         4mUs+F7K9CMeaR4FfqoQyhRCqJNFS3SdCITJMVgDFR8q7x92SpHqJrK37hGbzhM2/F4R
         CkJrdUer5fGXTrKqezru6Kxh1Ab5Ufg/aZuDGy6t9eZVFM6leElw0NhJZUfrNOZwNH/z
         qkN8KudsqESu/CVqC7IqtNmSD9nP6U7mbcVXI0oWDl1pp7eL/hjs+d5kP0GhF4nk8PRe
         IAwTGCZxx+9uvJ++8iodidcQuV57VOfe/4LfXSwaA1ccJVG5tZOkCflhHQbKeZut/6YH
         XgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772592167; x=1773196967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7dycZCW1i0wVXbu5i6p68JSQ3h2ubeTDMrk86ISU5M=;
        b=Q94f3/rph9vTy4P56r0qbBqGU9p1e0dtoy3v0CuLqW8zXehDGatXo26pospeh+9p53
         jjy+ehgMcG5gkvgLKw05p+X77Qjgjw5iHPi88c7HhJHSntia72y3cbdU3Tn+i4ZRIkH/
         Tc7VmpERWuyFKR2JJFC+9d2fPm6VQZXSN4X3TwasLywAa8nxVGvtGxBMX8umZeHRoLR6
         mAavGArdSaEJ6D91+mAKIHnVl1mCy56KtKBjT+8eUELKWQvQjAnmcbz+SkhtAUdRoYTr
         CUIQyz0YfkZb+28fgRJ7Dh2qiD2GlXm1YntThFQAEo7r/uYli2i2hEeMD+qG/bABNXZz
         DJrg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Ag6fnMGYWPvopezq0MiylTigPJaSPkO/zK/BArcyPflYk+b7VnOv9XwmOe7LHZ5hs1BDcX8ZGBUGOTg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yym/CGGAzObxFUuPg54f2Y5qgv2HdIhfS+i3pk5hSc1CDdM5HTq
	J4f8YatoUffDCZA5EOxBezMcd8MILhEfI15PYjrJCAv+qE0j82N0FtWO85NxyeMy5qo=
X-Gm-Gg: ATEYQzw/QzoNnSWRqXXUKFaqD7VsFFu3b5hI6BICu7qoP17PD2k9iELFVG5nH265kpO
	Tu6ZRC6INFADmw2xr4OhWAip5IxhMi9i9SctkAGtZYwAoJGdsZbWtk0JMpyt8v5Xi6nbwjjwxIg
	8POIaVplO+Y8UA7nIJenAIS2fQcuTL5WvC96LS5lw3rnB2q7MEbfFOGrgKpzZSUqYHGzLR/HG6F
	m9YwAd08TSU6aEQmtndW6VD05xXM0KY2HQ5hKCfMca8VLlQhi43/6cDK2gTSyvzBh6rGPrSX/wl
	2/EL8GpMn7bRj8dn6U5Gv7qaxcg0SiaIh5sqqgrrn6hGpJ4mGiGcL3aTuuODM/wtXqixC530+lZ
	HG5gx0pDASDLArO+nG1CvO716lOki2tb6B9LEx9KglX084xkQhtGUodNpTW66NITScN550WNbeF
	m6XqXTudnczbytnpViDPKmMxBi2cl9VJiUXAHgKE9VF10Q4nAZmwRXWWRFHCT5aObxlCx4AqTvD
	m4Z8cZCLw==
X-Received: by 2002:a05:6820:4a8e:b0:66a:1886:e4bf with SMTP id 006d021491bc7-67b17703546mr346906eaf.22.1772592166871;
        Tue, 03 Mar 2026 18:42:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm12574800eaf.7.2026.03.03.18.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 18:42:45 -0800 (PST)
Message-ID: <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
Date: Tue, 3 Mar 2026 19:42:40 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
To: Jakub Kicinski <kuba@kernel.org>, Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sean Christopherson <seanjc@google.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260303182845.250bb2de@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 7:28 PM, Jakub Kicinski wrote:
> On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
>> The net/9p networking driver has a handy macro to calculate the
>> amount of bytes from a given pointer to the end of page. Move it
>> to core/mm, and apply tree-wide. No functional changes intended.
>>
>> This series was originally introduced as a single patch #07/12 in:
>>
>> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
>>
>> Split it for better granularity and submit separately.
> 
> I don't get what the motivation is here. Another helper developers
> and readers of the code will need to know about just to replace 
> obvious and easy to comprehend math.

I fully agree, I had the same thought reading this.

-- 
Jens Axboe

