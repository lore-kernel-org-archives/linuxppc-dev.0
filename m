Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7F1F3DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:22:28 +1000 (EST)
Message-ID: <466EE45A.4050104@am.sony.com>
Date: Tue, 12 Jun 2007 11:22:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 00/18] PS3 patches for 2.6.23
References: <71e5ae7f85657e4ab5bfbc809cab9c60@bga.com>
In-Reply-To: <71e5ae7f85657e4ab5bfbc809cab9c60@bga.com>
Content-Type: text/plain; charset=UTF-8
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

Milton Miller wrote:
> On Wed Jun 6 12:59:06 EST 2007, Geoff Levand wrote:
>> Here is a series I have for 2.6.23.
>>
>> Patches 1-8 are more or less independent of each other.
>> Patches 9-18 are a dependent series of my system bus
>> rework patches.
> 
> I'm repling to the summary but will pull a few points from the series.
> 
> The dependent series is currently split per file.   While this makes it 
> easier to see what a given area looks like after all the patches, it 
> means that the kernel compile will break during the series.  Breaking 
> git bisect is frowned upon, so it will need to be re-split for merge.  
> (Or disable the ps3 system bus during the merge of the series).


Yes, I realize the state of the patches.  I will try to rework them for
the next round.  As the existing PS3 support is incomplete, I don't
think there will be many doing a git-bisect with PS3 support enabled.


>> [09/18] PS3: System-bus rework
>> [10/18] PS3: System-bus uevent
>> [11/18] PS3: System-bus modinfo attribute
> 
> If you define a module device table and add it to 
> scripts/bin/file2alias.c you would not need to create the MOD_ALIAS_xxx 
> driver defines.
> 
> Should your module alias and matching include the device_type?
> 
> Rather than setting core.owner = THIS_MODULE, take the 
> pci_driver_register approach where __pci_driver_register takes the 
> module name and owner id as arguments that are automatically passed by 
> a macro.


I will consider this for 2.6.24.  We don't have time to rework it
now.


>> [12/18] PS3: Repository probe cleanups
>> [13/18] PS3: USB system-bus rework
>> [14/18] PS3: vuart rework
> 
> This changes vuart_device->core from struct_device to ps3 system 
> device, but doesn't update the drivers.


I think this is just the same as your first comment about change
isolation, or is it something else?


>> [15/18] PS3: sys-manager re-work
>> [16/18] PS3: Rework AV settings driver
> 
> There are several dev_debug() that still use vuart_device.core not 
> .core.core.
> Maybe vuart_device.core should be renamed?


I wonder if you are not looking at the definition of
ps3_vuart_port_driver or struct ps3av, but the usage of a
ps3_system_bus_device?

The core of a ps3_system_bus_device is a struct device, and struct
device has no member named core.  vuart devices are instances of
ps3_system_bus_device, and so have no member named .core.core.

Anyway, I would think it would not build properly if an incorrect
type was used.


> The probe routine assigns to the global ps3av without checking if its 
> already set.  If a second device caused probe to be called the 
> references to the first one would be lost.


There is just a single AV setting device, so a second registration would
indicate a code bug.  It won't hurt to add a check and Geert added
that in.


>> [17/18] PS3: frame buffer system-bus rework
>> [18/18] PS3: Device registration routines.
> 
> ps3_start_probe_thread should add at least the bus_type to the thread 
> name (the thread name is a sprintf va_list format arg; you don't need 
> to create a temporary string buffer).


A good idea if we want to run more than one probe in the future.  We
are working on an interrupt driven registration though, and hopefully
that will eliminate this polling thread.


-Geoff
