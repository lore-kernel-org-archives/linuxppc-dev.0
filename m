Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "lew kenny" <zsuly@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: an error about "relocation truncated"
Date: Wed, 11 Aug 2004 09:23:37 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY13-F16VKixJfhENB00038ac8@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I'm porting the PPCboot2.0 to my ppc850 board.I just modified the Makefile,
config file,and the flash's code and head file with the template of board
c2mon. But after I compile the code, there are some "relocation truncated"
errors.

lib_ppc/libppc.a(board.o): In function `board_init_r':
/root/project/ppcboot-2.0.0/lib_ppc/board.c:896: undefined reference to
`ide_init'
/root/project/ppcboot-2.0.0/lib_ppc/board.c:896: relocation truncated to
fit: R_PPC_PLTREL24 ide_init
net/libnet.a(net.o): In function `NetLoop':
/root/project/ppcboot-2.0.0/net/net.c:149: undefined reference to
`eth_halt'
/root/project/ppcboot-2.0.0/net/net.c:149: relocation truncated to fit:
R_PPC_PLTREL24 eth_halt
/root/project/ppcboot-2.0.0/net/net.c:150: undefined reference to
`eth_init'
/root/project/ppcboot-2.0.0/net/net.c:150: relocation truncated to fit:
R_PPC_PLTREL24 eth_init
/root/project/ppcboot-2.0.0/net/net.c:252: undefined reference to `eth_rx'
/root/project/ppcboot-2.0.0/net/net.c:252: relocation truncated to fit:
R_PPC_PLTREL24 eth_rx
/root/project/ppcboot-2.0.0/net/net.c:258: undefined reference to
`eth_halt'
/root/project/ppcboot-2.0.0/net/net.c:258: relocation truncated to fit:
R_PPC_PLTREL24 eth_halt
/root/project/ppcboot-2.0.0/net/net.c:294: undefined reference to
`eth_halt'
/root/project/ppcboot-2.0.0/net/net.c:294: relocation truncated to fit:
R_PPC_PLTREL24 eth_halt
net/libnet.a(net.o): In function `NetSendPacket':
/root/project/ppcboot-2.0.0/net/net.c:376: undefined reference to
`eth_send'
/root/project/ppcboot-2.0.0/net/net.c:376: relocation truncated to fit:
R_PPC_PLTREL24 eth_send
make: *** [ppcboot] Error 1

At first, I think it may be caused by a low version number ompiler. Then I
changed the compiler to the last ELDK. But there are some new errors.

/root/ELDK/usr/bin/ppc_8xx-gcc -g  -Os  -mrelocatable -ffixed-r14 -meabi
-mrelocatable -ffixed-r14 -meabi -D__KERNEL__ -DTEXT_BASE=0x10000000
-I/root/project/ppcboot-2.0.0/include -fno-builtin -pipe -DCONFIG_PPC
-D__powerpc__ -DCONFIG_8xx -ffixed-r2 -ffixed-r29 -mstring -mcpu=860
-msoft-float -DCONFIG_PPC -D__powerpc__ -DCONFIG_8xx -ffixed-r2 -ffixed-r29
-mstring -mcpu=860 -msoft-float -Wall -Wstrict-prototypes -c -o zlib.o
zlib.c
{standard input}: Assembler messages:
{standard input}:4998: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:4999: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:5000: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:5001: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:5002: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:5003: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:5004: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:5005: Error: Relocation cannot be done when using
-mrelocatable
{standard input}:4969: Error: Relocation cannot be done when using
-mrelocatable

I doubt that there maybe are some ploblems in the "ppcboot.lds". I am not
sure of it, and I have no idea how to change it. It will be very
appreciated if anyone give me some ideas.

Thanks a lot,
Flab Lew

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
