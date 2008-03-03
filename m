Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-30.bluehost.com (outbound-mail-30.bluehost.com
	[69.89.17.212]) by ozlabs.org (Postfix) with SMTP id 3E92ADDF42
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 07:44:36 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: benh@kernel.crashing.org
Subject: Re: [patch 4/6] ARM: move bridge enable out of
	pcibios_enable_resources()
Date: Mon, 3 Mar 2008 12:43:51 -0800
References: <20080228000437.880811124@ldl.fc.hp.com>
	<200803030959.35625.jbarnes@virtuousgeek.org>
	<1204576557.21545.4.camel@pasglop>
In-Reply-To: <1204576557.21545.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803031243.51613.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, March 03, 2008 12:35 pm Benjamin Herrenschmidt wrote:
> On Mon, 2008-03-03 at 09:59 -0800, Jesse Barnes wrote:
> > On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> > > Move bridge enable from pcibios_enable_resources() to
> > > platform_pci_enable_device() so the former matches other
> > > architectures and can be shared.
> >
> > I really like the direction of these patches.  Getting PCI resources
> > assigned & devices setup correctly for new arches has always been a bit
> > more trouble than it should be...
>
> You'll noticed that I recently moved powerpc to something more common to
> x86 in the are of resource allocation. Still -slightly- different but I
> do believe there is room for somebody with some skills to try to turn
> some of that into generic code.

Yeah, I think that would be a good thing to shoot for.  Even on PCs there are 
times when we need resource allocation to be done (or re-done) by the kernel 
for hotplug or just because the platform is pared down enough that it doesn't 
to it all by itself.

I might be able to find time to look into that myself in the next few weeks; I 
think we even have some open PCI bugs that could be solved by better resource 
allocation.

Jesse
