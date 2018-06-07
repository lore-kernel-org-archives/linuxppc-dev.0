Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4120H86d1tzF31D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 08:15:47 +1000 (AEST)
Date: Thu, 7 Jun 2018 16:15:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexey Kardashevskiy  <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Ram
 Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org, Alistair Popple
 <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
Message-ID: <20180607161541.21df6434@w520.home>
In-Reply-To: <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
 <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
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

On Fri, 08 Jun 2018 07:54:02 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2018-06-07 at 11:04 -0600, Alex Williamson wrote:
> > 
> > Can we back up and discuss whether the IOMMU grouping of NVLink
> > connected devices makes sense?  AIUI we have a PCI view of these
> > devices and from that perspective they're isolated.  That's the view of
> > the device used to generate the grouping.  However, not visible to us,
> > these devices are interconnected via NVLink.  What isolation properties
> > does NVLink provide given that its entire purpose for existing seems to
> > be to provide a high performance link for p2p between devices?  
> 
> Not entire. On POWER chips, we also have an nvlink between the device
> and the CPU which is running significantly faster than PCIe.
> 
> But yes, there are cross-links and those should probably be accounted
> for in the grouping.

Then after we fix the grouping, can we just let the host driver manage
this coherent memory range and expose vGPUs to guests?  The use case of
assigning all 6 GPUs to one VM seems pretty limited.  (Might need to
convince NVIDIA to support more than a single vGPU per VM though)
Thanks,

Alex
