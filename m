Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8RX82nmVzDvHw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 12:02:32 +1100 (AEDT)
Date: Thu, 3 Nov 2016 12:02:28 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161103010228.GD4764@fergus.ozlabs.ibm.com>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
 <20161025044414.GW11052@umbus.fritz.box>
 <9f5fda35-be4d-12d1-e027-d8576cc8e8fe@ozlabs.ru>
 <20161031031318.GM18226@umbus.fritz.box>
 <baf7960d-dbd2-efc8-5574-6a575f2714c6@ozlabs.ru>
 <20161031042347.GN18226@umbus.fritz.box>
 <d03177f8-231e-cef7-d518-e33bea5a1cfb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d03177f8-231e-cef7-d518-e33bea5a1cfb@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 02, 2016 at 01:44:03PM +1100, Alexey Kardashevskiy wrote:
> On 31/10/16 15:23, David Gibson wrote:
[...]
> > 
> > Um.. yeah.. that's not really ok.  Prohibiting overlapping
> > registrations on the same container is reasonable enough.  Having a
> > container not be able to register memory because some completely
> > different container has registered something overlapping is getting
> > very ugly.
> 
> I am lost here. Does this mean the patches cannot go upstream?
> 
> Also how would I implement overlapping if we are not teaching KVM about
> VFIO containers? The mm list has a counter of how many times each memory
> region was mapped via TCE (and this prevents unregistration), and if we
> want overlapping regions - a "mapped" counter of which one would I update
> in real mode (where I only have a user address and a LIOBN)?

The patches fix a real bug, where we run out of memory to run VMs.

The patches don't change the interface, and don't introduce the
constraint that is being discussed here (that the regions being
registered may not overlap unless they are identical to a previously
registered region).  That constraint is already present in the
upstream code.

They do change the behaviour when you use a container fd from a
different process from the one which opened the fd, but that is not
something that worked in any meaningful way before anyway.

So David, do you still see any reason why the patches should not be
accepted?

Regards,
Paul.
