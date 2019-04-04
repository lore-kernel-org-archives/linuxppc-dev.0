Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6DC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:50:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F902206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ORdDr5Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F902206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZjVQ6RvNzDqMm
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:50:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::2; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="ORdDr5Zj"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZjS135GdzDqLY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 23:48:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554382117;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=TjkOlBGt/IrkPT4+vcXAHAs++LQgzJhLe8qgUs5jY2I=;
 b=ORdDr5ZjthYK883QsSW9K6HWEf//JNcWoEdX3aIvFb5dn/NqsLIF3Jryo5FEtPB1vq
 r1EnbKPyQ+YHoHQDPLNh1bVsIQG5fgL2phH8JbxJIQtkblIwHaNdlVLkrkKN3epjbhFr
 eNk6ZVQ1HLhljVodfcdboqs5Fg7PRLGBVZyinhJ2VJZD9G8UE52VSJnvDt2EzOHiCNXZ
 8nvV07Yf4wE/S3EPbseJ1t3x6+h3bOF14qAhH/6UYdZ3xo+CEqu8aH1u2lDNU0c9ZgoJ
 9abualMnjBsld2N/4iODtKkF51i4Mp0AlXATmRzth/gzlmdetu38j8sxV92tVO55Af1T
 vgAg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Clc2gaTv1hrqy+gNMPiPYD0N4Dw7Q=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:cd65:79f1:b19e:8a9f]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id k00e1ev34CmY3jx
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 4 Apr 2019 14:48:34 +0200 (CEST)
Subject: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
 <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
 <0f0403a0-476a-6129-8dc6-866d894c9adc@xenosoft.de>
 <5726a634-25ca-d267-17fd-af88436edf1f@c-s.fr>
 <99ff68a4-3aef-47ad-99f8-433b181afe3f@xenosoft.de>
 <84668be2-94ff-19f6-3b12-56ac545b92bd@c-s.fr>
 <0617ec18-e5a9-c430-3c66-9f1c95a1ef8e@xenosoft.de>
Message-ID: <f05643e6-3cba-87c2-7f6d-01f9b0937dce@xenosoft.de>
Date: Thu, 4 Apr 2019 14:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0617ec18-e5a9-c430-3c66-9f1c95a1ef8e@xenosoft.de>
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

On 04 April 2019 at 1:23PM, Christian Zigotzky wrote:
> On 04 April 2019 at 11:07AM, Christophe Leroy wrote:
>>
>>
>> On 04/04/2019 08:44 AM, Christian Zigotzky wrote:
>>> On 04 April 2019 at 06:00AM, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 04/04/2019 à 02:58, Christian Zigotzky a écrit :
>>>>> On 03 April 2019 at 07:05AM, Christophe Leroy wrote:
>>>>>> Le 03/04/2019 à 05:52, Christian Zigotzky a écrit :
>>>>>>> Please test VLC with the RC3 of kernel 5.1.
>>>>>>>
>>>>>>> The removing of the PowerPC fixes 5.1-3 has solved the VLC 
>>>>>>> issue. Another user has already confirmed that [1]. This isn’t 
>>>>>>> an April Fool‘s. ;-)
>>>>>>
>>>>>> Could you bisect to identify the guilty commit ?
>>>>>>
>>>>>> Thanks
>>>>>> Christophe
>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> [1] 
>>>>>>> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4256&start=20#p47561 
>>>>>>>
>>>>>>>
>>>>>>
>>>>> Hello Christophe,
>>>>>
>>>>> I have found the problematic patch. The following patch from the 
>>>>> PowerPC fixes 5.1-3 is responsible for the VLC issue.
>>>>
>>>> That change is part of the following commit:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc2&id=b5b4453e7912f056da1ca7572574cada32ecb60c 
>>>>
>>>>
>>>> Just changing back the type of wtom_clock_sec to 32 bits without 
>>>> changing back the loading instruction is likely to give unexpected 
>>>> results on PPC64.
>>>>
>>>> Are you using 32 bits or 64 bits powerpc ?
>>>>
>>>> Christophe
>>> 64-bit kernel + 32-bit userland for example:
>>>
>>> - ubuntu MATE 16.04.6 LTS 32-bit PowerPC with a 64-bit kernel
>>> - Fienix (Debian Sid) 32-bit PowerPC with a 64-bit kernel
>>> - MATE PowerPC Remix (ubuntu MATE 17.04) 32-bit PowerPC with a 
>>> 64-bit kernel
>>
>> Ok, thanks. Can you please try below change:
>>
>> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S 
>> b/arch/powerpc/kernel/vdso32/gettimeofday.S
>> index 1e0bc5955a40..afd516b572f8 100644
>> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
>> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
>> @@ -98,7 +98,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>>       * can be used, r7 contains NSEC_PER_SEC.
>>       */
>>
>> -    lwz    r5,WTOM_CLOCK_SEC(r9)
>> +    lwz    r5,(WTOM_CLOCK_SEC+LOPART)(r9)
>>      lwz    r6,WTOM_CLOCK_NSEC(r9)
>>
>>      /* We now have our offset in r5,r6. We create a fake dependency
>>
>>
>> Christophe
>>
> Hello Christophe,
>
> Your patch works! VLC plays videos without any problems! Thank you!
>
> Cheers,
> Christian

Christophe,

I also successfully tested the VLC with the RC3 of kernel 5.1 with your 
patch on openSUSE Tumbleweed PPC64 (64-bit kernel + 64-bit userland) 
today. VLC works without any problems!

Screenshot: 
https://i.pinimg.com/originals/5e/d4/4b/5ed44b324a7ea2fc541185880e21c165.png

Many thanks for your help! :-)

Cheers,
Christian
