Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DBEBB7D2F
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:02:12 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4O3wEbS009209
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 13:58:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4O3ssBo1732844
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 13:54:54 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4O42A7x025070
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:02:11 +1000
Date: Mon, 24 May 2010 09:32:04 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [RFC Patch 1/5] Allow arch-specific cleanup before breakpoint
	unregistration
Message-ID: <20100524040204.GB20873@in.ibm.com>
References: <20100524034520.964014525@linux.vnet.ibm.com>
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
