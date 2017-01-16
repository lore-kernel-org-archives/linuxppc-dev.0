Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2BDy2dMvzDqRl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 22:42:56 +1100 (AEDT)
Date: Mon, 16 Jan 2017 22:42:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: behanw@converseincode.com, ying.huang@intel.com,
 akpm@linux-foundation.org, oleg@redhat.com, Segher Boessenkool
 <segher@kernel.crashing.org>, mingo@elte.hu, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: llist code relies on undefined behaviour, upsets llvm/clang
Message-ID: <20170116224229.17d1f6fc@kryten>
In-Reply-To: <20170116090540.GE3159@twins.programming.kicks-ass.net>
References: <20170116083600.47175073@kryten>
 <20170116090540.GE3159@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

> Last I checked I couldn't build a x86_64 kernel with llvm. So no, not
> something I've ever ran into.
> 
> Also, I would argue that this is broken in llvm, the kernel very much
> relies on things like this all over the place. Sure, we're way outside
> of what the C language spec says, but who bloody cares ;-)

True, but is there anything preventing gcc from implementing this
optimisation in the future? If we are relying on undefined behaviour we
should have a -fno-strict-* option to cover it.

> If llvm wants to compile the kernel, it needs to learn the C dialect
> the kernel uses.

LLVM has done that before (eg adding -fno-strict-overflow). I don't
think that option covers this case however.

Anton
