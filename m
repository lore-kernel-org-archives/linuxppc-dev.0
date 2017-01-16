Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2JVs59sQzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 03:25:25 +1100 (AEDT)
Date: Mon, 16 Jan 2017 17:25:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Anton Blanchard' <anton@samba.org>,
 "behanw@converseincode.com" <behanw@converseincode.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "oleg@redhat.com" <oleg@redhat.com>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 "mingo@elte.hu" <mingo@elte.hu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: llist code relies on undefined behaviour, upsets llvm/clang
Message-ID: <20170116162504.GA6500@twins.programming.kicks-ass.net>
References: <20170116083600.47175073@kryten>
 <063D6719AE5E284EB5DD2968C1650D6DB0264AA5@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0264AA5@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 02:34:43PM +0000, David Laight wrote:
> From: Anton Blanchard
> > Sent: 15 January 2017 21:36
> > I was debugging a hang on a ppc64le kernel built with clang, and it
> > looks to be undefined behaviour with pointer wrapping in the llist code.
> > 
> > A test case is below. llist_for_each_entry() does container_of() on a
> > NULL pointer, which wraps our pointer negative, then adds the same
> > offset back in and expects to get back to NULL. Unfortunately clang
> > decides that this can never be NULL and optimises it into an infinite
> > loop.
> ...
> > #define llist_for_each_entry(pos, node, member)                         \
> >         for ((pos) = llist_entry((node), typeof(*(pos)), member);       \
> >              &(pos)->member != NULL;                                    \
> >              (pos) = llist_entry((pos)->member.next, typeof(*(pos)), member))
> 
> Maybe the above could be rewritten as (untested):
> 		for ((pos) = NULL; (!(pos) ? (node) : ((pos)->member.next) || (pos) = 0) && \
> 			(((pos) = !(pos) ? llist_entry((node), typeof(*(pos)), member) \
> 					: llist_entry((pos)->member.next, typeof(*(pos)), member)),1); )
> Provided the compiler assumes that the loop body is never executed with 'pos == 0'
> it should generate the same code.

That's far uglier code and to what point? The compiler should simply not
assume silly things.
