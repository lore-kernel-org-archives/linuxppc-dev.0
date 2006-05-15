Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20CC6679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 02:27:03 +1000 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4FGQuq7016256
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 May 2006 18:26:56 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4FGQsrC016219
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 May 2006 18:26:55 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8248 goes berserk when printing messages on the SMC console
Date: Mon, 15 May 2006 18:28:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605151828.22727.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm trying to convince an MPC8248 board to boot Linux, and I'm having problems 
with the SMC console. I posted an e-mail on linuxppc-embedded regarding 
BDI2000 problems earlier today. The problem hasn't been solved, but I've been 
able to work around it by adding an infinite loop in the kernel code at the 
point where I want to break, halting the execution when the loop has been 
reached, and using gdb from there.

The SMC console works fine in U-Boot. 115200 8N1, no problem there.

When booting a Linux 2.6.16 kernel, the processor doesn't print anything on 
the console and seems to hang. Further analysis with a BDI2000 reveals the 
following.

- The CPU is stuck in cpm_uart_console_write, checking for

while ((bdp->cbd_sc & BD_SC_READY) != 0);

  At that point, most of the external and internal memory read as 0 (SDRAM, 
flash, ...). A few memory locations contain values different than 0, and I 
suspect those to come directly from the cache.

- If I break right before setting the BD_SC_READY flag and run using stepi, 
random characters are sent on the serial port. Measuring the baudrate using 
an oscilloscope confirms that it has been correctly configured. Only the data 
is wrong.

- If I remove the lines

bdp->cbd_sc |= BD_SC_READY;

  the kernel runs until it panics when mounting the root partition.

- If I disable the SMC transmitter (by not setting SMCMR_TEN in SMCMR), the 
kernel hangs when wrapping around to the first buffer descriptor, waiting for 
it to be ready, which of course never happens.

This seems to confirm that the CPM does something very armful to the CPU. I'm 
completely lost here, and would appreciate any help.

Best regards,

Laurent Pinchart
