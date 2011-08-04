Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 41D3CB6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Aug 2011 20:41:07 +1000 (EST)
Date: Thu, 4 Aug 2011 12:41:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110804104105.GC22329@8bytes.org>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312230476.2653.395.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312230476.2653.395.camel@bling.home>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	David Gibson <dwg@au1.ibm.com>, Avi Kivity <avi@redhat.com>,
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

On Mon, Aug 01, 2011 at 02:27:36PM -0600, Alex Williamson wrote:
> It's not clear to me how we could skip it.  With VT-d, we'd have to
> implement an emulated interrupt remapper and hope that the guest picks
> unused indexes in the host interrupt remapping table before it could do
> anything useful with direct access to the MSI-X table.  Maybe AMD IOMMU
> makes this easier?

AMD IOMMU provides remapping tables per-device, and not a global one.
But that does not make direct guest-access to the MSI-X table safe. The
table contains the table contains the interrupt-type and the vector
which is used as an index into the remapping table by the IOMMU. So when
the guest writes into its MSI-X table the remapping-table in the host
needs to be updated too.

	Joerg
