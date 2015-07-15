Return-Path: <eric.dumazet@gmail.com>
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com
 [IPv6:2a00:1450:400c:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69B7D1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 22:16:42 +1000 (AEST)
Received: by wgjx7 with SMTP id x7so32003555wgj.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 05:16:39 -0700 (PDT)
Message-ID: <1436962596.1026.10.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH v2 3/3] sched/preempt: fix cond_resched_lock() and
 cond_resched_softirq()
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf
 <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Vrabel
 <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Jul 2015 14:16:36 +0200
In-Reply-To: <20150715095204.12246.98268.stgit@buzz>
References: <20150715095201.12246.49283.stgit@buzz>
 <20150715095204.12246.98268.stgit@buzz>
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

On Wed, 2015-07-15 at 12:52 +0300, Konstantin Khlebnikov wrote:
> These functions check should_resched() before unlocking spinlock/bh-enable:
> preempt_count always non-zero => should_resched() always returns false.
> cond_resched_lock() worked iff spin_needbreak is set.

Interesting, this definitely used to work (linux-3.11)

Any idea of which commit broke things ?
