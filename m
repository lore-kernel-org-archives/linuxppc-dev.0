Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWTHM73SrzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 23:28:30 +1100 (AEDT)
Received: by mail-wm0-x233.google.com with SMTP id r68so3484436wmr.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Nov 2017 04:28:30 -0800 (PST)
Date: Tue, 7 Nov 2017 15:28:25 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <20171107122825.posamr2dmzlzvs2p@node.shutemov.name>
References: <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
 <20171107222228.0c8a50ff@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107222228.0c8a50ff@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2017 at 10:56:36PM +1100, Nicholas Piggin wrote:
> > No, it won't. You will hit stack first.
> 
> I guess so. Florian's bug didn't crash there for some reason, okay
> but I suppose my point about brk is not exactly where the standard
> heap is, but the pattern of allocations. An allocator that uses
> mmap for managing its address space might do the same thing, e.g.,
> incrementally expand existing mmaps as necessary.

With MAP_FIXED? I don't think so.

> > > Second, the kernel can never completely solve the problem this way.
> > > How do we know a malloc library will not ask for > 128TB addresses
> > > and pass them to an unknowing application?  
> > 
> > The idea is that an application can provide hint (mallopt() ?) to malloc
> > implementation that it's ready to full address space. In this case, malloc
> > can use mmap((void *) -1,...) for its allocations and get full address
> > space this way.
> 
> Point is, there's nothing stopping an allocator library or runtime
> from asking for mmap anywhere and returning it to userspace.

Right. Nobody would stop it from doing stupid things. There are many
things that a library may do that application would not be happy about.

> Do > 128TB pointers matter so much that we should add this heuristic
> to prevent breakage, but little enough that we can accept some rare
> cases getting through? Genuine question.

At the end of the day what matters is if heuristic helps prevent breakage
of existing userspace and doesn't stay in the way of legitimate use of
full address space.

So far, it looks okay to me.

> > The idea was we shouldn't allow to slip above 47-bits by accidentally.
> > 
> > Correctly functioning program would never request addr+len above 47-bit
> > with MAP_FIXED, unless it's ready to handle such addresses. Otherwise the
> > request would simply fail on machine that doesn't support large VA.
> > 
> > In contrast, addr+len above 47-bit without MAP_FIXED will not fail on
> > machine that doesn't support large VA, kernel will find another place
> > under 47-bit. And I can imagine a reasonable application that does
> > something like this.
> > 
> > So we cannot rely that application is ready to handle large
> > addresses if we see addr+len without MAP_FIXED.
> 
> By the same logic, a request for addr > 128TB without MAP_FIXED will
> not fail, therefore we can't rely on that either.
> 
> Or an app that links to a library that attempts MAP_FIXED allocation
> of addr + len above 128TB might use high bits of pointer returned by
> that library because those are never satisfied today and the library
> would fall back.

If you want to point that it's ABI break, yes it is.

But we allow ABI break as long as nobody notices. I think it's reasonable
to expect that nobody relies on such corner cases.

If we would find any piece of software affect by the change we would need
to reconsider.

-- 
 Kirill A. Shutemov
