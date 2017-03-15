Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjxbx29pMzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:18:21 +1100 (AEDT)
Date: Wed, 15 Mar 2017 10:18:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v8 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170315101812.38946ca9@t450s.home>
In-Reply-To: <20170315044014.GA12603@umbus.fritz.box>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310035337.22091-11-aik@ozlabs.ru>
 <20170314150527.1c46c3c8@t450s.home>
 <20170315044014.GA12603@umbus.fritz.box>
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

On Wed, 15 Mar 2017 15:40:14 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:
> > > diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> > > index e96a4590464c..be18cda01e1b 100644
> > > --- a/arch/powerpc/kvm/book3s_64_vio.c
> > > +++ b/arch/powerpc/kvm/book3s_64_vio.c
> > > @@ -28,6 +28,10 @@
> > >  #include <linux/hugetlb.h>
> > >  #include <linux/list.h>
> > >  #include <linux/anon_inodes.h>
> > > +#include <linux/iommu.h>
> > > +#include <linux/file.h>
> > > +#include <linux/vfio.h>
> > > +#include <linux/module.h>
> > >  
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/kvm_ppc.h>
> > > @@ -40,6 +44,36 @@
> > >  #include <asm/udbg.h>
> > >  #include <asm/iommu.h>
> > >  #include <asm/tce.h>
> > > +#include <asm/mmu_context.h>
> > > +
> > > +static void kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
> > > +{
> > > +	void (*fn)(struct vfio_group *);
> > > +
> > > +	fn = symbol_get(vfio_group_put_external_user);
> > > +	if (WARN_ON(!fn))
> > > +		return;
> > > +
> > > +	fn(vfio_group);
> > > +
> > > +	symbol_put(vfio_group_put_external_user);
> > > +}
> > > +
> > > +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
> > > +{
> > > +	int (*fn)(struct vfio_group *);
> > > +	int ret = -1;
> > > +
> > > +	fn = symbol_get(vfio_external_user_iommu_id);
> > > +	if (!fn)
> > > +		return ret;
> > > +
> > > +	ret = fn(vfio_group);
> > > +
> > > +	symbol_put(vfio_external_user_iommu_id);
> > > +
> > > +	return ret;
> > > +}  
> > 
> > 
> > Ugh.  This feels so wrong.  Why can't you have kvm-vfio pass the
> > iommu_group?  Why do you need to hold this additional vfio_group
> > reference?  
> 
> Keeping the vfio_group reference makes sense to me, since we don't
> want the vfio context for the group to go away while it's attached to
> the LIOBN.

But there's already a reference for that, it's taken by
KVM_DEV_VFIO_GROUP_ADD and held until KVM_DEV_VFIO_GROUP_DEL.  Both the
DEL path and the cleanup path call kvm_spapr_tce_release_iommu_group()
before releasing that reference, so it seems entirely redundant.

> However, going via the iommu_id rather than just having an interface
> to directly grab the iommu group from the vfio_group seems bizarre to
> me.  I'm ok with cleaning that up later, however.

We have kvm_spapr_tce_attach_iommu_group() and
kvm_spapr_tce_release_iommu_group(), but both take a vfio_group, not an
iommu_group as a parameter.  I don't particularly have a problem with
the vfio_group -> iommu ID -> iommu_group, but if we drop the extra
vfio_group reference and pass the iommu_group itself to these functions
then we can keep all the symbol reference stuff in the kvm-vfio glue
layer.  Thanks,

Alex
