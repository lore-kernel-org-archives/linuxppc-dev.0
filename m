Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FDFC433C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 00:55:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3445461930
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 00:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3445461930
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3bdm6FTLz2yjY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 11:55:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=XjyhafFA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=XjyhafFA; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3bdK1dJbz2y07
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 11:55:15 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id
 a22-20020a17090aa516b02900c1215e9b33so9522379pjq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Mar 2021 17:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=YhjptOa1YLY02YG0NxjiEXQDPMTypn5KHITe161ubW8=;
 b=XjyhafFAg3wXva8WM5LObDDfgCIfrUS6S3ztJ28AyYH/b2GPcOTLtgLxtWECmkpr7l
 vGJZHDY1tif2FC7KyD8ToeYPd4bK/ePagyiqCdBq4UAIjnJF50hIlo6EayblM8ugIYFx
 GZ9LLX+CzSqud+1wJjwvebJKayc9NoySTnoh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=YhjptOa1YLY02YG0NxjiEXQDPMTypn5KHITe161ubW8=;
 b=EGn3JXbR9g4z3D/DfF5EWdoDxoEPsJ3y6cW+fxRO8T3lPZqM3Bd0xnKWsVebJYVWpg
 YV4NHWH8gX7+iOG6hbt+0QIhtCnXNJS5+CgNZo84M0stbH2twmnIn1ql+dx7wsMJDBq7
 voSfdD/2gl7gh2pHQc6ra8ki+QtavaE/5X9Je0o3MxYyKTTqBmwizRQ5412BBPRMQdAW
 p66qznfKogGIe8dwQA40fPcSFvrVsZQBQh1cLRuQiABR2DQrqrJzndOvEAutHmFPYAQY
 2scKYkqgk90uNWhbizSEj6wDwm/7gjZD/pcDIeMsv2MVOyo5zK3Z7jvpyAxnO+9efvl5
 IWsQ==
X-Gm-Message-State: AOAM530rYmh1KUJoD5lwaR03v8P6uqnZEE5zV4QJHyT7X+hjravH8+3+
 dh64BlkbFK2ZO5IYaBh+7QKmwA==
X-Google-Smtp-Source: ABdhPJzRcD3yNsaQ3jmRQ0MduvBzp8dYAxJ2WA2adD1Mh26gwWUxEkRCqKjrQfqNc13bL5NgiJ09qg==
X-Received: by 2002:a17:902:e546:b029:e5:ec5e:6bf4 with SMTP id
 n6-20020a170902e546b02900e5ec5e6bf4mr24400618plf.41.1616374511814; 
 Sun, 21 Mar 2021 17:55:11 -0700 (PDT)
Received: from localhost
 (2001-44b8-1113-6700-b0f2-84a1-ce9a-a0fd.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:b0f2:84a1:ce9a:a0fd])
 by smtp.gmail.com with ESMTPSA id j21sm11603072pfc.114.2021.03.21.17.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 17:55:11 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v11 6/6] powerpc: Book3S 64-bit outline-only KASAN support
In-Reply-To: <20210320060259.GF77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-7-dja@axtens.net>
 <20210320060259.GF77072@balbir-desktop>
Date: Mon, 22 Mar 2021 11:55:08 +1100
Message-ID: <87o8fcatxv.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Balbir,

> Could you highlight the changes from
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170729140901.5887-1-bsingharora@gmail.com/?
>
> Feel free to use my signed-off-by if you need to and add/update copyright
> headers if appropriate.

There's not really anything in common any more:

 - ppc32 KASAN landed, so there was already a kasan.h for powerpc, the
   explicit memcpy changes, the support for non-instrumented files,
   prom_check.sh, etc. all already landed.

 - I locate the shadow region differently and don't resize any virtual
   memory areas.

 - The ARCH_DEFINES_KASAN_ZERO_PTE handling changed upstream and our
   handling for that is now handled more by patch 3.

 - The outline hook is now an inline function rather than a #define.

 - The init function has been totally rewritten as it's gone from
   supporting real mode to not supporting real mode and back.

 - The list of non-instrumented files has grown a lot.

 - There's new stuff: stack walking is now safe, KASAN vmalloc support
   means modules are better supported now, ptdump works, and there's
   documentation.

It's been a while now, but I don't think when I started this process 2
years ago that I directly reused much of your code. So I'm not sure that
a signed-off-by makes sense here? Would a different tag (Originally-by?)
make more sense?

>> + * The shadow ends before the highest accessible address
>> + * because we don't need a shadow for the shadow. Instead:
>> + * c00e000000000000 << 3 + a80e 0000 0000 0000 000 = c00fc00000000000
>
> The comment has one extra 0 in a80e.., I did the math and had to use
> the data from the defines :)

3 extra 0s, even! Fixed.

>> +void __init kasan_init(void)
>> +{
>> +	/*
>> +	 * We want to do the following things:
>> +	 *  1) Map real memory into the shadow for all physical memblocks
>> +	 *     This takes us from c000... to c008...
>> +	 *  2) Leave a hole over the shadow of vmalloc space. KASAN_VMALLOC
>> +	 *     will manage this for us.
>> +	 *     This takes us from c008... to c00a...
>> +	 *  3) Map the 'early shadow'/zero page over iomap and vmemmap space.
>> +	 *     This takes us up to where we start at c00e...
>> +	 */
>> +
>
> assuming we have
> #define VMEMMAP_END R_VMEMMAP_END
> and ditto for hash we probably need
>
> 	BUILD_BUG_ON(VMEMMAP_END + KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);

Sorry, I'm not sure what this is supposed to be testing? In what
situation would this trigger?

Kind regards,
Daniel

>
> Looks good otherwise, I've not been able to test it yet
>
> Balbir Singh.
