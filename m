Message-ID: <3D0DA9C2.D78C43E5@imc-berlin.de>
Date: Mon, 17 Jun 2002 11:20:02 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: board specific defines in commproc.h !?!?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I think we should move the board specific defines such as

/***  RPXCLASSIC  *****************************************************/

#ifdef CONFIG_RPXCLASSIC
/* Bits in parallel I/O port registers that have to be set/cleared
 * to configure the pins for SCC1 use.
 */
#define PA_ENET_RXD     ((ushort)0x0001)
#define PA_ENET_TXD     ((ushort)0x0002)
#define PA_ENET_TCLK    ((ushort)0x0200)

etc. out of ./include/asm-ppc/commproc.h into the board specific header
files like ./arch/ppc/platforms/xxx.h

The advantage is, that you don't have to change many files to port linux
to a new, custom platform. After all #define PA_ENET_RXD
((ushort)0x0001) is a board specific configuration define.

The same goes for the status_led.h from DENX (which unfortunatly has not
yet made it into linuxppc_2_4_devel!?!?)

At the same time we should changes this in the PPCBoot source - to make
porting Linux to a new platform easier.

I am prepared to do this - if you think it's worth it!

So?

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
