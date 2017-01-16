Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v26lj4z1ZzDqSK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 20:05:53 +1100 (AEDT)
Date: Mon, 16 Jan 2017 10:05:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Anton Blanchard <anton@samba.org>
Cc: behanw@converseincode.com, ying.huang@intel.com,
 akpm@linux-foundation.org, oleg@redhat.com,
 Segher Boessenkool <segher@kernel.crashing.org>, mingo@elte.hu,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: llist code relies on undefined behaviour, upsets llvm/clang
Message-ID: <20170116090540.GE3159@twins.programming.kicks-ass.net>
References: <20170116083600.47175073@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170116083600.47175073@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 08:36:00AM +1100, Anton Blanchard wrote:
> Hi,
> 
> I was debugging a hang on a ppc64le kernel built with clang, and it
> looks to be undefined behaviour with pointer wrapping in the llist code.
> 
> A test case is below. llist_for_each_entry() does container_of() on a
> NULL pointer, which wraps our pointer negative, then adds the same
> offset back in and expects to get back to NULL. Unfortunately clang
> decides that this can never be NULL and optimises it into an infinite
> loop.
> 
> Build with -DFIX, such that the llist_node has a zero offset from the
> start of the struct, and things work.
> 
> Is anyone other than ppc64le building kernels with llvm/clang these
> days? This should reproduce on ARM64 and x86-64.

Last I checked I couldn't build a x86_64 kernel with llvm. So no, not
something I've ever ran into.


Also, I would argue that this is broken in llvm, the kernel very much
relies on things like this all over the place. Sure, we're way outside
of what the C language spec says, but who bloody cares ;-)

If llvm wants to compile the kernel, it needs to learn the C dialect the
kernel uses.
