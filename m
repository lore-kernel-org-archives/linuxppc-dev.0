Return-Path: <khlebnikov@yandex-team.ru>
Received: from forward-corp1g.mail.yandex.net (forward-corp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2B8B1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 22:52:42 +1000 (AEST)
Message-ID: <55A65792.80903@yandex-team.ru>
Date: Wed, 15 Jul 2015 15:52:34 +0300
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
MIME-Version: 1.0
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] sched/preempt: fix cond_resched_lock() and
 cond_resched_softirq()
References: <20150715095201.12246.49283.stgit@buzz>	
 <20150715095204.12246.98268.stgit@buzz>
 <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
In-Reply-To: <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.07.2015 15:16, Eric Dumazet wrote:
> On Wed, 2015-07-15 at 12:52 +0300, Konstantin Khlebnikov wrote:
>> These functions check should_resched() before unlocking spinlock/bh-enable:
>> preempt_count always non-zero => should_resched() always returns false.
>> cond_resched_lock() worked iff spin_needbreak is set.
>
> Interesting, this definitely used to work (linux-3.11)
>
> Any idea of which commit broke things ?
>

Searching... done

This one: bdb43806589096ac4272fe1307e789846ac08d7c in v3.13

before

-static inline int should_resched(void)
-{
-       return need_resched() && !(preempt_count() & PREEMPT_ACTIVE);
-}

after

+static __always_inline bool should_resched(void)
+{
+       return unlikely(!*preempt_count_ptr());
+}


So,

Fixes: bdb438065890 ("sched: Extract the basic add/sub preempt_count 
modifiers")

-- 
Konstantin
