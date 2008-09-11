Return-Path: <littelld@verizon.net>
Received: from vms044pub.verizon.net (vms044pub.verizon.net [206.46.252.44])
	by ozlabs.org (Postfix) with ESMTP id 6F377DE052
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Sep 2008 11:49:35 +1000 (EST)
Received: from [192.168.1.106] ([96.226.142.190])
	by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0K7000A0FD1W0571@vms044.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Wed, 10 Sep 2008 20:49:08 -0500 (CDT)
Date: Wed, 10 Sep 2008 20:49:08 -0500
From: Dave Littell <littelld@verizon.net>
Subject: Re: initramfs too large?
In-reply-to: <48C7CD29.7040906@coritel.it>
To: linuxppc-embedded@ozlabs.org
Message-id: <48C87914.4000005@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <48C719BB.1050807@verizon.net> <48C76AFF.6090205@coritel.it>
	<48C7BB99.1070902@verizon.net> <48C7CD29.7040906@coritel.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marco Stornelli wrote:
> Hi Dave,
> 
> no if well remeber for 2.6.18 it's "ramdisk_size" (before this option
> had a name slightly different) but you can check it out in the kernel
> documentation (in the documentation folder of your kernel). Another
> thing: you should check out that the kernel, the initram disk and the
> dtb are loaded in ram from your bootloader without overlapping, maybe
> you've changed the dimensions and something is overlapped.
> 

Everything is included in one zImage, so where things are placed in
memory is all a function of the linker, wrapper, and gunzip, right?  I
did try a "ramdisk_size" command-line argument and saw no change in
behavior.

I noticed today that with the smaller initramfs the kernel is smaller
than 8 MB (_end < 0xc0800000), but with the larger initramfs all the
symbols following the end marker for initramfs are beyond 8 MB.  Is this
a clue?

Using the JTAG I stopped at early_init() and looked at the
__machine_desc_start area.  I noticed that when booting with the smaller
initramfs there's (apparently) good information in there but with the
larger initramfs the area is mostly filled with 0xff's.  I'm now
wondering if there's some relationship between this 8 MB boundary and
possibly some problem in the zImage wrapper, the wrapper's gunzip, or
something in that area.

So, is 8 MB some magic number for the PowerPC kernel?


Thanks,
Dave
