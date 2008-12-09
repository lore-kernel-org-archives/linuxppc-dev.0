Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D05C6DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 17:37:18 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add support for SMP initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1228204546-1506-1-git-send-email-galak@kernel.crashing.org>
References: <1228204546-1506-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 09 Dec 2008 17:35:04 +1100
Message-Id: <1228804504.7101.72.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, tpiepho@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-02 at 01:55 -0600, Kumar Gala wrote:
> Added 85xx specifc smp_ops structure.  We use ePAPR style boot release
> and the MPIC for IPIs at this point.
> 
> Additionally added routines for secondary cpu entry and initializtion.

For some internal stuff, I did differently.

I have a separate entry point that I stick into the spin table, and I
moved most of the head_xxx.S init code into a subroutine.

IE, the main entry point basically does something like

	mr	r31,r3
	mr	r30,r4
	mr	r29,r5
	mr	r28,r6
	mr	r27,r7

	/* At this stage, we used to initialize the TLB, setup
         * IVORs/IVPR.... etc.. this is all moved to init_cpu_state
	 */
	li	r24,0
	bl	init_cpu_state

	/* ptr to current */
	lis	r2,init_task@h
	ori	r2,r2,init_task@l

	.../...

	bl early _init

etc...

Then, I have my secondary_entry that looks like:

_GLOBAL(secondary_entry_mycpu)
	mr	r24,r3

	bl	init_cpu_sate

	... more secondary init stuff


	b	start_secondary

I find this approach nicer than playing with the PIR which may or
may not do the right thing and branching off the main startup path

A few other nits I collected while doing that, I haven't looked if
you implemented any of it that way but heh !

After init_cpu_state, my secondary entry sets r1 to some temp stack
in the kernel .bss in order to call C code. it then calls what I
named mmu_init_secondary() which does the linear mapping setup since
init_cpu_state() only does one entry just like boot time.

init_cpu_state() is called with typically a 1:1 mapping from firmware
and returns with a KERNELBASE:0 mapping, but beware that tovirt() and
tophys() really don't do anything useful on CONFIG_BOOKE ! So at the
beginning of init_cpu_state, I do

	mflr	r22

and at the end I do

	addis	r22,r22,KERNELBASE@h
	mtlr	r22
	blr

Also, my ePAPR kick routine is a bit like yours, we should definitely
move that somewhere common. Yours is probably better as you use ioremap
which works if the spin table isn't in the linear mapping while mine
uses __va() to access it. However, I don't like the wait loop in yours,
I don't see the point in keeping that acknowledge stuff etc... the
generic code will wait for the CPU just fine by itself.

A couple of other things I thought about:

 - The code to fixup TSR and TCR. I put that straight into
start_secondary() in arch/powerpc/kernel/smp.c, just after
smp_store_cpu_info(), protected by CONFIG_BOOKE || CONFIG_40x. I don't
see the point in requiring all potential BookE platforms from having to
implement a CPU setup callback for that.

 - We should make mpic_setup_this_cpu() prototype so that it can be
called directly from smp_ops.setup_cpu

 - We should fix the code so it doesn't explode when CONFIG_SMP is set
and smp_ops is NULL, either that or statically initialize smp_ops to
some dummy ops. I want to be able to build an SMP kernel that will boot
fine on an UP HW setup and that involves not even filling the smp_ops in
some cases. For example, I have cases where I have a different PIC
between the UP and SMP machine (UIC vs. MPIC) and I don't want to have
an smp_ops dangling with mpic callbacks in it when I boot on the UIC
based machine.

 - Maybe more later :-)

Cheers,
Ben.
