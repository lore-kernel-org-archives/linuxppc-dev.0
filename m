Return-Path: <eparis@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 29EA9679F7
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 04:20:57 +1000 (EST)
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage
	boundries when needed
From: Eric Paris <eparis@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605171020390.13767@schroedinger.engr.sgi.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
	<Pine.LNX.4.64.0605171020390.13767@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:20:53 -0400
Message-Id: <1147890053.26468.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, wli@holomorphy.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 10:24 -0700, Christoph Lameter wrote:
> On Wed, 17 May 2006, Eric Paris wrote:
> 
> > --- linux-2.6.16.14/include/asm-sparc64/page.h.paris
> > +++ linux-2.6.16.14/include/asm-sparc64/page.h
> > @@ -104,6 +104,8 @@ typedef unsigned long pgprot_t;
> >  #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> >  #define ARCH_HAS_SETCLEAR_HUGE_PTE
> >  #define ARCH_HAS_HUGETLB_PREFAULT_HOOK
> > +/* to align the pointer to the (next) page boundary when dealing with hugepages*/
> > +#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
> >  #endif
> 
> Could you put the definition of HPAGE_ALIGN into include/linux/hugetlb.h 
> to avoid modifying all the page.h files?

I could, I was just following the example of PAGE_ALIGN which was in all
the page.h files.  But since it really is a nonarch specific hugepage
only macro maybe that is a better place for it.

If other results come back positive I'll repost with that change if
others think it best.

-Eric
