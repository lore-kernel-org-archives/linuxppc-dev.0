From: "Ole Andreas Torvmark" <ole.torvmark@radionor.no>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems with DMA transfers on Sandpoint
Date: Fri, 9 Nov 2001 18:38:26 +0100
Message-ID: <MHEAIGEFFBAFIOMKCIGCKEJLCAAA.ole.torvmark@radionor.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I'm having problems with what I think is DMA transfers on the Motorola
Sandpoint X3

I have tried numerous different cards like sound cards,network adapters and
even frame grabbers and all the cards that use dma transfers dont work.

The only card that has ever worked is an old realtek 8029. This card does
not support dma transfers.

I have then focused on testing one card and that is a etherExpress 10/100
from intel with the 82550 chip on it. The card fails during self test. I
have traced through the driver and found that when the self-test is
initiated the driver is waiting for the card to do a DMA transfer into the
drivers buffer (correct me if this is way off ). I have copied in the
section of the driver source at the bottom of this mail.

Since this is just one of the cards that fail in the sandpoint board i am
wondering if there is something that I haven't done to initialize DMA
transfers on the sandpoint or should they just work ?



My setup:

Motorola SPS Sandpoint X3 with Unity X4 PPMC MPC8240 @ 266 MHz
IRQ and GNT/REQ mode = 1 (Sandpoint X2 Compability) (I have tested the other
modes too)
Kernel : 2.4.2 MontaVista Hard Hat Journeyman v2.0






This is a transcript of the code that fails (from eepro100.c):

          /* Perform a system self-test. */
		            self_test_results = (s32*) ((((long) tx_ring_space) + 15) &
~0xf);
		            self_test_results[0] = 0;
		       	self_test_results[1] = -1;
DMA transfer---->>>>	outl(tx_ring_dma | PortSelfTest, ioaddr + SCBPort);
				do {
   				    udelay(100);
				   } while (self_test_results[1] == -1  &&  --boguscnt >= 0);
		                if (boguscnt < 0) {             /* Test optimized out. */
			 ---->>>>	printk(KERN_ERR "Self test failed, status %8.8x:\n"
This is what I get ---->>>>    KERN_ERR " Failure to initialize the
i82557.\n"
			 ---->>>>    KERN_ERR " Verify that the card is a bus-master"
				                " capable slot.\n",
				       self_test_results[1]);
				      } else
				printk(KERN_INFO "  General self-test: %s.\n"
				       KERN_INFO "  Serial sub-system self-test: %s.\n"
				       KERN_INFO "  Internal registers self-test: %s.\n"
				       KERN_INFO "  ROM checksum self-test: %s (%#8.8x).\n",
				        self_test_results[1] & 0x1000 ? "failed" : "passed",
				        self_test_results[1] & 0x0020 ? "failed" : "passed",
				        self_test_results[1] & 0x0008 ? "failed" : "passed",
				        self_test_results[1] & 0x0004 ? "failed" : "



Any help apreciated

regards

Ole Andreas Torvmark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
