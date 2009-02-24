Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id A2E47DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 03:58:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Tue, 24 Feb 2009 11:58:49 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C077EB@CYBORG3.cyclone.com>
In-Reply-To: <18AEF66AFDF06F4CAAA1D419D000FD3302B1EB2E@az33exm24.fsl.freescale.net>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<18AEF66AFDF06F4CAAA1D419D000FD3302B1EAB1@az33exm24.fsl.freescale.net>
	<43EB80E07C42E1408726E4905FB96B04C0774E@CYBORG3.cyclone.com>
	<18AEF66AFDF06F4CAAA1D419D000FD3302B1EB2E@az33exm24.fsl.freescale.net>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Haruki Dai-R35557" <Dai.Haruki@freescale.com>, <linuxppc-dev@ozlabs.org>
Cc: Gala Kumar-B11780 <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Dai,

>  I am not so sure about your PHY, but if you access to PHY while
packet
> transmission through MDIO bus, the packet might be corrupted. Do you
> have "phy_interrupt" in the /proc/interrupts? What is your dmesg
around
> the eTSEC look like (there is phy driver info surrounded).

With some printks, I did confirm that the kernel is polling the phy
every second or so.  So, I modified the routine which reads the phy
status to hardcode the link state, speed, and duplex without actually
performing any reads and the driver still bug checks with a truncated
packet.  I also dropped a printk in phy_read() and phy_write(), but
neither function is getting called with the hard-coded link information.

In gfar_clean_tx_ring() I printed out the tx descriptor data length
field when I detected that the descriptor had the TR bit set.  For 5 bug
checks in a row, the data length field was set to 1960 (which would
definitely cause the packet truncation).  I then went back into
gfar_start_xmit() and added some additional BUG_ON() checks of the data
length field before the descriptor is handed off to the TSEC and none of
them fire.  I am wondering if somehow the descriptor is getting
corrupted, perhaps by some code with an errant pointer.

Scott=20



___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
