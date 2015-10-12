Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 25BB51A0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 20:30:36 +1100 (AEDT)
Date: Mon, 12 Oct 2015 10:30:34 +0100
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 1/7] atomics: Add test for atomic operations with
 _relaxed variants
Message-ID: <20151012093033.GC16124@arm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-2-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442418575-12297-2-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2015 at 04:49:29PM +0100, Boqun Feng wrote:
> Some atomic operations now have _{relaxed, acquire, release} variants,
> this patch then adds some trivial tests for two purpose:
> 
> 1.	test the behavior of these new operations in single-CPU
> 	environment.
> 2.	make their code generated before we actually use them somewhere,
> 	so that we can examine their assembly code.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  lib/atomic64_test.c | 91 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 32 deletions(-)

FWIW: this was useful to me whilst developing the arm64 relaxed atomic
implementation. Could you extend it to include the recently queued inc/dec
variants too?

Will
