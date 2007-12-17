Return-Path: <vitb@kernel.crashing.org>
Date: Mon, 17 Dec 2007 23:55:03 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>, David Gibson
	<david@gibson.dropbear.id.au>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071217235503.3b714cd9@kernel.crashing.org>
In-Reply-To: <4766C471.6050703@freescale.com>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
	<20071217212654.2cf39355@kernel.crashing.org>
	<4766C471.6050703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Dec 2007 12:48:17 -0600
Scott Wood wrote:

> Vitaly Bordug wrote:
> > On Mon, 17 Dec 2007 11:03:04 -0600 Scott Wood wrote:
> >>> These phy nodes have basically no information in them.  PHY nodes
> >>>  are optional -
> >> If they are truly optional, then several Linux drivers (including 
> >> ucc_geth, which this board uses) are broken, as they'll error out
> >> if there's no phy-handle (gianfar is even worse -- it looks like
> >> the fsl_soc code will crash in that case).  But what do you propose
> >> they do in the absence of a phy-handle?  Hope that probing only
> >> finds one phy?
> > 
> > up-to-date fixed phy patch solves it in gianfar and fs_enet case. it
> > is implied, that either there *are* phy nodes (and the code will
> > look up their reg and phandle) or there should be fixed-link
> > property in NIC node, that describes to what link stuff is really
> > connected.
> 
> There's a difference between the phy *node* being optional and phy 
> *usage* being optional. :-)
> 
And I am telling exactly that :) [added David to the loop since it was his issue].

currently phy nodes are required by the drivers (referring phy-handle), and I'd tell it looks pretty
settled. We got rid of "pretend" phy nodes, but I don't think it makes sense to
change the things for this particular board, especially since there is no example,
how  to do that in correct way.

Addition of compatible prop may be useful though, at least one may just look into dts to memorize
what type of phys board has..


-- 
Sincerely, Vitaly
