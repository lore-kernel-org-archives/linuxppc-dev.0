Return-Path: <linuxppc-dev+bounces-22190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19EFCD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:49:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYsL9119Gz2ytV;
	Mon, 08 Jun 2026 22:49:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780922945;
	cv=none; b=TugeRMyWrd0BLN51EwUegKoda3hF8I3dXG7JozvCmb+mof/NMRM79Ue0s99HynBAvDYtJ4CBMlBqlyV1Yr5hv67d1e1LtGdS7Zw9JszbAhsEBxGL8Z/VFlz21s7enNqu+8wzFnRbDzWorWPH6dUlHrUo3ypIP4rXRhAnCiub6j9vR33jEwX0cPRemkMXDxhRbqi9AmcYxCBx7Ckcm8ZiZK557gzQcEeH6I2TIjmCZHazBSulrmMK9ocPaosk6LFJWWpGgyb63DLiRHxo6HH5l1RcfF72cHHJJOYllqq1lxlIk4JDqpWB33gNnfvhcwmjLUomBhD2a/A0WtHzizR2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780922945; c=relaxed/relaxed;
	bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK5TfUcnRPzzn5g9XwZwZhJMYZwm/+to7bUWXC1+2O03XlOkZCgdALGj7YQUD44bN7oOEZHFmjgN6iVA/fDG+92zAzex5L0scKhiBXxr4BcbqJGbal/PRYpp8ZQC8BRrzhvaiNEehKPSychPImHM+2Z/vaBleeLSRw5e4oYEIuX0eHRe9IiUMZ6FRCwo/6PK/emwj/NIt3VeZxfyCZrj60nRnaJwTugfxzZ5rvIAXVd0evSdSIwslB00w11sjsVmmDWTuT+c9ui/uwOAE4PUNaTA3KroUF7UMaRpwfXDOihuSPvFicrxug52R3z8jBrEr0ZKK6iyRCOFhLaTtLEKpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0tjozC1; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLbWwZWj; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0tjozC1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLbWwZWj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYsL81PYkz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 22:49:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780922940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
	b=M0tjozC15PaOOHr71Zp0PwN/isI/DqE511GLQSv5r8WWANVZv/bAfmCI1871Gf5qUn0Hf3
	O7IAtCRz5Y6EUhYsALb2QzE74r40TboRTda3DKIPfwAVc3VZm+tFsfltLlqg+CPB3Ozmuv
	4LENgltqzDJWQs8OZQhTtBSJSNog7/Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780922941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
	b=OLbWwZWjHZCGmTWjuR065PbGSz0Rv/EsZKeiiWQEt0PFg77v9nGhmvZx2CZsKGf2tXH+TP
	U/e63j1STbE4ZDVz20UCYMzjuY3iXnBMVoOdn8B8uy1GEirRF89v0AFr9a7vVPo97XesIX
	SR3p7SHhmfFcKrJWkBLCVFxuhYRToXw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-xhyjesC9NYuOGdYe9G8Q4Q-1; Mon, 08 Jun 2026 08:48:59 -0400
X-MC-Unique: xhyjesC9NYuOGdYe9G8Q4Q-1
X-Mimecast-MFC-AGG-ID: xhyjesC9NYuOGdYe9G8Q4Q_1780922938
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4601102c30dso2463928f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 05:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922938; x=1781527738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
        b=C3zWJ8Fn3TWb77UNuIJRdbEZU3Q3A6JfnbjNQEBjwHs2YadB6Jo8yUVOBJPRHw3ff5
         DEZ0teCC8M7vUQK2zGe5/uL6Gn9oCucU0tCbMKozKEMqg7sKVGje0eqzQg/6eLe0FyNI
         iEt57OJbiIo5rGlRqUDx1xV1ZusVx85lRaktyK5DTO8Mrd1md0aHXCsH51v4CyZffNBz
         WvFdpxpH8jgKaeFvvnI5yil/AMUvqOf5GHKKOCnvugjFID92HkdhUueXddhBIvKr7pG0
         wGAbavdV3yQixDXt0mMkxLPwnrf8MIBV3R33bwVmKtxCXs540iSgK6jNRMFc8vqxLTgI
         wDNg==
X-Forwarded-Encrypted: i=1; AFNElJ8o/sbp1O6KnpTByjqfXTNGtn1WEmS7tfL4pJMHsU2csKM8zqQanXzMH4TnqxnreiMoBBu6SBg6lGdiXnA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzibrUCwmzKVoo175NRj3dK8hBLPWiH8irxhYb8UEN7iRK7x+Zj
	SWFhfonJrBJ1dnGd8u0yM7RHRuEl8v70Q44GGOJh0tvjxzben9mSvE0PDWz8BqmT/1zwWRqx+np
	3U26xi11uYLu32UH/coXHJUYfoUTRaT8DVw9u102owzi/iUI7lRtGU++YhBM0TCVKA3g=
X-Gm-Gg: Acq92OE1kpV6bF8BiSkBodD+BaJ48E8c9i02EcwHr69IwLouh1aOPvq2M0xB9O9RJYT
	jEKUwBqZA8XEYwqtya46P2j9sv2f2KKIPLIXDRDJnt/XoigTC3mhPI9lElxs/sIAPjZhSX3vMjP
	JYQ17uskqc/uzwVTkIenGbJmb3aOPLvntY+383/b4VuOtCfvlIPUawamns9vx+ecycf73rEClyp
	deuJfnrbw4FA3OokXm7QOUvA7C321cz1WRGlFyrg1VjqR814EhJH4sjudhuJ6dKfN39G7gFGULk
	m1Hxt1wPCvsdgbt6pcQ64pMYnO6ewyBxBh3qg7j2X9zfelwFd0cenZSI8T+Y/X+WerK+rw6zzJH
	tGsw7dg160L+uXtZr8GkjUOlislbsvw==
X-Received: by 2002:a5d:458d:0:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-46030631c25mr19295178f8f.21.1780922937962;
        Mon, 08 Jun 2026 05:48:57 -0700 (PDT)
X-Received: by 2002:a5d:458d:0:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-46030631c25mr19295150f8f.21.1780922937604;
        Mon, 08 Jun 2026 05:48:57 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm54213965f8f.1.2026.06.08.05.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:48:56 -0700 (PDT)
Message-ID: <e375b2ec-3f60-4403-8b0d-aeb1d6943f65@redhat.com>
Date: Mon, 8 Jun 2026 14:48:55 +0200
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
Subject: Re: [kvm-unit-tests RFC PATCH 4/6] powerpc: gitlab CI update
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-5-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260602064806.3101025-5-rathc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CDVm1L_TJeLaX7FwoNv8SNGkw9pfHobZDIGpQuu526w_1780922938
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 08.48, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Change to using a gitlab-ci test group instead of specifying all
> tests in .gitlab-ci.yml, and adds a few additional tests (smp, atomics)
> that are known to work in CI.
> 
> To control overhead, ppc64be is used to test 64k page size, ppc64le is
> used to test 4k page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   .gitlab-ci.yml        | 53 ++++++++-----------------------------------
>   powerpc/unittests.cfg | 36 ++++++++++++++++++++++-------
>   2 files changed, 37 insertions(+), 52 deletions(-)

I don't like the idea of handling this differently for powerpc compared to 
the other architectures ... so please either also provide (separate) patches 
for the other architectures, too, or drop this patch.

  Thanks
   Thomas


