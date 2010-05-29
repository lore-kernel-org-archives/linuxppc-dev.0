Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14A48B7D27
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 13:40:56 +1000 (EST)
Subject: Re: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in
	CPM	early debug console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4BFFECF1.9060809@freescale.com>
References: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<4BFFECF1.9060809@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 29 May 2010 13:37:13 +1000
Message-ID: <1275104233.1931.523.camel@pasglop>
Mime-Version: 1.0
Cc: Martyn Welch <martyn.welch@ge.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-05-28 at 11:18 -0500, Scott Wood wrote:
> Only the physical address should depend on where IMMR is.  We should
> use 
> fixmap instead of an arbitrary address for the effective address. 
> There's a existing FIX_EARLY_DEBUG_BASE, but it's only 128 KiB so
> we'll 
> have to either grow it, or map only a subset of IMMR.
> 
> Plus, CONFIG_PPC_EARLY_DEBUG_CPM_ADDR points to the TX descriptor,
> not 
> to the beginning of IMMR, so you should mask off the lower 20 bits
> (the 
> offset is probably less than 64K, and the BAT might just ignore the 
> extra bits anyway, but why take chances?). 

BAT has other advantages such as limiting TLB usage for things that are
used often. I think we might want to revive Grant work on early ioremap
here :-)

Cheers,
Ben.
