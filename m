Return-Path: <DaveLiu@freescale.com>
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD945@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: Fleming Andy-afleming <afleming@freescale.com>, Guo Jaffe
	<jianfei616@hotmail.com>
Subject: RE: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Fri, 9 Jun 2006 11:35:06 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Jun 8, 2006, at 12:51, Guo Jaffe wrote:
> 
> > Hi Andy,
> >
> > Thank you for your information. So the driver is not the issue, but
> > better to upgraded.
> >
> > I will check the board once more. The PHY doesn't work because the
> > 8bit bus between MAC and PHY is locked(TX_EN and RX_DV all 
> disabled  
> > from the scope's view) and also you can't see any signals exist at  
> > the Magnetic side(nor LED signals). It seems that only 
> MDC/MDIO and  
> > CLOCK reference pin works. The PHY's ID must be read from MDC/MDIO  
> > interface and Clocks are right showed on the scope.
> 
> 
> But what error are you getting?  What are the symptoms of your  
> problem?  The GMII interface (the 8-bit bus) is inconsequential to  
> PHY configuration and management.  Only the MDC/MDIO bus is used.   
> Therefore the PHY id should be quite readable.  What version 
> of Linux  
> are you using?  Please describe what the kernel prints out when you  
> boot, and when you try to bring up the interface (assuming you don't  
> do that at boot).
> 
> Andy

As you said, the MDIO bus looks like well. If the PHY address it is right,
You can read the PHY ID from PHY. What is the PHY ID you read?

Please check the hardware status

1) 8540 hardware reset configuration for GMII interface;
Make sure it is GMII interface.

2) MARVELL 88E1111 configuration and GMII interface connection.
You can reference the 8540 ref board.
 
3)TSEC and PHY power

4)The 125M reference clock---GTX_CLK125, This looks
well as you said.

5)The GTX_CLK for GMII transmit clock, and TX_CLK for MII transmit clock.
What speed ethernet does the TSEC  connect to? 1000Mbps or 100Mbps?

6) The RX_CLK for receive clock.

7)Of cause, need check the RX_DV and TX_EN to see if have some traffic.

-Dave
