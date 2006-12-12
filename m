Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s15.bay0.hotmail.com (bay0-omc2-s15.bay0.hotmail.com
	[65.54.246.151]) by ozlabs.org (Postfix) with ESMTP id 26D27679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 22:20:18 +1100 (EST)
Message-ID: <BAY110-F278D0CB7E79880A1BEC358B2D70@phx.gbl>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C0360F790@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: rick.moleres@xilinx.com
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Tue, 12 Dec 2006 11:08:06 +0000
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
Now I am measuring the performance of my TEMAC on ml403 using netperf. 
However I cannot get a performance as high as yours(550Mbps for TX). My 
data is listed here:

Board --> PC (tx)

# ./netperf -H 192.168.0.3 -C -t TCP_STREAM -- -m 8192 -s 253952 -S 253952
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.0.3 
(192.168.0.3) port 0 AF_INET
Recv   Send    Send                          Utilization       Service 
Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   
remote
bytes  bytes   bytes    secs.    10^6bits/s  % U      % S      us/KB   
us/KB

262142 206848   8192    10.00        64.51   -1.00    2.59     -1.000  
6.587

PC --> board (rx)

linux:/home/mingliu/netperf-2.4.1 # netperf -H 192.168.0.5 -C -t TCP_STREAM 
-- -m 14400 -s 253952 -S 253952
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.0.5 
(192.168.0.5) port 0 AF_INET
Recv   Send    Send                          Utilization       Service 
Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   
remote
bytes  bytes   bytes    secs.    10^6bits/s  % U      % U      us/KB   
us/KB

206848 262142  14400    10.02       169.09   -1.00    -1.00    -1.000  
-0.484

I think this performance is much slower than what you have described. So 
what's the problem? I am using the old cores of TEMAC(plb_temac 2.00.a and 
hard_temac 1.00.a and DMA type is 3, Tx and Rx FIFO lengths are both 
131072, large enough?). My linux is 2.6.16 from the general kernel with the 
temac driver patched. The driver is from the patch 
http://source.mvista.com/~ank/paulus-powerpc/20060309/. Is this bad 
performance because of the old cores, or the driver? Or Montavista Linux is 
RTOS and it should have a much better performance like this? You must be 
more experienced on the performance issue and your suggestion will be 
extreamly useful for me. 

Anxious for your suggestion and explanation. 

Regards
Ming

>From: "Rick Moleres" <rick.moleres@xilinx.com>
>To: "Michael Galassi" <mgalassi@c-cor.com>,"Thomas Denzinger" 
<t.denzinger@lesametric.de>
>CC: linuxppc-embedded@ozlabs.org
>Subject: RE: Speed of plb_temac 3.00 on ML403 
>Date: Tue, 5 Dec 2006 12:08:58 -0700
>
>
>Thomas,
>
>Yes, Michael points out the hardware parameters that are needed to
>enable SGDMA along with DRE (to allow unaligned packets) and checksum
>offload. It also helps the queuing if the FIFOs in the hardware (Tx/Rx
>and IPIF) are deep to handle fast frame rates.  And finally, better
>performance if jumbo frames are enabled. Once SGDMA is tuned (e.g.,
>number of buffer descriptors, interrupt coalescing) and set up, the PPC
>is not involved in the data transfers - only in the setup and interrupt
>handling.
>
>With a 300Mhz system we saw about 730Mbps Tx with TCP on 2.4.20
>(MontaVista Linux) and about 550Mbps Tx with TCP on 2.6.10 (MontaVista
>again) - using netperf w/ TCP_SENDFILE option. We didn't investigate the
>difference between 2.4 and 2.6.
>
>-Rick
>
>-----Original Message-----
>From: linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org
>[mailto:linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org] On
>Behalf Of Michael Galassi
>Sent: Tuesday, December 05, 2006 11:42 AM
>To: Thomas Denzinger
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Speed of plb_temac 3.00 on ML403
>
> >My question is now: Has anybody deeper knowledge how ethernet and sgDMA
> >works? How deep is the PPC involved in the data transfer? Or does the
> >Temac-core handle the datatransfer to DDR-memory autonomous?
>
>Thomas,
>
>If you cut & pasted directly from my design you may be running without
>DMA, which in turn implies running without checksum offload and DRE.
>The plb_temac shrinks to about half it's size this way, but if you're
>performance bound you probably want to turn DMA back on in your mhs
>file:
>
>  PARAMETER C_DMA_TYPE = 3
>  PARAMETER C_INCLUDE_RX_CSUM = 1
>  PARAMETER C_INCLUDE_TX_CSUM = 1
>  PARAMETER C_RX_DRE_TYPE = 1
>  PARAMETER C_TX_DRE_TYPE = 1
>  PARAMETER C_RXFIFO_DEPTH = 32768
>
>You'll have to regenerate the xparameters file too if you make these
>changes (in xps: Software -> Generate Libraries and BSPs).
>
>There may also be issues with the IP stack in the 2.4 linux kernels.
>If you have the option, an experiment with at 2.6 stack would be
>ammusing.
>
>-michael
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
