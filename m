Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CD331A05AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 11:10:01 +1100 (AEDT)
Message-ID: <1444781400.12197.4.camel@ellerman.id.au>
Subject: Re: [PATCH RESEND v3 1/6] powerpc: atomic: Make *xchg and *cmpxchg
 a full barrier
From: Michael Ellerman <mpe@ellerman.id.au>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon
 <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 stable@vger.kernel.org
Date: Wed, 14 Oct 2015 11:10:00 +1100
In-Reply-To: <1444660220-25559-1-git-send-email-boqun.feng@gmail.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444660220-25559-1-git-send-email-boqun.feng@gmail.com>
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

On Mon, 2015-10-12 at 22:30 +0800, Boqun Feng wrote:
> According to memory-barriers.txt, xchg, cmpxchg and their atomic{,64}_
> versions all need to imply a full barrier, however they are now just
> RELEASE+ACQUIRE, which is not a full barrier.
> 
> So replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
> PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
> __{cmp,}xchg_{u32,u64} respectively to guarantee a full barrier
> semantics of atomic{,64}_{cmp,}xchg() and {cmp,}xchg().
> 
> This patch is a complement of commit b97021f85517 ("powerpc: Fix
> atomic_xxx_return barrier semantics").
> 
> Cc: <stable@vger.kernel.org> # 3.4.y-
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Hi Boqun,

Thanks for fixing this. In future you should send a patch like this as a
separate patch. I've not been paying attention to it because I assumed it was
part of your full series and was still under discussion like the other patches.

I don't think we've seen any crashes caused by this have we? So I guess I'll
put it in next to let it get some wider testing rather than sending it straight
to Linus.

To be clear you're doing:

> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER

Which is correct but doesn't actually change anything at the moment, because
both macros turn into LWSYNC.

On the other hand:

> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER

Is changing an isync (which is then patched to lwsync on some cpus), with a sync.


Also I'm not clear what your stable line means:

> Cc: <stable@vger.kernel.org> # 3.4.y-

Do you mean 3.4 and anything after? I usually write that as 3.4+, but I'm not
sure if that's the correct syntax either.


cheers
