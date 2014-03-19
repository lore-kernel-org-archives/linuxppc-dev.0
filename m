Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 90F8E2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 04:08:48 +1100 (EST)
Date: Wed, 19 Mar 2014 18:08:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140319170829.GD8557@laptop.programming.kicks-ass.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140319154705.GB8557@laptop.programming.kicks-ass.net>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 davidlohr@hp.com, paulus@samba.org, tglx@linutronix.de,
 torvalds@linux-foundation.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 04:47:05PM +0100, Peter Zijlstra wrote:
> > I reverted b0c29f79ecea0b6fbcefc999e70f2843ae8306db on top of v3.14-rc6 and confirmed that
> > reverting the commit solved the problem.
> 
> Joy,.. let me look at that with ppc in mind.

OK; so while pretty much all the comments from that patch are utter
nonsense (what was I thinking), I cannot actually find a real bug.

But could you try the below which replaces a control dependency with a
full barrier. The control flow is plenty convoluted that I think the
control barrier isn't actually valid anymore and that might indeed
explain the fail.


--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -119,42 +119,32 @@
  * sys_futex(WAIT, futex, val);
  *   futex_wait(futex, val);
  *
- *   waiters++;
- *   mb(); (A) <-- paired with -.
- *                              |
- *   lock(hash_bucket(futex));  |
- *                              |
- *   uval = *futex;             |
- *                              |        *futex = newval;
- *                              |        sys_futex(WAKE, futex);
- *                              |          futex_wake(futex);
- *                              |
- *                              `------->  mb(); (B)
- *   if (uval == val)
+ *
+ *   lock(hash_bucket(futex)); (A)
+ *
+ *   uval = *futex;
+ *                                       *futex = newval;
+ *                                       sys_futex(WAKE, futex);
+ *                                         futex_wake(futex);
+ *
+ *   if (uval == val) (B)		   smp_mb(); (D)
  *     queue();
- *     unlock(hash_bucket(futex));
- *     schedule();                         if (waiters)
+ *     unlock(hash_bucket(futex)); (C)
+ *     schedule();                         if (spin_is_locked(&hb_lock) ||
+ *					       (smp_rmb(), !plist_empty))) (E)
  *                                           lock(hash_bucket(futex));
  *                                           wake_waiters(futex);
  *                                           unlock(hash_bucket(futex));
  *
- * Where (A) orders the waiters increment and the futex value read -- this
- * is guaranteed by the head counter in the hb spinlock; and where (B)
- * orders the write to futex and the waiters read -- this is done by the
- * barriers in get_futex_key_refs(), through either ihold or atomic_inc,
- * depending on the futex type.
- *
- * This yields the following case (where X:=waiters, Y:=futex):
- *
- *	X = Y = 0
- *
- *	w[X]=1		w[Y]=1
- *	MB		MB
- *	r[Y]=y		r[X]=x
- *
- * Which guarantees that x==0 && y==0 is impossible; which translates back into
- * the guarantee that we cannot both miss the futex variable change and the
- * enqueue.
+ *
+ * Because of the acquire (A) and release (C) the futex value load and the 
+ * plist_add are guaranteed to be inside the locked region. Furthermore, the
+ * control dependency (B) ensures the futex load happens before the plist_add().
+ *
+ * On the wakeup side, the full barrier (D) separates the futex value write
+ * from the hb_lock load, and matches with the control dependency. The rmb (E)
+ * separates the spin_is_locked() read and the plist_head_empty() read, such
+ * that ..., matches with the release barrier (C).
  */
 
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
@@ -250,7 +240,7 @@ static inline void futex_get_mm(union fu
 	/*
 	 * Ensure futex_get_mm() implies a full barrier such that
 	 * get_futex_key() implies a full barrier. This is relied upon
-	 * as full barrier (B), see the ordering comment above.
+	 * as full barrier (D), see the ordering comment above.
 	 */
 	smp_mb__after_atomic();
 }
@@ -308,10 +298,10 @@ static void get_futex_key_refs(union fut
 
 	switch (key->both.offset & (FUT_OFF_INODE|FUT_OFF_MMSHARED)) {
 	case FUT_OFF_INODE:
-		ihold(key->shared.inode); /* implies MB (B) */
+		ihold(key->shared.inode); /* implies MB (D) */
 		break;
 	case FUT_OFF_MMSHARED:
-		futex_get_mm(key); /* implies MB (B) */
+		futex_get_mm(key); /* implies MB (D) */
 		break;
 	}
 }
@@ -385,7 +375,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 	if (!fshared) {
 		key->private.mm = mm;
 		key->private.address = address;
-		get_futex_key_refs(key);  /* implies MB (B) */
+		get_futex_key_refs(key);  /* implies MB (D) */
 		return 0;
 	}
 
@@ -492,7 +482,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 		key->shared.pgoff = basepage_index(page);
 	}
 
-	get_futex_key_refs(key); /* implies MB (B) */
+	get_futex_key_refs(key); /* implies MB (D) */
 
 out:
 	unlock_page(page_head);
@@ -1604,7 +1594,7 @@ static inline struct futex_hash_bucket *
 	hb = hash_futex(&q->key);
 	q->lock_ptr = &hb->lock;
 
-	spin_lock(&hb->lock); /* implies MB (A) */
+	spin_lock(&hb->lock);
 	return hb;
 }
 
@@ -1995,6 +1985,8 @@ static int futex_wait_setup(u32 __user *
 		goto retry;
 	}
 
+	smp_mb();
+
 	if (uval != val) {
 		queue_unlock(*hb);
 		ret = -EWOULDBLOCK;
