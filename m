Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WXlJ5P88zDqnM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 22:05:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Diana Madalina Craciun <diana.craciun@nxp.com>
Cc: oss@buserror.net, Bharat Bhushan <bharat.bhushan@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 4/6] powerpc/fsl: Enable cpu vulnerabilities reporting
 for NXP PPC BOOK3E
In-Reply-To: <20180718180203.Horde.hNnOtk9Z-nuEx9HefV50JQ1@messagerie.si.c-s.fr>
References: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
 <1531825797-14236-5-git-send-email-diana.craciun@nxp.com>
 <20180717184654.Horde.vpgbrK2KJGaXTbvLIr1Bgg1@messagerie.si.c-s.fr>
 <VI1PR0401MB246392F396B74D6153CF12F7FF530@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <20180718180203.Horde.hNnOtk9Z-nuEx9HefV50JQ1@messagerie.si.c-s.fr>
Date: Thu, 19 Jul 2018 22:05:15 +1000
Message-ID: <87601bctxg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Diana Madalina Craciun <diana.craciun@nxp.com> a =C3=A9crit=C2=A0:
>> On 7/17/2018 7:47 PM, LEROY Christophe wrote:
>>> Diana Craciun <diana.craciun@nxp.com> a =C3=A9crit :
>>>> The NXP PPC Book3E platforms are not vulnerable to meltdown and
>>>> Spectre v4, so make them PPC_BOOK3S_64 specific.
>>>>
>>>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
>>>> ---
>>>> History:
>>>>
>>>> v2-->v3
>>>> - used the existing functions for spectre v1/v2
>>>>
>>>>  arch/powerpc/Kconfig           | 7 ++++++-
>>>>  arch/powerpc/kernel/security.c | 2 ++
>>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>>> index 9f2b75f..116c953 100644
>>>> --- a/arch/powerpc/Kconfig
>>>> +++ b/arch/powerpc/Kconfig
>>>> @@ -165,7 +165,7 @@ config PPC
>>>>  	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
>>>>  	select GENERIC_CMOS_UPDATE
>>>>  	select GENERIC_CPU_AUTOPROBE
>>>> -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
>>>> +	select GENERIC_CPU_VULNERABILITIES	if PPC_NOSPEC
>>> I don't understand.  You say this patch is to make something specific
>>> to book3s64 specific, and you are creating a new config param that
>>> make things less specific
>>>
>>> Christophe
>>
>> In order to enable the vulnerabilities reporting on NXP socs I need to
>> enable them for PPC_FSL_BOOK3E. So they will be enabled for both
>> PPC_FSL_BOOK3E and PPC_BOOK3S_64. This is the reason for adding the
>> Kconfig. However this will enable: spectre v1/v2 and meltdown. NXP socs
>> are not vulnerable to meltdown, so I made the meltdown reporting
>> PPC_BOOK3S_64 specific. I guess I can have the PPC_NOSPEC definition in
>> a separate patch to be more clear.
>
> Yes you can. Or keep it as a single patch and add the details you gave=20=
=20
> me in the patch description.

Yeah I think the patch is fine, but the change log is a bit short on detail.

If you just send me a new change log I can fold it in.

cheers
