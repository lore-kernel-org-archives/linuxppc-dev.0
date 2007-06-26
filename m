Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s7.bay0.hotmail.com (bay0-omc1-s7.bay0.hotmail.com
	[65.54.246.79]) by ozlabs.org (Postfix) with ESMTP id 30338DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 17:43:02 +1000 (EST)
Message-ID: <BAY138-F3174C3DDCF11AC45905C1FB20B0@phx.gbl>
In-Reply-To: <e4fee3c50706251242h722c00dbpfc7881aa890a5e1e@mail.gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: greg.crocker@gmail.com, linuxppc-embedded@ozlabs.org
Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
Date: Tue, 26 Jun 2007 07:42:57 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Actually I have asked the xilinx expert on the statistics. With the 
PLB_TEMAC, we can also get a result like that, say 300Mbps for TCP. (From 
their numbers, the throughput is even higher.)

Some remindings from my experience: Remember to enable everything in the 
hardware and software which can improve the performance, such as, 
CS_offloading, data allighment engines, large fifos, and so on, from the 
configuration of PLB_TEMAC in EDK. As well, remember to enable cache. In 
the software field, interrupt_coaleascing will also help. At this time, 
normally we can get more than 100Mbps for TCP. Jumbo-frame of 8982 will 
almost double this number. 

Have fun.

BR
Ming


>From: "Greg Crocker" <greg.crocker@gmail.com>
>To: linuxppc-embedded@ozlabs.org
>Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
>Date: Mon, 25 Jun 2007 15:42:09 -0400
>
>I was able to achieve ~320 Mbit/sec data rate using the Gigabit 
>System
>Reference Design (GSRD XAPP535/536) from Xilinx.  This utilizes the
>LocalLink TEMAC to perform the transfers.  The reference design 
>provides the
>Linux 2.4 drivers that can be ported to Linux 2.6 with a little 
>effort.
>
>This implementation did not use checksum offloading and the data 
>rates were
>achieved using TCP_STREAM on netperf.
>
>Greg


>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
