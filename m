Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 5E7B22BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 04:16:02 +1000 (EST)
Date: Thu, 7 Oct 2004 14:09:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041007173023.GK14773@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 7 Oct 2004, Tom Rini wrote:

> Since these changes can go right into a linux-2.6 tree and out to 
> Linus, I should be able to get BitKeeper to happily merge these 
> changes and your changes.

since i already went to the trouble to figure out what it would take 
to do this, i'll just post it in case any of it is helpful.

first, i assume that anything related to UARTs in arch/ppc/8xx_io/ can 
be deleted (the newer stuff being in drivers/serial/cpm_uart/).  this 
would include uart.c, and any references to UARTs in both Kconfig and 
Makefile.  so that stuff is pretty easily deletable.

regarding Kconfig, that currently defines the following config 
variables related to UARTs (all of the latter ones dependent on the 
first, so if you delete the first, all the rest pretty well have to 
vanish as well):

   CONFIG_8xx_UART
   CONFIG_SMC2_UART
   CONFIG_ALTSMC2
   CONFIG_CONS_SMC2
   CONFIG_USE_SCC_IO

if you get rid of that chunk of Kconfig, then you better make sure 
there's nothing in the rest of the kernel source that refers to any of 
those config variables in any meaningful way.  other than uart.c, some 
of these variables are listed in arch/ppc/configs/*, so you'd probably 
want to clean up any of those defconfig files while you're at it.

(as an example, the file "SM850_defconfig" contains the line

   CONFIG_CONS_SMC2=y

not good. :-)

   now, once all that stuff is taken care of, i'm assuming all 
UART-related stuff and its configuration is found under 
drivers/serial/cpm_uart/, and the kernel config menu for that stuff 
under

   Device drivers ->
     Character devices ->
       Serial drivers

   apparently, according to this menu, i can walk through and select 
every single serial port possibility: SMC[12] and SCC[1234].  but even 
after you do that, you can apparently still go to the "MPC8xx" menu 
and select to put ethernet on, say, SCC1.  i'm pretty sure you 
shouldn't be able to select that SCC1 is for both UART and ethernet 
simultaneously.  just need to add more dependencies to some Kconfig 
files, i suspect.

   thoughts?

rday
