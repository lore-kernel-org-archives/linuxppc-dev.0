Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE12EDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 21:32:58 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IINJ0-0006Kw-TL
	for linuxppc-embedded@ozlabs.org; Tue, 07 Aug 2007 04:32:54 -0700
Message-ID: <12032525.post@talk.nabble.com>
Date: Tue, 7 Aug 2007 04:32:54 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: signals handling in the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

    I would like to send signals from the interrupt handler routine (in the
kernel) to the user application (in user space).
I have googled on that net and I have found that it could be done with the
function:
kill_proc_info.

When I have compiled my module which uses the kill_proc_info I have got and
error messge:

WARNING: "kill_proc_info" [drivers/char/xilinx_gpio/xilinx_gpio.ko]
undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

The  kill_proc_info source code is in the kernel/signal.c file. Due to
unknown reason the kill_proc_info symbol is not exported with EXPORT_SYMBOL
entry.


I can modify the file kernel/signal.c adding the line
EXPORT_SYMBOL(kill_proc_info) but maybe it is a good reason in order not to
use this function straight. If so what would be the best way to send a
signal form the kernel interrupt handler routine to the user space together
with the siginfo data.

Best Regards

Mirek
   
-- 
View this message in context: http://www.nabble.com/signals-handling-in-the-kernel-tf4229566.html#a12032525
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
