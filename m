Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhwDw6JdhzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 16:13:52 +1000 (AEST)
Date: Wed, 30 Aug 2017 08:13:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
Message-ID: <20170830061339.GH32112@worktop.programming.kicks-ass.net>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
 <20170828093727.5wldedputadanssh@hirez.programming.kicks-ass.net>
 <1503954877.4850.19.camel@kernel.crashing.org>
 <20170829083352.qrsxvk3lkiydi3o2@hirez.programming.kicks-ass.net>
 <20170829112731.vhgwrzwwlimdbjcn@hirez.programming.kicks-ass.net>
 <1504041570.2358.30.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504041570.2358.30.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 30, 2017 at 07:19:30AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-08-29 at 13:27 +0200, Peter Zijlstra wrote:
> > mpe helped me out and explained that is the PWC hint to TBLIE.
> > 
> > So, you set need_flush_all when you unhook pud/pmd/pte which you then
> > use to set PWC. So free_pgtables() will do the PWC when it unhooks
> > higher level pages.
> > 
> > But you're right that there's some issues, free_pgtables() itself
> > doesn't seem to use mm->page_table_lock,pmd->lock _AT_ALL_ to unhook the
> > pages.
> > 
> > If it were to do that, things should work fine since those locks would
> > then serialize against the speculative faults, we would never install a
> > page if the VMA would be under tear-down and it would thus not be
> > visible to your caches either.
> 
> That's one case. I don't remember of *all* the cases to be honest, but
> I do remember several times over the past few years thinking "ah we are
> fine because the mm sem taken for writing protects us from any
> concurrent tree structure change" :-)

Well, installing always seems to use the locks (it needs to, because its
always done with down_read()), that only leaves removal, and the only
place I know that removes stuff is free_pgtables().

But I think I found another fun place, copy_page_range(). While it
(pointlessly) takes all the PTLs on the dst mm it walks the src page
tables without any PTLs.

This means that if we have a multi-threaded process doing fork() a
thread of the src mm could instantiate page-tables that will not be
copied over.

Of course, this is highly dubious behaviour to begin with, and I don't
think there's anything fundamentally wrong with missing those pages but
we should document this stuff.
