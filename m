Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PJRC60Y4zF1r7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 03:29:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3FHT18D138170
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 13:29:24 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hbvm8h1cv-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 13:29:24 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Sun, 15 Apr 2018 18:29:21 +0100
Date: Sun, 15 Apr 2018 20:29:11 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/32] docs/vm: convert to ReST format
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180329154607.3d8bda75@lwn.net>
 <20180401063857.GA3357@rapoport-lnx>
 <20180413135551.0e6d1b12@lwn.net>
 <20180413202108.GA30271@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180413202108.GA30271@bombadil.infradead.org>
Message-Id: <20180415172910.GA31176@rapoport-lnx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2018 at 01:21:08PM -0700, Matthew Wilcox wrote:
> On Fri, Apr 13, 2018 at 01:55:51PM -0600, Jonathan Corbet wrote:
> > > I believe that keeping the mm docs together will give better visibility of
> > > what (little) mm documentation we have and will make the updates easier.
> > > The documents that fit well into a certain topic could be linked there. For
> > > instance:
> > 
> > ...but this sounds like just the opposite...?  
> > 
> > I've had this conversation with folks in a number of subsystems.
> > Everybody wants to keep their documentation together in one place - it's
> > easier for the developers after all.  But for the readers I think it's
> > objectively worse.  It perpetuates the mess that Documentation/ is, and
> > forces readers to go digging through all kinds of inappropriate material
> > in the hope of finding something that tells them what they need to know.
> > 
> > So I would *really* like to split the documentation by audience, as has
> > been done for a number of other kernel subsystems (and eventually all, I
> > hope).
> > 
> > I can go ahead and apply the RST conversion, that seems like a step in
> > the right direction regardless.  But I sure hope we don't really have to
> > keep it as an unorganized jumble of stuff...
> 
> I've started on Documentation/core-api/memory.rst which covers just
> memory allocation.  So far it has the Overview and GFP flags sections
> written and an outline for 'The slab allocator', 'The page allocator',
> 'The vmalloc allocator' and 'The page_frag allocator'.  And typing this
> up, I realise we need a 'The percpu allocator'.  I'm thinking that this
> is *not* the right document for the DMA memory allocators (although it
> should link to that documentation).
> 
> I suspect the existing Documentation/vm/ should probably stay as an
> unorganised jumble of stuff.  Developers mostly talking to other MM
> developers.  Stuff that people outside the MM fraternity should know
> about needs to be centrally documented.  By all means convert it to
> ReST ... I don't much care, and it may make it easier to steal bits
> or link to it from the organised documentation.
 
The existing Documentation/vm contains different types of documents. Some
are indeed "Developers mostly talking to other MM developers". Some are
really user/administrator guides. Others are somewhat in between.

I took another look at what's there and I think we can actually move part
of Documentation/vm to Documentation/admin-guide. We can add
Documentation/admin-guide/vm/ and title it "Memory Management Tuning" or
something like that. And several files, e.g. hugetlbpage, ksm, soft-dirty
can be moved there.

-- 
Sincerely yours,
Mike.
