Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpL6D1p0vzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 20:56:35 +1000 (AEST)
Message-ID: <1497524175.2897.75.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel 2/3] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for
 IODA host bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Yongji Xie <elohimes@gmail.com>, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@samba.org>, Yongji Xie
 <xyjxie@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Jun 2017 20:56:15 +1000
In-Reply-To: <877f0dppql.fsf@concordia.ellerman.id.au>
References: <20170615054845.8428-1-aik@ozlabs.ru>
 <20170615054845.8428-3-aik@ozlabs.ru>
 <877f0dppql.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 19:25 +1000, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
> > From: Yongji Xie <elohimes@gmail.com>
> > 
> > Any IODA host bridge have the capability of IRQ remapping.
> > So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
> > is detected.
> 
> Where's the code that actually enforces this property?
> 
> It would be good to have a comment in pnv_pci_ioda_root_bridge_prepare()
> (probably), pointing to that code, so that we can remember the
> relationship between the two.

Actually it's not so much remapping as:

 - The bridge can enforce that the interrupt is allowed for a given
partition

 - Because the interrupts are handled via the hypervisor, the latter
can do the remapping.

But the effect is the same, so yes we want the flag. On P9 with XIVE
exploitation we also have HW remapping on top.

Cheers,
Ben.
