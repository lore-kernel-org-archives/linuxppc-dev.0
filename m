Return-Path: <linuxppc-dev+bounces-23596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D84BC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv14S6Y7Cz2yVZ;
	Mon, 06 Jul 2026 20:36:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783334200;
	cv=none; b=Gl8Yo8UWOE5f3o6Si3qvo/7SVHV6pbFf/OB2f7d/HVkLkBTZv0yrEsZzf5yE0dMG+TFeMgMwbhsUSsJRHphlxZqo0sX07LaRJRH+6a42iTNkCgC80MXvT/KSkKqTXX55BXYVJJftdHtLnzAj2HfF012dvfG8Lj7AgHoxzLAz1hCBT6VXboCY2Ylpy5Ef3f3uzlfKzIWbEyMXBrUBYjJQHr2yw2fL9fvjtxNPeXVbVr9vVDxg1mk+mHMK+6KEou6y+zV5a32dDnTWQl3S3mOo9ciKwxjAI5oskd85SeAm25EIFCG25+J1bwxuYcRmXptzoryqNQrNU8fPKswX8ahP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783334200; c=relaxed/relaxed;
	bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdgQxDai8ekdnzJ9EBJsPmTk7LvwKl36LoBOlQyffGMB3RO20QqD32ccpRWGYHTdPdJet+x8pfe8PF0os9TUqv0bycGB4dkPbUwi2l4i6jQU4IGInNuom4nyJGqbXHjagW13+mLYnnelRYgMixdo5F/me6Zu7FQUQfe7C80sz6+GElzCg2Jenuu5Q9jBBuMp959bPDcOZ+0Fuedb1JPv1O99S5sXl3znVq6Px5QJ8ge6GXSHtdL8bw8ES5sYwdgMY3CBccibHuaqIq4REvgX2TIvJ+kurCjiqdtFpaaeUYlJugeCPBqv/mwCERru/AXZRUY84V57xFsl5rBfjwPZlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yp7I/guc; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDbl90Av; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yp7I/guc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDbl90Av;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv14R2M7Yz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 20:36:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
	b=Yp7I/gucx4Un8aolgmbKt33vUFhSK725/Xf+FNdQZRNpLgxlRmrHW1hiA0Vn3HS278H94R
	b+3tvTrc5OYwGJZeV/rxhAhxxV0Prqbth7bAMu1KmU6Ex3JL0/GunjTdDFdsAetUNa94wf
	238fpdZfH5OanA/ZEu0j3/pU+ez8X9c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
	b=bDbl90AvjKVSDA9Cqyk5nfZaGSOv8RtVip5gH3WMZJOed48fniKD0Akg8yyTFaXDk9rJdj
	TLqotvUrOwXv2fDea8TCTAxD1L8anrnbwgfFcLZ2dymdN7Zyjf1zbKkdPdCi5YadyDBBxN
	XtG7iI44EyaaKLn629L8AygWXbT04JU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-PJlnafGqNUeAIeFXmLu-6w-1; Mon, 06 Jul 2026 06:36:30 -0400
X-MC-Unique: PJlnafGqNUeAIeFXmLu-6w-1
X-Mimecast-MFC-AGG-ID: PJlnafGqNUeAIeFXmLu-6w_1783334189
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so27419105e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 03:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334189; x=1783938989;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
        b=MZ0S2gbgCdr7J/hnvqUJORHQIatrtUMxAXZclhGVsaWSDbmR4t4Gic03v1Is6WCFMW
         P1RaxvbaxuV7JJ9MSEZbBhfV4Db1epHgSJyDgO+p4vhEvDbD6JAJWWptfZ9nt4hyYwfl
         UoU0MEfIZ7isPbdHLIvAv2RiPsV7z7KtyQueZGa36udVR8aUCpgV3FksFtUDnsi/hKU0
         obM/qsOvBZsqzq96BD6gIyvhbNkVdTbwnhI9hn3uTcxJkGR0R2/qQ1FRFYBkFCb/DnRY
         j2FOExWvdWxsKfURq9lB/Ep4pX7Zb7F7tTWh5MD89g7G+KJpOmpSCR0Dxo8mvKJWkIWK
         tUSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCLNcS5mXfsHNutUtHpDDQecoA8f1x6A4+r1ZLxq3O7BH5SgH+id7tBuxY5dX7dOT7b6PmOoGT43DffDo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFO4gPCzk/pSMlx6qy/gy2xsiArcKnwK4F+kY8E2flcwXS8x2G
	HBCRXBJuOyDIEQnAdIYWPHYF/Deqo/ubsdzXZCj0WQ9C3wb0Kl+LVIchWRlymAeJ7X2Isj4ik2w
	tg3flXuzyDDtpRvFc2ieWJ7WuidfvefDkl2KmQSl4qSe/FRRCg0Dgraikm8w5UiUuW4I=
X-Gm-Gg: AfdE7clSN2hr6u05jvEMtQsVgz6dF5+8RuM4G6qzr6Ach0rOjjl37YfJnDooGykHY97
	OvlqkLTW4cEtdFogRTmPvK0AoH+TFepUVj3Mrq0sgOYbXM4iu6I97Bc36JLusgR3oW3O88pZZgv
	eJhZl2CALypxxiTZQSye2JTg4kSF8E6r8ZdlWf6flMifPjYnSvWws3YPg+i4GgIaKhjAPUO4gVA
	bvieUEUAiV2ty7APlAduILItCKdEiHl3dHqCEQAlb38l0vGm98o6dw5wyskuSzQEa+S7X0pRTrE
	+bXF53xdmimI975ozmyX+wHKgKtJeFilvoHsyokhJ7chBkosK/L4PQ9uTfFXwVdMzxRoWegJOZT
	E1IRvIYpBH/mS4QcMgZ27miQ6to4+wDXbCV9BVQqwZU6vWirQYilb
X-Received: by 2002:a05:600c:8717:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493decb3633mr1233095e9.4.1783334189180;
        Mon, 06 Jul 2026 03:36:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8717:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493decb3633mr1232715e9.4.1783334188773;
        Mon, 06 Jul 2026 03:36:28 -0700 (PDT)
Received: from ?IPV6:2a01:599:b25:5a4f:915f:c838:d9f4:60ca? ([2a01:599:b25:5a4f:915f:c838:d9f4:60ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef23feasm331060155e9.2.2026.07.06.03.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:36:27 -0700 (PDT)
Message-ID: <6e29ac41-383a-416c-bca4-c3d4349beda0@redhat.com>
Date: Mon, 6 Jul 2026 12:36:26 +0200
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
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
 <7d9e6365-1b2d-4b18-8fb5-d8048fddb7f0@redhat.com>
 <efbbe11b-9e02-4878-b61a-f804b491ab4c@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <efbbe11b-9e02-4878-b61a-f804b491ab4c@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TJcfu1b6_2AgLxRiPxm8AGUnY3qBJa-ecDHjxlWvwh4_1783334189
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/07/2026 08.46, Chinmay Rath wrote:
> 
> On 6/10/26 17:00, Thomas Huth wrote:
>> On 02/06/2026 08.48, Chinmay Rath wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> arch_libdir was brought in to improve the heuristic determination of
>>> the lib/ directory based on arch and testdir names, but it did not
>>> entirely clean that mess up.
>>>
>>> Remove the arch_libdir->arch->testdir heuristic and just require
>>> everybody sets arch_libdir correctly. Fail if the lib/arch or
>>> lib/arch/asm directories can not be found.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>> ---
>>>   Makefile  |  2 +-
>>>   configure | 20 ++++++++++++--------
>>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>
>> FYI, this patch seems to trigger yet another issue with Clang (I used v21):
>>
>> clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float -mno- 
>> altivec  -I /root/kvm-unit-tests/lib -I /root/kvm-unit-tests/lib/libfdt -I 
>> lib -Wa,-mregnames -fverbose-asm -S -o lib/powerpc/asm-offsets.s lib/ 
>> powerpc/asm-offsets.c
>> lib/powerpc/asm-offsets.c:10:10: error: 'asm/smp.h' file not found with 
>> <angled> include; use
>>       "quotes" instead
>>    10 | #include <asm/smp.h>
>>       |          ^~~~~~~~~~~
>>       |          "asm/smp.h"
>> In file included from lib/powerpc/asm-offsets.c:10:
>> lib/powerpc/asm/smp.h:5:10: fatal error: 'asm/processor.h' file not found
>>     5 | #include <asm/processor.h>
>>       |          ^~~~~~~~~~~~~~~~~
>> 2 errors generated.
>>
>> Could you please have a look?
> 
> Hi Thomas, back from traveling and looked into this.
> I am using Clang v21 as well :
> # clang --version
> clang version 21.1.8 (Fedora 21.1.8-4.fc43)
> Target: ppc64le-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg
> 
> I see the above file, asm-offsets.s being generated properly without any 
> error during the make process (used the extra flags for make that I have 
> mentioned in my other reply).
> Snippet from make :
> cat powerpc/boot_rom.bin.tmp >> powerpc/boot_rom.bin
> rm -f powerpc/boot_rom.bin.tmp
> clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 -msoft- 
> float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I /root/chins/ 
> git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -fverbose-asm -S -o lib/ 
> powerpc/asm-offsets.s /root/chins/git/kvm-unit-tests/lib/powerpc/asm-offsets.c
> (set -e; echo "#ifndef __ASM_OFFSETS_H__"; echo "#define __ASM_OFFSETS_H__"; 
> echo "/*"; echo " * Generated file. DO NOT MODIFY."; echo " *"; echo " */"; 
> echo ""; sed -ne  's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/ 
> {s:->#\(.*\):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([-0-9]*\) \(.*\):#define \1 
> \2 /* \3 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; 
> s:->::; p;}' lib/powerpc/asm-offsets.s; echo ""; echo "#endif" ) > lib/ 
> powerpc/asm-offsets.h
> cp -f lib/powerpc/asm-offsets.h lib/generated/
> clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 -msoft- 
> float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I /root/chins/ 
> git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -g -MMD -MP -MF 
> powerpc/.selftest.d -fno-strict-aliasing -fno-common -Wall -Wwrite-strings - 
> Wempty-body -Wuninitialized -Wignored-qualifiers -Wno-missing-braces -Werror 
> -fomit-frame-pointer  -fno-stack-protector   -Wno-frame-address  -fno-pic    
> -Wunused-but-set-parameter -Wno-override-init  -Wmissing-prototypes - 
> Wstrict-prototypes -mlittle-endian   -c -o powerpc/selftest.o /root/chins/ 
> git/kvm-unit-tests/powerpc/selftest.c
> 
> Infact, if I just execute that single command independently to build asm- 
> offsets.s, it works as well.

Ok, I finally got access to a POWER system again and tried to reproduce the 
issue, but I also cannot reproduce it anymore. No clue how I managed to get 
into that situation, but looks like it was rather due to a messed up build 
tree than due to your patch. So sorry for the trouble, and please go ahead 
and simply ignore my objection here.

  Thanks,
   Thomas



