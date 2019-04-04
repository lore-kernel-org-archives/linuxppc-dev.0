Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AECC10F05
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B43E21734
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oqGCMAco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B43E21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZccD3YCNzDqCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 20:10:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="oqGCMAco"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZcYB1CK6zDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 20:07:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZcY33tnRz9v0gv;
 Thu,  4 Apr 2019 11:07:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oqGCMAco; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qjFsYhmXoDMK; Thu,  4 Apr 2019 11:07:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZcY32Zqjz9v0gt;
 Thu,  4 Apr 2019 11:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554368871; bh=ws+azD3oknuXJ8azNkU/mT/eLrQKACxcLP6tqpKum1U=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=oqGCMAcofucgjntaa62ieLnqlOZZ/+0WKOvpHLQpvwoXi73Q0rwUZQdnIG4yR3FAY
 qhy2hg4LfgUgY1DWYg4PzSpMAqRr/mfppKdp+RsFkA0n91mTNQvLs2yCqnyjpwgP7s
 bcU2ylyAhdT+EDTra3nvEwz7NsdaoyFYDbjP2B5Y=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7086A8B914;
 Thu,  4 Apr 2019 11:07:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id x70-rUy5Qn-5; Thu,  4 Apr 2019 11:07:52 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.204.43])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D09888B7FD;
 Thu,  4 Apr 2019 11:07:51 +0200 (CEST)
Subject: Re: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
 <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
 <0f0403a0-476a-6129-8dc6-866d894c9adc@xenosoft.de>
 <5726a634-25ca-d267-17fd-af88436edf1f@c-s.fr>
 <99ff68a4-3aef-47ad-99f8-433b181afe3f@xenosoft.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <84668be2-94ff-19f6-3b12-56ac545b92bd@c-s.fr>
Date: Thu, 4 Apr 2019 09:07:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <99ff68a4-3aef-47ad-99f8-433b181afe3f@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 04/04/2019 08:44 AM, Christian Zigotzky wrote:
> On 04 April 2019 at 06:00AM, Christophe Leroy wrote:
>>
>>
>> Le 04/04/2019 à 02:58, Christian Zigotzky a écrit :
>>> On 03 April 2019 at 07:05AM, Christophe Leroy wrote:
>>>> Le 03/04/2019 à 05:52, Christian Zigotzky a écrit :
>>>>> Please test VLC with the RC3 of kernel 5.1.
>>>>>
>>>>> The removing of the PowerPC fixes 5.1-3 has solved the VLC issue. 
>>>>> Another user has already confirmed that [1]. This isn’t an April 
>>>>> Fool‘s. ;-)
>>>>
>>>> Could you bisect to identify the guilty commit ?
>>>>
>>>> Thanks
>>>> Christophe
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>> [1] 
>>>>> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4256&start=20#p47561 
>>>>>
>>>>>
>>>>
>>> Hello Christophe,
>>>
>>> I have found the problematic patch. The following patch from the 
>>> PowerPC fixes 5.1-3 is responsible for the VLC issue.
>>
>> That change is part of the following commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc2&id=b5b4453e7912f056da1ca7572574cada32ecb60c 
>>
>>
>> Just changing back the type of wtom_clock_sec to 32 bits without 
>> changing back the loading instruction is likely to give unexpected 
>> results on PPC64.
>>
>> Are you using 32 bits or 64 bits powerpc ?
>>
>> Christophe
> 64-bit kernel + 32-bit userland for example:
> 
> - ubuntu MATE 16.04.6 LTS 32-bit PowerPC with a 64-bit kernel
> - Fienix (Debian Sid) 32-bit PowerPC with a 64-bit kernel
> - MATE PowerPC Remix (ubuntu MATE 17.04) 32-bit PowerPC with a 64-bit 
> kernel

Ok, thanks. Can you please try below change:

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S 
b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 1e0bc5955a40..afd516b572f8 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -98,7 +98,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
  	 * can be used, r7 contains NSEC_PER_SEC.
  	 */

-	lwz	r5,WTOM_CLOCK_SEC(r9)
+	lwz	r5,(WTOM_CLOCK_SEC+LOPART)(r9)
  	lwz	r6,WTOM_CLOCK_NSEC(r9)

  	/* We now have our offset in r5,r6. We create a fake dependency


Christophe

> 
> -- Christian
>>
>>
>>>
>>> diff --git a/arch/powerpc/include/asm/vdso_datapage.h 
>>> b/arch/powerpc/include/asm/vdso_datapage.h
>>> index 1afe90ade595..bbc06bd72b1f 100644
>>> --- a/arch/powerpc/include/asm/vdso_datapage.h
>>> +++ b/arch/powerpc/include/asm/vdso_datapage.h
>>> @@ -82,10 +82,10 @@ struct vdso_data {
>>>      __u32 icache_block_size;      /* L1 i-cache block size */
>>>      __u32 dcache_log_block_size;      /* L1 d-cache log block size */
>>>      __u32 icache_log_block_size;      /* L1 i-cache log block size */
>>> -   __s32 wtom_clock_sec;         /* Wall to monotonic clock */
>>> -   __s32 wtom_clock_nsec;
>>> -   struct timespec stamp_xtime;   /* xtime as at tb_orig_stamp */
>>> -   __u32 stamp_sec_fraction;   /* fractional seconds of stamp_xtime */
>>> +   __u32 stamp_sec_fraction;      /* fractional seconds of 
>>> stamp_xtime */
>>> +   __s32 wtom_clock_nsec;         /* Wall to monotonic clock nsec */
>>> +   __s64 wtom_clock_sec;         /* Wall to monotonic clock sec */
>>> +   struct timespec stamp_xtime;      /* xtime as at tb_orig_stamp */
>>>         __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>>         __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>>   };
>>>
>>> -----
>>>
>>> Link: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/include/asm/vdso_datapage.h?h=v5.1-rc2&id=a5ed1e96cafde5ba48638f486bfca0685dc6ddc9 
>>>
>>>
>>> I created a patch for solving the VLC issue today.
>>>
>>> vdso_datapage_vlc.patch:
>>>
>>> diff -rupN a/arch/powerpc/include/asm/vdso_datapage.h 
>>> b/arch/powerpc/include/asm/vdso_datapage.h
>>> --- a/arch/powerpc/include/asm/vdso_datapage.h  2019-04-03 
>>> 22:56:44.560645936 +0200
>>> +++ b/arch/powerpc/include/asm/vdso_datapage.h  2019-04-04 
>>> 02:20:09.479361827 +0200
>>> @@ -82,10 +82,10 @@ struct vdso_data {
>>>          __u32 icache_block_size;                /* L1 i-cache block 
>>> size     */
>>>          __u32 dcache_log_block_size;            /* L1 d-cache log 
>>> block size */
>>>          __u32 icache_log_block_size;            /* L1 i-cache log 
>>> block size */
>>> -       __u32 stamp_sec_fraction;               /* fractional seconds 
>>> of stamp_xtime */
>>> -       __s32 wtom_clock_nsec;                  /* Wall to monotonic 
>>> clock nsec */
>>> -       __s64 wtom_clock_sec;                   /* Wall to monotonic 
>>> clock sec */
>>> -       struct timespec stamp_xtime;            /* xtime as at 
>>> tb_orig_stamp */
>>> +       __s32 wtom_clock_sec;                   /* Wall to monotonic 
>>> clock */
>>> +       __s32 wtom_clock_nsec;
>>> +       struct timespec stamp_xtime;    /* xtime as at tb_orig_stamp */
>>> +       __u32 stamp_sec_fraction;       /* fractional seconds of 
>>> stamp_xtime */
>>>          __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>>          __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>>   };
>>>
>>> -----
>>>
>>> Cheers,
>>> Christian
>>
