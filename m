Return-Path: <jianfei616@hotmail.com>
Message-ID: <BAY113-F3053BE1E61055DC5EFB9FF98880@phx.gbl>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673026FD945@zch01exm40.ap.freescale.net>
From: "Guo Jaffe" <jianfei616@hotmail.com>
To: DaveLiu@freescale.com, afleming@freescale.com
Subject: RE: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Fri, 09 Jun 2006 23:43:37 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Hi Dave,

The PHY ID I read is MARVELL 88E1101(1410cc2)

Today I took the MPC 8540 off the board, and checked the two GMII phy chips 
alone. I manually pulled up the phys's RST pins when the cable was in 
position. But the link LED still can't light up. So it turned out not the 
driver's problem. 

The hardware configuration of 88E1111 is GMII to copper, Auto-Neg, 
advertise all capabilities, prefer Master.

The PHY's power is correct and clean. And for interface between TESC and 
PHY I think even TESC power is set for 3.3V environment it still can work 
with the 88e1111 whose VDD is 2.5V. Because the datasheet of 88e1111 says 
that input pins are 3.3V tolerant. Am I right?

regards,
Jaffe

----------------------------------------------------------------------------

>As you said, the MDIO bus looks like well. If the PHY address it is right,
>You can read the PHY ID from PHY. What is the PHY ID you read?
>
>Please check the hardware status
>
>1) 8540 hardware reset configuration for GMII interface;
>Make sure it is GMII interface.
>
>2) MARVELL 88E1111 configuration and GMII interface connection.
>You can reference the 8540 ref board.
>
>3)TSEC and PHY power
>
>4)The 125M reference clock---GTX_CLK125, This looks
>well as you said.
>
>5)The GTX_CLK for GMII transmit clock, and TX_CLK for MII transmit clock.
>What speed ethernet does the TSEC  connect to? 1000Mbps or 100Mbps?
>
>6) The RX_CLK for receive clock.
>
>7)Of cause, need check the RX_DV and TX_EN to see if have some traffic.
>
>-Dave
