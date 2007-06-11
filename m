Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 6E3CADDEFF
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 17:09:17 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <466622FA.7030200@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <71e5ae7f85657e4ab5bfbc809cab9c60@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 00/18] PS3 patches for 2.6.23
Date: Mon, 11 Jun 2007 02:08:58 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Jun 6 12:59:06 EST 2007, Geoff Levand wrote:
> Here is a series I have for 2.6.23.
>
> Patches 1-8 are more or less independent of each other.
> Patches 9-18 are a dependent series of my system bus
> rework patches.

I'm repling to the summary but will pull a few points from the series.

The dependent series is currently split per file.   While this makes it 
easier to see what a given area looks like after all the patches, it 
means that the kernel compile will break during the series.  Breaking 
git bisect is frowned upon, so it will need to be re-split for merge.  
(Or disable the ps3 system bus during the merge of the series).

> [09/18] PS3: System-bus rework
> [10/18] PS3: System-bus uevent
> [11/18] PS3: System-bus modinfo attribute

If you define a module device table and add it to 
scripts/bin/file2alias.c you would not need to create the MOD_ALIAS_xxx 
driver defines.

Should your module alias and matching include the device_type?

Rather than setting core.owner = THIS_MODULE, take the 
pci_driver_register approach where __pci_driver_register takes the 
module name and owner id as arguments that are automatically passed by 
a macro.

> [12/18] PS3: Repository probe cleanups
> [13/18] PS3: USB system-bus rework
> [14/18] PS3: vuart rework

This changes vuart_device->core from struct_device to ps3 system 
device, but doesn't update the drivers.

> [15/18] PS3: sys-manager re-work
> [16/18] PS3: Rework AV settings driver

There are several dev_debug() that still use vuart_device.core not 
.core.core.
Maybe vuart_device.core should be renamed?

The probe routine assigns to the global ps3av without checking if its 
already set.  If a second device caused probe to be called the 
references to the first one would be lost.

> [17/18] PS3: frame buffer system-bus rework
> [18/18] PS3: Device registration routines.

ps3_start_probe_thread should add at least the bus_type to the thread 
name (the thread name is a sprintf va_list format arg; you don't need 
to create a temporary string buffer).

milton
