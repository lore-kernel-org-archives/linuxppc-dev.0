Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E1EE23F.5BC310F3@imc-berlin.de>
Date: Fri, 10 Jan 2003 16:09:51 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Definitions for c_cflag etc. in termbits.h???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am playing around with UARTs and got completly confused when looking at
./include/asm-ppc/termbits.h:

E.g. the DEFINEs of c_iflags appear to me as decimal values!?

/* c_iflag bits */
#define IGNBRK  0000001
#define BRKINT  0000002
#define IGNPAR  0000004
#define PARMRK  0000010
#define INPCK   0000020
#define ISTRIP  0000040
#define INLCR   0000100
#define IGNCR   0000200
#define ICRNL   0000400
#define IXON    0001000
#define IXOFF   0002000
#define IXANY   0004000
#define IUCLC   0010000
#define IMAXBEL 0020000

So how could code like

./arch/ppc/8xx_io/uart.c:       if (I_BRKINT(info->tty) || I_PARMRK(info->tty))
or
./arch/ppc/8xx_io/uart.c:#define RELEVANT_IFLAG(iflag) (iflag &
(IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))

possibly work?

Shouldn't that be hex values as in ./include/asm-sparc64/termbits.h:

/* c_iflag bits */
#define IGNBRK  0x00000001
#define BRKINT  0x00000002
#define IGNPAR  0x00000004
#define PARMRK  0x00000008
#define INPCK   0x00000010
#define ISTRIP  0x00000020
#define INLCR   0x00000040
#define IGNCR   0x00000080
etc. ???

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
