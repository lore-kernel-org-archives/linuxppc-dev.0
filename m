Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 9AC9FB6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 22:57:14 +1000 (EST)
Date: Fri, 5 Aug 2011 14:57:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110805125709.GB30353@8bytes.org>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312230476.2653.395.camel@bling.home>
	<20110804104105.GC22329@8bytes.org>
	<1312539971.8598.29.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312539971.8598.29.camel@pasglop>
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

On Fri, Aug 05, 2011 at 08:26:11PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2011-08-04 at 12:41 +0200, Joerg Roedel wrote:
> > On Mon, Aug 01, 2011 at 02:27:36PM -0600, Alex Williamson wrote:
> > > It's not clear to me how we could skip it.  With VT-d, we'd have to
> > > implement an emulated interrupt remapper and hope that the guest picks
> > > unused indexes in the host interrupt remapping table before it could do
> > > anything useful with direct access to the MSI-X table.  Maybe AMD IOMMU
> > > makes this easier?
> > 
> > AMD IOMMU provides remapping tables per-device, and not a global one.
> > But that does not make direct guest-access to the MSI-X table safe. The
> > table contains the table contains the interrupt-type and the vector
> > which is used as an index into the remapping table by the IOMMU. So when
> > the guest writes into its MSI-X table the remapping-table in the host
> > needs to be updated too.
> 
> Right, you need paravirt to avoid filtering :-)

Or a shadow MSI-X table like done on x86. How to handle this seems to be
platform specific. As you indicate there is a standardized paravirt
interface for that on Power.

> IE the problem is two fold:
> 
>  - Getting the right value in the table / remapper so things work
> (paravirt)
> 
>  - Protecting against the guest somewhat managing to change the value in
> the table (either directly or via a backdoor access to its own config
> space).
> 
> The later for us comes from the HW PE filtering of the MSI transactions.

Right. The second part of the problem can be avoided with
interrupt-remapping/filtering hardware in the IOMMUs.

	Joerg
