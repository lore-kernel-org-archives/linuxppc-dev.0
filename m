Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 46AEAB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Aug 2011 01:10:20 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 05 Aug 2011 09:10:09 -0600
In-Reply-To: <1312540958.8598.46.camel@pasglop>
References: <1311983933.8793.42.camel@pasglop>
	<20110804102752.GA22329@8bytes.org> <1312540958.8598.46.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312557012.2559.34.camel@x201.home>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Gibson <dwg@au1.ibm.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-08-05 at 20:42 +1000, Benjamin Herrenschmidt wrote:
> Right. In fact to try to clarify the problem for everybody, I think we
> can distinguish two different classes of "constraints" that can
> influence the grouping of devices:
> 
>  1- Hard constraints. These are typically devices using the same RID or
> where the RID cannot be reliably guaranteed (the later is the case with
> some PCIe-PCIX bridges which will take ownership of "some" transactions
> such as split but not all). Devices like that must be in the same
> domain. This is where PowerPC adds to what x86 does today the concept
> that the domains are pre-existing, since we use the RID for error
> isolation & MMIO segmenting as well. so we need to create those domains
> at boot time.
> 
>  2- Softer constraints. Those constraints derive from the fact that not
> applying them risks enabling the guest to create side effects outside of
> its "sandbox". To some extent, there can be "degrees" of badness between
> the various things that can cause such constraints. Examples are shared
> LSIs (since trusting DisINTx can be chancy, see earlier discussions),
> potentially any set of functions in the same device can be problematic
> due to the possibility to get backdoor access to the BARs etc...

This is what I've been trying to get to, hardware constraints vs system
policy constraints.

> Now, what I derive from the discussion we've had so far, is that we need
> to find a proper fix for #1, but Alex and Avi seem to prefer that #2
> remains a matter of libvirt/user doing the right thing (basically
> keeping a loaded gun aimed at the user's foot with a very very very
> sweet trigger but heh, let's not start a flamewar here :-)

Doesn't your own uncertainty of whether or not to allow this lead to the
same conclusion, that it belongs in userspace policy?  I don't think we
want to make white lists of which devices we trust to do DisINTx
correctly part of the kernel interface, do we?  Thanks,

Alex
