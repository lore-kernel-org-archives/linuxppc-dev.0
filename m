Subject: FEC question about setting SIEL register
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Tue, 8 Aug 2000 15:51:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000808055121.7716D220@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm running the MontaVista 2.2.13 kernel with a few local mods on our custom
855T board, and I've just diagnosed a problem where the system would hang when
the Ethernet was disconnected/reconnected.  The culprit was that I hadn't
configured the PHY MII link interrupt (which is on external IRQ5 on our board)
as edge triggerred in the SIU Interrupt Edge/Level (SIEL) register.

I was tipped off by this comment in fec.c:

/* We need to sequentially read registers 1 and INTERRUPT_STATUS_REG to clear
 * the interrupt.  We don't need to do that here because this
 * is an edge triggered interrupt that has already been acknowledged
 * by the top level handler.  We also read the extended status
 * register CHIP_STATUS_REG.  We just queue the commands and let them happen
 * as part of the "normal" processing.
 */

Unfortunately, this helpful comment has been deleted from fec.c in 2.4.0; I
don't know how long it would have taken me to stumble on the cause of my
problem without this hint that the FEC driver expected the interrupt to be
edge triggered.

Setting the SIEL is trivial enough, but where abouts is the right place to
do it: in the fec.c driver, or in the 8xxrom/boot loader?  The FADS code in
fec.c doesn't set the SIEL, and it doesn't seem to be set in the FADS code in
8xxrom/fadsrom either, so I would conclude that it probably suffers the same
problem.

Comments?
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
