Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1E342C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:35:25 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 13:03:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8F322125804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:05:44 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7ZI8943647118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:05:18 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7ZH5H024169
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:35:20 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 02/45] percpu_rwlock: Introduce per-CPU variables for the
 reader and the writer
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:03:32 +0530
Message-ID: <20130122073327.13822.96745.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Per-CPU rwlocks ought to give better performance than global rwlocks.
That is where the "per-CPU" component comes in. So introduce the necessary
per-CPU variables that would be necessary at the reader and the writer sides,
and add the support for dynamically initializing per-CPU rwlocks.
These per-CPU variables will be used subsequently to implement the core
algorithm behind per-CPU rwlocks.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/percpu-rwlock.h |    4 ++++
 lib/percpu-rwlock.c           |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/percpu-rwlock.h b/include/linux/percpu-rwlock.h
index 45620d0..cd5eab5 100644
--- a/include/linux/percpu-rwlock.h
+++ b/include/linux/percpu-rwlock.h
@@ -29,6 +29,8 @@
 #include <linux/spinlock.h>
 
 struct percpu_rwlock {
+	unsigned long __percpu	*reader_refcnt;
+	bool __percpu		*writer_signal;
 	rwlock_t		global_rwlock;
 };
 
@@ -41,6 +43,8 @@ extern void percpu_write_unlock(struct percpu_rwlock *);
 extern int __percpu_init_rwlock(struct percpu_rwlock *,
 				const char *, struct lock_class_key *);
 
+extern void percpu_free_rwlock(struct percpu_rwlock *);
+
 #define percpu_init_rwlock(pcpu_rwlock)					\
 ({	static struct lock_class_key rwlock_key;			\
 	__percpu_init_rwlock(pcpu_rwlock, #pcpu_rwlock, &rwlock_key);	\
diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index af0c714..80dad93 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -31,6 +31,17 @@
 int __percpu_init_rwlock(struct percpu_rwlock *pcpu_rwlock,
 			 const char *name, struct lock_class_key *rwlock_key)
 {
+	pcpu_rwlock->reader_refcnt = alloc_percpu(unsigned long);
+	if (unlikely(!pcpu_rwlock->reader_refcnt))
+		return -ENOMEM;
+
+	pcpu_rwlock->writer_signal = alloc_percpu(bool);
+	if (unlikely(!pcpu_rwlock->writer_signal)) {
+		free_percpu(pcpu_rwlock->reader_refcnt);
+		pcpu_rwlock->reader_refcnt = NULL;
+		return -ENOMEM;
+	}
+
 	/* ->global_rwlock represents the whole percpu_rwlock for lockdep */
 #ifdef CONFIG_DEBUG_SPINLOCK
 	__rwlock_init(&pcpu_rwlock->global_rwlock, name, rwlock_key);
@@ -41,6 +52,16 @@ int __percpu_init_rwlock(struct percpu_rwlock *pcpu_rwlock,
 	return 0;
 }
 
+void percpu_free_rwlock(struct percpu_rwlock *pcpu_rwlock)
+{
+	free_percpu(pcpu_rwlock->reader_refcnt);
+	free_percpu(pcpu_rwlock->writer_signal);
+
+	/* Catch use-after-free bugs */
+	pcpu_rwlock->reader_refcnt = NULL;
+	pcpu_rwlock->writer_signal = NULL;
+}
+
 void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
 {
 	read_lock(&pcpu_rwlock->global_rwlock);
