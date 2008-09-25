Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 145B5DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 19:42:31 +1000 (EST)
Received: from bzq-79-182-166-32.red.bezeqint.net ([79.182.166.32]:50036
	helo=felix.lan) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1KinMg-0005Tk-Pp
	for linuxppc-embedded@ozlabs.org; Thu, 25 Sep 2008 05:42:27 -0400
Message-ID: <48DB5CE9.8080604@embedded-sol.com>
Date: Thu, 25 Sep 2008 12:42:01 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Kernel debugging on 460EX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to debug Linux kernel (2.6.26) on custom 460EX based
board using BDI3000. The U-Boot succeeds to download kernel and
DTB into RAM and jump to kernel code.  Immediately after that
the board resets without printing anything to console. I'm trying
to set a breakpoint at _start kernel routine, but it doesn't work.

My BDI3000  configuration file looks like this:

[INIT]

[TARGET]
JTAGCLOCK       4       ;use 5 MHz JTAG clock
CPUTYPE         440     ;the used target CPU type
WAKEUP          500     ;wakeup time after reset
BREAKMODE       SOFT    ;SOFT or HARD, HARD uses PPC hardware breakpoint
STEPMODE        HWBP    ;JTAG or HWBP, HWBP uses one or two hardware 
breakpoints
RESET           HARD
MMU             XLAT

In BDI I let u-boot complete the initialization and get to the prompt.
Then I do

halt
bi 0xc0000000
go

and run bootd command in u-boot. However the board resets without breaking
into kernel code. What am I doing wrong ?

Thanks a lot in advance !

Felix.
