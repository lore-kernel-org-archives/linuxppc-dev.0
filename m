Return-Path: <ptich@hotmail.com>
Received: from hotmail.com (bay102-f21.bay102.hotmail.com [64.4.61.31])
	by ozlabs.org (Postfix) with ESMTP id 26C7167B83
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 19:53:01 +1100 (EST)
Message-ID: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
From: "M Ptich" <ptich@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Booting without Uboot on 8548E
Date: Sat, 04 Nov 2006 08:52:57 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Documentation mentions that the only dependencies between 2.6 Kernel and 
bootloader are:

1. 5 input parameters (bd_t pointer, start and end of command line, start 
and end of ram disk)
2. bd_t pointer and command line must with within 16MB of Kernel
3. Initial TLB1 entry must have IPROT=1

Slowly, we are finding that this list is not complete. For example, address 
calculation at the start of platform_init (r3 + ...) assumes that Kernel has 
been initially loaded at 0-base virtual address.

And now we are stuck with apparently another dependency: our Kernel fails to 
advance beyond time calibration because jiffies are not getting incremented, 
so we are not getting timer interrupts. Is it true that Kernel relies on 
EPIC timer set in Uboot ? If not - where the timer insterrupts are 
configured ?

_________________________________________________________________
Try the next generation of search with Windows Live Search today!  
http://imagine-windowslive.com/minisites/searchlaunch/?locale=en-us&source=hmtagline
