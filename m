Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14B61DDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 18:15:05 +1100 (EST)
Subject: Re: open-pic device tree node and subnodes for additional
	functionality?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8330CA5E-0F3B-49D5-AB55-500CD37739C1@kernel.crashing.org>
References: <59D5800B-309D-4A4E-AD1F-CEC8E2D1BE5B@kernel.crashing.org>
	<20090216181241.GB18069@ld0162-tx32.am.freescale.net>
	<8330CA5E-0F3B-49D5-AB55-500CD37739C1@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 19 Feb 2009 18:14:52 +1100
Message-Id: <1235027692.8805.10.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> For MSI I doubt any.  I think on some parts we might have two (or  
> more) groups of MSIs.
> 
> However I want to be able to handle timers and the slightly more  
> generic message interrupts.

You can probably add a reg and a ranges, the reg remains the same
as today as to not inflict any collateral damage, and the ranges
represents downstream addresses to child nodes msi, timers, ...

(ie, it's no big deal if the parent "reg" somewhat overlap the
childs ranges... it's only a problem if the drivers try to request
the resources in ways that collide)

Ben.
