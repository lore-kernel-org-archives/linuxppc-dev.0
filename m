Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3b302PLRzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 19:24:28 +1000 (AEST)
Date: Thu, 13 Apr 2017 11:24:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
 edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
 bobby.prani@gmail.com, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH tip/core/rcu 02/40] rcu: Make arch select
 smp_mb__after_unlock_lock() strength
Message-ID: <20170413092418.a2rudzukbgookior@hirez.programming.kicks-ass.net>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-2-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492018825-25634-2-git-send-email-paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2017 at 10:39:47AM -0700, Paul E. McKenney wrote:
> The definition of smp_mb__after_unlock_lock() is currently smp_mb()
> for CONFIG_PPC and a no-op otherwise.  It would be better to instead
> provide an architecture-selectable Kconfig option, and select the
> strength of smp_mb__after_unlock_lock() based on that option. 


Why is this better? Do we want to have more of this? I thought we still
wanted to convince PPC to go RCsc and eradicate all this RCpc 'fun'. But
instead now you're making it look like its OK to grow more of this pain.
