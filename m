Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56DA7474C2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:50:19 +1100 (EST)
Subject: Re: mal_probe crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20090108204634.GB2337@yoda.jdub.homelinux.org>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<20090108204634.GB2337@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 09:50:10 +1100
Message-Id: <1231368610.2142.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-01-08 at 15:46 -0500, Josh Boyer wrote:
> On Wed, Jan 07, 2009 at 03:44:34PM -0500, Sean MacLennan wrote:
> >With Linus' latest git, mal_probe crashes. It calls netif_napi_add with
> >the first parameter NULL. This was ok since the parameter, a net
> >device, was only used if CONFIG_NETPOLL was set.
> >
> >Now it is always de-referenced. A quick check shows that ibm_newemac is
> >the only driver that passed NULL as the first parameter to this call in
> >2.6.28.
> >
> >I don't really follow ibm_newemac changes, so the patch may be waiting
> >to be applied. This is really just a heads up.
> 
> I haven't heard of that, so I doubt there's a patch pending.  *Sigh*

There isn't that I know of. The EMAC code creates a single NAPI instance
for all EMACs and I think used to completely disconnect things. The old
code created a fake netdev just for NAPI, that became unnecessary with
the new NAPI stuff.... but it looks like the way we do things now
displeases some changes in the network stack. I'll have to dig.

Cheers,
Ben.
