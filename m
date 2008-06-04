Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 141DFDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 13:00:34 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K3jEk-0001e5-Bv
	for linuxppc-embedded@ozlabs.org; Tue, 03 Jun 2008 20:00:30 -0700
Message-ID: <17638198.post@talk.nabble.com>
Date: Tue, 3 Jun 2008 20:00:30 -0700 (PDT)
From: swamydp <swamydp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
In-Reply-To: <20080528140800.9ACE756007F@mail97-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <17222725.post@talk.nabble.com>
	<20080514150139.E258D8D006F@mail70-va3.bigfish.com>
	<17276753.post@talk.nabble.com>
	<20080516162807.2132E181804D@mail89-sin.bigfish.com>
	<17454696.post@talk.nabble.com> <17482754.post@talk.nabble.com>
	<20080528140800.9ACE756007F@mail97-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi John

I am using UARTLITE as serial console. I do not have license for UART 16550.
I have enabled the drivers for uartlite in menuconfig while configuring the
kernel. I have tested all combinations for the kernel command line - tty0,
ttyUL0, ttyl0, ttyS0 but could not get uartlite to output kernel printk
messages. 

Since I am using uartlite , the following settings are turned off in
menuconfig

CONFIG_SERIAL_8250=n
CONFIG_SERIAL_8250_CONSOLE=n

I have seen many posts claim that uartlite seems to work with ttyUL0 setting
in the kernel command line but I am having trouble with that.

Thanks
swamy




Hi Swamy,

Sorry for the long delay. Sounds like the console is not setup
correctly.

I notice in your command line it appears that you have 2 console
statements.  I have not tested this ever and I would change it to only
have the console=ttyS0,9600.  I have seen other mailings, no Xilinx
specific, related to this causing problems.

This console setup assumes you're using the Xilinx 16550 UART.  It could
be an issue with the xparameters*.h file with the address of the UART.

Have you compared your arch/ppc/platforms/4xx/xparameters/xparameters*.h
file, whichever one it's setup to use, to the ones that we provided in
the Git tree?

I'm assuming you have the kernel configured correctly to use the
UART16550 driver and the console is turned on, both are needed.  The
16550 is 8250 compatible (mostly) and works with it's driver from Linux.

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

Thanks,
John


-- 
View this message in context: http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-board-tp17222725p17638198.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
