Return-Path: <dadair@ariodata.com>
Received: from orion1.ariodata.com (adsl-64-170-199-186.dsl.snfc21.pacbell.net
	[64.170.199.186]) by ozlabs.org (Postfix) with ESMTP id 3787967A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 06:40:21 +1000 (EST)
Date: Mon, 4 Apr 2005 13:40:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8308E370BE4EA841BE9210B870179E833644FF@orion1.ariodata.com>
From: "David Adair" <dadair@ariodata.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 440GP system freezes with jiffies not incrementing?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have a configuration where it appears that I have missed a decrementer
interrupt and the system gets frozen in the idle loop:

      Dec:  0           (interrupts on 1->0 transition)
      MSR[EE]: 1        (interrupt enabled)
      TSR[DIS]: 0       (no interrupt pending)

Since the decrementer interrupt occurs ONLY on the 1->0 transition
I'm not too sure how the system can get out of this state -- in my
particular case the answer is it gets a Watchdog timeout and reboots.

This occurs very rarely running a modified version of 2.4.28_pre3
on a custom board very similar to the Ebony.

I am very curious about the behavior of the code in arch/ppc/time.c
in the case where I manage to miss exactly 1 jiffy - IRQ service time:

int timer_interrupt(struct pt_regs * regs)
{
	int next_dec;
	unsigned long cpu =3D smp_processor_id();
	unsigned jiffy_stamp =3D last_jiffy_stamp(cpu);
	extern void do_IRQ(struct pt_regs *);

	if (atomic_read(&ppc_n_lost_interrupts) !=3D 0)
		do_IRQ(regs);

	hardirq_enter(cpu);
	while ((next_dec =3D tb_ticks_per_jiffy - tb_delta(&jiffy_stamp))
< 0) {
		jiffy_stamp +=3D tb_ticks_per_jiffy;=20
<snip>
	}

	if ( !disarm_decr[smp_processor_id()] )
		set_dec(next_dec);
	last_jiffy_stamp(cpu) =3D jiffy_stamp;

}

Seems like the result is to go through the loop once and then program
the decrementer to 0, effectively disabling timer interrupts.

Also curious about exactly where disarm_decr() gets initialized.

I will be adjusting this and testing but it seems really strange
that I have the only setup that manages to hit just the right
timing -- is there someplace else where we would normally recover
from this situation?

Thanks
David
