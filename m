Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35A13B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 16:07:27 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p78625IP024973
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2011 16:02:05 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7866Pwe1048812
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2011 16:06:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7867L7b018472
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2011 16:07:22 +1000
Date: Mon, 8 Aug 2011 16:07:18 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110808060718.GC20120@yookeroo.fritz.box>
References: <1311983933.8793.42.camel@pasglop>
	<20110804102752.GA22329@8bytes.org>
	<1312540958.8598.46.camel@pasglop>
	<1312557012.2559.34.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312557012.2559.34.camel@x201.home>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>, Joerg Roedel <joro@8bytes.org>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2011 at 09:10:09AM -0600, Alex Williamson wrote:
> On Fri, 2011-08-05 at 20:42 +1000, Benjamin Herrenschmidt wrote:
> > Right. In fact to try to clarify the problem for everybody, I think we
> > can distinguish two different classes of "constraints" that can
> > influence the grouping of devices:
> > 
> >  1- Hard constraints. These are typically devices using the same RID or
> > where the RID cannot be reliably guaranteed (the later is the case with
> > some PCIe-PCIX bridges which will take ownership of "some" transactions
> > such as split but not all). Devices like that must be in the same
> > domain. This is where PowerPC adds to what x86 does today the concept
> > that the domains are pre-existing, since we use the RID for error
> > isolation & MMIO segmenting as well. so we need to create those domains
> > at boot time.
> > 
> >  2- Softer constraints. Those constraints derive from the fact that not
> > applying them risks enabling the guest to create side effects outside of
> > its "sandbox". To some extent, there can be "degrees" of badness between
> > the various things that can cause such constraints. Examples are shared
> > LSIs (since trusting DisINTx can be chancy, see earlier discussions),
> > potentially any set of functions in the same device can be problematic
> > due to the possibility to get backdoor access to the BARs etc...
> 
> This is what I've been trying to get to, hardware constraints vs system
> policy constraints.
> 
> > Now, what I derive from the discussion we've had so far, is that we need
> > to find a proper fix for #1, but Alex and Avi seem to prefer that #2
> > remains a matter of libvirt/user doing the right thing (basically
> > keeping a loaded gun aimed at the user's foot with a very very very
> > sweet trigger but heh, let's not start a flamewar here :-)
> 
> Doesn't your own uncertainty of whether or not to allow this lead to the
> same conclusion, that it belongs in userspace policy?  I don't think we
> want to make white lists of which devices we trust to do DisINTx
> correctly part of the kernel interface, do we?  Thanks,

Yes, but the overall point is that both the hard and soft constraints
are much easier to handle if a group or iommu domain or whatever is a
persistent entity that can be set up once-per-boot by the admin with
whatever degree of safety they want, rather than a transient entity
tied to an fd's lifetime, which must be set up correctly, every time,
by the thing establishing it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
