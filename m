Return-Path: <rick.moleres@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CF9D667BAD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 06:09:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Speed of plb_temac 3.00 on ML403 
Date: Tue, 5 Dec 2006 12:08:58 -0700
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C0360F790@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Michael Galassi" <mgalassi@c-cor.com>,
	"Thomas Denzinger" <t.denzinger@lesametric.de>
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


Thomas,

Yes, Michael points out the hardware parameters that are needed to
enable SGDMA along with DRE (to allow unaligned packets) and checksum
offload. It also helps the queuing if the FIFOs in the hardware (Tx/Rx
and IPIF) are deep to handle fast frame rates.  And finally, better
performance if jumbo frames are enabled. Once SGDMA is tuned (e.g.,
number of buffer descriptors, interrupt coalescing) and set up, the PPC
is not involved in the data transfers - only in the setup and interrupt
handling.

With a 300Mhz system we saw about 730Mbps Tx with TCP on 2.4.20
(MontaVista Linux) and about 550Mbps Tx with TCP on 2.6.10 (MontaVista
again) - using netperf w/ TCP_SENDFILE option. We didn't investigate the
difference between 2.4 and 2.6.

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Michael Galassi
Sent: Tuesday, December 05, 2006 11:42 AM
To: Thomas Denzinger
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Speed of plb_temac 3.00 on ML403=20

>My question is now: Has anybody deeper knowledge how ethernet and sgDMA
>works? How deep is the PPC involved in the data transfer? Or does the
>Temac-core handle the datatransfer to DDR-memory autonomous?

Thomas,

If you cut & pasted directly from my design you may be running without
DMA, which in turn implies running without checksum offload and DRE.
The plb_temac shrinks to about half it's size this way, but if you're
performance bound you probably want to turn DMA back on in your mhs
file:

 PARAMETER C_DMA_TYPE =3D 3
 PARAMETER C_INCLUDE_RX_CSUM =3D 1
 PARAMETER C_INCLUDE_TX_CSUM =3D 1
 PARAMETER C_RX_DRE_TYPE =3D 1
 PARAMETER C_TX_DRE_TYPE =3D 1
 PARAMETER C_RXFIFO_DEPTH =3D 32768

You'll have to regenerate the xparameters file too if you make these
changes (in xps: Software -> Generate Libraries and BSPs).

There may also be issues with the IP stack in the 2.4 linux kernels.
If you have the option, an experiment with at 2.6 stack would be
ammusing.

-michael
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
