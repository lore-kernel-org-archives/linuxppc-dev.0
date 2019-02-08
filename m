Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C516C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:41:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CBE2146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CBE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wyYH5fbDzDqPQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:41:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wy4S21qVzDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 01:19:51 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55ACFC056839;
 Fri,  8 Feb 2019 14:19:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 621691D9;
 Fri,  8 Feb 2019 14:19:45 +0000 (UTC)
Subject: Re: [PATCH-tip 15/22] locking/rwsem: Merge owner into count on x86-64
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-16-git-send-email-longman@redhat.com>
 <20190207200848.GH32477@hirez.programming.kicks-ass.net>
 <d157be4f-fbbe-4541-439b-7f6ab3b1dbdc@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <71f2a774-4ae7-2f8f-cb99-3c722a23323f@redhat.com>
Date: Fri, 8 Feb 2019 09:19:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d157be4f-fbbe-4541-439b-7f6ab3b1dbdc@redhat.com>
Content-Type: multipart/mixed; boundary="------------044906BC29EDC2231BFC9A7F"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 08 Feb 2019 14:19:49 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------044906BC29EDC2231BFC9A7F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 02/07/2019 03:54 PM, Waiman Long wrote:
> On 02/07/2019 03:08 PM, Peter Zijlstra wrote:
>> On Thu, Feb 07, 2019 at 02:07:19PM -0500, Waiman Long wrote:
>>> On 32-bit architectures, there aren't enough bits to hold both.
>>> 64-bit architectures, however, can have enough bits to do that. For
>>> x86-64, the physical address can use up to 52 bits. That is 4PB of
>>> memory. That leaves 12 bits available for other use. The task structure
>>> pointer is also aligned to the L1 cache size. That means another 6 bits
>>> (64 bytes cacheline) will be available. Reserving 2 bits for status
>>> flags, we will have 16 bits for the reader count.  That can supports
>>> up to (64k-1) readers.
>> 64k readers sounds like a number that is fairly 'easy' to reach, esp. on
>> 64bit. These are preemptible locks after all, all we need to do is get
>> 64k tasks nested on enough CPUs.
>>
>> I'm sure there's some willing Java proglet around that spawns more than
>> 64k threads just because it can. Run it on a big enough machine (ISTR
>> there's a number of >1k CPU systems out there) and voila.
> Yes, that can be a problem.
>
> One possible solution is to check if the count goes negative. If so,
> fail the read lock and make the readers wait in the wait queue until the
> count is in positive territory. That effectively reduces the reader
> count to 15 bits, but it will avoid the overflow situation. I will try
> to add that support into the next version.
>
> Cheers,
> Longman

Something like the attached patch.

Cheers,
Longman

--------------044906BC29EDC2231BFC9A7F
Content-Type: text/x-patch;
 name="0023-locking-rwsem-Make-MSbit-of-count-as-guard-bit-to-fa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0023-locking-rwsem-Make-MSbit-of-count-as-guard-bit-to-fa.pa";
 filename*1="tch"

From 746913e7d14e874eeace1e146e63bdaea4dfd4a5 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Fri, 8 Feb 2019 08:58:10 -0500
Subject: [PATCH 23/23] locking/rwsem: Make MSbit of count as guard bit to fail
 readlock

With the merging of owner into count for x86-64, there is only 16 bits
left for reader count. It is theoretically possible for an application to
cause more than 64k readers to acquire a rwsem leading to count overflow.

To prevent this dire situation, the most significant bit of the count
is now treated as a guard bit (RWSEM_FLAG_READFAIL). Read-lock will now
fails for both the fast and optimistic spinning paths whenever this bit
is set. So all those extra readers will be put to sleep in the wait
queue. Wakeup will not happen until the reader count reaches 0.

A limit of 256 is also imposed on the number of readers that can be woken
up in one wakeup function call. This will eliminate the possibility of
waking up more than 64k readers and overflowing the count.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem-xadd.c       | 40 ++++++++++++++++++++++++++++++++------
 kernel/locking/rwsem-xadd.h       | 41 ++++++++++++++++++++++++++-------------
 3 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 0052534..9ecdeac 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -60,6 +60,7 @@
 LOCK_EVENT(rwsem_opt_rlock)	/* # of read locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
+LOCK_EVENT(rwsem_opt_rfail)	/* # of failed reader-owned readlocks	*/
 LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled reader opt-spinnings	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 213c2aa..a993055 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -110,6 +110,8 @@ enum rwsem_wake_type {
 # define RWSEM_RSPIN_MAX	(1 << 12)
 #endif
 
+#define MAX_READERS_WAKEUP	0x100
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -208,6 +210,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 * after setting the reader waiter to nil.
 		 */
 		wake_q_add_safe(wake_q, tsk);
+
+		/*
+		 * Limit # of readers that can be woken up per wakeup call.
+		 */
+		if (woken >= MAX_READERS_WAKEUP)
+			break;
 	}
 
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
@@ -445,6 +453,16 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 			break;
 
 		/*
+		 * If a reader cannot acquire a reader-owned lock, we
+		 * have to quit. It is either the handoff bit just got
+		 * set or (unlikely) readfail bit is somehow set.
+		 */
+		if (unlikely(!wlock && (owner_state == OWNER_READER))) {
+			lockevent_inc(rwsem_opt_rfail);
+			break;
+		}
+
+		/*
 		 * An RT task cannot do optimistic spinning if it cannot
 		 * be sure the lock holder is running. When there's no owner
 		 * or is reader-owned, an RT task has to stop spinning or
@@ -526,12 +544,22 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
  * Wait for the read lock to be granted
  */
 static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
+__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	if (unlikely(count < 0)) {
+		/*
+		 * Too many active readers, decrement count &
+		 * enter the wait queue.
+		 */
+		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+		adjustment = 0;
+		goto queue;
+	}
+
 	if (!rwsem_can_spin_on_owner(sem))
 		goto queue;
 
@@ -635,16 +663,16 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
 }
 
 __visible struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
+rwsem_down_read_failed(struct rw_semaphore *sem, long cnt)
 {
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
+	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE, cnt);
 }
 EXPORT_SYMBOL(rwsem_down_read_failed);
 
 __visible struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
+rwsem_down_read_failed_killable(struct rw_semaphore *sem, long cnt)
 {
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
+	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE, cnt);
 }
 EXPORT_SYMBOL(rwsem_down_read_failed_killable);
 
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index be67dbd..72308b7 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -63,7 +63,8 @@
  * Bit   0    - waiters present bit
  * Bit   1    - lock handoff bit
  * Bits  2-47 - compressed task structure pointer
- * Bits 48-63 - 16-bit reader counts
+ * Bits 48-62 - 15-bit reader counts
+ * Bit  63    - read fail bit
  *
  * On other 64-bit architectures, the bit definitions are:
  *
@@ -71,7 +72,8 @@
  * Bit  1    - lock handoff bit
  * Bits 2-6  - reserved
  * Bit  7    - writer lock bit
- * Bits 8-63 - 56-bit reader counts
+ * Bits 8-62 - 55-bit reader counts
+ * Bit  63   - read fail bit
  *
  * On 32-bit architectures, the bit definitions of the count are:
  *
@@ -79,13 +81,15 @@
  * Bit  1    - lock handoff bit
  * Bits 2-6  - reserved
  * Bit  7    - writer lock bit
- * Bits 8-31 - 24-bit reader counts
+ * Bits 8-30 - 23-bit reader counts
+ * Bit  32   - read fail bit
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  */
 #define RWSEM_FLAG_WAITERS	(1UL << 0)
 #define RWSEM_FLAG_HANDOFF	(1UL << 1)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #ifdef CONFIG_X86_64
 
@@ -108,7 +112,7 @@
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
 #define RWSEM_COUNT_WLOCKED(c)	((c) & RWSEM_WRITER_MASK)
@@ -302,10 +306,15 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *
+rwsem_down_read_failed(struct rw_semaphore *sem, long count);
+extern struct rw_semaphore *
+rwsem_down_read_failed_killable(struct rw_semaphore *sem, long count);
+extern struct rw_semaphore *
+rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *
+rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
@@ -314,9 +323,11 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_failed(sem);
+	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						   &sem->count);
+
+	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
+		rwsem_down_read_failed(sem, count);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
@@ -325,9 +336,11 @@ static inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
+	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						   &sem->count);
+
+	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
+		if (IS_ERR(rwsem_down_read_failed_killable(sem, count)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
-- 
1.8.3.1


--------------044906BC29EDC2231BFC9A7F--
