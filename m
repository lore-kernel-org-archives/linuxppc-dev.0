Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f213.google.com (mail-gx0-f213.google.com
	[209.85.217.213]) by ozlabs.org (Postfix) with ESMTP id 088CAB7DA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 01:04:00 +1100 (EST)
Received: by gxk5 with SMTP id 5so83738gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Feb 2010 06:03:58 -0800 (PST)
Date: Fri, 5 Feb 2010 09:03:50 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/4] Add ps3_storage module alias
Message-ID: <20100205140350.GL12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205134235.GG12001@hansolo.jdub.homelinux.org>
	<alpine.LRH.2.00.1002051446280.5981@mink.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1002051446280.5981@mink.sonytel.be>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 05, 2010 at 02:49:14PM +0100, Geert Uytterhoeven wrote:
>On Fri, 5 Feb 2010, Josh Boyer wrote:
>> This allows the upgrade path from older kernel releases to work
>> with the Fedora mkinitrd tool.
>> 
>> ---
>> 
>> --- linux-2.6.22.ppc64/drivers/block/ps3disk.c~	2007-07-25 16:06:16.000000000 +0100
>> +++ linux-2.6.22.ppc64/drivers/block/ps3disk.c	2007-07-26 08:49:44.000000000 +0100
>> @@ -628,3 +628,4 @@ MODULE_LICENSE("GPL");
>>  MODULE_DESCRIPTION("PS3 Disk Storage Driver");
>>  MODULE_AUTHOR("Sony Corporation");
>>  MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_DISK);
>> +MODULE_ALIAS("ps3_storage");
>
>NAKed-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>
>ps3_storage was replaced by 3 drivers: ps3disk, ps3rom, and ps3flash. These are
>automatically loaded by udev.
>
>How does mkinitrd determine the driver for the root file system on other
>systems? Does it really contain a big list of e.g. all SCSI drivers?

At one time I believe it did have a list of "odd" drivers to explicitly
include.  Anaconda didn't (doesn't?) use udev to determine which drivers
to include in the initrd since the install image is most likely not composed
on a machine that includes those drivers.  If the install initrd didn't have
the drivers loaded, it wouldn't install on PS3.

This is highlighted as a Fedora local change, probably for the reasons you
state.  We might have already moved past the point where this is needed,
so I'm fine with it being NAKed.  I'll probably just drop it from the Fedora
kernel builds.

josh
