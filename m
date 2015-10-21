Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BDC21A039E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 19:18:34 +1100 (AEDT)
Date: Wed, 21 Oct 2015 10:18:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151021081833.GB2881@worktop.programming.kicks-ass.net>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151020212835.GH5105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 20, 2015 at 02:28:35PM -0700, Paul E. McKenney wrote:
> I am not seeing a sync there, but I really have to defer to the
> maintainers on this one.  I could easily have missed one.

So x86 implies a full barrier for everything that changes the CPL; and
some form of implied ordering seems a must if you change the privilege
level unless you tag every single load/store with the priv level at that
time, which seems the more expensive option.

So I suspect the typical implementation will flush all load/stores,
change the effective priv level and continue.

This can of course be implemented at a pure per CPU ordering (RCpc),
which would be in line with the rest of Power, in which case you do
indeed need an explicit sync to make it visible to other CPUs.

But yes, if Michael or Ben could clarify this it would be good.

Back then I talked to Ralf about what MIPS says on this, and MIPS arch
spec is entirely quiet on this, it allows implementations full freedom
IIRC.

</ramble>
