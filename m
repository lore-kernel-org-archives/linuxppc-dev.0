Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep20-int.chello.nl (amsfep20-int.chello.nl [213.46.243.18])
	by ozlabs.org (Postfix) with ESMTP id 28F5867A2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 21:18:48 +1100 (EST)
Received: from [192.168.0.27] (really [80.216.174.242])
	by amsfep20-int.chello.nl
	(InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
	id <20050215101841.SZRL1891.amsfep20-int.chello.nl@[192.168.0.27]>
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 Feb 2005 11:18:41 +0100
Message-ID: <4211CC97.1050801@bitsim.se>
Date: Tue, 15 Feb 2005 11:19:03 +0100
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Stuck in booting 2.6.10-ac11 on Memec Design FF1152...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone!

I seem to be promptly stuck at a place in booting (and has been for a 
while now) so I figured I'd ask the list and see if anyone of you has 
any ideas. This is all on a Memec Design FF1152 Rev. 3 Evaluation board 
containing a XC2VP20 Virtex-II pro chip (two ppc 405GP processors). 
Since the excellent Xilinx tools crash on ELF files, the only option is 
to download a binary and debug using the serial port.

After enabling SERIAL_DEBUG_IO_BASE to the serial port, the last 
printout is "MMU:exit()". Checking the PC and the System.map, I seem to 
halt in the function __delay() which I believe is the function in 
arch/ppc/kernel/misc.S since it's global. Now, I have two problems:

1. How does it get to (and get stuck in) __delay()? Can it be triggered 
by some interrupt if the controller isn't properly configured or is it 
called from init/main.c and there is some missing timer 
(initialization)? Looking at Andrei Konovalovs ML300 setup I can't see 
any external timer configured...

2. gen550_progress() (or something else) seem to be hogging the console 
(serial port) one way or the other, disabling printk() and making it 
much harder to debug. Any suggestions how I could deal with this? The 
serial device is a generic 16550 UART (Xilinx made).

Thanks in advance!

	/Jakob

(PS. Andrei: You seem to be using a DCR_INTC on your card and yet 
setting the parameter USE_DCR set to 0. Why is that?)
