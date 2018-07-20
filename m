Return-Path: <diana.craciun@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20085.outbound.protection.outlook.com [40.107.2.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41XFLD19ZKzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2018 01:34:27 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, LEROY Christophe
 <christophe.leroy@c-s.fr>
CC: "oss@buserror.net" <oss@buserror.net>, Bharat Bhushan
 <bharat.bhushan@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 4/6] powerpc/fsl: Enable cpu vulnerabilities reporting
 for NXP PPC BOOK3E
Date: Fri, 20 Jul 2018 15:34:21 +0000
Message-ID: <VI1PR0401MB246362E819D49AA3CC5AE9D7FF510@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
 <1531825797-14236-5-git-send-email-diana.craciun@nxp.com>
 <20180717184654.Horde.vpgbrK2KJGaXTbvLIr1Bgg1@messagerie.si.c-s.fr>
 <VI1PR0401MB246392F396B74D6153CF12F7FF530@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <20180718180203.Horde.hNnOtk9Z-nuEx9HefV50JQ1@messagerie.si.c-s.fr>
 <87601bctxg.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/19/2018 3:05 PM, Michael Ellerman wrote:=0A=
> LEROY Christophe <christophe.leroy@c-s.fr> writes:=0A=
>> Diana Madalina Craciun <diana.craciun@nxp.com> a =E9crit :=0A=
>>> On 7/17/2018 7:47 PM, LEROY Christophe wrote:=0A=
>>>> Diana Craciun <diana.craciun@nxp.com> a =E9crit :=0A=
>>>>> The NXP PPC Book3E platforms are not vulnerable to meltdown and=0A=
>>>>> Spectre v4, so make them PPC_BOOK3S_64 specific.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>=0A=
>>>>> ---=0A=
>>>>> History:=0A=
>>>>>=0A=
>>>>> v2-->v3=0A=
>>>>> - used the existing functions for spectre v1/v2=0A=
>>>>>=0A=
>>>>>  arch/powerpc/Kconfig           | 7 ++++++-=0A=
>>>>>  arch/powerpc/kernel/security.c | 2 ++=0A=
>>>>>  2 files changed, 8 insertions(+), 1 deletion(-)=0A=
>>>>>=0A=
>>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig=0A=
>>>>> index 9f2b75f..116c953 100644=0A=
>>>>> --- a/arch/powerpc/Kconfig=0A=
>>>>> +++ b/arch/powerpc/Kconfig=0A=
>>>>> @@ -165,7 +165,7 @@ config PPC=0A=
>>>>>  	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP=0A=
>>>>>  	select GENERIC_CMOS_UPDATE=0A=
>>>>>  	select GENERIC_CPU_AUTOPROBE=0A=
>>>>> -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64=0A=
>>>>> +	select GENERIC_CPU_VULNERABILITIES	if PPC_NOSPEC=0A=
>>>> I don't understand.  You say this patch is to make something specific=
=0A=
>>>> to book3s64 specific, and you are creating a new config param that=0A=
>>>> make things less specific=0A=
>>>>=0A=
>>>> Christophe=0A=
>>> In order to enable the vulnerabilities reporting on NXP socs I need to=
=0A=
>>> enable them for PPC_FSL_BOOK3E. So they will be enabled for both=0A=
>>> PPC_FSL_BOOK3E and PPC_BOOK3S_64. This is the reason for adding the=0A=
>>> Kconfig. However this will enable: spectre v1/v2 and meltdown. NXP socs=
=0A=
>>> are not vulnerable to meltdown, so I made the meltdown reporting=0A=
>>> PPC_BOOK3S_64 specific. I guess I can have the PPC_NOSPEC definition in=
=0A=
>>> a separate patch to be more clear.=0A=
>> Yes you can. Or keep it as a single patch and add the details you gave  =
=0A=
>> me in the patch description.=0A=
> Yeah I think the patch is fine, but the change log is a bit short on deta=
il.=0A=
>=0A=
> If you just send me a new change log I can fold it in.=0A=
>=0A=
> cheers=0A=
>=0A=
Thanks! This is the new change log:=0A=
=0A=
"The Spectre/Meltdown vulnerabilities will be enabled for both=0A=
PPC_FSL_BOOK3E and PPC_BOOK3S_64. In order to avoid a complicated ifdef=0A=
we add a new Kconfig (PPC_NOSPEC) to select the common code between=0A=
BOOK3S_64 and FSL_BOOK3E. However, the NXP platforms are not vulnerable=0A=
to Meltdown, so make the Meltdown vulnerability reporting PPC_BOOK3S_64=0A=
specific."=0A=
=0A=
Regards,=0A=
=0A=
Diana=0A=
=0A=
