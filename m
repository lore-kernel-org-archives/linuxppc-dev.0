Date: Wed, 17 May 2000 18:38:01 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Another useful piece of code lost
Message-ID: <Pine.LNX.4.21.0005171815010.32437-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

The kernel that Dan Malek wrote for us in Transcept, Inc. had the
following lines in include/asm-ppc/ide.h :

/*
 * The following are not needed for the non-m68k ports
 */
#if 0
#define ide_ack_intr(base, irq)         (1)
#else
static __inline__ void ide_ack_intr(unsigned int base, unsigned int irq)
{
        ((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pscr = ~0;
}
#endif

Strictly speaking, this is wrong because this code assumes that all PPC
machines, even PowerMac's use PCMCIA.

But from the practical point of view, this code makes it possible to
support ATA Flash at least on RPX/Lite, so the comment is wrong - there
are non-m68k ports depending on non-trivial ide_ack_intr().

The MontaVista kernels don't include anything like that. This is one of
the reasons why they don't support ATA Flash on RPX/Lite.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
