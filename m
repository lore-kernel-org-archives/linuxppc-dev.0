Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B9D71A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 14:02:42 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 686681402C4
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 14:02:40 +1100 (AEDT)
Message-ID: <1449538150.15946.114.camel@freescale.com>
Subject: Re: FCC driver for Motorola MPC82xx - an error found
From: Scott Wood <scottwood@freescale.com>
To: Martin Roth <martin.roth@motorolasolutions.com>, <linuxppc-dev@ozlabs.org>
Date: Mon, 7 Dec 2015 19:29:10 -0600
In-Reply-To: <1448367591225-101297.post@n7.nabble.com>
References: <1448367591225-101297.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-24 at 05:19 -0700, Martin Roth wrote:
> I was looking for an error on MPC8270 processor 100 Mbps Ethernet FCC port. 
> The port may become locked if it is set to AUTO, while the peer is forced to
> 100 Mbs full duplex (non AUTO).
> I was looking for an error in the area of collision handling of the driver.
> It looks like I found the problem.
> 
> The error is at line 555:
> http://lxr.free-electrons.com/source/drivers/net/ethernet/freescale/fs_enet/
> mac-fcc.c#L555
> 
> The problem is that the last descriptor address is not calculated correctly.
> 
> Instead of
>    last_tx_bd = fep->tx_bd_base + (fpi->tx_ring * sizeof(cbd_t)); 
> The fix should be:
>    last_tx_bd = fep->tx_bd_base + ((fpi->tx_ring-1)* sizeof(cbd_t));
> 
> Is it a bug? 
> Thanks,
> Martin Roth

Yes, it looks like a bug.  Could you send a patch to the netdev list and
maintainer?

-Scott
