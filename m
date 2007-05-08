Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5FE6DDE00
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:43:29 +1000 (EST)
Subject: Re: [PATCH 7/7] MPIC U3/U4 MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1178614502.18162.34.camel@johannes.berg>
References: <20070508025843.0D93ADDEFD@ozlabs.org>
	<1178614502.18162.34.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:43:14 +1000
Message-Id: <1178667794.14928.126.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-08 at 10:55 +0200, Johannes Berg wrote:
> On Tue, 2007-05-08 at 12:58 +1000, Michael Ellerman wrote:
> > MPIC U3/U4 MSI backend. Based on code from Segher, heavily hacked by me.
> > This only deals with MSI on U3/U4 MPICs, aka. CPC 9x5.
> > 
> > If we find a U3/U4 then we enable this backend, ie. take over the ppc_md
> > MSI hooks. We might need more elaborate logic in future to decide which
> > backend is enabled.
> > 
> > We need our own irq_chip so that we can do MSI masking/unmasking on
> > the device itself. We also need to mask explicitly on shutdown to make
> > sure we don't get bitten by lazy-disable semantics.
> 
> How badly will this clash with my patch that implements suspend/resume
> for mpic, and will I need to do more suspend/resume for this?

Maybe... for now, don't bother, we'll do fixups later on. I think your
patch can be done differently and more simply. I don't think we need to
save/restore all this state, we can proably reconfigure everything with
what we have.

Ben.
