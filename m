Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s39.bay0.hotmail.com (bay0-omc1-s39.bay0.hotmail.com
	[65.54.246.111]) by ozlabs.org (Postfix) with ESMTP id A2C31DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Feb 2007 01:16:46 +1100 (EST)
Message-ID: <BAY110-F38826CD4A177B058C34CFFB29C0@phx.gbl>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C0360F790@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: rick.moleres@xilinx.com
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Fri, 09 Feb 2007 14:16:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Rick,
Again the problem of TEMAC speed. Hopefully you can give me some suggestion 
on that.

>With a 300Mhz system we saw about 730Mbps Tx with TCP on 2.4.20
>(MontaVista Linux) and about 550Mbps Tx with TCP on 2.6.10 (MontaVista
>again) - using netperf w/ TCP_SENDFILE option. We didn't investigate the
>difference between 2.4 and 2.6.

Now with my system(plb_temac and hard_temac v3.00 with all features enabled 
to improve the performance, Linux 2.6.10, 300Mhz ppc, netperf), I can 
achieve AT MOST 213.8Mbps for TCP TX and 277.4Mbps for TCP RX, when 
jumbo-frame is enabled as 8500. For UDP it is 350Mbps for TX, also 8500 
jumbo-frame is enabled. 

So it looks that my results are still much less than yours from 
Xilinx(550Mbps TCP TX). So I am trying to find the bottleneck and improve 
the performance.

When I use netperf to transfer data, I noticed that the CPU utilization is 
almost 100%. So I suspect that CPU is the bottleneck. However other friends 
said the PLB structure is the bottleneck, because when the CPU is lowered 
to 100Mhz, the performance will not change much, but if the PLB frquency is 
lowered, it will. Then they conclude that with the PLB structure, the CPU 
will wait a long time to load and store data from DDR. So PLB is the 
criminal.

Then come some questions. 1. Is your result from the GSRD structure or just 
the normal PLB_TEMAC? Will the GSRD achieve a better performance than the 
normal PLB_TEMAC? 2. Which on earch is the bottleneck for the network 
performance, CPU or PLB structure? Is that possible for PLB to achieve a 
much higher throughput? 3. Because your result is based on Montavista 
Linux. Is there any difference between MontaVista Linux and the general 
open-source linux kernel which could lead to different performance? 

I know that many persons including me are struggling to improve the 
performance of PLB_TEMAC on ML403. So please give us some hints and 
suggestions with your experience and research. Thanks so much for your 
work.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
