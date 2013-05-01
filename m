Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 096F72C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 01:24:09 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id r10so861307pdi.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 May 2013 08:24:06 -0700 (PDT)
Message-ID: <1367421843.11020.43.camel@edumazet-glaptop>
Subject: [PATCH v2 net-next] af_unix: fix a fatal race with bit fields
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Miller <davem@davemloft.net>
Date: Wed, 01 May 2013 08:24:03 -0700
In-Reply-To: <20130501.033650.703182794549888825.davem@davemloft.net>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
 <20130501.033650.703182794549888825.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, ambrose@google.com,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-01 at 03:36 -0400, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 01 May 2013 11:39:53 +1000
> 
> > I'm not even completely certain bytes are safe to be honest, though
> > probably more than bitfields. I'll poke our compiler people.
> 
> Older Alpha only has 32-bit and 64-bit loads and stores, so byte sized
> accesses are not atomic, and therefore use racey read-modify-write
> sequences.

Right, so what about the following more general fix ?

Thanks !

[PATCH v2] af_unix: fix a fatal race with bit fields

Using bit fields is dangerous on ppc64/sparc64, as the compiler [1]
uses 64bit instructions to manipulate them.
If the 64bit word includes any atomic_t or spinlock_t, we can lose
critical concurrent changes.

This is happening in af_unix, where unix_sk(sk)->gc_candidate/
gc_maybe_cycle/lock share the same 64bit word.

This leads to fatal deadlock, as one/several cpus spin forever
on a spinlock that will never be available again.

A safer way would be to use a long to store flags.
This way we are sure compiler/arch wont do bad things.

As we own unix_gc_lock spinlock when clearing or setting bits,
we can use the non atomic __set_bit()/__clear_bit().

recursion_level can share the same 64bit location with the spinlock,
as it is set only with this spinlock held.

[1] bug fixed in gcc-4.8.0 :
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52080

Reported-by: Ambrose Feinstein <ambrose@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 include/net/af_unix.h |    5 +++--
 net/unix/garbage.c    |   12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index a8836e8..dbdfd2b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -57,9 +57,10 @@ struct unix_sock {
 	struct list_head	link;
 	atomic_long_t		inflight;
 	spinlock_t		lock;
-	unsigned int		gc_candidate : 1;
-	unsigned int		gc_maybe_cycle : 1;
 	unsigned char		recursion_level;
+	unsigned long		gc_flags;
+#define UNIX_GC_CANDIDATE	0
+#define UNIX_GC_MAYBE_CYCLE	1
 	struct socket_wq	peer_wq;
 };
 #define unix_sk(__sk) ((struct unix_sock *)__sk)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d0f6545..9c6cc08 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -185,7 +185,7 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 					 * have been added to the queues after
 					 * starting the garbage collection
 					 */
-					if (u->gc_candidate) {
+					if (test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
 						hit = true;
 						func(u);
 					}
@@ -254,7 +254,7 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 	 * of the list, so that it's checked even if it was already
 	 * passed over
 	 */
-	if (u->gc_maybe_cycle)
+	if (test_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags))
 		list_move_tail(&u->link, &gc_candidates);
 }
 
@@ -315,8 +315,8 @@ void unix_gc(void)
 		BUG_ON(total_refs < inflight_refs);
 		if (total_refs == inflight_refs) {
 			list_move_tail(&u->link, &gc_candidates);
-			u->gc_candidate = 1;
-			u->gc_maybe_cycle = 1;
+			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
+			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 		}
 	}
 
@@ -344,7 +344,7 @@ void unix_gc(void)
 
 		if (atomic_long_read(&u->inflight) > 0) {
 			list_move_tail(&u->link, &not_cycle_list);
-			u->gc_maybe_cycle = 0;
+			__clear_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 			scan_children(&u->sk, inc_inflight_move_tail, NULL);
 		}
 	}
@@ -356,7 +356,7 @@ void unix_gc(void)
 	 */
 	while (!list_empty(&not_cycle_list)) {
 		u = list_entry(not_cycle_list.next, struct unix_sock, link);
-		u->gc_candidate = 0;
+		__clear_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
 		list_move_tail(&u->link, &gc_inflight_list);
 	}
 
