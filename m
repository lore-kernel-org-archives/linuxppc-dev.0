Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4FBCD2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 14:22:43 +1100 (EST)
Message-ID: <1355368956.3224.357.camel@bling.home>
Subject: Re: [PATCH] vfio powerpc: enabled on powernv platform
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Dec 2012 20:22:36 -0700
In-Reply-To: <1355367458.19932.84.camel@pasglop>
References: <1354901926.3224.96.camel@bling.home>
 <1355315657-31153-1-git-send-email-aik@ozlabs.ru>
 <1355355035.3224.343.camel@bling.home> <1355367458.19932.84.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-12-13 at 13:57 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-12-12 at 16:30 -0700, Alex Williamson wrote:
> > Locked page accounting in this version is very, very broken.  How do
> > powerpc folks feel about seemingly generic kernel iommu interfaces
> > messing with the current task mm?  Besides that, more problems
> > below...
> 
> After a second look & thought...
> 
> This whole accounting business is fucked. First, we simply can't just
> randomly return errors from H_PUT_TCE because the process reached some
> rlimit. This is not a proper failure mode. That means that the guest
> will probably panic() ... possibly right in the middle of some disk
> writeback or god knows what. Not good.
> 
> Also the overhead of doing all that crap on every TCE map/unmap is
> ridiculous.
> 
> Finally, it's just not going to work for real mode which we really want,
> since we can't take the mmap-sem in real mode anyway, so unless we
> convert that counter to an atomic, we can't do it.
> 
> I'd suggest just not bothering, or if you want to bother, check once
> when creating a TCE table that the rlimit is enough to bolt as many
> pages as can be populated in that table and fail to create *that*. The
> failure mode is much better, ie, qemu failing to create a PCI bus due to
> insufficient rlimits.

I agree, we don't seem to be headed in the right direction.  x86 needs
to track rlimits or else a user can exploit the interface to pin all the
memory in the system.  On power, only the iova window can be pinned, so
it's a fixed amount.  I could see it as granting access to a group
implicitly grants access to pinning the iova window.  We can still make
it more explicit by handling the rlimit accounting upfront.  Thanks,

Alex
