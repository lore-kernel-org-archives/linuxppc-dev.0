Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A6B5DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 22:39:11 +1100 (EST)
Received: from [206.223.20.150] (helo=hp-dhlii.dlasys.net)
	by mx.dlasys.net with esmtp (Exim 4.67 #1 (Debian))
	id 1IvtEA-0002Wc-AE
	for <linuxppc-embedded@ozlabs.org>; Sat, 24 Nov 2007 06:31:14 -0500
Message-ID: <47480CF0.7090105@dlasys.net>
Date: Sat, 24 Nov 2007 06:37:20 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Xilinx devicetrees
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    I am following developments regarding device trees for xilinx boards
both here and on the microblaze list.

    I am trying to get a grasp on what they will really do for me and
what using them will demand.

    Please correct any misperceptions:

     As I understand it devicetrees are basically just a tree structured
binary  database describing the hardware.
    They have some heritage in OpenFirmware.
    There are tools to convert  some human readable representations into
the binary form.
    There appear to be tools to take xilinx firmware projects and create
a devicetree database from it
    A BSP using devicetree's configures its hardware, drivers etc, by
querying the devicetree database.  
    It it possible to pass the device tree database independent of the
kernel itself some what similar to the way many bootloaders pass initrd
filesystems.
   
    So in the end I write a BSP that could support a wide variety of
hardware and compile a single kernel that could be passed different
devicetree databases representing different xilinx firmware, and still
hope to work.
    But in return for making the BSP more generic (sort of), I now have
to somehow get the correct devicetree database passed for each different
firmware set that I load.

    I am having some difficulty grasping the significant advantages to
this.
    If the firmware for a given target is not fairly static - and I load
different firmware depending on what I am doing all the time, then I
know have to manage both a bit file for the firmware, and a devicetree
file describing it to the kernel.
    Currently for base hardware we maintain as much design consistancy
as possible accross all our different cards/firmware.
    particular hardware/firmware blocks/IP's may or may not be present -
but if present they are always the same - the Same Uartlite at the same
location, on the same irq, same for PIC's, TEMAC's ...
    For the most part it makes the most sense for us to use code to
detect the presence/absence of specific baseline hardware and then to
load non-base custom drivers after boot.

    What am  missing about devicetrees that would make me more
interested in them ?
      
  




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
