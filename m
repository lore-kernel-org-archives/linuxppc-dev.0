Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9A69DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:53:21 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 15 May 2007 06:53:14 +1000
Message-Id: <1179175994.32247.91.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 15:50 +0200, Segher Boessenkool wrote:
> >  - Cleanup and separate tracking of the ISA space in the reserved
> >    low 64K of IO space. No ISA -> Nothing mapped there.
> 
> > I now always reserve the first 64K of IO space for the bridge with
> > the ISA bus on it.
> 
> This is wrong -- there are systems with ISA that
> also have PCI devices that require 16-bit legacy
> I/O windows (e.g., systems with the AMD8111 chip,
> like Maple).
> 
> Or do you mean you reserve the low 64k for the PHB?
> That would work in this case, but still not in
> general.  Not sure if we care though.

Yes, if you have an "isa" node, you get a 64k mapping of IO's for your
PHB in the first 64K of IO space (in addition to a full mapping
elsewhere for devices with proper BARs).

If you don't, you don't get that mapping. I might add a call for
platforms to explicitely map those low 64K to a given PCI host though
for platforms who really want it.

Ben.
