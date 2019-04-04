Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39936C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 04:02:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566662171F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 04:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Tm7z8i3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566662171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZTmc6hnMzDqLZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 15:02:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Tm7z8i3w"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZTkh0qSxzDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 15:00:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZTkW3NbVz9v06G;
 Thu,  4 Apr 2019 06:00:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Tm7z8i3w; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id HFBQTewok6V2; Thu,  4 Apr 2019 06:00:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZTkW1jWwz9v06F;
 Thu,  4 Apr 2019 06:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554350435; bh=0PykcnfLnyviU+RdjOqdwWmoWGb9cg9ks7TtpDlXtRY=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Tm7z8i3wyA2kGZsXwaCrLuR+izkdrlgmGraZC6JQPYwZx0qOcmPHLl+JPbUq6sCab
 Hw9PjxSFPfqlXaxVKeRuVTFcqEexCQvkjjy8b9v/wiH+SHgHN43oYN9HUpMqNYd4O4
 raS52SkourGEJxl8JUaGSfluz097yLlxjkY1zmZE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E8F218B795;
 Thu,  4 Apr 2019 06:00:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id p5dm0RL8IkJX; Thu,  4 Apr 2019 06:00:35 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B9898B76F;
 Thu,  4 Apr 2019 06:00:35 +0200 (CEST)
Subject: Re: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
 <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
 <0f0403a0-476a-6129-8dc6-866d894c9adc@xenosoft.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5726a634-25ca-d267-17fd-af88436edf1f@c-s.fr>
Date: Thu, 4 Apr 2019 06:00:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0f0403a0-476a-6129-8dc6-866d894c9adc@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/04/2019 à 02:58, Christian Zigotzky a écrit :
> On 03 April 2019 at 07:05AM, Christophe Leroy wrote:
>> Le 03/04/2019 à 05:52, Christian Zigotzky a écrit :
>>> Please test VLC with the RC3 of kernel 5.1.
>>>
>>> The removing of the PowerPC fixes 5.1-3 has solved the VLC issue. 
>>> Another user has already confirmed that [1]. This isn’t an April 
>>> Fool‘s. ;-)
>>
>> Could you bisect to identify the guilty commit ?
>>
>> Thanks
>> Christophe
>>
>>>
>>> Thanks
>>>
>>> [1] 
>>> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4256&start=20#p47561 
>>>
>>>
>>
> Hello Christophe,
> 
> I have found the problematic patch. The following patch from the PowerPC 
> fixes 5.1-3 is responsible for the VLC issue.

That change is part of the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc2&id=b5b4453e7912f056da1ca7572574cada32ecb60c

Just changing back the type of wtom_clock_sec to 32 bits without 
changing back the loading instruction is likely to give unexpected 
results on PPC64.

Are you using 32 bits or 64 bits powerpc ?

Christophe

> 
> diff --git a/arch/powerpc/include/asm/vdso_datapage.h 
> b/arch/powerpc/include/asm/vdso_datapage.h
> index 1afe90ade595..bbc06bd72b1f 100644
> --- a/arch/powerpc/include/asm/vdso_datapage.h
> +++ b/arch/powerpc/include/asm/vdso_datapage.h
> @@ -82,10 +82,10 @@ struct vdso_data {
>      __u32 icache_block_size;      /* L1 i-cache block size     */
>      __u32 dcache_log_block_size;      /* L1 d-cache log block size */
>      __u32 icache_log_block_size;      /* L1 i-cache log block size */
> -   __s32 wtom_clock_sec;         /* Wall to monotonic clock */
> -   __s32 wtom_clock_nsec;
> -   struct timespec stamp_xtime;   /* xtime as at tb_orig_stamp */
> -   __u32 stamp_sec_fraction;   /* fractional seconds of stamp_xtime */
> +   __u32 stamp_sec_fraction;      /* fractional seconds of stamp_xtime */
> +   __s32 wtom_clock_nsec;         /* Wall to monotonic clock nsec */
> +   __s64 wtom_clock_sec;         /* Wall to monotonic clock sec */
> +   struct timespec stamp_xtime;      /* xtime as at tb_orig_stamp */
>         __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
>         __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>   };
> 
> -----
> 
> Link: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/include/asm/vdso_datapage.h?h=v5.1-rc2&id=a5ed1e96cafde5ba48638f486bfca0685dc6ddc9 
> 
> 
> I created a patch for solving the VLC issue today.
> 
> vdso_datapage_vlc.patch:
> 
> diff -rupN a/arch/powerpc/include/asm/vdso_datapage.h 
> b/arch/powerpc/include/asm/vdso_datapage.h
> --- a/arch/powerpc/include/asm/vdso_datapage.h  2019-04-03 
> 22:56:44.560645936 +0200
> +++ b/arch/powerpc/include/asm/vdso_datapage.h  2019-04-04 
> 02:20:09.479361827 +0200
> @@ -82,10 +82,10 @@ struct vdso_data {
>          __u32 icache_block_size;                /* L1 i-cache block 
> size     */
>          __u32 dcache_log_block_size;            /* L1 d-cache log block 
> size */
>          __u32 icache_log_block_size;            /* L1 i-cache log block 
> size */
> -       __u32 stamp_sec_fraction;               /* fractional seconds of 
> stamp_xtime */
> -       __s32 wtom_clock_nsec;                  /* Wall to monotonic 
> clock nsec */
> -       __s64 wtom_clock_sec;                   /* Wall to monotonic 
> clock sec */
> -       struct timespec stamp_xtime;            /* xtime as at 
> tb_orig_stamp */
> +       __s32 wtom_clock_sec;                   /* Wall to monotonic 
> clock */
> +       __s32 wtom_clock_nsec;
> +       struct timespec stamp_xtime;    /* xtime as at tb_orig_stamp */
> +       __u32 stamp_sec_fraction;       /* fractional seconds of 
> stamp_xtime */
>          __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
>          __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>   };
> 
> -----
> 
> Cheers,
> Christian
