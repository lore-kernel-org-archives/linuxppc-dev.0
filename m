From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: kernel crashes at InstructionTLBMiss
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00Jun4.144038est.115228@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Date: Sun, 4 Jun 2000 14:40:31 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm still having a few problems with my linux port (860T based board) so I hope
someone can give me some fresh ideas to how to track down the problem. When I
boot the target, I get the following output and nothing more.

loaded at:     00800000 0080B1D8
relocated to:  00B00000 00B0B1D8
board data at: 00B00190 00B001B8
relocated to:  007F0100 007F0128
zimage at:     00806000 0087C6C1
initrd at:     0087C6C1 00A53511
avail ram:     00A54000 02000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (aaluser@c1rb) (gcc version 2.95.2 19991024 (release)
) #97 Fri Jun 2 18:18:27 EST 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.77 BogoMIPS
Memory: 29308k available (852k kernel code, 688k data, 32k init)
[c0000000,c2000
000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX

I then ran the same code using a BDM debugger and it is showing that the code
is crashing at InstructionTLBMiss:

InstructionTLBMiss:
#ifndef NO_MPC8xxBUG_CPU6
        stw     r3, 8(r0)
        li      r3, M_TW_ADDR
        stw     r3, 12(r0)
        lwz     r3, 12(r0)
        mtspr   M_TW, r20       /* Save a couple of working registers */
        mfcr    r20
        stw     r20, 0(r0)
        stw     r21, 4(r0)
        mfspr   r20, SRR0       /* Get effective address of fault */
        li      r3, MD_EPN_ADDR
        stw     r3, 12(r0)
        lwz     r3, 12(r0)
#else /* NO_MPC8xxBUG_CPU6 */
        mtspr   M_TW, r20       /* Save a couple of working registers */
        mfcr    r20
        stw     r20, 0(r0)
        stw     r21, 4(r0)
        mfspr   r20, SRR0       /* Get effective address of fault */
#endif /* NO_MPC8xxBUG_CPU6 */
        mtspr   MD_EPN, r20     /* Have to use MD_EPN for walk, MI_EPN can't */

        mfspr   r20, M_TWB      /* Get level 1 table entry address */
==>        lwz     r21, 0(r20)     /* Get the level 1 entry */
        rlwinm. r20, r21,0,0,20 /* Extract page descriptor page address */

Note that I've applied the patch by Marcus Sundberg but either way, the same
thing happens.

The values of the general registers at the crash point are:

r0: 00a54230 c0a55dc0 c0a54000 00003780 c0a54230 00000000 c00f2000 00000319
r8: 0000001f 400f1000 0000000b c00f5b5c 84000028 00000000 00000000 00000000
r16: 00000000 00000000 00000000 00000000 400f1c00 000f4c20 00000000 00000000
r24: c0002284 00000000 00000000 c00f4bf0 00000001 c0a54000 c00f2ca8 c00f4be8

As you can see, r20 is 400f1c00, which looks wrong, but why? Any suggestions?

Thanks,
Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
