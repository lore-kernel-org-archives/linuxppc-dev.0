Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W2341bBzzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 02:02:07 +1000 (AEST)
Date: Wed, 18 Jul 2018 18:02:03 +0200
Message-ID: <20180718180203.Horde.hNnOtk9Z-nuEx9HefV50JQ1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Diana Madalina Craciun <diana.craciun@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, oss@buserror.net, Bharat Bhushan
 <bharat.bhushan@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 4/6] powerpc/fsl: Enable cpu vulnerabilities
 reporting for NXP PPC BOOK3E
References: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
 <1531825797-14236-5-git-send-email-diana.craciun@nxp.com>
 <20180717184654.Horde.vpgbrK2KJGaXTbvLIr1Bgg1@messagerie.si.c-s.fr>
 <VI1PR0401MB246392F396B74D6153CF12F7FF530@VI1PR0401MB2463.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB246392F396B74D6153CF12F7FF530@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Diana Madalina Craciun <diana.craciun@nxp.com> a =C3=A9crit=C2=A0:

> On 7/17/2018 7:47 PM, LEROY Christophe wrote:
>> Diana Craciun <diana.craciun@nxp.com> a =C3=A9crit :
>>
>>> The NXP PPC Book3E platforms are not vulnerable to meltdown and
>>> Spectre v4, so make them PPC_BOOK3S_64 specific.
>>>
>>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
>>> ---
>>> History:
>>>
>>> v2-->v3
>>> - used the existing functions for spectre v1/v2
>>>
>>>  arch/powerpc/Kconfig           | 7 ++++++-
>>>  arch/powerpc/kernel/security.c | 2 ++
>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 9f2b75f..116c953 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -165,7 +165,7 @@ config PPC
>>>  	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
>>>  	select GENERIC_CMOS_UPDATE
>>>  	select GENERIC_CPU_AUTOPROBE
>>> -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
>>> +	select GENERIC_CPU_VULNERABILITIES	if PPC_NOSPEC
>> I don't understand.  You say this patch is to make something specific
>> to book3s64 specific, and you are creating a new config param that
>> make things less specific
>>
>> Christophe
>
> In order to enable the vulnerabilities reporting on NXP socs I need to
> enable them for PPC_FSL_BOOK3E. So they will be enabled for both
> PPC_FSL_BOOK3E and PPC_BOOK3S_64. This is the reason for adding the
> Kconfig. However this will enable: spectre v1/v2 and meltdown. NXP socs
> are not vulnerable to meltdown, so I made the meltdown reporting
> PPC_BOOK3S_64 specific. I guess I can have the PPC_NOSPEC definition in
> a separate patch to be more clear.

Yes you can. Or keep it as a single patch and add the details you gave=20=
=20
me=20in the patch description.

Christophe

>
> Diana
>
>>
>>>  	select GENERIC_IRQ_SHOW
>>>  	select GENERIC_IRQ_SHOW_LEVEL
>>>  	select GENERIC_SMP_IDLE_THREAD
>>> @@ -240,6 +240,11 @@ config PPC
>>>  	# Please keep this list sorted alphabetically.
>>>  	#
>>>
>>> +config PPC_NOSPEC
>>> +    bool
>>> +    default y
>>> +    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
>>> +
>>>  config GENERIC_CSUM
>>>  	def_bool n
>>>
>>> diff --git a/arch/powerpc/kernel/security.c=20=20
>>>=20b/arch/powerpc/kernel/security.c
>>> index 3a4e5c3..539c744 100644
>>> --- a/arch/powerpc/kernel/security.c
>>> +++ b/arch/powerpc/kernel/security.c
>>> @@ -92,6 +92,7 @@ static __init int barrier_nospec_debugfs_init(void)
>>>  device_initcall(barrier_nospec_debugfs_init);
>>>  #endif /* CONFIG_DEBUG_FS */
>>>
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>  ssize_t cpu_show_meltdown(struct device *dev, struct
>>> device_attribute *attr, char *buf)
>>>  {
>>>  	bool thread_priv;
>>> @@ -124,6 +125,7 @@ ssize_t cpu_show_meltdown(struct device *dev,
>>> struct device_attribute *attr, cha
>>>
>>>  	return sprintf(buf, "Vulnerable\n");
>>>  }
>>> +#endif
>>>
>>>  ssize_t cpu_show_spectre_v1(struct device *dev, struct
>>> device_attribute *attr, char *buf)
>>>  {
>>> --
>>> 2.5.5
>>
>>
