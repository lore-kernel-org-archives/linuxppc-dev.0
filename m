Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc15.comcast.net (unknown [63.240.77.85])
	by ozlabs.org (Postfix) with ESMTP id C83E0679FB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 01:53:00 +1000 (EST)
Message-ID: <44D36D4B.90001@dlasys.net>
Date: Fri, 04 Aug 2006 11:52:43 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: "Ned W. Rhodes" <ned@softwaresystemsgroup.com>,  jonandia@aotek.es
Subject: Re: MTD Flash Howto ?
References: <001a01c6b7d1$17dd6130$6201eed0@ssgpoweredge>
In-Reply-To: <001a01c6b7d1$17dd6130$6201eed0@ssgpoweredge>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Thanks;

          I looked at the Denx stuff that was a good start. But raised
some questions:

          I have a single device. I presume that means it is 8 bits
wide, and constitutes a single Bank.
          I guess I have to query the Hardware people, on that.
          What exactly drives CONFIG_MTD_I? and CONFIG_MTD_B?

          A hard disk partition is usually reflected by data structures
(a partition table) written to the Disk.
          Am I correct in assuming that these are in drivers/mtd/maps.
          In my instance all the flash belongs to a single file system
There is a single reserved block at the begining,
          but it is reflected in the filesystem structure not the
partitioning.

          So as I understand things I have a single partition.
          When I ran menuconfig, I indicated that I did not need/had a
single partitions - would that be the correct choice ?

          There is a platform ram "map" that seems to allow defining the
flash region in a platform data structure - is that a viable alternative
to a machine specific map file ?
          Is it limited to just RAM.
         
          Prior to loading a filesystem driver shouldn;'t I get some
message indicating that mtd detected my specific type of flash ? or Is
that queriable inside /proc ?




Ned W. Rhodes wrote:
> The book Building Embedded Linux Systems has a good section on the use of
> flash file systems.
>
> When you boot, you will see something like this, depending on the type of
> flash driver you have. Make sure you have defined your mtd map in
> kernel/drivers/mtd/map.
>
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> JFS: nTxBlock = 965, nTxLock = 7720
>
> Then if you have the MTD partitions correctly identified, the kernel will
> show you something like:
>
> CBG flash bank 0: Found 1 x16 devices at 0x0 in 16-bit bank
>  Intel/Sharp Extended Query Table at 0x0031
> Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled
> Creating 2 MTD partitions on "CBG flash bank 0":
> 0x00000000-0x01800000 : "ffw1"
> 0x01800000-0x02000000 : "filesystem1"
>
> Once booted you can look at /proc/mtd and you should see the partitions
> something like:
>
> [root@lbg ]# cat /proc/mtd
> dev:    size   erasesize  name
> mtd0: 01800000 00020000 "ffw1"
> mtd1: 00800000 00020000 "filesystem1"
>
> Your mileage may vary depending on the type of flash you have and all the
> configuration options, but that is basically how to tell that things are
> mapped and ready for use.
>
> Ned W. Rhodes
> Software System Group
> 703.812.5072 x100
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
