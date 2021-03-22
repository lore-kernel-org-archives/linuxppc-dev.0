Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 00:30:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9132B6190A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 00:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9132B6190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3b4T4KYpz304D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 11:30:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=LIWwyHHN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=LIWwyHHN; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3b3r2s6mz2xZq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 11:29:41 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id
 kk2-20020a17090b4a02b02900c777aa746fso7598836pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Mar 2021 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=mN9M2gHDmHAMZP+50/Nsn8lRknSmspKGtmjuk7ePwS4=;
 b=LIWwyHHNktv8GP6XKK9oeK5MSL/7YlonGPEGcdfj73hiYJ3jW/UjEflWYG7ADC9ung
 +gQJhzdmo+TJ+pv7YoE+5JEPfYaCTZVrRo9hUj8H39b6bjycfjCDcvuoImxhv/1B9AxF
 F6hetDo8fEmbCZnSEQU3nAaVWQwEN1xZ6u7FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=mN9M2gHDmHAMZP+50/Nsn8lRknSmspKGtmjuk7ePwS4=;
 b=EGdJta6ZhMG5I0NCNTIQen8/sqYNcbFiqGwRF+4VRHBIp5rLg7GvX8fe6C+wzsTEGi
 +x+OkBHtCI+UtacHeQKiYLsk2Gk1l5Z2zHfjoJRZ3aIgzRC2CpRUqM4pw7CRx2LbD/PC
 xDzpW1baBwOI9EhwT+nEBOvxVo+rdxU0C7u/8KQb0fvo+f65z33vakb/XFLIPfLs/coq
 cMA1KbrSJYsbUcQ6JvLpLaROD+ffOikZIB3Y7paG99IIWYh6/8s/+J3Q5nbwyDhRfHJY
 nvJGA5w5UzpbNwen/jjFEs7+9Wkf4eso5WqRnkP8uTtyV4NvZ+b0IM69MTz5T+IOuJPt
 TfAw==
X-Gm-Message-State: AOAM531GaBjQ0w8C0QFCyY2qlh2OuqGh4p7JXzae/lR22J832BMHWsWu
 fWxd1mGbbgy7zFZ8aKKXP9jpOA==
X-Google-Smtp-Source: ABdhPJyZ/jN5TaWP814l7V73C6xJ4pkB8X56MyPwnqT5f4D8rK22D0Wcv1lAfC6UQf3ARiG2+GsELQ==
X-Received: by 2002:a17:903:228c:b029:e6:4c7e:1cbc with SMTP id
 b12-20020a170903228cb02900e64c7e1cbcmr24592365plh.38.1616372976026; 
 Sun, 21 Mar 2021 17:29:36 -0700 (PDT)
Received: from localhost
 (2001-44b8-1113-6700-b0f2-84a1-ce9a-a0fd.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:b0f2:84a1:ce9a:a0fd])
 by smtp.gmail.com with ESMTPSA id i10sm12299634pgo.75.2021.03.21.17.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 17:29:35 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v11 1/6] kasan: allow an architecture to disable inline
 instrumentation
In-Reply-To: <20210320014606.GB77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-2-dja@axtens.net>
 <20210320014606.GB77072@balbir-desktop>
Date: Mon, 22 Mar 2021 11:29:32 +1100
Message-ID: <87r1k8av4j.fsf@dja-thinkpad.axtens.net>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Sat, Mar 20, 2021 at 01:40:53AM +1100, Daniel Axtens wrote:
>> For annoying architectural reasons, it's very difficult to support inline
>> instrumentation on powerpc64.
>
> I think we can expand here and talk about how in hash mode, the vmalloc
> address space is in a region of memory different than where kernel virtual
> addresses are mapped. Did I recollect the reason correctly?

I think that's _a_ reason, but for radix mode (which is all I support at
the moment), the reason is a bit simpler. We call into generic code like
the DT parser and printk when we have translations off. The shadow
region lives at c00e.... which is not part of the linear mapping, so if
you try to access the shadow while in real mode you will access unmapped
memory and (at least on PowerNV) take a machine check.

>> 
>> Add a Kconfig flag to allow an arch to disable inline. (It's a bit
>> annoying to be 'backwards', but I'm not aware of any way to have
>> an arch force a symbol to be 'n', rather than 'y'.)
>> 
>> We also disable stack instrumentation in this case as it does things that
>> are functionally equivalent to inline instrumentation, namely adding
>> code that touches the shadow directly without going through a C helper.
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  lib/Kconfig.kasan | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>> index cffc2ebbf185..7e237dbb6df3 100644
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -12,6 +12,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
>>  config HAVE_ARCH_KASAN_VMALLOC
>>  	bool
>>  
>> +config ARCH_DISABLE_KASAN_INLINE
>> +	def_bool n
>> +
>
> Some comments on what arch's want to disable kasan inline would
> be helpful and why.

Sure, added.

Kind regards,
Daniel

