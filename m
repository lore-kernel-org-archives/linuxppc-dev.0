Subject: Re: mpc8xx-2.3.10 configuration questions.
To: dmalek@jlc.net (Dan Malek)
Date: Thu, 16 Sep 1999 17:36:33 +1000 (EST)
Cc: bsimon@ctam.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <37DFF342.94EE3B8@jlc.net> from "Dan Malek" at Sep 15, 99 03:28:02 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19990916073633.38BA67B8@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> When you play in this sandbox you have to expect things not to work
> correctly, and contribute to the updates.

Accordingly, I offer the following changes, which were necessary to build a
kernel for the RPCg CLLF board with an 860T. (I assume this board has the same
software model as the RPX Lite, since there is no CLLF option). Both problems
relate to the Fast Ethernet Controller code, which didn't compile:


*** arch/ppc/8xx_io/fec.c.dist	Wed Sep 15 17:32:26 1999
--- arch/ppc/8xx_io/fec.c	Thu Sep 16 17:31:35 1999
***************
*** 820,826 ****
  
  /* Initialize the FEC Ethernet on 860T.
   */
! __initfunc(int fec_enet_init(void))
  {
  	struct net_device *dev;
  	struct fec_enet_private *fep;
--- 820,826 ----
  
  /* Initialize the FEC Ethernet on 860T.
   */
! int __init fec_enet_init(void)
  {
  	struct net_device *dev;
  	struct fec_enet_private *fep;


*** include/asm-ppc/rpxlite.h.dist	Thu Sep 16 17:30:04 1999
--- include/asm-ppc/rpxlite.h	Thu Sep 16 17:31:02 1999
***************
*** 56,61 ****
--- 56,65 ----
  #define HIOX_CSR_ENAUDIO	((uint)0x00000200)
  #define HIOX_CSR_RSTAUDIO	((uint)0x00000100)	/* 0 == reset */
  
+ /* Interrupt level assignments.
+ */
+ #define FEC_INTERRUPT	SIU_LEVEL1	/* FEC interrupt */
+ 
  /* We don't use the 8259.
  */
  #define NR_8259_INTS	0

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
