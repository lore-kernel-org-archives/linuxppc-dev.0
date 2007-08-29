Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42362DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 08:28:56 +1000 (EST)
In-Reply-To: <40D0BF15B1434F469B8639BF3A31D6F20B5F28@wiems02014.ceu.corp.heidelberg.com>
References: <40D0BF15B1434F469B8639BF3A31D6F20B5F28@wiems02014.ceu.corp.heidelberg.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <35461E70-20B4-4459-A76A-9519DCCE310A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: ppc/powerpc, remote debugging (ptrace), floating point variables
Date: Wed, 29 Aug 2007 17:31:14 -0500
To: "Visser, Udo RD-IS-E23" <Udo.Visser@heidelberg.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 28, 2007, at 4:40 AM, Visser, Udo RD-IS-E23 wrote:

>
> Hello world, ;-)
>
> when stepping through my own software, which is using floating =20
> point variables, gdb showed weird results (mostly NAN=B4s) for these =20=

> variables. Running the software without gdb did not show any =20
> problems. The software is compiled with floating point instructions =20=

> and the results (without gdb) are OK.
>
> My setup:
>
> MPC8349 target, "home grown", much like the MPC8349EMDS, running =20
> 2.6.16 (ppc)
> GDB, gdbserver 6.3 connected via ethernet with my Linux Host.
>
>
> What I did to get rid of the described problem:
>
> In module:     arch/powerpc/kernel/process.c
> In function:   void flush_fp_to_thread(struct tast_struct *tsk)
>
> I changed the line:  giveup_fpu(current);
> to:                  giveup_fpu(tsk);
>
>
> Now my questions: Has anybody else had such problems?
>                   Have I found a bug, or will I encounter any yet =20
> unknown problems in the near future?
>
> I would appreciate any comment on my changes, especially from the =20
> maintainers.

I have a patch to fix just this issue.

take a look at:

http://patchwork.ozlabs.org/linuxppc/patch?id=3D13219

- k
