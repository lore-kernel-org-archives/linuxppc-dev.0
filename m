Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2117AB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 20:26:33 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Roedel <joro@8bytes.org>
In-Reply-To: <20110804104105.GC22329@8bytes.org>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312230476.2653.395.camel@bling.home>
	<20110804104105.GC22329@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 20:26:11 +1000
Message-ID: <1312539971.8598.29.camel@pasglop>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
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

On Thu, 2011-08-04 at 12:41 +0200, Joerg Roedel wrote:
> On Mon, Aug 01, 2011 at 02:27:36PM -0600, Alex Williamson wrote:
> > It's not clear to me how we could skip it.  With VT-d, we'd have to
> > implement an emulated interrupt remapper and hope that the guest picks
> > unused indexes in the host interrupt remapping table before it could do
> > anything useful with direct access to the MSI-X table.  Maybe AMD IOMMU
> > makes this easier?
> 
> AMD IOMMU provides remapping tables per-device, and not a global one.
> But that does not make direct guest-access to the MSI-X table safe. The
> table contains the table contains the interrupt-type and the vector
> which is used as an index into the remapping table by the IOMMU. So when
> the guest writes into its MSI-X table the remapping-table in the host
> needs to be updated too.

Right, you need paravirt to avoid filtering :-)

IE the problem is two fold:

 - Getting the right value in the table / remapper so things work
(paravirt)

 - Protecting against the guest somewhat managing to change the value in
the table (either directly or via a backdoor access to its own config
space).

The later for us comes from the HW PE filtering of the MSI transactions.

Cheers,
Ben.
