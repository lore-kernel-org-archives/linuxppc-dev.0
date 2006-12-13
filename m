Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 0262867BF7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 02:36:05 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Wed, 13 Dec 2006 16:36:00 +0100
Message-ID: <032a01c71ecc$659ae480$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <5CD24382-201C-4B60-B410-3746A032415A@kernel.crashing.org>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org] 
> Sent: den 13 december 2006 15:46
> To: joakim.tjernlund@transmode.se
> Cc: linuxppc-dev Development; spi-devel-general@lists.sourceforge.net
> Subject: Re: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
> 
> 
> On Dec 13, 2006, at 3:22 AM, Joakim Tjernlund wrote:
> 
> > The MPC 832x has a different SPI controller i/f, probably due to
> > its QUICC engine support. This patch adapts the spi_mpx83xx 
> driver to
> > be usable on QE based 83xx cpus.
> >
> >  Jocke
> 
> One problem I have with this patch is the fact that it assumes the  
> current driver for (mpc834x) and your mods to support mpc832x/QE are  
> mutually exclusive.

I don't see that as a problem ATM. If that is added it should be optional.

> 
> We need to handle the case of having driver support for both the QE  
> and MPC834x style in the same kernel.

Adding that will double the number RX_BUF/TX_BUF functions from 6 to 12
(possibly this can be reduced by adding more logic to the tx_buf/rx_buf functions)
not to mention what will happen when support for reversed bit order is added.

I would argue that the kernel lacks the possibility to remove complexity
I don't need. Example in this driver is that there is no way to remove
support for 16 and 32 bit SPI character sizes. The same goes for a lot of
the probing code in fsl-soc.c.

It would be nice if a board port could add a custom header file that
gets included by all .c automatically. Then one could add knobs
(read #defines) there to futher tune such things as SPI char size.
That way one don't have add Kconfig entries for all those small
tuning knobs.

 Jocke
