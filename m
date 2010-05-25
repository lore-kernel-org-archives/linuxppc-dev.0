Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9EF5B811A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 19:14:23 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4P8Fm2I025634
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 13:45:48 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4P9DwjG3678400
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 14:43:58 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4P9DvW2022742
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 14:43:58 +0530
Date: Tue, 25 May 2010 14:43:56 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 1/4] Allow arch-specific cleanup before breakpoint
	unregistration
Message-ID: <20100525091356.GB29003@in.ibm.com>
References: <20100525083055.342788418@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Certain architectures (such as PowerPC Book III S) have a need to cleanup
data-structures before the breakpoint is unregistered. This patch introduces
an arch-specific hook in release_bp_slot() along with a weak definition in
the form of a stub funciton.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 kernel/hw_breakpoint.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6.ppc64_test/kernel/hw_breakpoint.c
===================================================================
--- linux-2.6.ppc64_test.orig/kernel/hw_breakpoint.c
+++ linux-2.6.ppc64_test/kernel/hw_breakpoint.c
@@ -242,6 +242,17 @@ toggle_bp_slot(struct perf_event *bp, bo
 }
 
 /*
+ * Function to perform processor-specific cleanup during unregistration
+ */
+__weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
+{
+	/*
+	 * A weak stub function here for those archs that don't define
+	 * it inside arch/.../kernel/hw_breakpoint.c
+	 */
+}
+
+/*
  * Contraints to check before allowing this new breakpoint counter:
  *
  *  == Non-pinned counter == (Considered as pinned for now)
@@ -339,6 +350,7 @@ void release_bp_slot(struct perf_event *
 {
 	mutex_lock(&nr_bp_mutex);
 
+	arch_unregister_hw_breakpoint(bp);
 	__release_bp_slot(bp);
 
 	mutex_unlock(&nr_bp_mutex);
