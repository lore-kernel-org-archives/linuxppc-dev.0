Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id EA3EF67C4A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 23:27:25 +1000 (EST)
Message-ID: <42DCFFB9.3050109@anagramm.de>
Date: Tue, 19 Jul 2005 15:27:21 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42DBCE60.8090300@anagramm.de>
	<550C0481-4DD8-4AFC-AFA2-13AAEBD055E5@freescale.com>
In-Reply-To: <550C0481-4DD8-4AFC-AFA2-13AAEBD055E5@freescale.com>
Content-Type: multipart/mixed; boundary="------------030509020005050808080203"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8540 DMA routines (channel 0 broken?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030509020005050808080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Kumar!

> Glad to see that the issue was software.  If there is something going  
> on in u-boot during init that isn't leaving the DMA channel in a  clean 
> state let me know.

The MPC8540RM.pdf says: 15.4.1.1.1:
4. _Clear_and_then_set_ the mode register channel start bit, MRn[CS],
   to start the DMA transfer

The exact problem was that Jason's original code cleared
the DMA.MR0 register to 0x00000000 in the interrupt service handler
_after_ each transaction.
Then the MR can get re-programmed along with the CS bit (Channel Start)
set at once and everything is fine.
But if MR0 didn't get cleared before that, the DMA won't start.

So, u-boot just didn't clear MR0[CS] _after_ a transaction, too.
The attached patch for u-boot would put in more safety to avoid
things like that in the future. It's optional, as my driver
explicitly clears the MRn[CS] now, _before_ it starts it's work.

> Also, it looks like there maybe some proposal for a general DMA  engine 
> API.  If your interested take a look at the Linux Sympoisum  2005 papers 
> (Accelerating Network Receive Processing).  I'm hoping to  talk to the 
> guys doing this to see what their thoughts are.  If you  have some 
> feedback on what they are proposing let me know.

I've had a look at the proposal. Thanks! I guess it shouldn't be too
difficult to implement an API like that.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

--------------030509020005050808080203
Content-Type: text/plain;
 name="u-boot_mpc85xx_dma_cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="u-boot_mpc85xx_dma_cleanup.patch"

diff -Nur u-boot/cpu/mpc85xx/cpu.c u-boot-local/cpu/mpc85xx/cpu.c
--- u-boot/cpu/mpc85xx/cpu.c	2005-07-19 14:48:37.000000000 +0200
+++ u-boot-local/cpu/mpc85xx/cpu.c	2005-07-19 14:50:46.000000000 +0200
@@ -191,6 +191,9 @@
 	while((status & 4) == 4) {
 		status = dma->sr0;
 	}
+	/* clear MR0[CS] channel start bit */
+	dma->mr0 &= ~0x00000001;
+	asm("sync;isync;msync");
 
 	if (status != 0) {
 		printf ("DMA Error: status = %x\n", status);

--------------030509020005050808080203--
