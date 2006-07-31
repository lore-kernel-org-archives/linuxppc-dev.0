Return-Path: <linuxppc@lizardlogic.co.uk>
Received: from murano.lizardlogic.co.uk (unknown [195.10.246.108])
	by ozlabs.org (Postfix) with ESMTP id BA3AE67B53
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 00:07:46 +1000 (EST)
Received: from [10.105.8.10] (lizardlogic.plus.com [84.92.176.208])
	by murano.lizardlogic.co.uk (Postfix) with ESMTP id DE3701000CA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 14:50:41 +0100 (BST)
Mime-Version: 1.0 (Apple Message framework v624)
To: linuxppc-embedded@ozlabs.org
Message-Id: <76f51967dc88fd0821a524d69fdc3e1c@lizardlogic.co.uk>
Content-Type: multipart/mixed; boundary=Apple-Mail-8--47018222
From: Stig Telfer <linuxppc@lizardlogic.co.uk>
Subject: Xilinx PIC and kernel interrupt handler 
Date: Mon, 31 Jul 2006 14:50:40 +0100
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-8--47018222
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi -

There appears to be a kernel bug in the 2.4 and 2.6.17.7 kernel trees 
relating to reading the interrupt vector from the Xilinx PIC 
(xilinx_pic_get_irq() in xilinx_pic.c).  As I see it, here's the 
problem: If no interrupt is pending, the register should read all ones. 
  However, the IVR is only as wide as the number of interrupt sources.  
The routine mistakenly assumes sign extension and checks for a 32-bit 
read of -1 instead of a read of w bits where w is the number of 
connected interrupt sources.

The 2.6 version also has a search-and-replace glitch relating to 
removal of the reversal of bit numbering.  I have attached a two line 
patch (for 2.6.17.7) that makes the IVR comparison against the right 
bit pattern and removes the remnants of the former bit-reversal code.

Share and enjoy,
Stig Telfer


--Apple-Mail-8--47018222
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="xilinx_pic.patch"
Content-Disposition: attachment;
	filename=xilinx_pic.patch

diff -Naurb linux-2.6.17.7/arch/ppc/syslib/xilinx_pic.c linux-2.6.17.7-stig/arch/ppc/syslib/xilinx_pic.c
--- linux-2.6.17.7/arch/ppc/syslib/xilinx_pic.c	2006-07-25 04:36:01.000000000 +0100
+++ linux-2.6.17.7-stig/arch/ppc/syslib/xilinx_pic.c	2006-07-31 14:20:04.000000000 +0100
@@ -97,8 +97,8 @@
 	 */
 
 	irq = intc_in_be32(intc + IVR);
-	if (irq != -1)
-		irq = irq;
+	if (irq == (1 << XPAR_INTC_MAX_NUM_INTR_INPUTS) - 1)
+		irq = -1;
 
 	pr_debug("get_irq: %d\n", irq);
 

--Apple-Mail-8--47018222--
