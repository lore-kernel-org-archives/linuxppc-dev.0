Message-ID: <3DD254F0.3050701@uab.ericsson.se>
Date: Wed, 13 Nov 2002 14:34:40 +0100
From: Hans Feldt <Hans.Feldt@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 - Spurious interrupts again
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am running a 750 with a 8260 as slave. Since I get heaps of spurious
interrupts I started digging into it. The old thread "8260 - Spurious
interrupt when calling __sti()" and the latest code didn't help but this
does:

- A sync instruction last in m8260_mask_irq and m8260_mask_and_ack in
ppc8260_pic.c.

I guess you need to let the write to SIMR make it before enabling
external interrupts in the 750 (603). This is probably due to our use of
8260 as a slave processor but I think it makes sense anyway.

Note that this problem is not related to the fact that I am running the
new ATM driver, this also happens as indicated in the old mail thread
with serial and Ethernet interrupts only.

Thanks,
Hans

P.S. Tack Magnus!

without sync:
==============
bash-2.04# cat /proc/interrupts
            CPU0
   4:       9777   8260 SIU   Edge      uart
   5:          0   8260 SIU   Edge      uart
  32: 1396813673   8260 SIU   Edge      atm
  33:      57596   8260 SIU   Edge      fenet
  41:          0   8260 SIU   Edge      uart
  42:          0   8260 SIU   Edge      uart
  60:         11   8260 SIU   Edge      ide0
BAD: 1396813185

with sync:
===========
bash-2.04# cat /proc/interrupts
            CPU0
   4:       4709   8260 SIU   Edge      uart
   5:          0   8260 SIU   Edge      uart
  32:     217671   8260 SIU   Edge      atm
  33:      10395   8260 SIU   Edge      fenet
  41:          0   8260 SIU   Edge      uart
  42:          0   8260 SIU   Edge      uart
  60:         11   8260 SIU   Edge      ide0
BAD:          0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
