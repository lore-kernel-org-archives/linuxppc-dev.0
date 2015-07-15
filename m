Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00C921A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 23:35:20 +1000 (AEST)
Date: Wed, 15 Jul 2015 15:35:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-arch@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>,
 xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] sched/preempt: fix cond_resched_lock() and
 cond_resched_softirq()
Message-ID: <20150715133507.GR19282@twins.programming.kicks-ass.net>
References: <20150715095201.12246.49283.stgit@buzz>
 <20150715095204.12246.98268.stgit@buzz>
 <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
 <55A65792.80903@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A65792.80903@yandex-team.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 15, 2015 at 03:52:34PM +0300, Konstantin Khlebnikov wrote:
> On 15.07.2015 15:16, Eric Dumazet wrote:
> >On Wed, 2015-07-15 at 12:52 +0300, Konstantin Khlebnikov wrote:
> >>These functions check should_resched() before unlocking spinlock/bh-enable:
> >>preempt_count always non-zero => should_resched() always returns false.
> >>cond_resched_lock() worked iff spin_needbreak is set.
> >
> >Interesting, this definitely used to work (linux-3.11)
> >
> >Any idea of which commit broke things ?
> >
> 
> Searching... done
> 
> This one: bdb43806589096ac4272fe1307e789846ac08d7c in v3.13
> 
> before
> 
> -static inline int should_resched(void)
> -{
> -       return need_resched() && !(preempt_count() & PREEMPT_ACTIVE);
> -}
> 
> after
> 
> +static __always_inline bool should_resched(void)
> +{
> +       return unlikely(!*preempt_count_ptr());
> +}

Argh, indeed!

> 
> So,
> 
> Fixes: bdb438065890 ("sched: Extract the basic add/sub preempt_count
> modifiers")

Thanks!
