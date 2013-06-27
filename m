Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57F222C085F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:01:04 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:46:28 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B567E2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:00:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJk6r837027850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:46:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RK0tC5013715
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:00:58 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 30/45] x86/xen: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:27:33 +0530
Message-ID: <20130627195733.29830.8002.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Ingo Molnar <mingo@redhat.com>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 xen-devel@lists.xensource.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/xen/mmu.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index fdc3ba2..3229c4f 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -39,6 +39,7 @@
  * Jeremy Fitzhardinge <jeremy@xensource.com>, XenSource Inc, 2007
  */
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/highmem.h>
 #include <linux/debugfs.h>
 #include <linux/bug.h>
@@ -1163,9 +1164,13 @@ static void xen_drop_mm_ref(struct mm_struct *mm)
  */
 static void xen_exit_mmap(struct mm_struct *mm)
 {
-	get_cpu();		/* make sure we don't move around */
+	/*
+	 * Make sure we don't move around, and also prevent CPUs from
+	 * going offline.
+	 */
+	get_online_cpus_atomic();
 	xen_drop_mm_ref(mm);
-	put_cpu();
+	put_online_cpus_atomic();
 
 	spin_lock(&mm->page_table_lock);
 
