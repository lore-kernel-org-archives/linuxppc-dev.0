Return-Path: <bsilverman@conceptxdesign.com>
Received: from smtprelay.hostedemail.com (smtprelay0191.hostedemail.com
	[216.40.44.191]) by ozlabs.org (Postfix) with ESMTP id E48DEDDE46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Feb 2008 04:28:28 +1100 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id A9883B43DD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Feb 2008 16:32:01 +0000 (UTC)
Received: from emd2-omf01.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay03.hostedemail.com (Postfix) with ESMTP id 36E568BD1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Feb 2008 16:26:55 +0000 (UTC)
Received: from [192.168.1.37] (pool-71-248-24-233.bltmmd.east.verizon.net
	[71.248.24.233])
	(Authenticated sender: bsilverman@conceptxdesign.com)
	by emd2-omf01.hostedemail.com (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Feb 2008 16:26:55 +0000 (UTC)
Message-ID: <47C43DC8.2030104@conceptxdesign.com>
Date: Tue, 26 Feb 2008 11:26:48 -0500
From: Brian Silverman <bsilverman@conceptxdesign.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MMC over SPI on Virtex-4
Content-Type: multipart/alternative;
	boundary="------------090903070702070901020403"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090903070702070901020403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I'm attempting to get MMC over xilinx_spi working on a custom Xilinx 
Virtex-4 board (that has a working SD/SPI interface, tested with a 
standalone app).

I'm having issues mounting the device, and after doing a bit of 
debugging, I'm confused about how things are supposed to work.  I'm 
using 2.6.24-rc8-xlnx from git.xilinx.com, with some patches (for the 
uartlite (Grant Likely), and other minor things).  In addition, I'm 
using some of a patch from Andrei Konovalov ( 
<list?person=202&id=11577>http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11577) 
for Xilinx SPI support in virtex_devices.c (BTW, will this patch hit the 
main git.xilinx.com tree at some point?)

Here's what I do, and what I see:
- Create a block device: "mknod /dev/m0 b 179 0"
- Access that device ("cat /dev/m0")
- I see the calls into the kernel:
    blkdev_open()
       do_open()
          get_gendisk()
             kobj_lookup(bdev_map, ...)
- The device is not found (bdev_map has been initialized, but the only 
"probe" at major 179 is base_probe().
- kobj_lookup() returns NULL, and the open returns ENXIO (No such device 
or address).

Here's what I don't understand:  In order for kobj_lookup to 
successfully return non-NULL, a "probe" has to have been added to 
bdev_map using kobj_map().  But, kobj_map(bdev_map,...) is called only 
by blk_register_region(), which is never called by the MMC driver.

I'm clearly missing something here.  Has anyone successfully used MMC 
over SPI or xilinx_spi?  How is the MMC driver supposed to work in 
regards to opening a device?

Also, for reference:

I've added the following configs:
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_XILINX=y

CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_BOUNCE=y
CONFIG_MMC_SPI=y

And, /proc/devices does report the mmc device:

# cat /proc/devices
Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
128 ptm
136 pts
204 ttyUL

Block devices:
  1 ramdisk
179 mmc


-- 
Brian Silverman
Concept X, LLC


--------------090903070702070901020403
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello all,<br>
<br>
I'm attempting to get MMC over xilinx_spi working on a custom Xilinx
Virtex-4 board (that has a working SD/SPI interface, tested with a
standalone app).<br>
<br>
I'm having issues mounting the device, and after doing a bit of
debugging, I'm confused about how things are supposed to work.&nbsp; I'm
using 2.6.24-rc8-xlnx from git.xilinx.com, with some patches (for the
uartlite (Grant Likely), and other minor things).&nbsp; In addition, I'm
using some of a patch from <a href="list?person=202&amp;id=11577">Andrei
Konovalov (</a><a class="moz-txt-link-freetext" href="http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11577">http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11577</a>)
for Xilinx SPI support in virtex_devices.c (BTW, will this patch hit
the main git.xilinx.com tree at some point?)<br>
<br>
Here's what I do, and what I see:<br>
- Create a block device: "mknod /dev/m0 b 179 0"<br>
- Access that device ("cat /dev/m0")<br>
- I see the calls into the kernel:<br>
&nbsp;&nbsp;&nbsp; blkdev_open()<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; do_open()<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; get_gendisk()<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; kobj_lookup(bdev_map, ...)<br>
- The device is not found (bdev_map has been initialized, but the only
"probe" at major 179 is base_probe().<br>
- kobj_lookup() returns NULL, and the open returns ENXIO (No such
device or address).<br>
<br>
Here's what I don't understand:&nbsp; In order for kobj_lookup to
successfully return non-NULL, a "probe" has to have been added to
bdev_map using kobj_map().&nbsp; But, kobj_map(bdev_map,...) is called only
by blk_register_region(), which is never called by the MMC driver.<br>
<br>
I'm clearly missing something here.&nbsp; Has anyone successfully used MMC
over SPI or xilinx_spi?&nbsp; How is the MMC driver supposed to work in
regards to opening a device?<br>
<br>
Also, for reference:<br>
<br>
I've added the following configs:<br>
CONFIG_SPI=y<br>
CONFIG_SPI_DEBUG=y<br>
CONFIG_SPI_MASTER=y<br>
CONFIG_SPI_BITBANG=y<br>
CONFIG_SPI_XILINX=y<br>
<br>
CONFIG_MMC=y<br>
CONFIG_MMC_BLOCK=y<br>
CONFIG_MMC_BLOCK_BOUNCE=y<br>
CONFIG_MMC_SPI=y<br>
<br>
And, /proc/devices does report the mmc device:<br>
<br>
# cat /proc/devices<br>
Character devices:<br>
&nbsp; 1 mem<br>
&nbsp; 4 /dev/vc/0<br>
&nbsp; 4 tty<br>
&nbsp; 5 /dev/tty<br>
&nbsp; 5 /dev/console<br>
&nbsp; 5 /dev/ptmx<br>
&nbsp; 7 vcs<br>
&nbsp;10 misc<br>
&nbsp;13 input<br>
128 ptm<br>
136 pts<br>
204 ttyUL<br>
<br>
Block devices:<br>
&nbsp; 1 ramdisk<br>
179 mmc<br>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Brian Silverman
Concept X, LLC
</pre>
</body>
</html>

--------------090903070702070901020403--
