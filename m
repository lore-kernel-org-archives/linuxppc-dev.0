Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03F58DDD0E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:04:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KE44JR005925
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 09:04:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KE4429487020
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:04:04 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KE440N009258
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:04:04 -0700
Subject: Re: [0/14] Ebony support, 2nd spin
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070220020837.GF17818@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 08:05:07 -0600
Message-Id: <1171980307.24204.66.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 13:08 +1100, David Gibson wrote:

> 	- The early serial hacks no longer use an entire 64-bit
> 	  constant, so should work on non-64-bit aware assemblers

Yes, this compiles now with my toolchain.  However, I get no output
after this:

Linux/PowerPC load:                                                             
Finalizing device tree... flat tree at 0x408568                                 
id mach(): done                                                                 
MMU:enter                                                                       
MMU:hw init                                                                     
MMU:mapin                                                                       
MMU:setio                                                                       
MMU:exit                                                                        
[    0.000000] Using Ebony machine description                                  
[    0.000000] Linux version 2.6.20-gc9ce2283-dirty (jwboyer@zod.rchland.ibm.co7
setup_arch: bootmem                                                             
arch: exit                                                                      
[    0.000000] Zone PFN ranges:                                                 
[    0.000000]   DMA             0 ->    32768                                  
[    0.000000]   Normal      32768 ->    32768                                  
[    0.000000] early_node_map[1] active PFN ranges                              
[    0.000000]     0:        0 ->    32768                                      
[    0.000000] Built 1 zonelists.  Total pages: 32512                           
[    0.000000] Kernel command line: ip=on                                       
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0                                
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0                                
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)               

Which probably has something to do with the of_serial driver being used
now.  Just an FYI.

josh
