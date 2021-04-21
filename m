Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5BC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 21:00:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBD06140C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 21:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBD06140C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQXxx0rXDz30Df
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:00:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OlWMvgCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=OlWMvgCX; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQXxC38xjz2yRY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 06:59:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=rfZ2allPP+v8X2sml5OGsmvKn3aZtnzQ4fKQFLZOE34=; b=OlWMvgCXyK582OBPpn1kHYBz2K
 6jKh7dCqNYyMAG+uW5cOdGkml6d3Q20/rVX2CAUzHBzUt69kefVDoBQc/DCeIIx7kOHk6ky+EkTD1
 ofzvdBvhOjs17A5HTeKgGOSqX2ouM1UyNyvumkaQwhDjguT2/iHtT+1ht+xFBPjTONuyQ5xvJ/D2Y
 j4FeqPFl+vHqbWzHf13pdnNuyo3uPJ7xSpNnEQtd8z7/pBLKFZdXpy1T8IyHcmGaq+LjBaSem+uB9
 4tuCG/kYX4EMI7MgCrdkGmmM+BbdTV9XJ3wPkcDKj5p3Afnk6tHAtOQFDQ/BqnPSj8VIW92b4vy3k
 uoj7YMRw==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lZJwc-00FBur-8o; Wed, 21 Apr 2021 20:59:36 +0000
Subject: Re: [PATCH v2] powerpc: make ALTIVEC select PPC_FPU
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org
References: <20210421025605.10868-1-rdunlap@infradead.org>
 <60ac6ff1-6bfa-d335-ac0e-336fe3e50587@csgroup.eu>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d2821589-0205-cd80-ef81-050d396f8cc1@infradead.org>
Date: Wed, 21 Apr 2021 13:59:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <60ac6ff1-6bfa-d335-ac0e-336fe3e50587@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/20/21 10:19 PM, Christophe Leroy wrote:
> 
> 
> Le 21/04/2021 à 04:56, Randy Dunlap a écrit :
>> On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
>> there are build errors:
>>
>> drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
>>             enable_kernel_fp();
>> ../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
>> ../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
>>    637 |   put_vr(rn, &u.v);
>>        |   ^~~~~~
>> ../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
>> ../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
>>    660 |   get_vr(rn, &u.v);
>>        |   ^~~~~~
>>
>> In theory ALTIVEC is independent of PPC_FPU but in practice nobody
>> is going to build such a machine, so make ALTIVEC require PPC_FPU
>> by selecting it.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>> Cc: lkp@intel.com
>> ---
>> v2: change ALTIVEC depends on PPC_FPU to select (Christophe and Michael)
>>
>>   arch/powerpc/platforms/86xx/Kconfig    |    1 +
>>   arch/powerpc/platforms/Kconfig.cputype |    2 ++
>>   2 files changed, 3 insertions(+)
>>
>> --- linux-next-20210416.orig/arch/powerpc/platforms/86xx/Kconfig
>> +++ linux-next-20210416/arch/powerpc/platforms/86xx/Kconfig
>> @@ -4,6 +4,7 @@ menuconfig PPC_86xx
>>       bool "86xx-based boards"
>>       depends on PPC_BOOK3S_32
>>       select FSL_SOC
>> +    select PPC_FPU
> 
> Now that ALTIVEC selects PPC_FPU by itself, I don't think you need that.
> 
>>       select ALTIVEC
>>       help
>>         The Freescale E600 SoCs have 74xx cores.
>> --- linux-next-20210416.orig/arch/powerpc/platforms/Kconfig.cputype
>> +++ linux-next-20210416/arch/powerpc/platforms/Kconfig.cputype
>> @@ -186,6 +186,7 @@ config E300C3_CPU
>>   config G4_CPU
>>       bool "G4 (74xx)"
>>       depends on PPC_BOOK3S_32
>> +    select PPC_FPU
> 
> Same

Of course. v3 coming up.
Thanks.

>>       select ALTIVEC
>>     endchoice
>> @@ -310,6 +311,7 @@ config PHYS_64BIT
>>   config ALTIVEC
>>       bool "AltiVec Support"
>>       depends on PPC_BOOK3S_32 || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
>> +    select PPC_FPU
>>       help
>>         This option enables kernel support for the Altivec extensions to the
>>         PowerPC processor. The kernel currently supports saving and restoring
>>


-- 
~Randy
