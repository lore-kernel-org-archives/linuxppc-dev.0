Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc1-s18.bay0.hotmail.com (bay0-omc1-s18.bay0.hotmail.com
	[65.54.246.90]) by ozlabs.org (Postfix) with ESMTP id EEF27DE158
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 19:48:36 +1100 (EST)
Message-ID: <BAY117-F357AAA4A4F722329BBA628C8A10@phx.gbl>
In-Reply-To: <315BEE09-4826-47F5-9E85-D268A4EA3022@kernel.crashing.org>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: mem=XXXM  ioremap DMA 
Date: Sat, 27 Jan 2007 03:48:30 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've seen a couple posts out there about issuing a kernel boot parameter of 
mem=XXXM, say for example mem=504M on a 512 MiB system followed by issuing 
an ioremap function call from a module/driver such as: ioremap( 0x1F800000, 
0x800000 ) where an attempt is made to remap the unclaimed (by the kernel) 
physical memory from 504MiB up to 512MiB.

I've tried this route which looks to make great logical sense and I've tried 
to actually use the remapped range for DMA with no luck.  I've seen posts 
from all the way back in 2003 where folks are doing the same thing and have 
the same bad results... and no replies to the posts.

Can this ram really be used for DMA?

I'm afraid that since I'm using a PCI device (PLX) with device specific 
hardware address decoding on the LOCAL bus side of the PLX, that by taking 
this approach, the kernel comes back with virtual addresses that, after 
being mapped back to bus addresses still won't allow for DMA to work 
properly.   Can anyone give some insight into this?

I'm basically trying the following:
  boot kernel (2.4.xx) with mem=504M

in my driver, I'm calling
my_virt_address =   ioremap( 0x1F800000, 0x800000  );
my_bus_address = virt_to_bus( my_virt_address );

Then, I'm telling my FPGA bus master device (across a PLX chip) that it's 
starting DMA address is my_bus_address.

I get interrupts, but no data in my_virt_address.  I've seen several posts 
exactly like this and have yet to see any answers to these posts...

I've tried an alternative approach of calling one of the alloc_bootmem_xxx 
functions early in start_kernel and have had positivie results ONLY on the 
montavista 3.1 pro kernel with preemption enabled.  On the Denx 2.4.25 
Kernel from ELDK 3.1 I just get a locked up/frozen kernel when I trie to use 
the alloc_bootmem_xx approach and when I use the mem=504M / ioremap 
approach, I don't get any DMA data from either kernel...

Please help!!
Thanks,
Eric

_________________________________________________________________
FREE online classifieds from Windows Live Expo – buy and sell with people 
you know 
http://clk.atdmt.com/MSN/go/msnnkwex0010000001msn/direct/01/?href=http://expo.live.com?s_cid=Hotmail_tagline_12/06
