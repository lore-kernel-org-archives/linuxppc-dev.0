Return-Path: <imrek@atomki.hu>
Received: from imrek.org (strawberry.diszk.unideb.hu [193.6.143.139])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BDFBDDE35
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Feb 2007 01:50:49 +1100 (EST)
Date: Fri, 9 Feb 2007 15:57:15 +0100 (CET)
From: jozsef imrek <imrek@atomki.hu>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Speed of plb_temac 3.00 on ML403
In-Reply-To: <BAY110-F38826CD4A177B058C34CFFB29C0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0702091527440.32063@imrek.org>
References: <BAY110-F38826CD4A177B058C34CFFB29C0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: rick.moleres@xilinx.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 9 Feb 2007, Ming Liu wrote:

> Now with my system(plb_temac and hard_temac v3.00 with all features enabled 
> to improve the performance, Linux 2.6.10, 300Mhz ppc, netperf), I can achieve 
> AT MOST 213.8Mbps for TCP TX and 277.4Mbps for TCP RX, when jumbo-frame is 
> enabled as 8500. For UDP it is 350Mbps for TX, also 8500 jumbo-frame is 
> enabled. 
> So it looks that my results are still much less than yours from 
> Xilinx(550Mbps TCP TX). So I am trying to find the bottleneck and improve the 
> performance.


when testing network performance you might want to use the packet
generator included in the 2.6 linux kernel (in menuconfig go to
Networking -> Networking options -> Network testing -> Packet Generator).

with this tool you can bypass the ip stack, user space/kernel space 
barrier, etc, and measure the speed of the hardware itself using UDP-like
packets.

using pktgen i have seen data rates close to gigabit. (the hardware i'm 
working with is a memec minimodule with V4FX12. i'm using plb_temac with
s/g dma, plb running at 100MHz, and our custom core accessed via IPIF's
address range. sw is linux 2.6.19, xilinx tools are EDK 8.2i)



another hint: when transfering bulk amount of data TCP is probably an
overkill, especially on dedicated intranets and given the reliability
of the network devices available today. just use UDP if you can.


-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------
