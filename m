Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA6C10F0C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 08:46:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F2520855
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 08:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="h4dXUeo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F2520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zc46443nzDqPG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::8; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="h4dXUeo4"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zc261vd5zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 19:44:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554367458;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=A4PQkv1MXITBe5qfxDmair+xDjlNBE4ZSXXMqR/s5Jw=;
 b=h4dXUeo4jnhBdqeNNKPPQX/PDKij8oyLODiuXzOPVd5KtBMe56L+1Ylr3vcamF/Jfl
 slxYGoM/jyTQJdtKQukZoXWMB3Gd49OazLqovkoM65UjpIt837RcWaTymp69d9yEOdma
 0vawFQrgCoPHB/PmQPV0ogFIWi91Bv2/x3Twp5BzrWNWiEVs4Kds9TeuCeBJW8FnQqd1
 +Lqh/4H/3l4btpX9+Z+jhvStJt7EA/PLE2RSWu4CTNdfj7MLzw3dnymeqeIfXp1fDAEt
 EtMAuZBuZUzgCyDWQUzCW3nkYjolmz7jfFpevoAg1OZzi/JVuejPFXeytm9xsOYC0ROM
 cLNA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkNjlBPV/3IdB0Je2K2M1gQpcht"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:2057:f49:8d2c:44ac]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id k00e1ev348iD24j
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 4 Apr 2019 10:44:13 +0200 (CEST)
Subject: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
 <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
 <0f0403a0-476a-6129-8dc6-866d894c9adc@xenosoft.de>
 <5726a634-25ca-d267-17fd-af88436edf1f@c-s.fr>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <99ff68a4-3aef-47ad-99f8-433b181afe3f@xenosoft.de>
Date: Thu, 4 Apr 2019 10:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5726a634-25ca-d267-17fd-af88436edf1f@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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

On 04 April 2019 at 06:00AM, Christophe Leroy wrote:
>
>
> Le 04/04/2019 à 02:58, Christian Zigotzky a écrit :
>> On 03 April 2019 at 07:05AM, Christophe Leroy wrote:
>>> Le 03/04/2019 à 05:52, Christian Zigotzky a écrit :
>>>> Please test VLC with the RC3 of kernel 5.1.
>>>>
>>>> The removing of the PowerPC fixes 5.1-3 has solved the VLC issue. 
>>>> Another user has already confirmed that [1]. This isn’t an April 
>>>> Fool‘s. ;-)
>>>
>>> Could you bisect to identify the guilty commit ?
>>>
>>> Thanks
>>> Christophe
>>>
>>>>
>>>> Thanks
>>>>
>>>> [1] 
>>>> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4256&start=20#p47561 
>>>>
>>>>
>>>
>> Hello Christophe,
>>
>> I have found the problematic patch. The following patch from the 
>> PowerPC fixes 5.1-3 is responsible for the VLC issue.
>
> That change is part of the following commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc2&id=b5b4453e7912f056da1ca7572574cada32ecb60c 
>
>
> Just changing back the type of wtom_clock_sec to 32 bits without 
> changing back the loading instruction is likely to give unexpected 
> results on PPC64.
>
> Are you using 32 bits or 64 bits powerpc ?
>
> Christophe
64-bit kernel + 32-bit userland for example:

- ubuntu MATE 16.04.6 LTS 32-bit PowerPC with a 64-bit kernel
- Fienix (Debian Sid) 32-bit PowerPC with a 64-bit kernel
- MATE PowerPC Remix (ubuntu MATE 17.04) 32-bit PowerPC with a 64-bit kernel

-- Christian
>
>
>>
>> diff --git a/arch/powerpc/include/asm/vdso_datapage.h 
>> b/arch/powerpc/include/asm/vdso_datapage.h
>> index 1afe90ade595..bbc06bd72b1f 100644
>> --- a/arch/powerpc/include/asm/vdso_datapage.h
>> +++ b/arch/powerpc/include/asm/vdso_datapage.h
>> @@ -82,10 +82,10 @@ struct vdso_data {
>>      __u32 icache_block_size;      /* L1 i-cache block size */
>>      __u32 dcache_log_block_size;      /* L1 d-cache log block size */
>>      __u32 icache_log_block_size;      /* L1 i-cache log block size */
>> -   __s32 wtom_clock_sec;         /* Wall to monotonic clock */
>> -   __s32 wtom_clock_nsec;
>> -   struct timespec stamp_xtime;   /* xtime as at tb_orig_stamp */
>> -   __u32 stamp_sec_fraction;   /* fractional seconds of stamp_xtime */
>> +   __u32 stamp_sec_fraction;      /* fractional seconds of 
>> stamp_xtime */
>> +   __s32 wtom_clock_nsec;         /* Wall to monotonic clock nsec */
>> +   __s64 wtom_clock_sec;         /* Wall to monotonic clock sec */
>> +   struct timespec stamp_xtime;      /* xtime as at tb_orig_stamp */
>>         __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>         __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>   };
>>
>> -----
>>
>> Link: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/include/asm/vdso_datapage.h?h=v5.1-rc2&id=a5ed1e96cafde5ba48638f486bfca0685dc6ddc9 
>>
>>
>> I created a patch for solving the VLC issue today.
>>
>> vdso_datapage_vlc.patch:
>>
>> diff -rupN a/arch/powerpc/include/asm/vdso_datapage.h 
>> b/arch/powerpc/include/asm/vdso_datapage.h
>> --- a/arch/powerpc/include/asm/vdso_datapage.h  2019-04-03 
>> 22:56:44.560645936 +0200
>> +++ b/arch/powerpc/include/asm/vdso_datapage.h  2019-04-04 
>> 02:20:09.479361827 +0200
>> @@ -82,10 +82,10 @@ struct vdso_data {
>>          __u32 icache_block_size;                /* L1 i-cache block 
>> size     */
>>          __u32 dcache_log_block_size;            /* L1 d-cache log 
>> block size */
>>          __u32 icache_log_block_size;            /* L1 i-cache log 
>> block size */
>> -       __u32 stamp_sec_fraction;               /* fractional seconds 
>> of stamp_xtime */
>> -       __s32 wtom_clock_nsec;                  /* Wall to monotonic 
>> clock nsec */
>> -       __s64 wtom_clock_sec;                   /* Wall to monotonic 
>> clock sec */
>> -       struct timespec stamp_xtime;            /* xtime as at 
>> tb_orig_stamp */
>> +       __s32 wtom_clock_sec;                   /* Wall to monotonic 
>> clock */
>> +       __s32 wtom_clock_nsec;
>> +       struct timespec stamp_xtime;    /* xtime as at tb_orig_stamp */
>> +       __u32 stamp_sec_fraction;       /* fractional seconds of 
>> stamp_xtime */
>>          __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>          __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>>   };
>>
>> -----
>>
>> Cheers,
>> Christian
>

