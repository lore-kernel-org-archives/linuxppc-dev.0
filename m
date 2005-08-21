Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id BA22167FAC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 06:59:10 +1000 (EST)
To: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 21 Aug 2005 16:02:26 +0800."
	<20050821080936.DA55167F92@ozlabs.org>
Date: Sun, 21 Aug 2005 22:58:51 +0200
Sender: wd@denx.de
Message-Id: <20050821205851.66E52353D18@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050821080936.DA55167F92@ozlabs.org> you wrote:
> 
> Just as I know, we can have many partitions for our flash if we turn on MTD
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
