Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B173E67B23
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 08:29:44 +1000 (EST)
In-Reply-To: <20050407221440.GT3396@smtp.west.cox.net>
References: <20050407221440.GT3396@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <159727e9d7fb3a3d217b6edf411e43c1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 7 Apr 2005 17:29:32 -0500
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]
>  > >The problem here is, HEY! (classic) FP instrs in the kernel.? The
>  > > question is why?? Or rather, why are these four classic FP instrs
>  > > (lfs/lfd/stfd/stfs) being done on CONFIG_4xx || E500 when neither=20=

> has
>  > > classic FP?? I think the problem here is that on !FPU
>  > >(which is 4xx||E500||8xx, or so), we need to rewrite these two
>  > > functions (yes, 8xx does emulate them if hit, but that's a=20
> tangent).
>  >
> > What is not clear to me is what condition causes these to get hit on=20=

> an
> > e500.
>
> They are called in align.c from fix_alignment().=A0 As has been said,=20=

> some
>  of the stress testing apps in LTP will trigger this.=A0 Since the=20
> comment
>  around the code in question (in fix_alignent()) is
>  /* Single-precision FP load and store require conversions... */
>  perhaps it's more valid to not define these functions on e500 || 4xx,
>  and make the two cases in the switch there depend on !e500 && !4xx.

What I'm concerned about what instruction is actually causing this=20
fault that e500 actually gets into this case to began with.  Maybe I=20
missed something in the email thread, but it would seem the only way to=20=

get here is via kernel emulation of the floating point load/store=20
instructions, but that seems odd since they would have to be doing=20
normal integer load/store... something is not quiet right in all this.

Before we go start making changes I really do want to know what=20
instruction, with what effective address is causing this case to get=20
triggered.

Can someone add something like the following:

if (__get_user(instr, (unsigned int __user *) regs->nip))
    return 0;

int insn_orig;
....

insn_orig =3D instr;

....

case LD+F+S:
     printk ("align fault [LD+F+S] for insn =3D %x @ %x\n", insn_orig,=20=

regs->nip);
..
case ST+F+S:
     printk ("align fault [ST+F+S] for insn =3D %x @ %x\n", insn_orig,=20=

regs->nip);

and report back the results.

thanks

- kumar
