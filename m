Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id DD5F3DDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Dec 2008 17:31:56 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LDYto-00086o-1Y
	for linuxppc-embedded@ozlabs.org; Fri, 19 Dec 2008 06:31:49 +0000
Received: from CPE-124-190-96-129.vic.bigpond.net.au ([124.190.96.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Dec 2008 06:31:48 +0000
Received: from daniel_ng11 by CPE-124-190-96-129.vic.bigpond.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Dec 2008 06:31:48 +0000
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Device Tree setup for 8272-based board
Date: Fri, 19 Dec 2008 06:31:41 +0000 (UTC)
Message-ID: <loom.20081219T062005-806@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

We are migrating our PowerPC 8272-based board from 2.6.14 to 2.6.27.

One of the big changes is the need for a Device Tree for bootup.

So far, my bootup looks like the below (using u-boot).

I am just using arch/powerpc/boot/cuboot-824x.c 
and /arch/powerpc/boot/dts/mpc8272ads.dts for now. Therefore, all the settings 
as printed below are wrong ie. Memory, ENET0 mac, CPU clock freq, etc.

When I change the settings in mpc8272ads.dts and do a fresh recompile, the 
settings do not change. However, if I use another cuboot*.c file, I get a 
different set of printed settings eg. 2 ethernet ports instead of 1. This is 
fine, but I don't see where in the cuboot*.c file these settings are 
specified. Can someone suggest where these might be?

Cheers,
Daniel


## Booting image at 00200000 ...
   Image Name:   Linux-2.6.27-mybuild
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1477233 Bytes =  1.4 MB
   Load Address: 00400000
   Entry Point:  00400594
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x4000000> (64MB)
ENET0: local-mac-address <- c0:a8:01:4b:7e:13
CPU clock-frequency <- 0xa175c100 (2709MHz)
CPU timebase-frequency <- 0x4ead9a0 (83MHz)
CPU bus-frequency <- 0x13ab6680 (330MHz)

zImage starting: loaded at 0x00400000 (sp: 0x03f7c9c8)
Allocating 0x316e8c bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0071367c)...done 0x2f41a0 bytes

Linux/PowerPC load:
Finalizing device tree... flat tree at 0x40acd8

(there is no more output after this)
