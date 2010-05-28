Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3790DB7D49
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:40:04 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4S6deNc003950
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 12:09:40 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S6dekC893174
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 12:09:40 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4S6ddCn008270
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:39:40 +1000
Date: Fri, 28 May 2010 12:09:38 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 1/5] Allow arch-specific cleanup before breakpoint
	unregistration
Message-ID: <20100528063938.GB8679@in.ibm.com>
References: <20100528061928.677651410@linux.vnet.ibm.com>
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
Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
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
