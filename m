Message-ID: <3E32B782.9060603@tataelxsi.co.in>
Date: Sat, 25 Jan 2003 21:42:50 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel hangs in copy_and_flush while `lwzx` instruction
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
we are facing a problem in booting monta vista linux on mpc8260ads
board. kernel is

#define UTS_RELEASE "2.4.17_mvl21"

kernel hangs while executing the following lines in arch/ppc/kernel/head.S.

--code begins--
/*
  * Copy routine used to copy the kernel to start at physical address 0
  * and flush and invalidate the caches as needed.
  * r3 = dest addr, r4 = source addr, r5 = copy limit, r6 = start offset
  * on exit, r3, r4, r5 are unchanged, r6 is updated to be >= r5.
  */
copy_and_flush:
         addi    r5,r5,-4
         addi    r6,r6,-4
4:      li      r0,L1_CACHE_LINE_SIZE/4
         mtctr   r0
3:      addi    r6,r6,4                 /* copy a cache line */

/** execution hangs in the next instruction */
         lwzx    r0,r6,r4
/* never reaches here */
         stwx    r0,r6,r3
         bdnz    3b
         dcbst   r6,r3                   /* write it to memory */
         sync
         icbi    r6,r3                   /* flush the icache line */
         cmplw   0,r6,r5
         blt     4b
         sync                      /* additional sync needed on g4 */
         isync
         addi    r5,r5,4
         addi    r6,r6,4
         blr

--code ends--
Instruction `lwzx` tries to load from 0xc0100000 which is the r4
content. This is out of our memory limits and in turn cpu hangs (run led
goes off). We tried with bdi2000, but unable to set any breakpoints. We
found out it by debugging using programmable sl1 and sl0 leds in the code.

Any help is appreciated.
Thanks and regards,
Om and kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
