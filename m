Date: Tue, 13 Jul 2004 13:34:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: fix to enet.c to enable networking when booting from flash
Message-ID: <Pine.LNX.4.60.0407131328290.19248@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   with our current 2.4.22-pre8 kernel, we found that, on our 850DE
board (ethernet on SCC3), ethernet would work fine when we downloaded
the bootable image, but not if we booted from the image that was
burned into flash.

   eventually, one of the guys here tracked the problem to
arch/ppc/8xx_io/enet.c, and made the following change (around line 915
in enet.c in both this version of the kernel and in the latest bk pull
of linuxppc-2.5):

#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) ||
defined(CONFIG_EP8xx) || defined(CONFIG_EP852)
         /* And while we are here, set the configuration to enable
ethernet.
         */
         *((volatile uint *)RPX_CSR_ADDR) &= ~BCSR0_ETHLPBK;
         *((volatile uint *)RPX_CSR_ADDR) |=
              (BCSR0_ETHEN | BCSR0_COLTESTDIS | BCSR0_FULLDPLXDIS);
>        *((volatile uint *)RPX_CSR_ADDR) |=0x00100000;  <-- add this
//1:ethernet,0:SPI
#endif


   i don't know enough about the hardware to know what this is for.  if
anyone does, is it still an issue?  is there a better way to handle
this?  as much as possible, i'm trying to get everything running on
this board without messing with the kernel source.  thanks.  given
that the author of that line is not around at the moment, i'm just
going to poke around the source and see if i can deduce what it's for.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
