Subject: Re: CLLF860T FEC problem in linux-2.4.0-test4-pre6
To: dan@netx4.com (Dan Malek)
Date: Fri, 14 Jul 2000 12:46:37 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <396DE80E.81BFABD1@embeddededge.com> from "Dan Malek" at Jul 13, 2000 12:02:22 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000714024637.A8868229@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

Dan Malek writes:
> A while back I posted a message stating I made lots of changes to this
> driver based upon patches people have sent (including some of yours).
> I also stated this is quite broken and I have not yet completed all
> of the changes.  I am surprised it works at all.

Thanks for the clarification.  I don't have BitKeeper access because of the
firewall I'm behind, so I'm relying on the public snapshots to track what's
going on.  Things move so quick it's hard to keep up, and I haven't been
following 2.4 that closely up till now.

> I am now working on both the 8260 FCC (I have patches but will check
> them in today), and the 8xx FEC as they are somewhat similar.

OK, that sounds great.  While you're in there, any chance of getting this
little change committed to improve board-independence?:

diff -ur linux-2.4.0-test4-pre6/arch/ppc/8xx_io/fec.c linux-2.4.0-test4-pre6.cllf/arch/ppc/8xx_io/fec.c
--- linux-2.4.0-test4-pre6/arch/ppc/8xx_io/fec.c	Tue Jun 20 06:25:06 2000
+++ linux-2.4.0-test4-pre6.cllf/arch/ppc/8xx_io/fec.c	Fri Jul 14 12:42:23 2000
@@ -1572,8 +1572,8 @@
 	*/
 	*((uint *) RPX_CSR_ADDR) &= ~BCSR2_FETHLEDMODE;
 #endif
-#ifdef CONFIG_FADS
-	if (request_8xxirq(SIU_IRQ2, mii_link_interrupt, 0, "mii", dev) != 0)
+#ifdef PHY_INTERRUPT
+	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
 		panic("Could not allocate MII IRQ!");
 #endif

diff -ur linux-2.4.0-test4-pre6/include/asm-ppc/fads.h linux-2.4.0-test4-pre6.cllf/include/asm-ppc/fads.h
--- linux-2.4.0-test4-pre6/include/asm-ppc/fads.h	Sun Nov 28 10:42:33 1999
+++ linux-2.4.0-test4-pre6.cllf/include/asm-ppc/fads.h	Thu Jul 13 18:59:38 2000
@@ -36,4 +36,6 @@
 #define PCMCIA_MEM_ADDR		((uint)0x04000000)
 #define PCMCIA_MEM_SIZE		((uint)(64 * 1024))

+#define PHY_INTERRUPT	SIU_IRQ2
+
 #endif

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
