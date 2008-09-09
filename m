Return-Path: <mazsi@imrek.org>
Received: from mail.imrek.org (mail.imrek.org [67.207.130.102])
	by ozlabs.org (Postfix) with ESMTP id 676F0DDF83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 04:58:47 +1000 (EST)
Date: Tue, 9 Sep 2008 20:58:44 +0200 (CEST)
From: jozsef imrek <mazsi@imrek.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: EDK10.1 and emaclite
In-Reply-To: <48C63578.8030106@team-ctech.de>
Message-ID: <Pine.LNX.4.64.0809092041350.10180@mail.imrek.org>
References: <48C5F6ED.4000804@cdac.in> <48C62603.7080606@team-ctech.de>
	<48C63317.7080709@cdac.in> <48C63578.8030106@team-ctech.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Georg Schardt <schardt@team-ctech.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


dear georg,


On Tue, 9 Sep 2008, Georg Schardt wrote:

> Yes, i will try this. i use this board with the edk 8.2 a year ago. with this 
> edk version the emaclite was working fine. but in this project there was an 
> ip core "Hard Temac" this is missing now. i think i have an error in my edk 
> project.

for the EMAC lite you don't need the hard temac. the work done by
the "hard temac" core and the plb_temac (or ll_temac) core together
in your old project will be done by the EMAC lite core alone.

so the signals to/from the broadcom PHY on your minimodule should be
connected directly to the EMAC lite core:

 	BEGIN opb_ethernetlite
 	 PARAMETER INSTANCE = etherlite
 	 PARAMETER HW_VER = 1.01.b
 	 PARAMETER C_RX_PING_PONG = 1
 	 PARAMETER C_TX_PING_PONG = 1
 	 ...
 	 BUS_INTERFACE sopb = opb
 	 PORT IP2INTC_Irpt = emac_interrupt
 	 PORT phy_rx_data = phy_rxd
 	 PORT phy_tx_data = phy_txd
 	 PORT phy_dv = phy_rxdv
 	 ...
 	END

(but this is probably getting off topic for this list.)


-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       mazsi@imrek.org
----------------------------------------------------------------
