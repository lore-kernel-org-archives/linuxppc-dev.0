Return-Path: <pku.leo@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 5DC3AB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 05:27:11 +1100 (EST)
Received: by wwb29 with SMTP id 29so2738083wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 03 Dec 2010 10:27:08 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <9127D47D-F146-4387-AF36-3193CF47389A@kernel.crashing.org>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<9127D47D-F146-4387-AF36-3193CF47389A@kernel.crashing.org>
Date: Sat, 4 Dec 2010 02:27:07 +0800
Message-ID: <AANLkTi=XekUOF2+OtCkxw7KBfAWJ_dOkSijr6AS5YZfV@mail.gmail.com>
Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
	KEXEC patch
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Matthew McClintock <msm@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 4, 2010 at 12:40 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Dec 3, 2010, at 6:34 AM, Li Yang wrote:
>
>> The timebase sync is not only necessary when using KEXEC. =C2=A0It shoul=
d also
>> be used by normal boot up and cpu hotplug. =C2=A0Remove the ifdef added =
by
>> the KEXEC patch. =C2=A0Fix a problem that cpu hotplugging freezes the wh=
ole system.
>>
>> Signed-off-by: Jin Qing <b24347@freescale.com>
>> Singed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/platforms/85xx/smp.c | =C2=A0 =C2=A04 +---
>> 1 files changed, 1 insertions(+), 3 deletions(-)
>
> But we have problems with KEXEC w/o this? =C2=A0What is the issue with ho=
tplugging and the generic timebase code? =C2=A0When do we freeze?

Actually the KEXEC patch disables timebase sync when KEXEC is not
defined.  If the timebase sync is disabled, the timebase on non-boot
cpu will become non-consistent.  And thus ruins the scheduler when
hot-plugged.

>
>>
>> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/=
85xx/smp.c
>> index 5c91a99..1e8aec8 100644
>> --- a/arch/powerpc/platforms/85xx/smp.c
>> +++ b/arch/powerpc/platforms/85xx/smp.c
>> @@ -2,7 +2,7 @@
>> =C2=A0* Author: Andy Fleming <afleming@freescale.com>
>> =C2=A0* =C2=A0 =C2=A0 =C2=A0 Kumar Gala <galak@kernel.crashing.org>
>> =C2=A0*
>> - * Copyright 2006-2008 Freescale Semiconductor Inc.
>> + * Copyright 2006-2010 Freescale Semiconductor Inc.
>> =C2=A0*
>> =C2=A0* This program is free software; you can redistribute =C2=A0it and=
/or modify it
>> =C2=A0* under =C2=A0the terms of =C2=A0the GNU General =C2=A0Public Lice=
nse as published by the
>> @@ -115,10 +115,8 @@ smp_85xx_setup_cpu(int cpu_nr)
>>
>> struct smp_ops_t smp_85xx_ops =3D {
>> =C2=A0 =C2=A0 =C2=A0 .kick_cpu =3D smp_85xx_kick_cpu,
>> -#ifdef CONFIG_KEXEC
>> =C2=A0 =C2=A0 =C2=A0 .give_timebase =C2=A0=3D smp_generic_give_timebase,
>> =C2=A0 =C2=A0 =C2=A0 .take_timebase =C2=A0=3D smp_generic_take_timebase,
>> -#endif
>> };
>>
>> #ifdef CONFIG_KEXEC
>> --
>> 1.6.6-rc1.GIT
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
- Leo
