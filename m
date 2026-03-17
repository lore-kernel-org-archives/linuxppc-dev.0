Return-Path: <linuxppc-dev+bounces-18287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B617FB5EAE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 03:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZdJR1x88z2yVP;
	Tue, 17 Mar 2026 14:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773719399;
	cv=none; b=ULKhu1brbgalHj9skGFyHHKJcxCJ8HL6eWVU/JGYLROj5Jh5v9HwPM3FprNDCPQ8Hh5tr7LmhfplPgHjPVu9lEm4QcrgqTrkiD4mcWF462rt/DUwd5q3EFP3qoQjl7kxuvt4zkpFsbd7A9AmDCs3N+kQxhLmtq+7Bbv09gwGYkrUJpGTLwqlXB6HNdJGpAxf+NxBe/WhMf31R2c75bOXmW9VxDfl/0noem2lfTJvTDZv0YGWSChhkRhn2NmOnB5bZs3UJbVt2FSpNO8Ul3LvppO/hW4808U8LCvEZ3kSvLc4qEpTpSp9MSc0t9DL+1Zcq4M8CUSYVA8Fan9YNHJyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773719399; c=relaxed/relaxed;
	bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HD6GtSvNw/PDEYl56+cRuyzs0id3kIORZu12CCKWtVR4EzcDnXUMDoyyRfNcLR4KLfuIfbubwHuDn26kKXOVVRgMrbjEuEbyYb3UQWc1YQGoHWk5TERzfayEqBxzpYAmASP6XQ86DjtDio84UdWG3MjjhYuhreo73RmczHD+zz199sp1yXTE57uCKUPzni30F/s+KR7Os66FZE2jSbtzE+iq1TFLn0XPwSqW7M46PM2uxO4+C2swdTfRiNiA1qnsQoNRVjmgRiz+Rs1BL2+r5awk7SBqvprVYH1KxXbAmy0K2po8TFFnBpAzjKV0VowUXQgCMgDR9fe4Sds0PcKdKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=l/w0Nlcq; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org) smtp.mailfrom=sifive.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=l/w0Nlcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sifive.com (client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZdJP6hfpz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 14:49:56 +1100 (AEDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so3130033fac.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773719394; x=1774324194; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
        b=l/w0NlcqkZe/stB3qWlAmb4xwGmzB/lTi7wl00rjWCzK5alE1BBbZfnfHbsauqNyvZ
         FSHFjBr3KGj4u1F/mTOhHtZHCWx07WXOZz1PvKsSXTdFIIW2AQIfGar/IWahwQW/3WXf
         a5KMgWET8ahForJ43AgWD9uQXjU15sUkafOcM66jfl3kco26GXHOV4B42ZiUZDQchGYg
         qweih1VA5ZZO33jjTqY62WaX2B8JozMbXXwWaDiDRdfXeaUzdCU+f4edQemXIFp2pCWQ
         McADjzXU1zzkKFmErk1BREzmjG01F5w57oNjSRg+4xNipYMPdFja7/WcpJS0IlSerw9d
         zrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773719394; x=1774324194;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
        b=mrPAm5NiAc43B7QypSR3Xek5YbsddgS5bJPydlNoXSPq+CHVA+JBzYWNOOt3DQDqn0
         bUoJz4kZ2llLG1dumOCqkc3pQHnEOPT2C6VkQfKh91Du/LXIeeBh6eYGmET3OwebDrmp
         y/2Rxn0GceoEMGMSIblCMCl21C2QUFrw0rAorr8XQG0KJsAgD/wYCzFhAFN9AohOBXHM
         yBl347IrnKr5sygTF5YCdQdCl3zoB2kdIObs5r7cNRXdSNW1I3bjcvM/Ju4koqRgQUpT
         HPNNQJnerXKsWmHn0J4pk2I6g2/ELlHAgn+/Aygvx1xZxd0KksAjmu73iAqSsqqRSFhV
         GcYg==
X-Forwarded-Encrypted: i=1; AJvYcCWrZ4c+Athp5j2rUllYmdGhUB0QdP/TvdZRscuZd6k5jXJgVEKfH7Hj+2qgisJnfFSzIsAMofWWK3t7SBY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4lLsUupDPwqTvH6nzjQTxMzXfGN8HUdpWazRTlYlSGi2TE7lH
	cPZzl2ARyez7QDW6N2+8k2XV9FzX7lVlElzc/MmqdJOaRLU6779YHocTXgDDIzDY+fY=
X-Gm-Gg: ATEYQzxxNR6njkaGItKJvBJmJ1jXhtebRJ+WeI2m6hYpBvg+VVx+RWzwBFPbw5jMGlV
	5ncLTz71vDTVIaqVggKBUUkrAT4oBq/eiwMR8VZEyglykykxOSQsxNj7WAkS24Gdi0QEhLg0sK3
	RKdg/EPbbwf3/bfQwpVDPoqs51tNDKilnITo91o8HMPWqnndIi+RW8QeZ0rtxpbTIvhzUV+A1hT
	Y7G9n+iFShMmYVJoL31YT0SS32h9TFbuleocfmKjiyR8M4eppQNITgU47959nIPfssivmDWR+ff
	Uvtgi56EWsivroDpcQ48L9xQ4Golc4P6GLEPEPhjOh8Z3aOqT3nEms2SR2W2jHKjGu+2KHbDfke
	tG85FWmfxBRebH/2ZSZ+RcbDuXo+pCpkOtQZDJwerbQlaAOX/Aj/qUBJgOnJF6xqn2oQ85Wgctd
	Ew43XLPtIJ5ES93Xajag7vBQwG
X-Received: by 2002:a05:6870:d406:b0:409:74c7:1cbb with SMTP id 586e51a60fabf-417b906d206mr9213737fac.7.1773719394528;
        Mon, 16 Mar 2026 20:49:54 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm19148337fac.16.2026.03.16.20.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 20:49:54 -0700 (PDT)
Message-ID: <da8c8b57-6d5e-461a-83b3-9339a712aca4@sifive.com>
Date: Mon, 16 Mar 2026 22:49:52 -0500
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
Subject: Re: [PATCH v5 14/15] mm/kasan: add document into
 kernel-parameters.txt
To: Baoquan He <bhe@redhat.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, andreyknvl@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
 linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
 <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com> <abjMP58VdUu_eElh@fedora>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <abjMP58VdUu_eElh@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-03-16 10:36 PM, Baoquan He wrote:
> On 03/12/26 at 07:53am, Samuel Holland wrote:
>> Hi Baoquan,
>>
>> On 2026-02-25 2:14 AM, Baoquan He wrote:
>>> And also remove the relevant description in dev-tools/kasan.rst
>>> which is hw_tags specificially.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>>>  Documentation/dev-tools/kasan.rst               | 2 --
>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index cb850e5290c2..e0115fad9e60 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2899,6 +2899,10 @@ Kernel parameters
>>>  	js=		[HW,JOY] Analog joystick
>>>  			See Documentation/input/joydev/joystick.rst.
>>>  
>>> +	kasan=		[KNL] controls whether KASAN is enabled.
>>> +			Format: off | on
>>> +			default: on
>>> +
>>>  	kasan_multi_shot
>>>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>>>  			report on every invalid memory access. Without this
>>> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
>>> index a034700da7c4..eaae83fcb5e4 100644
>>> --- a/Documentation/dev-tools/kasan.rst
>>> +++ b/Documentation/dev-tools/kasan.rst
>>> @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
>>>  mitigation. Therefore, it supports additional boot parameters that allow
>>>  disabling KASAN altogether or controlling its features:
>>
>> The sentence above is now incorrect as well. I would recommend documenting the
>> parameter earlier in the "Boot parameters" section instead of removing it from
>> this document entirely.
> 
> Good catch and the suggestion is good to me. Thanks.
> 
> Is below change OK to you?
> 
> 
> From 317be48b9c1bf9d33b8d8fff5e401e3155531d81 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Tue, 17 Mar 2026 11:28:39 +0800
> Subject: [PATCH] mm/kasan: adjust documentation

I'd suggest something a bit more specific, maybe like "mm/kasan: document kasan=
for all modes".

> Content-type: text/plain
> 
> To reflect the change of kasan=on|off.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/dev-tools/kasan.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a034700da7c4..8e65bc04dbcd 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -103,6 +103,9 @@ Boot parameters
>  KASAN is affected by the generic ``panic_on_warn`` command line parameter.
>  When it is enabled, KASAN panics the kernel after printing a bug report.
>  
> +The generic ``kasan=off`` or ``=on`` command line parameter controls
> +whether KASAN is enabled (default: ``on``).
> +

This is in the middle of paragraphs describing the fault reporting options. I'd
suggest to move it to the beginning of the section.

With those fixes, you can add

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

>  By default, KASAN prints a bug report only for the first invalid memory access.
>  With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
>  effectively disables ``panic_on_warn`` for KASAN reports.
> @@ -127,9 +130,7 @@ modes below) support altering stack trace collection behavior:
>  
>  Hardware Tag-Based KASAN mode is intended for use in production as a security
>  mitigation. Therefore, it supports additional boot parameters that allow
> -disabling KASAN altogether or controlling its features:
> -
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> +controlling its features:
>  
>  - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
>    is configured in synchronous, asynchronous or asymmetric mode of


