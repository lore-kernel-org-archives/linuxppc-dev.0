Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2CqB5XTKzDqRg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 23:54:14 +1100 (AEDT)
Date: Mon, 16 Jan 2017 13:53:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Anton Blanchard <anton@samba.org>
Cc: behanw@converseincode.com, ying.huang@intel.com,
 akpm@linux-foundation.org, oleg@redhat.com,
 Segher Boessenkool <segher@kernel.crashing.org>, mingo@elte.hu,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: llist code relies on undefined behaviour, upsets llvm/clang
Message-ID: <20170116125356.GF3159@twins.programming.kicks-ass.net>
References: <20170116083600.47175073@kryten>
 <20170116090540.GE3159@twins.programming.kicks-ass.net>
 <20170116224229.17d1f6fc@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170116224229.17d1f6fc@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 10:42:29PM +1100, Anton Blanchard wrote:
> Hi Peter,
> 
> > Last I checked I couldn't build a x86_64 kernel with llvm. So no, not
> > something I've ever ran into.
> > 
> > Also, I would argue that this is broken in llvm, the kernel very much
> > relies on things like this all over the place. Sure, we're way outside
> > of what the C language spec says, but who bloody cares ;-)
> 
> True, but is there anything preventing gcc from implementing this
> optimisation in the future? If we are relying on undefined behaviour we
> should have a -fno-strict-* option to cover it.
> 
> > If llvm wants to compile the kernel, it needs to learn the C dialect
> > the kernel uses.
> 
> LLVM has done that before (eg adding -fno-strict-overflow). I don't
> think that option covers this case however.

Our comment there states:

# disable invalid "can't wrap" optimizations for signed / pointers
KBUILD_CFLAGS   += $(call cc-option,-fno-strict-overflow)

So this option should apply to pointer arithmetic, therefore I would
expect -fno-strict-overflow to actually apply here, or am I missing
something?
