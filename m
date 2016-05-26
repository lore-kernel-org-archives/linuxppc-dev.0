Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFw7115S9zDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 02:47:41 +1000 (AEST)
Date: Thu, 26 May 2016 18:47:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, jeremy@goop.org, chrisw@sous-sol.org,
 akataria@vmware.com, rusty@rustcorp.com.au
Subject: Re: [PATCH v3 5/6] pv-qspinlock: use cmpxchg_release in
 __pv_queued_spin_unlock
Message-ID: <20160526164729.GL3206@twins.programming.kicks-ass.net>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464164289-6124-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464164289-6124-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2016 at 04:18:08PM +0800, Pan Xinhui wrote:
> cmpxchg_release is light-wight than cmpxchg, we can gain a better
> performace then. On some arch like ppc, barrier impact the performace
> too much.
> 
> Suggested-by:  Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  kernel/locking/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index a5b1248..2bbffe4 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -614,7 +614,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
>  	 * unhash. Otherwise it would be possible to have multiple @lock
>  	 * entries, which would be BAD.
>  	 */
> -	locked = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
> +	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
>  	if (likely(locked == _Q_LOCKED_VAL))
>  		return;

This patch fails to explain _why_ it can be relaxed.

And seeing how this cmpxchg() can actually unlock the lock, I don't see
how this can possibly be correct. Maybe cmpxchg_release(), but relaxed
seems very wrong.
