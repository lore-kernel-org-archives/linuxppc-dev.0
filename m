Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 725BDB6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 02:13:46 +1000 (EST)
Date: Tue, 30 Aug 2011 18:13:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110830161343.GB5203@8bytes.org>
References: <1314118861.2859.51.camel@bling.home>
	<CA79326A.FB97%aafabbri@cisco.com> <20110824091035.GD2079@amd.com>
	<1314220434.2859.203.camel@bling.home>
	<20110825105402.GB1923@amd.com>
	<1314292832.2492.31.camel@x201.home>
	<20110825180557.GD8978@8bytes.org>
	<1314381863.2859.312.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314381863.2859.312.camel@bling.home>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, "Roedel, Joerg" <Joerg.Roedel@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, Aaron Fabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2011 at 12:04:22PM -0600, Alex Williamson wrote:
> On Thu, 2011-08-25 at 20:05 +0200, Joerg Roedel wrote:

> > If we really expect segment numbers that need the full 16 bit then this
> > would be the way to go. Otherwise I would prefer returning the group-id
> > directly and partition the group-id space for the error values (s32 with
> > negative numbers being errors).
> 
> It's unlikely to have segments using the top bit, but it would be broken
> for an iommu driver to define it's group numbers using pci s:b:d.f if we
> don't have that bit available.  Ben/David, do PEs have an identifier of
> a convenient size?  I'd guess any hardware based identifier is going to
> use a full unsigned bit width.

Okay, if we want to go the secure way I am fine with the "int *group"
parameter. Another option is to just return u64 and use the extended
number space for errors. But that is even worse as an interface, I
think.

	Joerg
