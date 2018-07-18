Return-Path: <diana.craciun@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe08::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W00M3T8HzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 00:29:37 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
CC: Leo Li <leoyang.li@nxp.com>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 4/6] powerpc/fsl: Enable cpu vulnerabilities reporting
 for NXP PPC BOOK3E
Date: Wed, 18 Jul 2018 14:29:31 +0000
Message-ID: <VI1PR0401MB246392F396B74D6153CF12F7FF530@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
 <1531825797-14236-5-git-send-email-diana.craciun@nxp.com>
 <20180717184654.Horde.vpgbrK2KJGaXTbvLIr1Bgg1@messagerie.si.c-s.fr>
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

On 7/17/2018 7:47 PM, LEROY Christophe wrote:=0A=
> Diana Craciun <diana.craciun@nxp.com> a =E9crit :=0A=
>=0A=
>> The NXP PPC Book3E platforms are not vulnerable to meltdown and=0A=
>> Spectre v4, so make them PPC_BOOK3S_64 specific.=0A=
>>=0A=
>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>=0A=
>> ---=0A=
>> History:=0A=
>>=0A=
>> v2-->v3=0A=
>> - used the existing functions for spectre v1/v2=0A=
>>=0A=
>>  arch/powerpc/Kconfig           | 7 ++++++-=0A=
>>  arch/powerpc/kernel/security.c | 2 ++=0A=
>>  2 files changed, 8 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig=0A=
>> index 9f2b75f..116c953 100644=0A=
>> --- a/arch/powerpc/Kconfig=0A=
>> +++ b/arch/powerpc/Kconfig=0A=
>> @@ -165,7 +165,7 @@ config PPC=0A=
>>  	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP=0A=
>>  	select GENERIC_CMOS_UPDATE=0A=
>>  	select GENERIC_CPU_AUTOPROBE=0A=
>> -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64=0A=
>> +	select GENERIC_CPU_VULNERABILITIES	if PPC_NOSPEC=0A=
> I don't understand.  You say this patch is to make something specific  =
=0A=
> to book3s64 specific, and you are creating a new config param that  =0A=
> make things less specific=0A=
>=0A=
> Christophe=0A=
=0A=
In order to enable the vulnerabilities reporting on NXP socs I need to=0A=
enable them for PPC_FSL_BOOK3E. So they will be enabled for both=0A=
PPC_FSL_BOOK3E and PPC_BOOK3S_64. This is the reason for adding the=0A=
Kconfig. However this will enable: spectre v1/v2 and meltdown. NXP socs=0A=
are not vulnerable to meltdown, so I made the meltdown reporting=0A=
PPC_BOOK3S_64 specific. I guess I can have the PPC_NOSPEC definition in=0A=
a separate patch to be more clear.=0A=
=0A=
Diana=0A=
=0A=
>=0A=
>>  	select GENERIC_IRQ_SHOW=0A=
>>  	select GENERIC_IRQ_SHOW_LEVEL=0A=
>>  	select GENERIC_SMP_IDLE_THREAD=0A=
>> @@ -240,6 +240,11 @@ config PPC=0A=
>>  	# Please keep this list sorted alphabetically.=0A=
>>  	#=0A=
>>=0A=
>> +config PPC_NOSPEC=0A=
>> +    bool=0A=
>> +    default y=0A=
>> +    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E=0A=
>> +=0A=
>>  config GENERIC_CSUM=0A=
>>  	def_bool n=0A=
>>=0A=
>> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securi=
ty.c=0A=
>> index 3a4e5c3..539c744 100644=0A=
>> --- a/arch/powerpc/kernel/security.c=0A=
>> +++ b/arch/powerpc/kernel/security.c=0A=
>> @@ -92,6 +92,7 @@ static __init int barrier_nospec_debugfs_init(void)=0A=
>>  device_initcall(barrier_nospec_debugfs_init);=0A=
>>  #endif /* CONFIG_DEBUG_FS */=0A=
>>=0A=
>> +#ifdef CONFIG_PPC_BOOK3S_64=0A=
>>  ssize_t cpu_show_meltdown(struct device *dev, struct  =0A=
>> device_attribute *attr, char *buf)=0A=
>>  {=0A=
>>  	bool thread_priv;=0A=
>> @@ -124,6 +125,7 @@ ssize_t cpu_show_meltdown(struct device *dev,  =0A=
>> struct device_attribute *attr, cha=0A=
>>=0A=
>>  	return sprintf(buf, "Vulnerable\n");=0A=
>>  }=0A=
>> +#endif=0A=
>>=0A=
>>  ssize_t cpu_show_spectre_v1(struct device *dev, struct  =0A=
>> device_attribute *attr, char *buf)=0A=
>>  {=0A=
>> --=0A=
>> 2.5.5=0A=
>=0A=
>=0A=
=0A=
