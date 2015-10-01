Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61D3E1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 22:36:36 +1000 (AEST)
Date: Thu, 1 Oct 2015 14:36:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 5/7] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151001123626.GB3281@worktop.programming.kicks-ass.net>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 02:27:15PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 16, 2015 at 11:49:33PM +0800, Boqun Feng wrote:
> > Unlike other atomic operation variants, cmpxchg{,64}_acquire and
> > atomic{,64}_cmpxchg_acquire don't have acquire semantics if the cmp part
> > fails, so we need to implement these using assembly.
> 
> I think that is actually expected and documented. That is, a cmpxchg
> only implies barriers on success. See:
> 
>   ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory ordering semantics")

Also:

654672d4ba1a6 (Will Deacon     2015-08-06 17:54:37 +0100  28)  * store portion of the operation. Note that a failed cmpxchg_acquire
654672d4ba1a6 (Will Deacon     2015-08-06 17:54:37 +0100  29)  * does -not- imply any memory ordering constraints.
