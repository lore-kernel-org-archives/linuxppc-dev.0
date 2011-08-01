Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 64F70B70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 06:28:02 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Avi Kivity <avi@redhat.com>
Date: Mon, 01 Aug 2011 14:27:36 -0600
In-Reply-To: <4E356221.6010302@redhat.com>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312230476.2653.395.camel@bling.home>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>, David Gibson <dwg@au1.ibm.com>,
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

On Sun, 2011-07-31 at 17:09 +0300, Avi Kivity wrote:
> On 07/30/2011 02:58 AM, Benjamin Herrenschmidt wrote:
> > Due to our paravirt nature, we don't need to masquerade the MSI-X table
> > for example. At all. If the guest configures crap into it, too bad, it
> > can only shoot itself in the foot since the host bridge enforce
> > validation anyways as I explained earlier. Because it's all paravirt, we
> > don't need to "translate" the interrupt vectors&  addresses, the guest
> > will call hyercalls to configure things anyways.
> 
> So, you have interrupt redirection?  That is, MSI-x table values encode 
> the vcpu, not pcpu?
> 
> Alex, with interrupt redirection, we can skip this as well?  Perhaps 
> only if the guest enables interrupt redirection?

It's not clear to me how we could skip it.  With VT-d, we'd have to
implement an emulated interrupt remapper and hope that the guest picks
unused indexes in the host interrupt remapping table before it could do
anything useful with direct access to the MSI-X table.  Maybe AMD IOMMU
makes this easier?  Thanks,

Alex
