Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh5YD4h4zzDqBf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 08:10:08 +1000 (AEST)
Message-ID: <1503954877.4850.19.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>, "Kirill A. Shutemov"
 <kirill@shutemov.name>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Date: Tue, 29 Aug 2017 07:14:37 +1000
In-Reply-To: <20170828093727.5wldedputadanssh@hirez.programming.kicks-ass.net>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
 <20170828093727.5wldedputadanssh@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 11:37 +0200, Peter Zijlstra wrote:
> > Doing all this job and just give up because we cannot allocate page tables
> > looks very wasteful to me.
> > 
> > Have you considered to look how we can hand over from speculative to
> > non-speculative path without starting from scratch (when possible)?
> 
> So we _can_ in fact allocate and install page-tables, but we have to be
> very careful about it. The interesting case is where we race with
> free_pgtables() and install a page that was just taken out.
> 
> But since we already have the VMA I think we can do something like:

That makes me extremely nervous... there could be all sort of
assumptions esp. in arch code about the fact that we never populate the
tree without the mm sem.

We'd have to audit archs closely. Things like the page walk cache
flushing on power etc...

I don't mind the "retry" .. .we've brought stuff in the L1 cache
already which I would expect to be the bulk of the overhead, and the
allocation case isn't that common. Do we have numbers to show how
destrimental this is today ?

Cheers,
Ben.
