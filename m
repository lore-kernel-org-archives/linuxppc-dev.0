Return-Path: <linuxppc-dev+bounces-18002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB8DFD88D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:20:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvbZ2Z1dz3bTf;
	Wed, 11 Mar 2026 13:20:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195610;
	cv=none; b=Ksgan3ZnEWA+WmGo6oc7qdLhAFcyfmS9uBw27PYJ7nNiqcvVDhlKCgaNlvjBSJbKBUtMu4lDJl01/JhWjIsjwBwZp9MIWQFa5sEMRcHqcHy7VKpbOiXzNQHcmr9qVFcl4pLUArS1y2rcUh+ME3yuGotqFltZg6ItQGRuzVP6cHeb2h4QBTm5k2acfYlTFElVrJC7vTVuolpe0xYlRjr7yQT8g9voyijq/R0T+KXn+9e96fdAqYLlhSNl94FC21ZIqHX93rAHJN/Yonp2FPXx4rYhHdpNMkXaoKg5a8hX2W6+Lrl3Y37SR1ZAkGih/NWHNNpcsmzVDAXlx1Se5klLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195610; c=relaxed/relaxed;
	bh=iN9WjUK71z6Jp7rOLbUs73V2L0A4vMW0/ovhSkgQxj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=lYys9xRoCya1ZbAL6oh2Ll0S791Uufa73dlrlUmcx+XYS6xvrmyVvaPE6i/DgbFAGo2WGPkLI965ck6gvFD8xP2yZJnPzHKLeEngyWR8Klw/SZ18NAZUUN5sf0a0LQ9PUdiMzivIVm8rEAu177c58lIKyxlJxyWlRf1sy3n2bzyncO4ts/SQXQFCJoYUGwUyuQhnma6QBdGCGGBacXaX1pjQc82EtsbQ8v7+gJ4ui5GJyOQPq54DMSZVGC8g5+7kySyZdx2Sxqe6lfgxmu+m6VHlS8M2stCHgA5zROYIf5IoLymSJGrtQrZpnx2aX0+ExsLHeFwcghsrlsdKge8Klg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BjKomo8b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BjKomo8b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvbX5PTLz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:20:08 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-829b2018c94so2496926b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773195606; x=1773800406; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN9WjUK71z6Jp7rOLbUs73V2L0A4vMW0/ovhSkgQxj4=;
        b=BjKomo8bHZE9LUdQC8s3xGh994pYYHw3AmOoT5eQDWuNGi33ixBfQRIq4u2WBh2AAM
         Fdg2SRzKZ2gWumL9WOlLe7tHXrJ19FnWRNTRXsXqPR5XMtnrRVe6u6Rzd/dGFaKcr0U/
         /4zF4D8hav4JVe56Q7UV74tgF4RDRLMBll33hWuiMeSH6hxElF6kjd382zblh4gHiMZg
         4QLAy7gBEfJaZcUMpAjCoxhNm1qjcbYpaUnzSUqc76vEcxa3TG4uHrnL0g/DdRmYNj9a
         tXQGT6Zu+iwTxgznrKgjFmR1HJSHL5ypmks5vWYThk23txFeCX9WyI6sQWRsXwDVv/Jg
         PSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195606; x=1773800406;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iN9WjUK71z6Jp7rOLbUs73V2L0A4vMW0/ovhSkgQxj4=;
        b=il1h1U/t04xPtvEmt0Ez8XqghU7vINrCysyxd3/65wXDm+JbZeMLLpMKNcxVTjLpaA
         9wvqxdVjtLQm1MdtOMJvFb8SLRvPqKqbzrgZRY6YgzpSYrpqqLjzgnn1qptiXrfgOVXq
         hzkofjIFsfMnS3u0WhBhYwwjKjGEZD3l5++lQVJPZWkZYe+fj9xSDTjRkd+4392hMTr/
         MmeEekh0v2x+eSKU5y58pz2OUpBlYfP+GiDlr0X9B4ZbyUri+v5NrLi5NlivtQdOzWeb
         /PoMTorjI1lYhogNH1HRW5PxAExoGDMI+It9/7CHyd0O1WXGrrGA5+Knfe7PGfYCaL2Z
         uDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx+BJiq9O1abF8Fml0WxHuf9Z0susw0HzQGPL7eXFLeFAoRR7//yN0Xjh6I05hcbn3R35oC3mdcuxaXvg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxtm42YDkdx3Av/ir6QJcXkPZpKwAQCNsNnd7PnMiX7plpEZsEn
	vxn44gCuGb2rEEEAs0wO5H0siIDjPupLxPg7BmxApkp1/0SNqM4dcRFu
X-Gm-Gg: ATEYQzy08E42E6PdVRKorQf4980LrGx6CM+0beTt9xUD84oKBnAwchUNJxDY7qDShVh
	qems0GWziv1TahYYyQEKWC5zFLkqG6a26d03QIC+rVlouGcc3SGfOf9tBJhv17/ygTyW+k3tpqx
	CMt82PNj2gcC6qIXZ8zbp2WbG796zci+irwgwYPaeo3aK4I2Ak10IyxW7OAWZNQyTB/DeVNhiYZ
	2LeZLbKqXkbsL6Q1xlhS12kMTE4v9DCvsz/Pw/Iegi0ck1IrfMMbPgfTucZ8Hb/8eOsCpo3ple7
	FAFEqM4U8XbiwuSvRBMe8fvHcZTy0we4e5AwazXJf7pwBpPKQs59+TPE+4FmU8uUCMbfCklR7lb
	c1duiLuPbOJayx5LO+aQP99tT3G/HX7Yf1aPCQ2o3nKmDPDzrntoYukLiAXeENMCWxxCyIyaEGU
	Ewteqad0wzPWnh/pVinX78axMMFBX6Izfq
X-Received: by 2002:a05:6a00:3d54:b0:823:8a5:297f with SMTP id d2e1a72fcca58-829f6ea7405mr826301b3a.16.1773195606247;
        Tue, 10 Mar 2026 19:20:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3b9esm608441b3a.17.2026.03.10.19.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:20:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Sayali Patil <sayalip@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] Misc powerpc selftests kernel fixes and cleanups
In-Reply-To: <f42fc693-b5be-4b3f-9bb2-7aab5b8bc599@linux.ibm.com>
Date: Wed, 11 Mar 2026 07:40:57 +0530
Message-ID: <3427unda.ritesh.list@gmail.com>
References: <cover.1773078178.git.ritesh.list@gmail.com> <f42fc693-b5be-4b3f-9bb2-7aab5b8bc599@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:

> On 09/03/26 11:44 pm, Ritesh Harjani (IBM) wrote:
>> v1->v2:
>>
>> - dropped debug_vm_pgtable patch which adds a testcase to simulate the
>>    failure scenario. Since it belongs to linux-mm, I will send that out
>>    separately.
>> - Modified Patch-2 in this series to also cover PMD device migration
>>    entry (in addition to PMD THP migration entry). Hence dropped the
>>    previous RB tag.
>> - Added a new Patch-3 to fix another selftests WARNING.
>> - Fixed commit subject of Patch-10.
>> - Changed subject pre-fix of few patches to be consistent with others
>>    (powerpc/64s)
>> - Added RB tags
>>
>> This patch series addresses selftests issues w.r.t warnings or
>> VM_BUG_ONs seen mainly on book3s64 powerpc kernel. This also carries
>> cleanups and refactoring changes which I identified while reviewing
>> other's patches and/or during code walkthrough.
>>
>> Suggestions and feedback are welcome!
>>
>> Ritesh Harjani (IBM) (10):
>>    powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy
>>    powerpc/64s: Fix unmap race with PMD migration entries
>>    powerpc/64s: Fix _HPAGE_CHG_MASK to include _PAGE_SPECIAL bit
>>    powerpc/64s/tlbflush-radix: Remove unused radix__flush_tlb_pwc()
>>    powerpc/64s: Move serialize_against_pte_lookup() to hash_pgtable.c
>>    powerpc/64s: Kill the unused argument of exit_lazy_flush_tlb
>>    powerpc/64s: Rename tlbie_va_lpid to tlbie_va_pid_lpid
>>    powerpc/64s: Rename tlbie_lpid_va to tlbie_va_lpid
>>    powerpc/64s: Make use of H_RPTI_TYPE_ALL macro
>>    powerpc: Print MMU_FTRS_POSSIBLE & MMU_FTRS_ALWAYS at startup
>>
>>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 20 +++++-
>>   .../include/asm/book3s/64/tlbflush-radix.h    |  1 -
>>   arch/powerpc/kernel/setup-common.c            |  4 ++
>>   arch/powerpc/mm/book3s64/hash_pgtable.c       | 21 +++++++
>>   arch/powerpc/mm/book3s64/internal.h           |  2 -
>>   arch/powerpc/mm/book3s64/pgtable.c            | 40 +++---------
>>   arch/powerpc/mm/book3s64/radix_tlb.c          | 61 ++++++++-----------
>>   arch/powerpc/mm/pgtable-frag.c                |  1 +
>>   8 files changed, 79 insertions(+), 71 deletions(-)
>>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Thanks a lot!

>
> I applied the patch series on top of mainline and verified that the kernel
> builds and boots successfully.
>
> I also ran the following test suites on both RADIX (POWER11) and HASH 
> (POWER9)
> MMU configurations:
>
>    - tools/testing/selftests/mm
>    - tools/testing/selftests/memory-hotplug
>    - tools/testing/selftests/powerpc/mm
>    - tools/testing/selftests/powerpc/cache_shape
>    - tools/testing/selftests/powerpc/copyloops
>
> In addition, I executed basic sanity and stress tests, including:
> stutter, eatmemory, hugepage_sanity, fork_mem, memory_api mprotect,
> vatest, and several transparent-hugepage sanity checks.

Thanks Venkat for verifying this extensively.
So other than couple of hmm tests, there shouldn't be any other kernel
warnings or any VM_BUG_ONs() hitting after this patch series.
(we discussed this internally too!)

And as for those warnings with hmm tests fixes - will fix them in a
separate patch series later (as those looks to be non-powerpc fixes).

This should also enable Venkat and other CI systems to run mm selftests
on book3s64 PowerPC without any kernel issues.

>
> All tests passed without regressions.

Thanks! 

>
> Regards,
> Venkat

