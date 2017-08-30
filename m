Return-Path: <jglisse@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhnBc35v0zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:56:24 +1000 (AEST)
Date: Tue, 29 Aug 2017 20:56:15 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bernhard Held <berny156@gmx.de>, Adam Borowski <kilobyte@angband.pl>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Sudeep Dutt <sudeep.dutt@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Dimitri Sivanich <sivanich@sgi.com>, Jack Steiner <steiner@sgi.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 DRI <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
 xen-devel <xen-devel@lists.xenproject.org>, KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 00/13] mmu_notifier kill invalidate_page callback
Message-ID: <20170830005615.GA2386@redhat.com>
References: <20170829235447.10050-1-jglisse@redhat.com>
 <CA+55aFz6ArJ-ADXiYCu6xMUzdY=mKBtkzfJmLaBohC6Ub9t2SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+55aFz6ArJ-ADXiYCu6xMUzdY=mKBtkzfJmLaBohC6Ub9t2SQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2017 at 05:11:24PM -0700, Linus Torvalds wrote:
> On Tue, Aug 29, 2017 at 4:54 PM, Jérôme Glisse <jglisse@redhat.com> wrote:
> >
> > Note this is barely tested. I intend to do more testing of next few days
> > but i do not have access to all hardware that make use of the mmu_notifier
> > API.
> 
> Thanks for doing this.
> 
> > First 2 patches convert existing call of mmu_notifier_invalidate_page()
> > to mmu_notifier_invalidate_range() and bracket those call with call to
> > mmu_notifier_invalidate_range_start()/end().
> 
> Ok, those two patches are a bit more complex than I was hoping for,
> but not *too* bad.
> 
> And the final end result certainly looks nice:
> 
> >  16 files changed, 74 insertions(+), 214 deletions(-)
> 
> Yeah, removing all those invalidate_page() notifiers certainly makes
> for a nice patch.
> 
> And I actually think you missed some more lines that can now be
> removed: kvm_arch_mmu_notifier_invalidate_page() should no longer be
> needed either, so you can remove all of those too (most of them are
> empty inline functions, but x86 has one that actually does something.
> 
> So there's an added 30 or so dead lines that should be removed in the
> kvm patch, I think.

Yes i missed that. I will wait for people to test and for result of my
own test before reposting if need be, otherwise i will post as separate
patch.

> 
> But from a _very_ quick read-through this looks fine. But it obviously
> needs testing.
> 
> People - *especially* the people who saw issues under KVM - can you
> try out Jérôme's patch-series? I aded some people to the cc, the full
> series is on lkml. Jérôme - do you have a git branch for people to
> test that they could easily pull and try out?

https://cgit.freedesktop.org/~glisse/linux mmu-notifier branch
git://people.freedesktop.org/~glisse/linux

(Sorry if that tree is bit big it has a lot of dead thing i need
 to push a clean and slim one)

Jérôme
