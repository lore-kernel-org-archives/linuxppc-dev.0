Message-ID: <3A251EA8.74A26893@Ferrari.DE>
Date: Wed, 29 Nov 2000 16:20:08 +0100
From: Rolf Fiedler <Rolf.Fiedler@Ferrari.DE>
Reply-To: Rolf.Fiedler@Ferrari.DE
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, Ruedi Dummermuth <ruedi@abatron.ch>
Subject: target entered debug mode
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi there,

I have a monta vista 2.4.0-test1 kernel running on a IBM PPC405GP
selfmade board. Connected to the board is an Abatron BDI2000, which
I use for TFTP booting. The board mounts the root nfs via PMC ethernet
(intel i82559ER). The internal ethernet controller isn't working,
I have no idea why - can't talk to the LXT972 via MII management
interface. That is my next task...

My question is:
How come the board enters debug mode on the Abatron BDI2000 once
in a while? I had it running processing data all over the weekend,
and on monday it locked. I had a number of lock-ups since.

what I get from the debugger is:
- TARGET: target has entered debug mode

and if I do info:
Target state      : debug mode
Debug entry cause : JTAG stop request
Current PC        : 0xc0012b90
Current CR        : 0x24000028
Current MSR       : 0x00009230
Current LR        : 0xc00048c4

Is it a problem with the Abatron debugger or is my board instable?

I did a objdump -d of the kernel running and the debug mode entry
happend in the scheduler, in schedule:
        /*
         * 'sched_data' is protected by the fact that we can run
         * only one process per CPU.
         */
        sched_data = & aligned_data[this_cpu].schedule_data;
c0012b84:       3d 20 c0 14     lis     r9,-16364
c0012b88:       39 29 b0 c0     addi    r9,r9,-20288
c0012b8c:       7f de 4a 14     add     r30,r30,r9

        spin_lock_irq(&runqueue_lock);
c0012b90:       3d 60 c0 13     lis     r11,-16365     <--------
c0012b94:       80 0b 83 e0     lwz     r0,-31776(r11)
c0012b98:       7c 08 03 a6     mtlr    r0
c0012b9c:       4e 80 00 21     blrl

        /* move an exhausted RR process to be last.. */
        if (prev->policy == SCHED_RR)
c0012ba0:       80 df 00 08     lwz     r6,8(r31)
c0012ba4:       3d 20 c0 14     lis     r9,-16364
c0012ba8:       80 06 00 28     lwz     r0,40(r6)
c0012bac:       2c 00 00 02     cmpwi   r0,2
c0012bb0:       41 82 03 e4     beq     c0012f94 <schedule+0x4a8>
                goto move_rr_last;

I can not see anything wrong with that...

Did anybody experience similar problems with PPC405GP or BDI2000?

Besides this as yet unidentified problem the BDI2000 has proven to
be an excellent product, you get the software-updates without asking
for them and their support is quite good (they found a hardware
design mistake for me).

Thanks for any hints,
Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
