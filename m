Subject: Re: MPC8260 bad interrupts
From: Jon Diekema <diekema@cideas.com>
Reply-To: diekema@cideas.com
To: li <slowforce@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <n2959792844041.01982@webmail1.inner-21cn.com>
References: <n2959792844041.01982@webmail1.inner-21cn.com>
Content-Type: text/plain
Message-Id: <1076164075.2531.2.camel@smoke.agre.smiths.aero>
Mime-Version: 1.0
Date: Sat, 07 Feb 2004 09:27:56 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-02-07 at 02:59, li wrote:

> but lots of bad interrupts occured when ATM transvier
> starts
> so does any one got similar problem with me?

Subject: ppc826x BAD interrupts

Looking at /proc/interrupts, I see a large number of "BAD" interrups
on both my MPC8260 board.

# cat /proc/interrupts
           CPU0
  4:         16   8260 SIU   Edge      uart
  5:          0   8260 SIU   Edge      uart
 33:        179   8260 SIU   Edge      fenet
 40:         27   8260 SIU   Edge      uart
 41:       4530   8260 SIU   Edge      RxSCC2
 42:       4528   8260 SIU   Edge      RxSCC3
 43:       4529   8260 SIU   Edge      TxSCC4
BAD:         49 <<====== this the problem

The source of this count is ppc_spurious_interrupts which is
incremented in the arch/ppc/kernel/irq.c if:

    1) there is no interrupt handler installed

    2) SIVEC is showing zero (no interrupts pending)

Looking into the problem it would appear that the problem is the later
case and the get_irq() function in ppc8260_pic.c is indeed reading a
zero from the SIVEC.

----------

This problem was discussed on mailing list before also and you can
eliminate this problem by inserting a sync instruction at a certain
place in the 8260 interrupt handling code. See, for example,
http://lists.linuxppc.org/linuxppc-embedded/200211/msg00139.html

Add a __asm__ volatile("sync"); at the end of the m8260_mask_and_ack
function in arch/ppc/kernel/ppc8260_pic.c to fix it.

Regards,
Muhammad Sarwar
Mangrove Systems Inc.

----------

static void m8260_mask_and_ack(unsigned int irq_nr)
{
        int     bit, word;
        volatile uint   *simr, *sipnr;

        bit = irq_to_siubit[irq_nr];
        word = irq_to_siureg[irq_nr];

        simr = &(immr->im_intctl.ic_simrh);
        sipnr = &(immr->im_intctl.ic_sipnrh);
        ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
        simr[word] = ppc_cached_irq_mask[word];
        sipnr[word] = 1 << (31 - bit);

        /*
         * Add a "sync" instruction to avoid spurious or bad interrupts
         * at the end of m8260_mask_and_ack().
         */
        __asm__ volatile("sync");
}

--
-------------------\\----------------------\\----------------------------
Jon Diekema         |  Custom IDEAS         |  http://www.cideas.com/
diekema@cideas.com  |  Grand Rapids, MI     |

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
