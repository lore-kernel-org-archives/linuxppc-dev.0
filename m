Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43E17DDF58
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 14:36:24 +1100 (EST)
Subject: Re: [PATCH 1/2] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <47EDA6F1.9080206@garzik.org>
References: <20080327144044.GA8831@ru.mvista.com> <47EDA6F1.9080206@garzik.org>
Content-Type: text/plain
Date: Sat, 29 Mar 2008 14:28:16 +1100
Message-Id: <1206761296.10388.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-28 at 22:18 -0400, Jeff Garzik wrote:
> Valentine Barshak wrote:
> > The PowerPC 440GX Taishan board fails to reset EMAC3 (reset timeout error)
> > if there's no link. Because of that it fails to find PHY chip. The older ibm_emac
> > driver had a workaround for that: the EMAC_CLK_INTERNAL/EMAC_CLK_EXTERNAL macros,
> > which toggle the Ethernet Clock Select bit in the SDR0_MFR register. This patch
> > does the same for "ibm,emac-440gx" compatible chips. The workaround forces
> > clock on -all- EMACs, so we select clock under global emac_phy_map_lock.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > ---
> >  drivers/net/ibm_newemac/core.c |   16 +++++++++++++++-
> >  drivers/net/ibm_newemac/core.h |    8 ++++++--
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> is this for 2.6.25-rc?

Nah, too late imho.

Ben.
