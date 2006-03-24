Return-Path: <rsmith@imagemap.com>
Received: from fileserver3.imagemap.com (mail.imagemap.com [68.156.94.66])
	by ozlabs.org (Postfix) with ESMTP id 32C0B679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Mar 2006 00:32:40 +1100 (EST)
Received: from amavis by fileserver3.imagemap.com with scanned-ok (Exim 3.36
	#1 (Debian)) id 1FMmRP-00020L-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 24 Mar 2006 08:34:59 -0500
Received: from fileserver3.imagemap.com ([127.0.0.1])
	by localhost (fileserver3 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07640-02 for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 08:34:43 -0500 (EST)
Received: from [192.168.0.196] (helo=[192.168.0.196])
	by fileserver3.imagemap.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FMmR9-00020B-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 24 Mar 2006 08:34:43 -0500
Message-ID: <4423F502.3060205@imagemap.com>
Date: Fri, 24 Mar 2006 08:32:50 -0500
From: Randy Smith <rsmith@imagemap.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MTD physmap issues trying to map flash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone,

I have been trying to get my flash memory to show up as an mtd device in 
my 2.4.25 kernel and I get the following error:

physmap flash device: 0 at 0
__ioremap(): phys addr 00000000 is RAM lr c000f67c
Failed to ioremap

My hardware is based on the Icecube reference design but uses one 
Spansion S29G128M-R2 16 MByte flash chip at physical address 0xff00000.  
I am using u-boot 1.1.4 and the flash operates correctly in that 
environment (after some tweaking).  I am using a vanilla 2.4.25 linux 
kernel from DENX's ELDK 3.1 and I have tried almost every incantation 
regarding MTD configuration but no joy.

Some questions:

1.  Does 2.4.25 expect the physmap_map structure to be populated by 
u-boot and if so, where should I look in u-boot to make that happen?

2.  I am assuming that this chip is CFI compliant and should show up 
with that probing (and AMD support) enabled.  Does it matter if turn on 
both CFI and JEDEC probes?  Or put another way, why should I have to 
probe if this information is passed by u-boot, if it is?

3.  How does the partitioning (command line) of the chip effect the 
recognition of the chip?

4.  What should I put in the physmap menuconfig line for the physical 
address and size of the chip?  I am using 0xff000000 and 0x01000000.  Is 
this correct and something else is broken?

5.  Is there a patch to the kernel or u-boot that addresses this type of 
failure?


Thanks,

Randy Smith
Software Engineer
ImageMap, Inc.
