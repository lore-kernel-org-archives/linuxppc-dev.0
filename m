Message-Id: <s8835efe.003@netstal.com>
Date: Mon, 17 Jan 2000 18:26:55 +0100
From: "Niklaus Giger" <n.giger@netstal.com>
To: <grant@lcse.umn.edu>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Help Sought for 403GCX-startup
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Grant, 

I successfully managed to create vmlinux for the oak-IBM 403 Evaluation Board.

As our OAK-board does not work anymore (it is over 4 years old and out of service)
I tried to load the vmlinux using my vxworks boot-rom. I got a memory access
while trying to access 0xc0000008.

Therefore I tried to change in linux/arch/ppc/Makefile the 
KERNELLOAD =0xc0000000
to
KERNELLOAD =0x10000
as all my 4 MB RAM (known at boottime) is located at address 0.
After make clean vmlinux I was able to load vmlinux.

It load, but it does not start up. A hardware debugging session
using the JTAG-based SDS-debugger showed, that it crashed after very few
instruction at 0x10074

SDS-debugger deassembles:
00010000: or r31,r3,r3
00010004: or r30,r4,r4
00010008: or r29,r5,r5
0001000C: or r28,r6,r6
00010010: or r27,r7,r7
00010014: addi r24,r0,0
00010018: addis r3,r0,0xC0000000@HI
0001001C: addis r3,r3,0x00000000@HI
00010020: addis r4,r3,0x40000000@HI
00010024: mfspr r7,PID
00010028: addi r0,r0,0
0001002C: mtspr PID,r0
00010030: rlwinm r4,r4,0,0,21
00010034: ori r4,r4,0x304
00010038: rlwinm r3,r3,0,0,21
0001003C: ori r3,r3,0x3C0
00010040: illegal
00010044: illegal
00010048: isync
0001004C: mtspr PID,r7
00010050: addis r4,r0,0xC0000000@HI
00010054: addis r0,r4,0x40000000@HI
00010058: mtspr EVPR,r0
0001005C: mfmsr r0
00010060: ori r0,r0,0x30
00010064: mtspr SRR1,r0
00010068: addis r0,r0,0x00010000@HI
0001006C: ori r0,r0,0x21C8
00010070: mtspr SRR0,r0
00010074: rfi

After the rfi at 0x10074
PC is at 0x1211C8 (000121BC  is abort:)
all the memory arount the PC is filled with C8
 read 0x000121BC
(0x121BC)
000121BC                                       C8 C8 C8 C8              ....
000121C0   C8 C8 C8 C8 C8 C8 C8 C8 C8 C8 C8 C8 C8 C8 C8 C8

It seems to me that my MMU is not yet correctly setup or that?

Dear Grant,
could you please be so kind to describe your patchs (against 2.3.39) and post them on your home page?

I would also appreciate any hints how to disable the 16650-SCC (our hardware does not have one) and
how to uses the internal 403 (I have the knowledge to program it).

Regards 

Niklaus Giger
Netstal Maschinen AG
CH-8752 Naefels
+41 55 618 64 68
E-Mail: n.giger@netstal.com
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             !
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             !
                                                                       



 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             !
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
