Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id EA263DE7BE
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 06:55:56 +1000 (EST)
Message-ID: <48AC84D9.8050809@harris.com>
Date: Wed, 20 Aug 2008 16:55:53 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Strange behavior with I2C on Sequoia board
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just tried enabling I2C on a Sequoia board (kernel is DENX 2.6.26) and
doing that appears to corrupt the u-boot / kernel communications.

Prior to turning on I2C, I see the ethernet mac and kernel command line
correctly passed, but once I turn on I2C, the ethernet mac becomes 0 and the
kernel command line is missing many parameters.  I'll paste in a good log, then
a bad one.  The only configuration difference is that the bad one has
CONFIG_I2C_CHARDEV=y and CONFIG_I2C_IBM_IIC=y in the configuration.

I'll start digging into it, but if anyone has any experience or ideas regarding
I2C on PPC440, I'd appreciate your thoughts on this.

	Steve

Good log:
=========

## Booting kernel from Legacy Image at fd400000 ...
   Image Name:   Linux-2.6.26.1-00033-g088efe4-di
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1801234 Bytes =  1.7 MB
   Load Address: 00400000
   Entry Point:  00400454
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading init Ramdisk from Legacy Image at fd900000 ...
   Image Name:   initramfs
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2442283 Bytes =  2.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fcb8000, end 0ff0c42b ... OK
CPU clock-frequency <- 0x27bc86a4 (667MHz)
CPU timebase-frequency <- 0x27bc86a4 (667MHz)
/plb: clock-frequency <- 9ef21a9 (167MHz)
/plb/opb: clock-frequency <- 4f790d4 (83MHz)
/plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
Memory <- <0x0 0x0 0xffff000> (255MB)
ENET0: local-mac-address <- 00:10:ec:01:04:d0
ENET1: local-mac-address <- 00:10:ec:01:04:d1

zImage starting: loaded at 0x00400000 (sp: 0x0ff0d220)
Allocating 0x3dbc2c bytes for kernel ...
gunzipping (0x00000000 <- 0x0040e000:0x007ed9c8)...done 0x39c1c4 bytes
Using loader supplied ramdisk at 0xfcb8000-0xff0c42b
initrd head: 0x1f8b0808

Linux/PowerPC load: root=/dev/sda3 rw
ip=137.237.178.105:137.237.179.31:137.237.178.1:255.255.255.0:hydra_temp:eth0:off
panic=1 console=ttyS0,115200

Bad log:
========
## Booting kernel from Legacy Image at fd400000 ...
   Image Name:   Linux-2.6.26.1-00034-gf084326-di
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1811651 Bytes =  1.7 MB
   Load Address: 00400000
   Entry Point:  00400454
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading init Ramdisk from Legacy Image at fd900000 ...
   Image Name:   initramfs
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2442283 Bytes =  2.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fcb8000, end 0ff0c42b ... OK
CPU clock-frequency <- 0x27bc86a4 (667MHz)
CPU timebase-frequency <- 0x27bc86a4 (667MHz)
/plb: clock-frequency <- 9ef21a9 (167MHz)
/plb/opb: clock-frequency <- 4f790d4 (83MHz)
/plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
Memory <- <0x0 0x0 0xffff000> (255MB)
ENET0: local-mac-address <- 00:00:00:00:00:00
ENET1: local-mac-address <- 00:00:00:00:00:00

zImage starting: loaded at 0x00400000 (sp: 0x0ff0d220)
Allocating 0x3e1c48 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040e000:0x007f3a24)...done 0x3a21c4 bytes
Using loader supplied ramdisk at 0xfcb8000-0xff0c42b
initrd head: 0x1f8b0808

Linux/PowerPC load: console=ttyS0,115200
