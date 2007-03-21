Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A033EDDF5E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 03:01:20 +1100 (EST)
Date: Wed, 21 Mar 2007 11:01:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/17] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070321160112.GA31655@ld0162-tx32.am.freescale.net>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172757.GC29784@ld0162-tx32.am.freescale.net>
	<20070320035005.GB21124@localhost.localdomain>
	<e07db139f025494f172389e2773a2e32@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e07db139f025494f172389e2773a2e32@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 02:49:30PM +0100, Segher Boessenkool wrote:
> I didn't look at the actual code but it should be really
> small; I hope it doesn't copy the Linux code with its
> millions of workarounds for broken device trees -- we
> should insist on correct trees, or even just fix them
> if they *are* broken ;-)

It's around 1700 bytes.  Most of the complexity is for dealing with
different #address-cells and #size-cells -- if we could assume a max of 2
for each, then it could be simplified quite a bit by using u64 instead of
arrays.  However, that wouldn't work with PCI, which has 3 address cells.

-Scott
