Message-ID: <3CFE7197.1040408@linuxfoundary.com>
Date: Wed, 05 Jun 2002 16:16:23 -0400
From: Dave Strout <dstrout@linuxfoundary.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can compile, now on to booting
References: <20020605191638.298B0102F2@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks all for the help with the toolchain -- I'm now cranking out ppc
code.

Now to boot.  What I'm actually trying to do is replace a VxWorks
environment on one of my companies products with Linux. The unit is
405GP based, and pretty close to a walnut, as far as I can tell
(comparing the mem map in the docs with the 405gp.h file in the
kernel).  I'm hoping to get away with using the existing boot monitor,
at least in the short term.  The monitor has the ability to load an ELF
executable & jump to it, but I'm not getting very far beyond that -- in
fact it crashes with the pc at the first instruction.  I've tried my
freshly-built 2.4.18 kernel, and the ppcboot executable, and they both
crash on the first instruction.

I don't have a hardware debugger for this, so I'm sort of at a loss.
 There are some LED's on the front that I could try & write some asm to
blink as I go along, but since I hang on the first instruction, I'm not
sure that would help.......

All thoughts greatly appreciated.

dave.


Dumps:

Linux:
ftp 134.141.133.254:vmlinux to SDRAM size=1430968
Booting system S/W at entry 0xc0000000
Starting at 0xc0000000...


program
Exception current instruction address: 0xc0000000
Machine Status Register: 0x00029200
Condition Register: 0x24200082
Task: 0x1f1a8e0 "tBoot"

r0     =   c034dc   sp     =  1f1a4d0   r2     =        0   r3
=        0
r4     =  1f80000   r5     =  1f1a8e0   r6     =    29200   r7     =
1200
r8     =       20   r9     =   ca0000   r10    =        4   r11
=        0
r12    =        0   r13    =        0   r14    =        0   r15
=        0
r16    =        0   r17    =        0   r18    =        0   r19
=        0
r20    =        0   r21    =        0   r22    =        0   r23
=        0
r24    =        0   r25    =        0   r26    =        0   r27    =
ca0000
r28    =   ca0000   r29    = c0000000   r30    =  1ffffc8   r31    =
c0000000
msr    =    29200   lr     =   c034e4   ctr    =        0   pc     =
c0000000
cr     = 24200082   xer    =        0

ppcboot:

ftp 134.141.133.254:ppcboot to SDRAM size=186232 + 4
Booting system S/W at entry 0xfff80000
Starting at 0xfff80000...


program
Exception current instruction address: 0xfff80000
Machine Status Register: 0x00029200
Condition Register: 0x24200082
Task: 0x1f1a8e0 "tBoot"

r0     =   c034dc   sp     =  1f1a4d0   r2     =        0   r3
=        0
r4     =  1f80000   r5     =  1f1a8e0   r6     =    29200   r7     =
1200
r8     =       20   r9     =   ca0000   r10    =        4   r11
=        0
r12    =        0   r13    =        0   r14    =        0   r15
=        0
r16    =        0   r17    =        0   r18    =        0   r19
=        0
r20    =        0   r21    =        0   r22    =        0   r23
=        0
r24    =        0   r25    =        0   r26    =        0   r27    =
ca0000
r28    =   ca0000   r29    = fff80000   r30    =  1ffffc8   r31    =
fff80000
msr    =    29200   lr     =   c034e4   ctr    =        0   pc     =
fff80000
cr     = 24200082   xer    =        0

Objdump says:
[dstrout@dstrout dstrout]$ ~/tools/bin/powerpc-linux-objdump -D ppcboot
| head -20

ppcboot:     file format elf32-powerpc

Disassembly of section .resetvec:

fffffffc <.resetvec>:
fffc:    4b f8 01 04     b    fff80100 <_start>
Disassembly of section .text:

fff80000 <version_string-0x4>:
fff80000:    27 05 19 56     dozi    r24,r5,6486

fff80004 <version_string>:
fff80004:    50 50 43 42     rlwimi    r16,r2,8,13,1
fff80008:    6f 6f 74 20     xoris    r15,r27,29728
fff8000c:    31 2e 31 2e     addic    r9,r14,12590
fff80010:    35 20 28 4a     addic.    r9,r0,10314
fff80014:    75 6e 20 20     andis.    r14,r11,8224
fff80018:    35 20 32 30     addic.    r9,r0,12848
fff8001c:    30 32 20 2d     addic    r1,r18,8237

[dstrout@dstrout dstrout]$ ~/tools/bin/powerpc-linux-objdump -D vmlinux
| head -20

vmlinux:     file format elf32-powerpc

Disassembly of section .text:

c0000000 <_start>:
c0000000:    7c 7f 1b 78     mr    r31,r3
c0000004:    7c 9e 23 78     mr    r30,r4
c0000008:    7c bd 2b 78     mr    r29,r5
c000000c:    7c dc 33 78     mr    r28,r6
c0000010:    7c fb 3b 78     mr    r27,r7
c0000014:    3b 00 00 00     li    r24,0
c0000018:    48 00 23 49     bl    c0002360 <initial_mmu>

c000001c <turn_on_mmu>:
c000001c:    38 00 10 32     li    r0,4146
c0000020:    7c 1b 03 a6     mtsrr1    r0
c0000024:    3c 00 c0 00     lis    r0,-16384
c0000028:    60 00 22 c0     ori    r0,r0,8896
c000002c:    7c 1a 03 a6     mtsrr0    r0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
