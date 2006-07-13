Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc15.comcast.net (sccrmhc15.comcast.net [204.127.200.85])
	by ozlabs.org (Postfix) with ESMTP id 2004C67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 09:55:00 +1000 (EST)
Message-ID: <44B6DC18.9020409@dlasys.net>
Date: Thu, 13 Jul 2006 19:49:44 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Xilinx hard TEMAC
References: <BAY110-F40A48564C0A5B30AB0DCCB2690@phx.gbl>
	<44B671D2.304@gmail.com>
In-Reply-To: <44B671D2.304@gmail.com>
Content-Type: text/plain; charset=GB2312
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


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

Am I correct that the TEMAC patch floating arround is not for that TEMAC ?

I am also trying to digest the paternity of the TEMAC. Is the basic
programming of the hard TEMAC and the IP TEMAC the same ? i.e. does the
fact that the both have TEMAC in their name actually express some
commonality ? TEMAC means Tri-Mode EMAC - does that mean there is some
commonality with the IBM EMAC ?

I have a driver in the works that is based on the working uCos code I
mentioned, as well as I think the pcnet32 driver as a very basic template.
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




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
