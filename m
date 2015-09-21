Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B97BD1A03AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 22:12:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 22:12:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 70B583578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 22:12:20 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LCCB9G26804310
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 22:12:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LCBkRH013239
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 22:11:47 +1000
Date: Mon, 21 Sep 2015 22:11:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] VFIO: Accept IOMMU group (PE) ID
Message-ID: <20150921121119.GA19278@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1442591252.23936.254.camel@redhat.com>
 <20150919062247.GC29031@voom.redhat.com>
 <20150921014228.GG20331@voom.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150921014228.GG20331@voom.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 11:42:28AM +1000, David Gibson wrote:
>On Sat, Sep 19, 2015 at 04:22:47PM +1000, David Gibson wrote:
>> On Fri, Sep 18, 2015 at 09:47:32AM -0600, Alex Williamson wrote:
>> > On Fri, 2015-09-18 at 16:24 +1000, Gavin Shan wrote:
>> > > This allows to accept IOMMU group (PE) ID from the parameter from userland
>> > > when handling EEH operation so that the operation only affects the target
>> > > IOMMU group (PE). If the IOMMU group (PE) ID in the parameter from userland
>> > > is invalid, all IOMMU groups (PEs) attached to the specified container are
>> > > affected as before.
>> > > 
>> > > Gavin Shan (2):
>> > >   drivers/vfio: Support EEH API revision
>> > >   drivers/vfio: Support IOMMU group for EEH operations
>> > > 
>> > >  drivers/vfio/vfio_iommu_spapr_tce.c | 50 ++++++++++++++++++++++++++++++++++---
>> > >  drivers/vfio/vfio_spapr_eeh.c       | 46 ++++++++++++++++++++++------------
>> > >  include/linux/vfio.h                | 13 +++++++---
>> > >  include/uapi/linux/vfio.h           |  6 +++++
>> > >  4 files changed, 93 insertions(+), 22 deletions(-)
>> > 
>> > This interface is terrible.  A function named foo_enabled() should
>> > return a bool, yes or no, don't try to overload it to also return a
>> > version.
>> 
>> Sorry, that one's my fault.  I suggested that approach to Gavin
>> without really thinking it through.
>> 
>> 
>> > AFAICT, patch 2/2 breaks current users by changing the offset
>> > of the union in struct vfio_eeh_pe_err.
>> 
>> Yeah, this one's ugly.  We have to preserve the offset, but that means
>> putting the group in a very awkward place.  Especially since I'm not
>> sure if there even are any existing users of the single extant union
>> branch.
>> 
>> Sigh.
>> 
>> > Also, we generally pass group
>> > file descriptors rather than a group ID because we can prove the
>> > ownership of the group through the file descriptor and we don't need to
>> > worry about races with the group because we can hold a reference to it.
>
>Duh.  I finally realised the better, simpler, obvious solution.
>
>Rather than changing the parameter structure, we should move the
>ioctl()s so they're on the group fd instead of the container fd.
>
>Obviously we need to keep it on the container fd for backwards compat,
>but I think we should just error out if there is more than one group
>in the container there.
>
>We will need a new capability too, obviously.  VFIO_EEH_GROUPFD maybe?
>

Yeah, the patches should be marked as "RFC" actually as they're actually
prototypes. I agree with David that the EEH ioctl commands should be routed
through IOMMU group as I proposed long time ago. However, if we're going
to do it now, we have to maintain two set the interfaces: one handled by
container's ioctl() and another one is handled by IOMMU group's ioctl().
Would it be a problem?

Actually, the code change is made based on the fact: nobody is using
the union (struct vfio_eeh_pe_err) yet before the QEMU changes to do
error injection gets merged by David. So I think it's fine to introduce
another field in struct vfio_eeh_pe_op though there is gap?

Thanks,
Gavin
