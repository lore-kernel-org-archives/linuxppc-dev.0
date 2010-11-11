Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EFBBB713A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 23:26:57 +1100 (EST)
Subject: Re: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9FCE46230501DF4D9461B9ACC152FD7104DDA26D@zmy16exm20.fsl.freescale.net>
Date: Thu, 11 Nov 2010 06:26:33 -0600
Message-Id: <A530CF80-F6B6-40BE-A465-18884B887432@kernel.crashing.org>
References: <1288777018-24259-1-git-send-email-b21989@freescale.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201538B08@CORPEXCH1.na.ads.idt.com>
	<9FCE46230501DF4D9461B9ACC152FD7104DDA26D@zmy16exm20.fsl.freescale.net>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Cc: Li Yang-R58472 <R58472@freescale.com>, linux-kernel@vger.kernel.org,
	Zang Roy-R61911 <R61911@freescale.com>, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 11, 2010, at 4:19 AM, Xie Shaohui-B21989 wrote:

>=20
>=20
>=20
> Best Regards,=20
> Shaohui Xie=20
>=20
>=20
>> -----Original Message-----
>> From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]
>> Sent: Thursday, November 11, 2010 6:55 AM
>> To: Xie Shaohui-B21989; akpm@linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Li
> Yang-
>> R58472; Gala Kumar-B11780; Zang Roy-R61911
>> Subject: RE: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
>> machine_check_e500 & machine_check_e500mc
>>=20
>> Shaohui Xie <b21989@freescale.com> wrote:
>>>=20
>>> diff --git a/arch/powerpc/kernel/traps.c
> b/arch/powerpc/kernel/traps.c
>>> index a45a63c..2a5fb9d 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -55,6 +55,7 @@
>>> #endif
>>> #include <asm/kexec.h>
>>> #include <asm/ppc-opcode.h>
>>> +#include <linux/rio.h>
>>>=20
>>> #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)  int
>>> (*__debugger)(struct pt_regs *regs) __read_mostly; @@ -500,6 +501,13
>>> @@ int machine_check_e500mc(struct pt_regs *regs)
>>> 		       reason & MCSR_MEA ? "Effective" : "Physical",
>> addr);
>>> 	}
>>>=20
>>> +	if (reason & MCSR_BUS_RBERR) {
>>> +		printk("Bus - Read Data Bus Error\n"); #ifdef
> CONFIG_RAPIDIO
>>> +		recoverable =3D fsl_rio_mcheck_exception(regs); #endif
>>> +	}
>>> +
>>> 	mtspr(SPRN_MCSR, mcsr);
>>> 	return mfspr(SPRN_MCSR) =3D=3D 0 && recoverable;  } @@ -527,8
> +535,12
>> @@
>>> int machine_check_e500(struct pt_regs *regs)
>>> 		printk("Bus - Write Address Error\n");
>>> 	if (reason & MCSR_BUS_IBERR)
>>> 		printk("Bus - Instruction Data Error\n");
>>> -	if (reason & MCSR_BUS_RBERR)
>>> +	if (reason & MCSR_BUS_RBERR) {
>>> 		printk("Bus - Read Data Bus Error\n");
>>> +#ifdef CONFIG_RAPIDIO
>>> +		fsl_rio_mcheck_exception(regs);
>>> +#endif
>>> +	}
>>> 	if (reason & MCSR_BUS_WBERR)
>>> 		printk("Bus - Read Data Bus Error\n");
>>> 	if (reason & MCSR_BUS_IPERR)
>>=20
>> This implementation breaks an intended use of
>> fsl_rio_mcheck_exception():
>> 1. for e500 it does not check the return value of the rio handler and
>> crashes the system even after RIO Mchk was serviced. Looks like =
e500mc
>> version handles it better but I have no HW to test it.
>> 2. the RIO Mchk is expected to be handled quietly but here it has =
many
>> printk's. May be it is better to call the fsl_rio_mcheck_exception()
>> handler in very beginning and simply exit if it returns 1.
>>=20
>> Alex.
> [Xie Shaohui-B21989] Hi Alex, seems your suggestion is some kind of
> conflict with Kumar, you can have a look at=20
> http://patchwork.ozlabs.org/patch/67774/

I think Alex's comment is the fact we ignore the 'return' value in the =
machine_check_e500 case.

- k=
