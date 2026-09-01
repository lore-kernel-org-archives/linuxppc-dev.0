Return-Path: <linuxppc-dev+bounces-26363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDE9C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 08:42:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYzrv03nNz2y2S;
	Tue, 01 Sep 2026 18:42:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788252174;
	cv=none; b=W2RSBxENC/86g60h0JdByJjJv8FV9Rv/8gzokxpVO/R+Ty7+TwfiFdkRhBaaS+oGVVGcAbcyF8h+GgWIw5Uf1NgzgARgI8THbcRQ9y7j2mooroutYsrXBrdDheYvwafeB1yvWLYFPTYfEdXq1kYzUfS6soDxhPWVvMp/leZyjiOkex+YbZj2BEkD28XovAJcVNWHxYhf2JcGFhuuAbl+eD5sXh+LMF7P1GQlb1iGkf/XJHYIQAnuUCtwcEHB5KsTjv2reNLE4YKOv+2jWJqlYgJcaxhni2/H1kJUTLwwLeokHCSu1KGDtm523Ulcl0JuqQFa0Pco298/yaOhduWiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788252174; c=relaxed/relaxed;
	bh=+NB8kXEuSYL9KHpcK9ADFRjV/ISbKtGYd98joTGYzk0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dYEtkOO9m8d/Tq8TEkK7zQ96Ien8e1m03cCAdjKukVC/84s3tKE/7NR28iunhEpE8FVJvXLSuSTa2ZdE6gH58Z5k+VRJx0RroP56TjQxzXjQ4JWdwf6LspGGUx5C2PnRuLW5dk1s1EadoYrIQK+jdtZaZHgz05UGRULJ0wh9mE6CAlLkksmuNjvVYxJfywiXVDWerWK78bgdxclVS8aPY8waBwOYoEC9Z9WCHzbAJ3gqSx+83DeXuORanh4VoqF6PZ+yUhL5+K0XSYU43QDM9MayChgCwaGTLPDonjQtEve+qluurCbubDz4HDoJF4SDacnvFW6e2PDMeOFOgrKrIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DIlIBhrd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DIlIBhrd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYzrs5sjQz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 18:42:53 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c25b661d37dso89838366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252170; x=1788856970; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NB8kXEuSYL9KHpcK9ADFRjV/ISbKtGYd98joTGYzk0=;
        b=DIlIBhrdRrLCvns/xdueBqXwqsGQYAxAT/qs+7bALQJz4d8oiP+rPfEtEHjTCBoNeR
         vruN0Icl2NEu2yxxkm+RPmhg4nzSZFpgnUo9s35QTjM1JUJQgUxBfTGGe/RJ/p3bNSn2
         y4Y9MjXNHrzm1n9kA3kBs725AJu9bu+TxLzqAAabx/GK+UgmFtmC3ijgRxl1eRO2lEPk
         sbMILKfkmNwyMqrQ4aAlVPmndQmPZT9Q/vpjLurAlh3CB6fURn9DK+OvJ7jKWAu3V9Yc
         57BzQVPpddGYEscBV+CmWs1ZDbbXCUzu6wuDFiV59Ygp+CMqWNSnzuFaiP7BeZv05lmA
         nzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252170; x=1788856970;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NB8kXEuSYL9KHpcK9ADFRjV/ISbKtGYd98joTGYzk0=;
        b=WLhuX8cfMAfx2rRmzJ1oVOtyWkuEpletM7gV0U8bqITHbmyQTnSIRFzneQ0PgFNv0o
         01lhhAD/DuC8N2ZhCvSuQocmXnXu960KaWragheEvczSLjquQNXh2+ZHGcK+Bx/KCJ0U
         ZRj++2+WOr2Us3hWCg252IwsVDqzGV7Ob0i5NT8EsujrTgp39QkZ+eK8EsJ14UOU9xAZ
         13bgNpAKJlsTj0YaUc8X6uszbIUJTpXfUDA+F4LY2twHfkJs3DSHG4iyF0cTWDlivrrX
         V3l7OXWD98D92nMB/pNd4AVTz2Ay97gsUkWuO8fdW29RxDruB16w7Swr4UFNL/8rQsFr
         T5mw==
X-Forwarded-Encrypted: i=1; AHgh+RrAFHhMC9xOW/ZtQUiDEs8VZd3emXoxnRlQV8TDw5lRpDSWub7aSCIIeh+LIx0Dm7TLALsn8vntSAzoeis=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m5dO5sEvyUPbdi8V9WgjJ02QOaqPN2ccOUDRuu8kXpkEUKb/iF
	q6tDCMZGN0+GfjBKL8/Ic/wE5PABL1gimJsrjAcpZJZ4uKcVx/AYbdHZ
X-Gm-Gg: AR+sD11t5r8/vUv8yxe3CeAdkq1UaV3Sqjjm8j042JAhl6bON5S6FC6CXHnVRqTZ+TA
	eJQaynCOcsKIBmeUUC726EmZe93zAIdjsH+3xlq2LLBaF4tvJ0BpJz+QBeWCC1OpM7tBujuYkUS
	0XwF2JrpuLwNoqP1oqbAqCZmSUNx7i846hPW7/wDPnFpzjJ6txAJCqJhLepcdGw7lfW9tYTeTBZ
	dN+aW9DvO96X8oPEn4xfY13H96UVddIYiPM0o7MUDMQ+2Hbdyqu8vx4BYVav/OpkcuoR5cshIQM
	isFE77iKpYSeBHIwupSH8x2J40SloVPYAsffY6uztNnJ5zhrFBsU8K9ww96wcPcAF3AQi/8cmDo
	mUhmd+OBRBFvBneciB0rNVrB8bw8NuKt1HTxzNdnnUnebVjCwqKyQB+j/g1r6bVWfeLouHM7rqO
	DgTEu/IQwN2CpZNrZXYQ1e0MG9Ig34hukkRjR0yzPEYDmQhODE/45FL06ucEphpHNa5TKGVcvwU
	fbLNLYnpzwC/TWgy/RgV1w=
X-Received: by 2002:a17:907:c491:b0:c20:53c7:488d with SMTP id a640c23a62f3a-c25572036b9mr1872224266b.14.1788252169492;
        Tue, 01 Sep 2026 01:42:49 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f23cf9fsm543163366b.53.2026.09.01.01.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 01:42:49 -0700 (PDT)
Message-ID: <7adfefaa-91c5-4bf4-ff98-5dfbba0eac96@outbound.gmail.com>
Date: Tue, 1 Sep 2026 10:42:47 +0200
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
 <apVmYXlqsVr_p4Oc@kernel.org>
Content-Language: en-US
In-Reply-To: <apVmYXlqsVr_p4Oc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 13:32, Mike Rapoport wrote:
> For large sizes kmalloc falls back to page allocator anyway.
> 
> And the doc is out of date unfortunately.

I think it would be a good idea to update the doc first, and by doing so 
officially change the API. After getting this change approved, it's 
indeed safe to rely on kmalloc() even for larger memory allocations.

Regards,
    Eli

