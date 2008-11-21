Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65013DDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 20:18:03 +1100 (EST)
Subject: Re: Kernel completely crashes after accessing an unmapped area.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ricardo <ricardo.ribalda@gmail.com>
In-Reply-To: <aa76a2be0811190459x461128a5m82eb5d8d8d6da5fe@mail.gmail.com>
References: <aa76a2be0811190459x461128a5m82eb5d8d8d6da5fe@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 20:17:53 +1100
Message-Id: <1227259073.7185.228.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-19 at 13:59 +0100, Ricardo wrote:
> Hello All:
> 
>   I am using the paulus tree popwerpc linux kernel for a ppc440 cpu
> located in a Virtex5 FPGA.
> 
>   While developing some drivers (a simple gpio device) I have notice
> that if I try to access an unmapped area (an address without any
> register/device attached), the system completely crashes... I remember
> that doing the same with a ppc400 cpu the system showed a
> "Instruction/Data bus error" and continue working.
> 
>   My question: The ppc440 cannot recover from this types of errors or
> is a kernel missing feature/bug?

You may want to look at the patch I posted recently:

powerpc: Fix 460EX/460GT machine check handling

>From the look of your log, we aren't using the right type of machine
check handler for your core and it may need a similar treatement as the
above processors.

There are two kind of 440 cores vs. machine checks. On the old kind,
machine checks used to be critical interrupts (and thus used CSRR0 and
CSRR1 to save the context) while on the new kind, machine checks are
their own type of exception with a dedicated pair of context save
registers MCSRR0 and MCSRR1.

It -looks- like the problem might be that the kernel isn't using the
right set for your core. It uses by default the old style unless
you change the machine check IVOR to point to MachineCheckA
which is done by calling __fixup_440A_mcheck() in your CPU init routine
for example, as we do for other 440 cores.

So you would have to hook up a setup_cpu routine in cputable for
those guys (I can see the virtex cores seem to not have any at
this stage) and also change their machine check pointer to 
use machine_check_440A instead of machine_check_4xx so the machine
check details are properly decoded.

Of course check your Virtex user manual to make sure that's indeed
what is happening :-)

Cheers,
Ben.
