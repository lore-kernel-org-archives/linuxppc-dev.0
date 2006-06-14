Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C9F3A67B6A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 09:02:14 +1000 (EST)
To: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board,
	linux ke rnel 2.4.20
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 14 Jun 2006 16:48:16 CDT."
	<162B449665D6D643AD9E1D50FC6F4B1403F16E83@mdcexc05.na.ops.local>
Date: Thu, 15 Jun 2006 01:02:08 +0200
Sender: wd@denx.de
Message-Id: <20060614230208.B7035353C1B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <162B449665D6D643AD9E1D50FC6F4B1403F16E83@mdcexc05.na.ops.local> you wrote:
...
> I am using the kernel build using the ELDK 3.1.1 tools and a file system
> which was build using Montavista tools (DevRocket 1.1). Is that a problem???

Don't know. Why don't you try either the ramdisk  image  or  the  NFS
root file system that comes included with the ELDK? Both are known to
work fine, and testing should take less than 5 minutes.

> Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2
> ip=192.168.0.7:192.
...

How did you create the root file system image, and how did you  write
it to flash?

> devfs_register(ttyS): could not append to parent, err: -17
> devfs_register(ttyS): could not append to parent, err: -17
> devfs_register(cua): could not append to parent, err: -17
> devfs_register(cua): could not append to parent, err: -17

This doesn't look so good to me. I recommend to disable devfs in your
kernel configuration.

...

Eventually the kernel does not find the needed  /dev/  entries.  Make
sure what your root filesystem expects. Does it really use devfs?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Wagner's music is better than it sounds."               - Mark Twain
