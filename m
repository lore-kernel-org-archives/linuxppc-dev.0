Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D834C2C02A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:15 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:08:52 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 980D31258051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:11:55 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICf7JN30081146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:11:08 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICf5Eo018691
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:08 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 06/46] percpu_rwlock: Rearrange the read-lock code to
 fastpath nested percpu readers
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:09:07 +0530
Message-ID: <20130218123907.26245.37550.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we are dealing with a nester percpu reader, we can optimize away quite
a few costly operations. Improve that fastpath further, by avoiding the
unnecessary addition and subtraction of 'READER_PRESENT' to reader_refcnt,
by rearranging the code a bit.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 lib/percpu-rwlock.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index ce7e440..ed36531 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -80,23 +80,21 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 	preempt_disable();
 
 	/*
-	 * Let the writer know that a reader is active, even before we choose
-	 * our reader-side synchronization scheme.
-	 */
-	this_cpu_add(pcpu_rwlock->rw_state->reader_refcnt, READER_PRESENT);
-
-	/*
 	 * If we are already using per-cpu refcounts, it is not safe to switch
 	 * the synchronization scheme. So continue using the refcounts.
 	 */
 	if (reader_uses_percpu_refcnt(pcpu_rwlock)) {
 		this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
-		this_cpu_sub(pcpu_rwlock->rw_state->reader_refcnt,
-			     READER_PRESENT);
 		return;
 	}
 
 	/*
+	 * Let the writer know that a reader is active, even before we choose
+	 * our reader-side synchronization scheme.
+	 */
+	this_cpu_add(pcpu_rwlock->rw_state->reader_refcnt, READER_PRESENT);
+
+	/*
 	 * The write to 'reader_refcnt' must be visible before we read
 	 * 'writer_signal'.
 	 */
