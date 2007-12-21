Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 1A654DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 14:44:54 +1100 (EST)
Date: Thu, 20 Dec 2007 22:38:15 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/4] arch/powerpc support for SBC8560 board
Message-ID: <20071221033815.GA13921@windriver.com>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<AD8BE998-401D-4109-8DD0-F26760C0E980@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AD8BE998-401D-4109-8DD0-F26760C0E980@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH 0/4] arch/powerpc support for SBC8560 board
on 20/12/2007 Kumar Gala wrote:

>> 3) Add device tree source for Wind River SBC8560 board
>>
>> This is probably the most interesting part of the group, given that the
>> board doesn't use the CPM2 to provide the serial console.  I've made a
>> duart dts entry that is kind of similar to what is done for the tsi108
>> on the mpc7448/hpc-ii board, and made sure that the serial had their
>> parent marked as "soc" (found out the hard way that UARTs were ignored
>> as possible consoles unless they were soc or tsi108 children...)
>>
>> b/arch/powerpc/boot/dts/sbc8560.dts |  203 
>> +++++++++++++++++++++++++++++++++++-
>
> we need to figure out to fix this so we don't need the parent marked as 
> 'soc'.

Here is my interpretation of what is happening here -- we come in via
find_legacy_serial_ports() to pick a console port.  It grabs "chosen"
to get np stdout, and then checks the parent of the 16550 compat ports
against the following, requiring at least one of them to match:

	parent->type == "soc" ? add_legacy_soc_port()

	parent->type == "isa" ? add_legacy_isa_port()

	parent->type == "tsi-bridge" ? add_legacy_soc_port()

	parent->type == "opb" ? add_legacy_soc_port()

No match means no serial console, it seems.  I figured that parent == "soc"
was the lesser lie to choose from, but I'm open to an alternate approach 
that is less apt to make David go "ewww" (an understandable reaction...).

>
> Out of interest how exactly are the duart's wired on the 8560.  Are they 
> off localbus?

The board has a bunch of stuff hanging off of CS5 -- an RTC, a 7 segment
display, an EEPROM, some BCSR-like registers, and of course the two
UARTs which are supposed to be 16C2550.  According to TFM, an EPM7128
PLD is responsible for mashing/sub-decoding this all onto/off of CS5.
CS3 and CS4 are the LB-SDRAM.

>
>> I'd quickly spun together a u-boot 1.2.0 for testing this -- since that 
>> was
>> the quickest route to getting a powerpc capable version.  I'll see what
>> can be done for getting a u-boot 1.3.1 patchset out so the 
>> local-mac-address
>> vs address thing in the dtb isn't an issue.
>
> Probably should add a boot wrapper to work with old non-device tree aware 
> u-boots.

Something to consider, sure -- but I figured working towards a more up
to date u-boot is something people would see more of a future for and
more of an interest in.

Paul.
