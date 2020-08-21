Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDAC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 22:47:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D942067C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aaem4Vn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D942067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BYGr40CCyzDrMD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2020 08:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Aaem4Vn0; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BYGnz2BFszDqbc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2020 08:45:57 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id x6so1652740pgx.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=XRteHtv7uQmPq//ewuwrb7IZate8ro17vyeajkupG2I=;
 b=Aaem4Vn0bTEhViBFnc9tNsPPZfZuxBSub2f1nuc4MmLrKJfehNNHC9FP58+Q99TpoJ
 CpyvdmR758FAbXUk+bZELWHzl0ZBJJHNrJ0o1OiFr5aEhnPiK7JAYnBYHuFlc87PBxMw
 5CkKUufHHUze0EbfKk5GkR4Sze0bxy10EoqSvehwLcZJivmtaCviba+jHzYG29+4F1hR
 kqoGu7zsi8jiLTa8Ca1bap7yXXxhgWrpwIC4iek8D8rNgLuKpNWAQMCj6+Sri3WvOUGr
 ZpkrJVq6T11xVJA0tVsLBKFfIsFV+B/n1jrQ+SlwybFHe3e4OAiIp0iV880jRDPNyHar
 P9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=XRteHtv7uQmPq//ewuwrb7IZate8ro17vyeajkupG2I=;
 b=OZPV5xG2vMZGQpNdc6/Bv5ToNObT69d7TN4zUBuJadJ/Iw/oUHhw36i7+uqemf+kCf
 XLj4YZpWM0X9TnEtYdnOsl+Hrwyfl3ibpPjkQkDN6stBAG5z8zbfh8b1CdqyCkGWJL/q
 lgUmP1f5PHysNPqHB9f3FIdrRxdcU1vJPHPFKnEhQtyEqlM/5xzF/8NWuR1WIgVKS75L
 rETnJpVoK8SMW354JzVSrzdP8y0ssvk7dvlOSk3EgacdEz+h2TrDzdCQFpd4dUBlFyHZ
 PVMGWnTlaFFqYtEhocMsGzvFA+ooi2Kkmpxt16CchtE8id+ZRi6beFesIgsEfuD5ouxZ
 YVMw==
X-Gm-Message-State: AOAM530a47A5GMRy0cIBkCeBLr40T1mFcv5NvFf2rB5PliGpmYXHC4yS
 1QYC2ssug50k07Cbk6+AXGQ=
X-Google-Smtp-Source: ABdhPJy7krGSqdemncjBBCsDGsMdylWo6zM9qjg4SD8PzW/+V58PKpTZD+S3JHXtmZJ0AJ7MWzK3TQ==
X-Received: by 2002:a62:7acb:: with SMTP id v194mr4142526pfc.302.1598049954288; 
 Fri, 21 Aug 2020 15:45:54 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
 by smtp.gmail.com with ESMTPSA id w130sm3564073pfd.104.2020.08.21.15.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 15:45:53 -0700 (PDT)
Date: Sat, 22 Aug 2020 08:45:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 05/12] mm: HUGE_VMAP arch support cleanup
To: Andrew Morton <akpm@linux-foundation.org>
References: <20200821151216.1005117-1-npiggin@gmail.com>
 <20200821151216.1005117-6-npiggin@gmail.com>
 <20200821131422.110abb1a0c0b6a9d378b0e48@linux-foundation.org>
In-Reply-To: <20200821131422.110abb1a0c0b6a9d378b0e48@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1598049779.exwra3cjwe.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>,
 =?iso-8859-1?q?Borislav=0A?= Petkov <bp@alien8.de>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 =?iso-8859-1?q?Thomas=0A?= Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Andrew Morton's message of August 22, 2020 6:14 am:
> On Sat, 22 Aug 2020 01:12:09 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> This changes the awkward approach where architectures provide init
>> functions to determine which levels they can provide large mappings for,
>> to one where the arch is queried for each call.
>>=20
>> This removes code and indirection, and allows constant-folding of dead
>> code for unsupported levels.
>>=20
>> This also adds a prot argument to the arch query. This is unused
>> currently but could help with some architectures (e.g., some powerpc
>> processors can't map uncacheable memory with large pages).
>>=20
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -1,4 +1,12 @@
>>  #ifndef _ASM_ARM64_VMALLOC_H
>>  #define _ASM_ARM64_VMALLOC_H
>> =20
>> +#include <asm/page.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> +bool arch_vmap_p4d_supported(pgprot_t prot);
>> +bool arch_vmap_pud_supported(pgprot_t prot);
>> +bool arch_vmap_pmd_supported(pgprot_t prot);
>> +#endif
>=20
> Moving these out of generic code and into multiple arch headers is
> unfortunate.  Can we leave them in include/linux/somewhere?  And remove
> the ifdefs, if so inclined - they just move the build error from
> link-time to compile-time, and such an error shouldn't occur!

Yeah this was just an intermediate step as you saw. It's a bit=20
unfortunate, but I thought it made the arch changes clearer.

Thanks,
Nick

