Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B08BF2C0152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:35:36 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 13:03:39 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CCEDE125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:05:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7ZSMK40239284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:05:28 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7ZRvi018992
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:35:30 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 03/45] percpu_rwlock: Provide a way to define and init
 percpu-rwlocks at compile time
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:03:42 +0530
Message-ID: <20130122073338.13822.94829.stgit@srivatsabhat.in.ibm.com>
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

Add the support for defining and initializing percpu-rwlocks at compile time
for those users who would like to use percpu-rwlocks really early in the boot
process (even before dynamic per-CPU allocations can begin).

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/percpu-rwlock.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/percpu-rwlock.h b/include/linux/percpu-rwlock.h
index cd5eab5..8dec8fe 100644
--- a/include/linux/percpu-rwlock.h
+++ b/include/linux/percpu-rwlock.h
@@ -45,6 +45,24 @@ extern int __percpu_init_rwlock(struct percpu_rwlock *,
 
 extern void percpu_free_rwlock(struct percpu_rwlock *);
 
+
+#define __PERCPU_RWLOCK_INIT(name)					\
+	{								\
+		.reader_refcnt = &name##_reader_refcnt,			\
+		.writer_signal = &name##_writer_signal,			\
+		.global_rwlock = __RW_LOCK_UNLOCKED(name.global_rwlock) \
+	}
+
+#define DEFINE_PERCPU_RWLOCK(name)					\
+	static DEFINE_PER_CPU(unsigned long, name##_reader_refcnt);	\
+	static DEFINE_PER_CPU(bool, name##_writer_signal);		\
+	struct percpu_rwlock (name) = __PERCPU_RWLOCK_INIT(name);
+
+#define DEFINE_STATIC_PERCPU_RWLOCK(name)				\
+	static DEFINE_PER_CPU(unsigned long, name##_reader_refcnt);	\
+	static DEFINE_PER_CPU(bool, name##_writer_signal);		\
+	static struct percpu_rwlock(name) = __PERCPU_RWLOCK_INIT(name);
+
 #define percpu_init_rwlock(pcpu_rwlock)					\
 ({	static struct lock_class_key rwlock_key;			\
 	__percpu_init_rwlock(pcpu_rwlock, #pcpu_rwlock, &rwlock_key);	\
