Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zXMp0pK7zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 23:11:34 +1000 (AEST)
Date: Mon, 27 Aug 2018 15:11:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, deller@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
 Simon Horman <horms@verge.net.au>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, rth@twiddle.net,
 ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
 linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, msalter@redhat.com,
 jacquiot.aurelien@gmail.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, rkuo@codeaurora.org,
 tony.luck@intel.com, fenghua.yu@intel.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, monstr@monstr.eu,
 ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
 green.hu@gmail.com, deanbo422@gmail.com, lftan@altera.com,
 jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 Stafford Horne <shorne@gmail.com>, jejb@parisc-linux.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 palmer@sifive.com, aou@eecs.berkeley.edu, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, dalias@libc.org,
 "David S. Miller" <davem@davemloft.net>, gxt@pku.edu.cn,
 x86@kernel.org, jdike@addtoit.com, richard@nod.at, chris@zankel.net,
 jcmvbkbc@gmail.com, Tobias Klauser <tklauser@distanz.ch>,
 noamc@ezchip.com, mickael.guene@st.com, nicolas.pitre@linaro.org,
 Kees Cook <keescook@chromium.org>, Dave Martin <Dave.Martin@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, alex.bennee@linaro.org,
 Laura Abbott <labbott@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>,
 Mark Rutland <mark.rutland@arm.com>, chenhc@lemote.com,
 macro@mips.com, Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
 sukadev@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 linuxram@us.ibm.com, christophe.leroy@c-s.fr, cohuck@redhat.com,
 gor@linux.vnet.ibm.com, nick.alcock@oracle.com,
 shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com,
 luto@kernel.org, bp@suse.de, dave.hansen@linux.intel.com,
 vkuznets@redhat.com, jkosina@suse.cz, linux-alpha@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH] treewide: remove current_text_addr
Message-ID: <20180827131103.GD24124@hirez.programming.kicks-ass.net>
References: <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
 <20180827073358.GV24124@hirez.programming.kicks-ass.net>
 <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 27, 2018 at 05:26:53AM -0700, H. Peter Anvin wrote:

> _THIS_IP_, however, is completely ill-defined, other than being an
> address *somewhere* in the same global function (not even necessarily
> the same function if the function is static!)  As my experiment show, in
> many (nearly) cases gcc will hoist the address all the way to the top of
> the function, at least for the current generic implementation.

It seems to have mostly worked so far... did anything change?

> For the case where _THIS_IP_ is passed to an out-of-line function in all
> cases, it is extra pointless because all it does is increase the
> footprint of every caller: _RET_IP_ is inherently passed to the function
> anyway, and with tailcall protection it will uniquely identify a callsite.

So I think we can convert many of the lockdep _THIS_IP_ calls to
_RET_IP_ on the other side, with a wee bit of care.

A little something like so perhaps...

---

 drivers/md/bcache/btree.c    |  2 +-
 fs/jbd2/transaction.c        |  6 +++---
 fs/super.c                   |  4 ++--
 include/linux/fs.h           |  4 ++--
 include/linux/jbd2.h         |  4 ++--
 include/linux/lockdep.h      | 21 ++++++++++-----------
 include/linux/percpu-rwsem.h | 22 ++++++++++------------
 include/linux/rcupdate.h     |  8 ++++----
 include/linux/ww_mutex.h     |  2 +-
 kernel/locking/lockdep.c     | 14 ++++++++------
 kernel/printk/printk.c       | 14 +++++++-------
 kernel/sched/core.c          |  4 ++--
 lib/locking-selftest.c       | 32 ++++++++++++++++----------------
 13 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index c19f7716df88..21ede9b317de 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -940,7 +940,7 @@ static struct btree *mca_alloc(struct cache_set *c, struct btree_op *op,
 	hlist_del_init_rcu(&b->hash);
 	hlist_add_head_rcu(&b->hash, mca_hash(c, k));
 
-	lock_set_subclass(&b->lock.dep_map, level + 1, _THIS_IP_);
+	lock_set_subclass(&b->lock.dep_map, level + 1);
 	b->parent	= (void *) ~0UL;
 	b->flags	= 0;
 	b->written	= 0;
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c0b66a7a795b..40aa71321f8a 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -382,7 +382,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	read_unlock(&journal->j_state_lock);
 	current->journal_info = handle;
 
-	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
+	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0);
 	jbd2_journal_free_transaction(new_transaction);
 	/*
 	 * Ensure that no allocations done while the transaction is open are
@@ -677,7 +677,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
 	if (need_to_start)
 		jbd2_log_start_commit(journal, tid);
 
-	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
+	rwsem_release(&journal->j_trans_commit_map, 1);
 	handle->h_buffer_credits = nblocks;
 	/*
 	 * Restore the original nofs context because the journal restart
@@ -1771,7 +1771,7 @@ int jbd2_journal_stop(handle_t *handle)
 			wake_up(&journal->j_wait_transaction_locked);
 	}
 
-	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
+	rwsem_release(&journal->j_trans_commit_map, 1);
 
 	if (wait_for_commit)
 		err = jbd2_log_wait_commit(journal, tid);
diff --git a/fs/super.c b/fs/super.c
index 50728d9c1a05..ec650a558f09 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1431,7 +1431,7 @@ static void lockdep_sb_freeze_release(struct super_block *sb)
 	int level;
 
 	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
-		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
+		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0);
 }
 
 /*
@@ -1442,7 +1442,7 @@ static void lockdep_sb_freeze_acquire(struct super_block *sb)
 	int level;
 
 	for (level = 0; level < SB_FREEZE_LEVELS; ++level)
-		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
+		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0);
 }
 
 static void sb_freeze_unlock(struct super_block *sb)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1ec33fd0423f..2ba14e5362e4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1505,9 +1505,9 @@ void __sb_end_write(struct super_block *sb, int level);
 int __sb_start_write(struct super_block *sb, int level, bool wait);
 
 #define __sb_writers_acquired(sb, lev)	\
-	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1)
 #define __sb_writers_release(sb, lev)	\
-	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1)
 
 /**
  * sb_end_write - drop write access to a superblock
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b708e5169d1d..7c31176ec8ae 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1155,8 +1155,8 @@ struct journal_s
 
 #define jbd2_might_wait_for_commit(j) \
 	do { \
-		rwsem_acquire(&j->j_trans_commit_map, 0, 0, _THIS_IP_); \
-		rwsem_release(&j->j_trans_commit_map, 1, _THIS_IP_); \
+		rwsem_acquire(&j->j_trans_commit_map, 0, 0); \
+		rwsem_release(&j->j_trans_commit_map, 1); \
 	} while (0)
 
 /* journal feature predicate functions */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..ed3daf41ae7b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -348,16 +348,15 @@ static inline int lock_is_held(const struct lockdep_map *lock)
 #define lockdep_is_held_type(lock, r)	lock_is_held_type(&(lock)->dep_map, (r))
 
 extern void lock_set_class(struct lockdep_map *lock, const char *name,
-			   struct lock_class_key *key, unsigned int subclass,
-			   unsigned long ip);
+			   struct lock_class_key *key, unsigned int subclass);
 
-static inline void lock_set_subclass(struct lockdep_map *lock,
-		unsigned int subclass, unsigned long ip)
+static __always_inline void
+lock_set_subclass(struct lockdep_map *lock, unsigned int subclass)
 {
-	lock_set_class(lock, lock->name, lock->key, subclass, ip);
+	lock_set_class(lock, lock->name, lock->key, subclass);
 }
 
-extern void lock_downgrade(struct lockdep_map *lock, unsigned long ip);
+extern void lock_downgrade(struct lockdep_map *lock);
 
 struct pin_cookie { unsigned int val; };
 
@@ -401,11 +400,11 @@ static inline void lockdep_on(void)
 {
 }
 
-# define lock_acquire(l, s, t, r, c, n, i)	do { } while (0)
-# define lock_release(l, n, i)			do { } while (0)
-# define lock_downgrade(l, i)			do { } while (0)
-# define lock_set_class(l, n, k, s, i)		do { } while (0)
-# define lock_set_subclass(l, s, i)		do { } while (0)
+# define lock_acquire(l, s, t, r, c, n)		do { } while (0)
+# define lock_release(l, n)			do { } while (0)
+# define lock_downgrade(l)			do { } while (0)
+# define lock_set_class(l, n, k, s)		do { } while (0)
+# define lock_set_subclass(l, s)		do { } while (0)
 # define lockdep_info()				do { } while (0)
 # define lockdep_init_map(lock, name, key, sub) \
 		do { (void)(name); (void)(key); } while (0)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 79b99d653e03..4ebf14e99034 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -29,11 +29,11 @@ static struct percpu_rw_semaphore name = {				\
 extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
 extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
-static inline void percpu_down_read_preempt_disable(struct percpu_rw_semaphore *sem)
+static __always_inline void percpu_down_read_preempt_disable(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 
-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0);
 
 	preempt_disable();
 	/*
@@ -60,7 +60,7 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static __always_inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
 	int ret = 1;
 
@@ -78,12 +78,12 @@ static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 */
 
 	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
+		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1);
 
 	return ret;
 }
 
-static inline void percpu_up_read_preempt_enable(struct percpu_rw_semaphore *sem)
+static __always_inline void percpu_up_read_preempt_enable(struct percpu_rw_semaphore *sem)
 {
 	/*
 	 * The barrier() prevents the compiler from
@@ -99,7 +99,7 @@ static inline void percpu_up_read_preempt_enable(struct percpu_rw_semaphore *sem
 		__percpu_up_read(sem); /* Unconditional memory barrier */
 	preempt_enable();
 
-	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
+	rwsem_release(&sem->rw_sem.dep_map, 1);
 }
 
 static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
@@ -127,20 +127,18 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
 #define percpu_rwsem_assert_held(sem)				\
 	lockdep_assert_held(&(sem)->rw_sem)
 
-static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
-					bool read, unsigned long ip)
+static __always_inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem, bool read)
 {
-	lock_release(&sem->rw_sem.dep_map, 1, ip);
+	lock_release(&sem->rw_sem.dep_map, 1);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
 #endif
 }
 
-static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
-					bool read, unsigned long ip)
+static __always_inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem, bool read)
 {
-	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		sem->rw_sem.owner = current;
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 75e5b393cf44..6c1a35555e9d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -239,14 +239,14 @@ static inline bool rcu_lockdep_current_cpu_online(void) { return true; }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-static inline void rcu_lock_acquire(struct lockdep_map *map)
+static __always_inline void rcu_lock_acquire(struct lockdep_map *map)
 {
-	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
+	lock_acquire(map, 0, 0, 2, 0, NULL);
 }
 
-static inline void rcu_lock_release(struct lockdep_map *map)
+static __always_inline void rcu_lock_release(struct lockdep_map *map)
 {
-	lock_release(map, 1, _THIS_IP_);
+	lock_release(map, 1);
 }
 
 extern struct lockdep_map rcu_lock_map;
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 3af7c0e03be5..524aa28eef33 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -182,7 +182,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
 #ifdef CONFIG_DEBUG_MUTEXES
-	mutex_release(&ctx->dep_map, 0, _THIS_IP_);
+	mutex_release(&ctx->dep_map, 0);
 
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..0b7c4f94a7a3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3868,9 +3868,9 @@ static void check_flags(unsigned long flags)
 }
 
 void lock_set_class(struct lockdep_map *lock, const char *name,
-		    struct lock_class_key *key, unsigned int subclass,
-		    unsigned long ip)
+		    struct lock_class_key *key, unsigned int subclass)
 {
+	unsigned long ip = _RET_IP_;
 	unsigned long flags;
 
 	if (unlikely(current->lockdep_recursion))
@@ -3886,8 +3886,9 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 }
 EXPORT_SYMBOL_GPL(lock_set_class);
 
-void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
+void lock_downgrade(struct lockdep_map *lock)
 {
+	unsigned long ip = _RET_IP_;
 	unsigned long flags;
 
 	if (unlikely(current->lockdep_recursion))
@@ -3909,8 +3910,9 @@ EXPORT_SYMBOL_GPL(lock_downgrade);
  */
 void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			  int trylock, int read, int check,
-			  struct lockdep_map *nest_lock, unsigned long ip)
+			  struct lockdep_map *nest_lock)
 {
+	unsigned long ip = _RET_IP_;
 	unsigned long flags;
 
 	if (unlikely(current->lockdep_recursion))
@@ -3928,9 +3930,9 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
 
-void lock_release(struct lockdep_map *lock, int nested,
-			  unsigned long ip)
+void lock_release(struct lockdep_map *lock, int nested)
 {
+	unsigned long ip = _RET_IP_;
 	unsigned long flags;
 
 	if (unlikely(current->lockdep_recursion))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 90b6ab01db59..9c8654be08bb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1583,7 +1583,7 @@ static void console_lock_spinning_enable(void)
 	raw_spin_unlock(&console_owner_lock);
 
 	/* The waiter may spin on us after setting console_owner */
-	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
+	spin_acquire(&console_owner_dep_map, 0, 0);
 }
 
 /**
@@ -1611,20 +1611,20 @@ static int console_lock_spinning_disable_and_check(void)
 	raw_spin_unlock(&console_owner_lock);
 
 	if (!waiter) {
-		spin_release(&console_owner_dep_map, 1, _THIS_IP_);
+		spin_release(&console_owner_dep_map, 1);
 		return 0;
 	}
 
 	/* The waiter is now free to continue */
 	WRITE_ONCE(console_waiter, false);
 
-	spin_release(&console_owner_dep_map, 1, _THIS_IP_);
+	spin_release(&console_owner_dep_map, 1);
 
 	/*
 	 * Hand off console_lock to waiter. The waiter will perform
 	 * the up(). After this, the waiter is the console_lock owner.
 	 */
-	mutex_release(&console_lock_dep_map, 1, _THIS_IP_);
+	mutex_release(&console_lock_dep_map, 1);
 	return 1;
 }
 
@@ -1674,11 +1674,11 @@ static int console_trylock_spinning(void)
 	}
 
 	/* We spin waiting for the owner to release us */
-	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
+	spin_acquire(&console_owner_dep_map, 0, 0);
 	/* Owner will clear console_waiter on hand off */
 	while (READ_ONCE(console_waiter))
 		cpu_relax();
-	spin_release(&console_owner_dep_map, 1, _THIS_IP_);
+	spin_release(&console_owner_dep_map, 1);
 
 	printk_safe_exit_irqrestore(flags);
 	/*
@@ -1687,7 +1687,7 @@ static int console_trylock_spinning(void)
 	 * this as a trylock. Otherwise lockdep will
 	 * complain.
 	 */
-	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
+	mutex_acquire(&console_lock_dep_map, 0, 1);
 
 	return 1;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 454adf9f8180..a3d146cc2cb9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2557,7 +2557,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
+	spin_release(&rq->lock.dep_map, 1);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
 	rq->lock.owner = next;
@@ -2571,7 +2571,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	spin_acquire(&rq->lock.dep_map, 0, 0);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf171eca..d9599c7d0426 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1475,7 +1475,7 @@ static void ww_test_edeadlk_normal(void)
 
 	mutex_lock(&o2.base);
 	o2.ctx = &t2;
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 
 	WWAI(&t);
 	t2 = t;
@@ -1488,7 +1488,7 @@ static void ww_test_edeadlk_normal(void)
 	WARN_ON(ret != -EDEADLK);
 
 	o2.ctx = NULL;
-	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
+	mutex_acquire(&o2.base.dep_map, 0, 1);
 	mutex_unlock(&o2.base);
 	WWU(&o);
 
@@ -1500,7 +1500,7 @@ static void ww_test_edeadlk_normal_slow(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	WWAI(&t);
@@ -1514,7 +1514,7 @@ static void ww_test_edeadlk_normal_slow(void)
 	WARN_ON(ret != -EDEADLK);
 
 	o2.ctx = NULL;
-	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
+	mutex_acquire(&o2.base.dep_map, 0, 1);
 	mutex_unlock(&o2.base);
 	WWU(&o);
 
@@ -1527,7 +1527,7 @@ static void ww_test_edeadlk_no_unlock(void)
 
 	mutex_lock(&o2.base);
 	o2.ctx = &t2;
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 
 	WWAI(&t);
 	t2 = t;
@@ -1540,7 +1540,7 @@ static void ww_test_edeadlk_no_unlock(void)
 	WARN_ON(ret != -EDEADLK);
 
 	o2.ctx = NULL;
-	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
+	mutex_acquire(&o2.base.dep_map, 0, 1);
 	mutex_unlock(&o2.base);
 
 	WWL(&o2, &t);
@@ -1551,7 +1551,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	WWAI(&t);
@@ -1565,7 +1565,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 	WARN_ON(ret != -EDEADLK);
 
 	o2.ctx = NULL;
-	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
+	mutex_acquire(&o2.base.dep_map, 0, 1);
 	mutex_unlock(&o2.base);
 
 	ww_mutex_lock_slow(&o2, &t);
@@ -1576,7 +1576,7 @@ static void ww_test_edeadlk_acquire_more(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	WWAI(&t);
@@ -1597,7 +1597,7 @@ static void ww_test_edeadlk_acquire_more_slow(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	WWAI(&t);
@@ -1618,11 +1618,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	mutex_lock(&o3.base);
-	mutex_release(&o3.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o3.base.dep_map, 1);
 	o3.ctx = &t2;
 
 	WWAI(&t);
@@ -1644,11 +1644,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk_slow(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	mutex_lock(&o3.base);
-	mutex_release(&o3.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o3.base.dep_map, 1);
 	o3.ctx = &t2;
 
 	WWAI(&t);
@@ -1669,7 +1669,7 @@ static void ww_test_edeadlk_acquire_wrong(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	WWAI(&t);
@@ -1694,7 +1694,7 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 	int ret;
 
 	mutex_lock(&o2.base);
-	mutex_release(&o2.base.dep_map, 1, _THIS_IP_);
+	mutex_release(&o2.base.dep_map, 1);
 	o2.ctx = &t2;
 
 	WWAI(&t);
