Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4693DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 12:35:07 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4U2YxrC005240
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:35:00 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4U2Yw2J017968
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:34:59 -0500 (CDT)
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1180492466.12577.6.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 30 May 2007 10:34:26 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 03:29, Kumar Gala wrote:
> On May 28, 2007, at 9:36 PM, Zang Roy-r61911 wrote:
> 
> > Fix the e500 v2 core reset bug.
> > For e500 v2 core, a new reset control register is added to
> > reset the core.
> > On 85xx CDS board with e500 v2 core, normal reboot code will
> > induce DDR block in u-boot. This patch fixes this bug. It is
> > also tested on legacy e500 v1 core.
> 
> what happens on an e500 based 85xx system?

Without this patch on MPC8548CDS board, after key in "reboot" command,
the u-boot will hang at DDR init. See the following log without this
patch:

--- log start ---
~ # uname -a
Linux mpc8548cds 2.6.22-rc2-g843b8c89-dirty #5 Tue May 29 16:37:21 CST
2007 ppc
unknown
~ # reboot
~ # Stopping the boa webserver:
Stopping the port mapper:
Stopping inetd:
Syncing hardware clock to system time
hwclock: Could not set the RTC time: Invalid argument
Unmounting filesystems
umount: Cannot open /proc/mounts
The system is going down NOW !!
Sending SIGTERM to all processes.
Please stand by while rebooting the system.
Restarting system.


U-Boot 1.1.6-gcd32691c-dirty (Apr  2 2007 - 17:42:01)

CPU:   8548_E, Version: 2.0, (0x80390020)
Core:  E500, Version: 2.0, (0x80210020)
Clock Configuration:
       CPU: 990 MHz, CCB: 396 MHz,
       DDR: 198 MHz, LBC:  49 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: CDS Version 0x13, PCI Slot 1
CPU Board Revision 114.121 (0x7279)
    PCI1: 32 bit, 33 MHz, async
    PCI2: disabled
I2C:   ready
DRAM:  Initializing
    SDRAM: 64 MB
    DDR: 256 MB

--- log end --

This patch has been tested on 8548/55 CDS board and 8540/60 ADS board.

> I'm not terrible happy with blindly writing to rstcr.
> 
I can understand you.
But I jut want to make things simple and workable.
Any idea?
Roy
