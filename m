Return-Path: <linuxppc-dev+bounces-18116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52617105A596
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:53:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWncF4Xv0z3cFN;
	Thu, 12 Mar 2026 23:53:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773320029;
	cv=none; b=Fc6b1XJwiXG3gRZzxYc3871XQHzQfjLa14HoKC5w+97KJcsxh6o7u0AjcAJQ5CVNACw4cM5QKW+odblBr0c82wzFwHxhxk2cIaV2KesUQ6zfwyBc7XER/cz3/DaWUoCwFdgVRn+ZpWqifAXWvwWs0I7HK8xQzBj5YIaiV98j8pIaMSacZLkJUs5Fj0EieMdlKk/2UEwDlKx2QuNNtuLc+BgYCXbAFjfvUZaaDe+bpWeyPvtaSXyxLiviRJ24qcF+Nude5Ma8SAKL/3pPYMuPlhI/ozMHVAllmWbr/uAGq5N6qkqB0+/iOQiBbYVWxheRQqlOoLOliBz2chx59W390Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773320029; c=relaxed/relaxed;
	bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeL2Guk9w3FKmeRMF4voIVdKtXm8Tddj2Ew6yKgbduUvj276bvNtOIxUH9Ah1bd5bbEFJ4hyPuJujbz6LBhScNXVB6eNqFpzzTHKKGqP/evIHn271PfWF9itJP0sRDJqw7mevZJ0veVqouZsuH9HtF68+KER8KIkZ4S1YC9XS9LraR1JDLqq5nE04Xk0KHUvI7evlnaUZNfEAL0Y4jTUkbywu/cxyBnnIma+1pZy/C6YorUDsu1sebKI+WhfFeVd6Y3g9mRAtriSqMCvziu+XQYrpA761x7GeaKZpUoJcORA+2ywYPR/A0EKMflnmTohBj/DrjykQ4756fb3YbRHFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=CDSQkie2; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org) smtp.mailfrom=sifive.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=CDSQkie2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sifive.com (client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWncC4qJpz3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:53:47 +1100 (AEDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-40ef10ec84cso666899fac.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773320025; x=1773924825; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
        b=CDSQkie2UH0DeieRa1/qeF2sRX/CAREKPuo/AekTt3EzXpomo5iZYWu+eGz11Nwivj
         jLrqmQFYI1Oa/W2hXuAGtHxRGDwLCB9f/jMLU5iStjm7QftkH9JLkGHl+36kRzMrSMWu
         JKWL5rwu1W8UDi4vVs8v6Y69EZl+lzz5ZCg+NiTZG/TB253Uf7bm9wZtk39wakRZCqbw
         fzcjaRPXbLG6B1AnW1gZSqsvFlGBvr1BaxtZLlD8NYOhfHRovRm3LN4ERpy6XmlDlPv5
         NOC6EqiY1Ew4rzhG1R9Z52c9Q5R40CwHokUNJSD3JZSlNZEV+lG8Q0Kxxs3rm5vke74o
         FAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320025; x=1773924825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
        b=luZWM+7BrgQ2QWS2t9bBxSQUVA5HZtYDa8iD/15vopO6NkwMsYS+cGhRrkAkyV10wj
         c/31xuDQ+bMs2FaLrX1YrFiD78Yov6cSUZ0O6WUNW/LFb0ZHGe1nyUrKohPX15RH2tp/
         N9Iu9DCKIipC6Gfo17IFX7ClZKOVhP75KpR7m7TGRcOmMQoGEvJ38qabX0P/Hi11QQkd
         mUxdHLJc30lObgsYMvNCO2oH1+iZZ5e3/S5H84/RHWmt10BdurD4+Is9k6Pjz7z8AbNf
         4ejjkEtHMRO6Fx8xVB+Ad0foYdwBbPn1izyxj1siqnvuosHkM5STOEGv+sI4d3NZfUmu
         eF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfcZIqokSbQfDzwpQCsJGeTeYcR1In3vrtt0K+GrLvjBcvwqorWqI92zaX31ZJxF2pX/4ljHmduoZBvnk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywz80dhL8B/tcs6ntHr7OxUfbtPX5314B3Y37U7Az7HK1cqEyeg
	71uSQBPlwT2B+VWy6vU8RhwASNZKAdPK3s7PXN3l82YYcPL2NuJF7pgmY+ffiMYe66c=
X-Gm-Gg: ATEYQzwp/LBvAs3Eqj/756ZwGMjE4otjz7iXJrv7Wml3RQqXJhEsYEX9q+k7gdF0dvx
	35H9Hr5pvoOsKIDJiSTN1w9Rnq+9MrQHattEbio1fATLNbwtc5HVj/3Jj2484I6q+5S119Obu7r
	EuzCVlKkgRSgRJGJvukgw5NHjGZU0fUk9B+5+EFsQI+vr3TwhjyBmx32c5bqIvntlOTa4zJOupr
	r6DiBW+fZPPZZq1gCGe6Ucu3rQa0ZZLiCEMja+IkFg73tSbg3PQE4Q869G49XqQ6w9B/ZeA2Olj
	qka7EzqE6naHgzbBa73EMCgeE+phUE6F8NFV9ByiwOWy8oFBt18NGXBNYt/b9Y428/B2tMZhJzF
	B6PONQg1xk6z9pQ9MnUgBbSfk10yYf4HMd/QdSAWQ5i29nmhsSJem8n2RFPwAxWt/DXYAdgRp/J
	z3duVuyUjlTP8rwmA6P1zzlutYCM609ba1DosjXDk=
X-Received: by 2002:a05:6870:649f:b0:409:74c7:1cbb with SMTP id 586e51a60fabf-4177c6f1d08mr3392540fac.7.1773320024820;
        Thu, 12 Mar 2026 05:53:44 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41791432d87sm3765785fac.1.2026.03.12.05.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:53:44 -0700 (PDT)
Message-ID: <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com>
Date: Thu, 12 Mar 2026 07:53:42 -0500
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
To: Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260225081412.76502-15-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Baoquan,

On 2026-02-25 2:14 AM, Baoquan He wrote:
> And also remove the relevant description in dev-tools/kasan.rst
> which is hw_tags specificially.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>  Documentation/dev-tools/kasan.rst               | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb850e5290c2..e0115fad9e60 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2899,6 +2899,10 @@ Kernel parameters
>  	js=		[HW,JOY] Analog joystick
>  			See Documentation/input/joydev/joystick.rst.
>  
> +	kasan=		[KNL] controls whether KASAN is enabled.
> +			Format: off | on
> +			default: on
> +
>  	kasan_multi_shot
>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>  			report on every invalid memory access. Without this
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a034700da7c4..eaae83fcb5e4 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
>  mitigation. Therefore, it supports additional boot parameters that allow
>  disabling KASAN altogether or controlling its features:

The sentence above is now incorrect as well. I would recommend documenting the
parameter earlier in the "Boot parameters" section instead of removing it from
this document entirely.

Regards,
Samuel

>  
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> -
>  - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
>    is configured in synchronous, asynchronous or asymmetric mode of
>    execution (default: ``sync``).


