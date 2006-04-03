Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id F29CE67A60
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 00:44:33 +1000 (EST)
Date: 3 Apr 2006 14:44:30 -0000
Message-ID: <20060403144430.18964.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: TSchnuerer@men.de, linuxppc-dev@ozlabs.org
Subject: Re: MPC5200 FEC Ethernet only halfduplex ?
In-Reply-To: <0ABEEA3685414344B4BE536AE3912E6EC0506F@men-exch1.intra.men.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

TSchnuerer@men.de wrote:
> Im working with Linux on our MPC5200 Board, with the latest Rev. B3 
> Processor.
> I was updating our Linux BSP from BestComm 2.1 to 2.2 some time ago and
> used your patches which increased usability of the FEC very much.
> 
> There is a line in the driver code which I dont understand, it says:
> + fec_restart(dev, 0); /* always use half duplex mode only */
> 
> Why can only half duplex be used ?

The reason is simple, but not satisfying.  The driver has no
mechanism to detect PHY status changes and thus no way to determine
when a connection changes from full to half duplex.  It needs a
poll function for PHY status change.  Doing only half-duplex
avoids this issue--at a big performance cost.

I think a poll function was added in the Denx version.

The MPC5200 FEC driver desperately needs a rewrite.

-Dale
