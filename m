Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9429CDDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 05:28:14 +1100 (EST)
Date: Mon, 17 Dec 2007 21:26:54 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071217212654.2cf39355@kernel.crashing.org>
In-Reply-To: <20071217170303.GA4303@loki.buserror.net>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
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

On Mon, 17 Dec 2007 11:03:04 -0600
Scott Wood wrote:

> > > +			phy1: ethernet-phy@1 {
> > > +				reg = <1>;
> > > +				device_type = "ethernet-phy";
> > > +			};  
> > 
> > These phy nodes have basically no information in them.  PHY nodes
> > are optional -  
> 
> If they are truly optional, then several Linux drivers (including
> ucc_geth, which this board uses) are broken, as they'll error out if
> there's no phy-handle (gianfar is even worse -- it looks like the
> fsl_soc code will crash in that case).  But what do you propose they
> do in the absence of a phy-handle?  Hope that probing only finds one
> phy?

up-to-date fixed phy patch solves it in gianfar and fs_enet case. it is implied, that either there *are* phy nodes (and the
code will look up their reg and phandle) or there should be fixed-link property in NIC node, that describes to what link stuff
is really connected.

As a recap, we can kill this, but powerpc will live without SoC network stuff then (modulo 4xx). IOW, if we have to change bits around here, that should happen for all the boards, using current notation, or it will soon become maintenance hell.
-- 
Sincerely, Vitaly
