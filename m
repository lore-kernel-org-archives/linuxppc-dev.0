Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx018.isp.belgacom.be (outmx018.isp.belgacom.be
	[195.238.4.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8817679F2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 May 2006 20:09:36 +1000 (EST)
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
	by outmx018.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4FA9Q3g016127
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 May 2006 12:09:26 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx018.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4FA9N6X016077
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 May 2006 12:09:23 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Page fault when debugging a 2.6.16 kernel on MPC8248
Date: Mon, 15 May 2006 12:10:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605151210.51785.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everybody,

I'm trying to bring up Linux on a custom MPC8248 board.

I've been able to setup U-Boot correctly up to the point where I boot the 
Linux kernel using bootm. The kernel doesn't print anything on the serial 
console and hangs.

Thanks to a BDI2000, I've been able to get the following backtrace.

#0  cpm_uart_console_write (co=0xd,
    s=0xc0203e4b "x version 2.6.16-dirty (laurent@pclaurent) (gcc version 
3.4.1) #422 Thu May 11 13:30:44 CEST 2006\n<6>Technotrade S.A.",
    count=1) at drivers/serial/cpm_uart/cpm_uart_core.c:1023
#1  0xc0014144 in __call_console_drivers (start=3, end=105) at 
kernel/printk.c:368
#2  0xc00144f4 in release_console_sem () at kernel/printk.c:430
#3  0xc0014ce4 in register_console (console=0xc01c2e60) at kernel/printk.c:946
#4  0xc01f7308 in cpm_uart_console_init () at 
drivers/serial/cpm_uart/cpm_uart_core.c:1149
#5  0xc01f673c in console_init () at drivers/char/tty_io.c:3181
#6  0xc01e85b8 in start_kernel () at init/main.c:495
#7  0x00000000 in ?? ()

At that point, all the memory read with the BDI2000 (internal memory, SDRAM, 
SRAM, flash, ...) reads as 0.

Knowing that something was wrong with the memory, I tried to execute the 
kernel step by step. Unfortunately, after breaking in start_kernel, the first 
gdb "next" command to step over the call to printk(KERN_NOTICE) hung. Hitting 
Ctrl-C in gdb returned the following backtrace.

#0  0xc0005f4c in __delay ()
#1  0xc0013b18 in panic (fmt=0x487ab0 <Address 0x487ab0 out of bounds>) at 
include/asm/delay.h:42
#2  0xc001679c in do_exit (code=11) at kernel/exit.c:809
#3  0x2400c022 in ?? ()
#4  0xc0004b8c in die (str=0x3ff <Address 0x3ff out of bounds>, fp=0xc01e7c60, 
err=11) at arch/ppc/kernel/traps.c:101
#5  0xc000bf3c in bad_page_fault (regs=0xc01e7c60, address=0, sig=11) at 
arch/ppc/mm/fault.c:336
#6  0xc00046d0 in handle_page_fault ()
#7  0xc00046d0 in handle_page_fault ()

I'm lost here. Why does Linux page faults when executed step by step (or 
rather using "next") but doesn't when running normally ? I suspect that this 
could be related to the memory reading as 0 in cpm_uart_console_write.

Thanks in advance for all the help you can provide.

Best regards,

Laurent Pinchart
