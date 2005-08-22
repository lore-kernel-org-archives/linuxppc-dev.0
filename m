Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id B5B1767FBD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 12:56:44 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Wolfgang Denk'" <wd@denx.de>
Date: Mon, 22 Aug 2005 10:56:14 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050821205851.66E52353D18@atlas.denx.de>
Message-Id: <20050822025644.B5B1767FBD@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Very Thanks for your reply.
I am sorry that this data is copied from Building Embedded Linux Systems
book.
Actually, the range of my flash is from 0xFF000000 to 0xFFFFFFFF. My
starting address of Kernel is 0xFF000000, and the starting address of
ramdisk image is FF200000, so the partitions is as following:
0xFF000000 - 0xFF1FFFFF		Kernel
0xFF200000 - 0xFF9FFFFF		RamDisk Image ( also my Root File System )

And I found my RootFS image is so big that waste many time while write it to
flash.
I hope I can use MTD to distribute it into two parts, Simple RootFS and
libraries, but I don't know how to implement it?

My CPU is MPC8241, and my kernel configure is base on Sandpoint_defconfig.

Thanks,
Johnson Cheng  

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Wolfgang Denk
Sent: Monday, August 22, 2005 4:59 AM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 

In message <20050821080936.DA55167F92@ozlabs.org> you wrote:
> 
> Just as I know, we can have many partitions for our flash if we turn on
MTD
> in Kernel. For example:

Right.

> How could I distribute my RootFS into initrd1 and initrd2?

You cannot. The *root* filesystem is always just a single file system.

You can mount  additional  file  systems  on  top  of  the  directory
hierarchy  provided  by  your root file system, but this is something
completely different.

> In U-Boot command, bootcmd, I set it to "bootm 40000 100000". 40000 is
> Kernel address, and 100000 is RootFS1 address. But where to set RootRS2
> address?

There are several errors in this text.

First, the kernel download address 0x40000 = 256kB is  much  too  low
and can never work.

Second, the "100000" parameter is not a "RootFS1 address". It  is  the
start  address  of  a ramdisk image. This may or may not be your root
file system, and it is usually NOT the address as seen by the kernel.
And, 100000 = 1 MB is a much too low address and can never work.


And finally: all this has absolutely NOTHING to do with MTD partitions.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Documentation is like sex: when it is good, it is  very,  very  good;
and when it is bad, it is better than nothing.         - Dick Brandon
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
