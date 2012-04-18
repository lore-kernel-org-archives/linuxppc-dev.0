Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BF388B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 00:15:55 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add back condition for smp
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F8DEC0E.4060700@freescale.com>
Date: Wed, 18 Apr 2012 09:15:48 -0500
Message-Id: <15110B63-4B9B-4457-B127-65C82C377D3E@kernel.crashing.org>
References: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
 <4F8DEC0E.4060700@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 17, 2012, at 5:17 PM, Scott Wood wrote:

> On 04/17/2012 04:39 PM, York Sun wrote:
>> The timebase synchronization is only necessary if we need to reset a
>> separate core.  Currently only KEXEC and CPU hotplug require =
resetting
>> a single core. The following code should be in the condition of
>> CONFIG_KEXEC or CONFIG_HOTPLUG_CPU
>>=20
>>        .give_timebase  =3D smp_generic_give_timebase,
>>        .take_timebase  =3D smp_generic_take_timebase,
>>=20
>> Signed-off-by: York Sun <yorksun@freescale.com>
>> Acked-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/platforms/85xx/smp.c |    2 ++
>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/85xx/smp.c =
b/arch/powerpc/platforms/85xx/smp.c
>> index 56942af..868c6d7 100644
>> --- a/arch/powerpc/platforms/85xx/smp.c
>> +++ b/arch/powerpc/platforms/85xx/smp.c
>> @@ -192,8 +192,10 @@ struct smp_ops_t smp_85xx_ops =3D {
>> 	.cpu_disable	=3D generic_cpu_disable,
>> 	.cpu_die	=3D generic_cpu_die,
>> #endif
>> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
>> 	.give_timebase	=3D smp_generic_give_timebase,
>> 	.take_timebase	=3D smp_generic_take_timebase,
>> +#endif
>> };
>>=20
>> #ifdef CONFIG_KEXEC
>=20
> Note that this is only a temporary fix, that assumes the environments
> where tbsync is problematic[1] (virtualization and simulation) do not
> enable CONFIG_KEXEC or CONFIG_HOTPLUG_CPU.  Eventually the sync should
> be done via CCSR like in U-Boot, and the decision on whether to do it
> should be runtime.

Is the thinking with the CCSR like u-boot sync after boot would resync =
to some non-zero TB value?

I'm guessing the idea is doing such a rsync w/TB stopped in the system =
is quick enough that the freezing of it will not be noticed.  One should =
measure this and see what it looks like in core cycles and how it scales =
based on # of cores.  (could use alternate TB as a counter to measure).

- k=
