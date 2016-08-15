Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCfcv32kyzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 01:32:31 +1000 (AEST)
Date: Mon, 15 Aug 2016 09:32:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
Message-ID: <20160815093227.1bb06da5@t450s.home>
In-Reply-To: <20160815035947.GA6923@oak.ozlabs.ibm.com>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
 <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <20160815035947.GA6923@oak.ozlabs.ibm.com>
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

On Mon, 15 Aug 2016 13:59:47 +1000
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Tue, Aug 09, 2016 at 06:16:30AM -0600, Alex Williamson wrote:
> > On Tue, 9 Aug 2016 15:19:39 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> > > On 09/08/16 02:43, Alex Williamson wrote:  
> > > > 
> > > > I think you need to take a closer look of the lifecycle of a container,
> > > > having a reference means the container itself won't go away, but only
> > > > having a group set within that container holds the actual IOMMU
> > > > references.  container->iommu_data is going to be NULL once the
> > > > groups are lost.  Thanks,    
> > > 
> > > 
> > > Container owns the iommu tables and this is what I care about here, groups
> > > attached or not - this is handled separately via IOMMU group list in a
> > > specific iommu_table struct, these groups get detached from iommu_table
> > > when they are removed from a container.  
> > 
> > The container doesn't own anything, the container is privileged by the
> > groups being attached to it.  When groups are closed, they detach from
> > the container and once the container group list is empty the iommu
> > backend is released and iommu_data is NULL.  A container reference
> > doesn't give you what you're looking for.  It implies nothing about the
> > iommu backend.  
> 
> Alex, I'd like to understand more what the objection is here - is it
> just about the object lifetimes, or is it a more fundamental objection
> to the style of interface?
> 
> Regarding lifetimes, my understanding was that Alexey's previous
> patches added refcounting to the iommu tables, so that KVM could get a
> reference to the iommu tables through the container and then safely
> use the iommu tables directly.  There may still be a potential race in
> the interval between asking the container about its iommu tables and
> incrementing the tables' reference counts, but that should be able to
> be solved.  I don't see any unsolvable problem regarding lifetimes.
> 
> Or is your objection about any external access to the container?
> As far as I know, when a group is not part of a container it has its
> own iommu tables, but when it is put in a container it loses its own
> iommu tables and instead uses a common pair of iommu tables (one for
> the 32-bit window, one for the 64-bit window) that belong to the
> container.  So we do in fact need the container's iommu tables not the
> individual groups' tables.

Hi Paul,

Have you looked at this?  The ends do not justify the means.  First off
we're trying to create an external user interface to get and put a
reference to a container for the purpose of getting a reference to
iommu data.  So you might expect that that reference actually maintains
that iommu data, right?  Wrong.  The container is just the gateway
through which we access the iommu, a reference to the container doesn't
actually include a reference to the iommu backing it.  The user can
unset and reconstitute a new iommu state any time they want to and it's
actually the groups that privilege the container to have an iommu state
at all, so removal of groups automatically de-privileges the container
and the reference to the state is lost.  So the reference we're
creating a meaningless for the intended context.

Furthermore, why are we trying to get this reference?  Alexey wants to
add an interface that allows an _external_ user to get the _opaque_,
_private_ data structure for the iommu backend.  Are bells and whistles
going off in your head yet?  Without any validation of what iommu
backend is running we pass that void* to a function that casts it as a
struct tce_container and starts iterating through it.  This is
horribly, horribly wrong.  Thanks,

Alex
