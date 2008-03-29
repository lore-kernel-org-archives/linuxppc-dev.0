Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83D30DDF44
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 14:33:29 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2T3XGSH025113
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 23:33:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2T3XGUt193134
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 21:33:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2T3XGgo030156
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 21:33:16 -0600
Date: Fri, 28 Mar 2008 22:30:05 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
Message-ID: <20080328223005.34181eb7@zod.rchland.ibm.com>
In-Reply-To: <47EDA6F1.9080206@garzik.org>
References: <20080327144044.GA8831@ru.mvista.com> <47EDA6F1.9080206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Mar 2008 22:18:25 -0400
Jeff Garzik <jeff@garzik.org> wrote:

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

No.  This, and patch 2/2, are for 2.6.26 and depend on a patch in my
tree.  These are the two Ben asked about going through the powerpc tree
but naturally we wanted an Ack from you first.

thx,
josh 
