Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B06E967B69
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 00:35:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx hard TEMAC
Date: Fri, 14 Jul 2006 08:32:57 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C029DC841@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: <dhlii@comcast.net>, "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


David,

I'll see if I can clarify a bit.  In Virtex-4, there is a silicon-based
Hard TEMAC.  But in order to get to it (and have things like buffering
and DMA) you need a soft wrapper - which comes in two flavors.  One is
the LL_TEMAC, which is released as part of the GSRD reference design.
The other is PLB_TEMAC, which is released in the EDK.  The fundamental
difference between the two (I'm simplifying) is that the LL_TEMAC and
GSRD system keep data off the PLB bus, using LocalLink point-to-point
connections between the LL_TEMAC and the memory and DMA controllers.
The PLB_TEMAC's data path is over the PLB.  The LL_TEMAC also supports
both channels of the Hard TEMAC, whereas the PLB_TEMAC does not (yet).
Both are comparable in performance.  The PLB_TEMAC, as part of the EDK,
has the official Xilinx support that other EDK IP has, whereas LL_TEMAC
and GSRD are just a reference design.

The Linux driver posted for the TEMAC (by MontaVista) is for the
PLB_TEMAC.  Updates to this driver may also be released with the EDK
(e.g., EDK 8.1.2 updated the driver to include checksum offload).  There
is a Linux driver for the LL_TEMAC that comes with GSRD, but my group's
efforts go toward the PLB_TEMAC as that is the EDK IP we want to promote
and whose drivers we'd like to see in kernel.org.

By the way, there is no relation to the IBM EMAC.

Hope that helps,
-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of David H. Lynch Jr.
Sent: Thursday, July 13, 2006 5:50 PM
To: linuxppc-embedded
Subject: Xilinx hard TEMAC


I am trying to get the Xilinx TEMAC working. I am getting an education
in Xilinx, TEMAC's, PHY's, ... in the process.

The hardware I have to support is the Hard TEMAC on the LocalLink Bus.
It is my understanding that this is the TEMAC builtin to the FX parts,
not one that is created in the FPGA.

Is anyone else working to support that configuration ? I think that is
basically the same as the GRSD TEMAC.
Is it sane to try to adapt the soft TEMAC patch from the list ?

I have a driver that works under uCos as a starting point. It initially
appeared to use basically the same xilinx_edk code that the linux temac
driver patch that has been the subject of a number of messages uses. But
on deeper inspection that dependence appears to be very shallow - mostly
using the edk macros to read the PHY and registers in the MAC.

Am I correct that the TEMAC patch floating arround is not for that TEMAC
?

I am also trying to digest the paternity of the TEMAC. Is the basic
programming of the hard TEMAC and the IP TEMAC the same ? i.e. does the
fact that the both have TEMAC in their name actually express some
commonality ? TEMAC means Tri-Mode EMAC - does that mean there is some
commonality with the IBM EMAC ?

I have a driver in the works that is based on the working uCos code I
mentioned, as well as I think the pcnet32 driver as a very basic
template.
I seem to got the PHY portions working, but then addapted to the
separate PHY driver model with the MAC driver providing routines to
access the PHY registers. I may have that working. I think I have DCR
access to the MAC registers working. I am just starting on getting the
TX and RX code working.

I actually started trying to get the posted TEMAC patch working but that
quickly went off the rails - I presumed because the hard and soft
TEMAC's are just too different, or because the xilinx_edk really does
not support the hard TEMAC.

The xilinx_edk based driver seems incredibly complex. I think the OS
independent xilinx_edk incurrs a high cost in obscurity - but I am not
looking to gore someone elses ox, just solve my problem.

If the edk based driver is going to make it into the kernel, and
somebody who understands better than I beleives that it is reasonable to
adapt that to support the hard TEMAC too, I am willing to pursue that
approach.

Regardless. I need to get a driver working, and I am not looking to
duplicate effort.




--=20
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
