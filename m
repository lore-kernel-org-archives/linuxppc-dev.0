Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 714F567B6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 11:11:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Tue, 12 Dec 2006 17:11:35 -0700
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C036F1C1B@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Ming Liu" <eemingliu@hotmail.com>
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

The numbers I quoted were using the TCP_SENDFILE option of netperf, and =
also using the plb_temac_v3 core, which has checksum offload and some =
other features that help performance.  Given the core you're using, your =
RX numbers are probably about right (assuming you're not using jumbo =
frames).  Your transmit number looks low, though.  Perhaps you can try =
tuning the packet threshold (e.g., less interrupts - try 8 instead of 1) =
and the waitbound (use 1) in adapter.c.  Also, how many buffer =
descriptors are being allocated in adapter.c?

I doubt MV Linux has anything to do with it, I would say it's a =
combination of using the later core and its features (checksum offload, =
DRE, jumbo frames) along with netperf's SENDFILE feature, and the =
adapter/driver that takes advantage of both.  Plus tuning the interrupt =
coalescing (threshold, waitbound) typically helps.

-Rick

-----Original Message-----
From: Ming Liu [mailto:eemingliu@hotmail.com]=20
Sent: Tuesday, December 12, 2006 4:08 AM
To: Rick Moleres
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Speed of plb_temac 3.00 on ML403

Dear Rick,
Now I am measuring the performance of my TEMAC on ml403 using netperf.=20
However I cannot get a performance as high as yours(550Mbps for TX). My=20
data is listed here:

Board --> PC (tx)

# ./netperf -H 192.168.0.3 -C -t TCP_STREAM -- -m 8192 -s 253952 -S =
253952
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.0.3=20
(192.168.0.3) port 0 AF_INET
Recv   Send    Send                          Utilization       Service=20
Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    =
Recv
Size   Size    Size     Time     Throughput  local    remote   local  =20
remote
bytes  bytes   bytes    secs.    10^6bits/s  % U      % S      us/KB  =20
us/KB

262142 206848   8192    10.00        64.51   -1.00    2.59     -1.000 =20
6.587

PC --> board (rx)

linux:/home/mingliu/netperf-2.4.1 # netperf -H 192.168.0.5 -C -t =
TCP_STREAM=20
-- -m 14400 -s 253952 -S 253952
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.0.5=20
(192.168.0.5) port 0 AF_INET
Recv   Send    Send                          Utilization       Service=20
Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    =
Recv
Size   Size    Size     Time     Throughput  local    remote   local  =20
remote
bytes  bytes   bytes    secs.    10^6bits/s  % U      % U      us/KB  =20
us/KB

206848 262142  14400    10.02       169.09   -1.00    -1.00    -1.000 =20
-0.484

I think this performance is much slower than what you have described. So =

what's the problem? I am using the old cores of TEMAC(plb_temac 2.00.a =
and=20
hard_temac 1.00.a and DMA type is 3, Tx and Rx FIFO lengths are both=20
131072, large enough?). My linux is 2.6.16 from the general kernel with =
the=20
temac driver patched. The driver is from the patch=20
http://source.mvista.com/~ank/paulus-powerpc/20060309/. Is this bad=20
performance because of the old cores, or the driver? Or Montavista Linux =
is=20
RTOS and it should have a much better performance like this? You must be =

more experienced on the performance issue and your suggestion will be=20
extreamly useful for me.=20

Anxious for your suggestion and explanation.=20

Regards
Ming

>From: "Rick Moleres" <rick.moleres@xilinx.com>
>To: "Michael Galassi" <mgalassi@c-cor.com>,"Thomas Denzinger"=20
<t.denzinger@lesametric.de>
>CC: linuxppc-embedded@ozlabs.org
>Subject: RE: Speed of plb_temac 3.00 on ML403=20
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
>again) - using netperf w/ TCP_SENDFILE option. We didn't investigate =
the
>difference between 2.4 and 2.6.
>
>-Rick
>
>-----Original Message-----
>From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
>[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
>Behalf Of Michael Galassi
>Sent: Tuesday, December 05, 2006 11:42 AM
>To: Thomas Denzinger
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Speed of plb_temac 3.00 on ML403
>
> >My question is now: Has anybody deeper knowledge how ethernet and =
sgDMA
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
>  PARAMETER C_DMA_TYPE =3D 3
>  PARAMETER C_INCLUDE_RX_CSUM =3D 1
>  PARAMETER C_INCLUDE_TX_CSUM =3D 1
>  PARAMETER C_RX_DRE_TYPE =3D 1
>  PARAMETER C_TX_DRE_TYPE =3D 1
>  PARAMETER C_RXFIFO_DEPTH =3D 32768
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
=D3=EB=C1=AA=BB=FA=B5=C4=C5=F3=D3=D1=BD=F8=D0=D0=BD=BB=C1=F7=A3=AC=C7=EB=CA=
=B9=D3=C3 MSN Messenger:  http://messenger.msn.com/cn =20
