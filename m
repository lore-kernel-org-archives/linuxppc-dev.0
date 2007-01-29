Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 09837DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:19:45 +1100 (EST)
Date: Sun, 28 Jan 2007 20:19:38 -0800 (PST)
Message-Id: <20070128.201938.102578509.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1170040622.26655.187.camel@localhost.localdomain>
References: <1170032301.26655.140.camel@localhost.localdomain>
	<20070128.171309.11624572.davem@davemloft.net>
	<1170040622.26655.187.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 29 Jan 2007 14:17:02 +1100

> However, your vector space is per-bus (which is good), so you do need to
> allocate linux virtual irqs and map them to the actual MSI vectors like
> we do on powerpc.

Yes, I already use virtual irqs on powerpc so it'll be easy to
implement.

Those "devino" numbers are used with "device numbers" to create
system interrupt numbers, and I'd point the virtual IRQ at that.

> I think Eric's framework would work for you. As long as you don't need
> to do something special for MSI-X, which I don't think you do...

That's my current understanding as well.

>  - Try to force our stuff in by implementing x86 completely (and Altix)
> under Michael's infrastructure and then try to convince
> Andrew/Greg/Linus to take it. Fairly unlikely. We do have a somewhat
> "gradual" approach to it which consist of having Michael's code at the
> toplevel, Eric's code hooked in as if it was a hypervisor, and then
> gradually "merge" the raw backend with the x86 code, but it doesn't seem
> very sexy (to me neither).

Well unless you have a working alternative for x86/ia64/etc folk you
have no alternative to Eric's patches to offer for consideration.

I think in the future we'll see more stuff like RTAS, it's the only
way outside of hardware filtering in the PCI-E bridges to provide
real isolation between PCI devices that get divided into different
logical domains.  And full isolation is absolutely required for
proper virtualization.

I think Eric really needs to consider the problem of logical domains,
and what the problem is which the RTAS folks are trying to resolve.
You can't just say something sucks without providing a resaonable
alternative suggestion.

Eric isn't responding to any of my emails on this matter, and that is
not helping at all.  If he would, on the other hand, make constructive
suggestions of how to implement isolation between independant PCI
devices on the same PCI bus which belong to different logical domains,
accounting for MSI, we could actually have a real conversation.

You can't implement isolation unless you 1) strictly control what
devices can do to other devices on the PCI domain or 2) filter
transactions in the PCI bridges so that PCI devices cannot send
arbitrary junk to each other.

#2 is prohibitively expensive and complicated because it requires
specialized hardware.  #1 is low cost in that all you need to do is
make PCI config space accesses and MSI setup go through the
hypervisor.  That's why systems implement #1 to give full isolation.

That's why I think the whole MSI hypervisor thing done by RTAS is
absolutely reasonable and something we should support.  It's NOT like
TCP Offload Engines and the like, not at all, and it's quite upsetting
to see Eric characterize it in that way.  It's a protection and
isolation facility, not a way to hide hardware behind binary blobs.
