Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C69E9DDEB6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 04:01:27 +1000 (EST)
Date: Fri, 5 Oct 2007 13:01:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
Message-ID: <20071005180135.GA7127@loki.buserror.net>
References: <20071005174015.GA11016@localhost.localdomain>
	<20071005174642.GB32145@localhost.localdomain>
	<47067ADE.9060306@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47067ADE.9060306@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 09:56:46PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Anton Vorontsov wrote:
> 
> > Commit 5bece127f0666996ca90772229e00332a34e516c tried to fix
> > PCI/PCIe nodes, but actually it broke them even harder. ;-)
> 
>     Of course. But shouldn't those be the subnoses of the "soc" type node?

No -- the soc node is for immr/ccsr only, and while the PCI control
registers are there, the ranges are not.  There was a lengthy discussion on
IRC about this a couple weeks ago.  It'd be cleaner to split the control
node from the bus node, and connect them with phandles, but some people
didn't like that, and this is what we compromised on.

-Scott
