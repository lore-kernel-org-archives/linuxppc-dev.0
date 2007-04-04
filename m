Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4612D8FE.1070400@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
	<1175568133.16182.15.camel@concordia <4612C48F.9080805@am.sony.com>
	<1175636904.10567.8.camel@shinybook.infradead.org>
	<4612D8FE.1070400@am.sony.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:30:45 +1000
Message-Id: <1175650246.30879.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There are several points here I feel need explanation.  One is that memory
> is a dynamic resource allocated by the HV, so it needs to be managed as a
> dynamic resource by the guest OS.

That happens on pSeries too and we still keep the device-tree in check,
but that's related to the way all hotplug operations work on p... on
these, the HV provides us with device-tree updates.

I still think that the RMO is _not_ a dynamic resource, and as such
should be present in the memory node as this is expected of quite a few
things around including kexec tools.

>   Another point is that the HV has two
> types of memory; boot memory, and virtual memory.  Boot memory is what will
> be in is in the DT when I finish the zImage implementation.  Virtual memory
> is what I currently have as hotplug memory.
> 
> So there are really two answers, one is that having the boot memory in the
> DT hasn't changed, I just haven't finished that part yet.  The other is that
> we get the amount of memory at runtime because it is a dynamic resource, and
> cannot be known at DT compile time.  It is just by some luck that the 2.6.16
> kernel continues to work correctly on the PS3, but it is not guaranteed to,
> and has a good chance of failing on non-ps3 systems that use the lv1 hypervisor.

Adding/removing memory outside of the RMO without updating the DT is
fine with me. The RMO itself should be in the DT though.

Ben.
