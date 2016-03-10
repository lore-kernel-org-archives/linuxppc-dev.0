Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B3CA1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 19:40:08 +1100 (AEDT)
Date: Thu, 10 Mar 2016 19:33:05 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/9] KVM: PPC: Use preregistered memory API to
 access TCE list
Message-ID: <20160310083305.GB1230@fergus.ozlabs.ibm.com>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-4-git-send-email-aik@ozlabs.ru>
 <20160307060014.GL22546@voom.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160307060014.GL22546@voom.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2016 at 05:00:14PM +1100, David Gibson wrote:
> On Mon, Mar 07, 2016 at 02:41:11PM +1100, Alexey Kardashevskiy wrote:
> > VFIO on sPAPR already implements guest memory pre-registration
> > when the entire guest RAM gets pinned. This can be used to translate
> > the physical address of a guest page containing the TCE list
> > from H_PUT_TCE_INDIRECT.
> > 
> > This makes use of the pre-registrered memory API to access TCE list
> > pages in order to avoid unnecessary locking on the KVM memory
> > reverse map.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Ok.. so, what's the benefit of not having to lock the rmap?

It's not primarily about locking or not locking the rmap.  The point
is that when memory is pre-registered, we know that all of guest
memory is pinned and we have a flat array mapping GPA to HPA.  It's
simpler and quicker to index into that array (even with looking up the
kernel page tables in vmalloc_to_phys) than it is to find the memslot,
lock the rmap entry, look up the user page tables, and unlock the rmap
entry.  We were only locking the rmap entry to stop the page being
unmapped and reallocated to something else, but if memory is
pre-registered, it's all pinned, so it can't be reallocated.

Paul.
