Message-Id: <5.1.1.6.0.20030507145601.01a67df0@192.168.2.1>
Date: Wed, 07 May 2003 16:01:53 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: Re: Kernel hangs on a 405EP eval. board with U-Boot
In-Reply-To: <5.1.1.6.0.20030506182211.01a68700@dns.struinfo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Anybody can give me some help? Do you think the procedure I used is correct?

After some further investigations, I found that the function memset_io
invoked by early_init, corrupts the memory region where the function
identify_cpu is located.
This is the disassembled produced by objdump:

c0006774 <identify_cpu>:
c0006774:       3d 03 c0 12     addis   r8,r3,-16366
c0006778:       39 08 e1 40     addi    r8,r8,-7872
c000677c:       7c ff 42 a6     mfpvr   r7
c0006780:       80 a8 00 00     lwz     r5,0(r8)
c0006784:       7c a5 38 38     and     r5,r5,r7
c0006788:       80 c8 00 04     lwz     r6,4(r8)
c000678c:       7c 06 28 40     cmplw   r6,r5
c0006790:       41 82 00 0c     beq-    c000679c <identify_cpu+0x28>
c0006794:       39 08 00 20     addi    r8,r8,32
c0006798:       4b ff ff e8     b       c0006780 <identify_cpu+0xc>
c000679c:       3c c3 c0 14     addis   r6,r3,-16364
c00067a0:       38 c6 f0 bc     addi    r6,r6,-3908
c00067a4:       54 84 10 3a     rlwinm  r4,r4,2,0,29
c00067a8:       7d 03 40 50     subf    r8,r3,r8
c00067ac:       7d 04 31 2e     stwx    r8,r4,r6
c00067b0:       4e 80 00 20     blr


This is what I see in memory before executing the memset_io:

PPC405EP>go
- TARGET: target has entered debug mode
PPC405EP>md 0xc0006774 8
c0006774 : 0x3d03c012   1023655954  =...
c0006778 : 0x3908e140    956883264  9..@
c000677c : 0x7cff42a6   2097103526  |.B.
c0006780 : 0x80a80000  -2136473600  ....
c0006784 : 0x7ca53838   2091202616  |.88
c0006788 : 0x80c80004  -2134376444  ....
c000678c : 0x7c062840   2080778304  |.(@
c0006790 : 0x4182000c   1099038732  A...
PPC405EP>go
- TARGET: target has entered debug mode

This is what I see in memory before executing the memset_io:

PPC405EP>md 0xc0006774 8
c0006774 : 0xff03ffff  -  16515073  ....
c0006778 : 0xff08ffff  -  16187393  ....
c000677c : 0xff08ffff  -  16187393  ....
c0006780 : 0x80a80000  -2136473600  ....
c0006784 : 0x7ca53838   2091202616  |.88
c0006788 : 0x80c80004  -2134376444  ....
c000678c : 0x3c060840   1007028288  <..@
c0006790 : 0x7c062840   2080778304  |.(@
PPC405EP>


Anybody have already seen something like that?
Is it possible that this has to do with an erroneous cache initialization?



llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
