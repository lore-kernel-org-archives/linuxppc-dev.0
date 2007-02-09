Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AA36BDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Feb 2007 06:14:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Fri, 9 Feb 2007 09:00:37 -0700
In-Reply-To: <BAY110-F38826CD4A177B058C34CFFB29C0@phx.gbl>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Ming Liu" <eemingliu@hotmail.com>
Message-Id: <20070209160123.BFF2BA30080@mail83-dub.bigfish.com>
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

Ming,

Here's a quick summary of the systems we used:

Operating system:	MontaVista Linux 40
Benchmark tool:		NetPerf / NetServer
Kernel:			Linux ml403 2.6.10_mvl401-ml40x

IP Core:
Name & version: 		PLB TEMAC 3.00A
Operation Mode:		SGDMA mode
TX/RX DRE:		Yes / Yes
TX/RX CSUM offload:	Yes / Yes
TX Data FIFO depth:	131072 bits (i.e. 16K bytes)
RX Data FIFO depth:	131072 bits (i.e. 16K bytes)

Xilinx Platform Hardware:
Board:			ML403 / Virtex4 FX12
Processor:		PPC405 @ 300MHz
Memory type:		DDR
Memory burst:		Yes

PC-side Test Hardware:
Processor:		Intel(R) Pentium(R) 4 CPU 3.20GHz
OS:			Ubuntu Linux 6.06 LTS, kernel 2.6.15-26-386
Network adapters used:	D-LinkDL2000-based Gigabit Ethernet (rev 0c)


- Are Checksum offload, SGDMA, and DRE enabled in the plb_temac?
- Are you using the TCP_SENDFILE option of netperf?  Your UDP numbers =
are similar already to what we saw in Linux 2.6, and your TCP numbers =
are similar to what we saw *without* the sendfile option.

I don't believe the PLB is the bottleneck here.  We had similar =
platforms running with Treck and have achieved over 800Mbps TCP rates =
(Tx and Rx) over the PLB.

To answer your questions:
1. Results are from PLB_TEMAC, not GSRD.  You would likely see similar =
throughput rates with GSRD and Linux.
2. Assuming you have everything tuned for SGDMA based on previous =
emails, I would suspect the bottleneck is the 300MHz CPU *when* running =
Linux.  In Linux 2.6 we've not spent any time trying to tune the =
TCP/Ethernet parameters on the target board or the host, so there could =
be some optimizations that can be done at that level.  In the exact same =
system we can achieve over 800Mbps using the Treck TCP/IP stack, and =
with VxWorks it was over 600Mbps.  I'm not a Linux expert, so I don't =
know what's tunable for network performance, and there is a possibility =
the driver could be optimized as well.

Thanks,
-Rick

-----Original Message-----
From: Ming Liu [mailto:eemingliu@hotmail.com]=20
Sent: Friday, February 09, 2007 7:17 AM
To: Rick Moleres
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Speed of plb_temac 3.00 on ML403

Dear Rick,
Again the problem of TEMAC speed. Hopefully you can give me some =
suggestion=20
on that.

>With a 300Mhz system we saw about 730Mbps Tx with TCP on 2.4.20
>(MontaVista Linux) and about 550Mbps Tx with TCP on 2.6.10 (MontaVista
>again) - using netperf w/ TCP_SENDFILE option. We didn't investigate =
the
>difference between 2.4 and 2.6.

Now with my system(plb_temac and hard_temac v3.00 with all features =
enabled=20
to improve the performance, Linux 2.6.10, 300Mhz ppc, netperf), I can=20
achieve AT MOST 213.8Mbps for TCP TX and 277.4Mbps for TCP RX, when=20
jumbo-frame is enabled as 8500. For UDP it is 350Mbps for TX, also 8500=20
jumbo-frame is enabled.=20

So it looks that my results are still much less than yours from=20
Xilinx(550Mbps TCP TX). So I am trying to find the bottleneck and =
improve=20
the performance.

When I use netperf to transfer data, I noticed that the CPU utilization =
is=20
almost 100%. So I suspect that CPU is the bottleneck. However other =
friends=20
said the PLB structure is the bottleneck, because when the CPU is =
lowered=20
to 100Mhz, the performance will not change much, but if the PLB frquency =
is=20
lowered, it will. Then they conclude that with the PLB structure, the =
CPU=20
will wait a long time to load and store data from DDR. So PLB is the=20
criminal.

Then come some questions. 1. Is your result from the GSRD structure or =
just=20
the normal PLB_TEMAC? Will the GSRD achieve a better performance than =
the=20
normal PLB_TEMAC? 2. Which on earch is the bottleneck for the network=20
performance, CPU or PLB structure? Is that possible for PLB to achieve a =

much higher throughput? 3. Because your result is based on Montavista=20
Linux. Is there any difference between MontaVista Linux and the general=20
open-source linux kernel which could lead to different performance?=20

I know that many persons including me are struggling to improve the=20
performance of PLB_TEMAC on ML403. So please give us some hints and=20
suggestions with your experience and research. Thanks so much for your=20
work.

BR
Ming

_________________________________________________________________
=D3=EB=C1=AA=BB=FA=B5=C4=C5=F3=D3=D1=BD=F8=D0=D0=BD=BB=C1=F7=A3=AC=C7=EB=CA=
=B9=D3=C3 MSN Messenger:  http://messenger.msn.com/cn =20
