Return-Path: <typedef@eircom.net>
Received: from eurodubx.europlex.local (unknown [193.120.144.98])
	by ozlabs.org (Postfix) with ESMTP id 4EF9C67AAE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 23:50:47 +1100 (EST)
Message-ID: <42079D4D.9090904@eircom.net>
Date: Mon, 07 Feb 2005 16:54:37 +0000
From: Bryan O'Donoghue <typedef@eircom.net>
MIME-Version: 1.0
To: Peter Asemann <peter.asemann@web.de>
References: <420780F6.70209@web.de>
In-Reply-To: <420780F6.70209@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Creating a configuration for my custom MPC875 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Asemann wrote:
> Some days ago I was told on this mailinglist I needed to create a custom 
> configuration in order to get linux running on my custom hardware.
> 
> So I did as I was told and created an own <name>_defconfig and entries 
> in the menu via editing arch/ppc/config.in and so on.
> 
> Well, every board seems to include it's custom header file from 
> platforms/<NAME>.h in the include/asm/mpc8xx.h header file.
> Now I'm curious if I also need to include something?
> 
> It seems there usually isn't much stuff in the <name>.h file, only an 
> IMAP_ADDR define and the definition of struct bd_info.
> 
> Do I need this stuff - or how do I find out?
> 
> Best regards,
> 
> Peter Asemann


You'll definately need to find out what _your_ IMAP_ADDR is, that is 
something which is almost certainly going to be unique to your own PCB.

Aside from that depending on what bootloader you are using, you may or 
may not have to do things to enumerate a bd structure.

In the case of Redboot, you would probably have to take the board 
descriptor given by redboot and parse it, else, with u-boot, I think you 
have _less_ maintenance on that front.

Do you have a working bootloader for your board, something that will try 
to execute a *image ? If you do, then getting Linux booting should be 
relatively trivial.

Bod
