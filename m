Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4123M274YTzF34C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 10:34:21 +1000 (AEST)
Date: Thu, 7 Jun 2018 18:34:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Ram
 Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org, Alistair Popple
 <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
Message-ID: <20180607183417.3ff2acf1@w520.home>
In-Reply-To: <33590885d138195c8ede78b588ddb03b132267fd.camel@kernel.crashing.org>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
 <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
 <20180607161541.21df6434@w520.home>
 <33590885d138195c8ede78b588ddb03b132267fd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 08 Jun 2018 09:20:30 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2018-06-07 at 16:15 -0600, Alex Williamson wrote:
> > On Fri, 08 Jun 2018 07:54:02 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >   
> > > On Thu, 2018-06-07 at 11:04 -0600, Alex Williamson wrote:  
> > > > 
> > > > Can we back up and discuss whether the IOMMU grouping of NVLink
> > > > connected devices makes sense?  AIUI we have a PCI view of these
> > > > devices and from that perspective they're isolated.  That's the view of
> > > > the device used to generate the grouping.  However, not visible to us,
> > > > these devices are interconnected via NVLink.  What isolation properties
> > > > does NVLink provide given that its entire purpose for existing seems to
> > > > be to provide a high performance link for p2p between devices?    
> > > 
> > > Not entire. On POWER chips, we also have an nvlink between the device
> > > and the CPU which is running significantly faster than PCIe.
> > > 
> > > But yes, there are cross-links and those should probably be accounted
> > > for in the grouping.  
> > 
> > Then after we fix the grouping, can we just let the host driver manage
> > this coherent memory range and expose vGPUs to guests?  The use case of
> > assigning all 6 GPUs to one VM seems pretty limited.  (Might need to
> > convince NVIDIA to support more than a single vGPU per VM though)
> > Thanks,  
> 
> I don't know about "vGPUs" and what nVidia may be cooking in that area.
> 
> The patched from Alexey allow for passing through the full thing, but
> they aren't trivial (there are additional issues, I'm not sure how
> covered they are, as we need to pay with the mapping attributes of
> portions of the GPU memory on the host side...).
> 
> Note: The cross-links are only per-socket so that would be 2 groups of
> 3.
> 
> We *can* allow individual GPUs to be passed through, either if somebody
> designs a system without cross links, or if the user is ok with the
> security risk as the guest driver will not enable them if it doesn't
> "find" both sides of them.

If GPUs are not isolated and we cannot prevent them from probing each
other via these links, then I think we have an obligation to configure
grouping in a way that doesn't rely on a benevolent userspace.  Thanks,

Alex
