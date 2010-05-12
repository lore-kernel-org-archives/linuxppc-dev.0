Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 029BBB7DC6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 13:33:23 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4C3XZ3r022607
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 13:33:35 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4C3QGgg1609822
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 13:26:16 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4C3XL45008396
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 13:33:22 +1000
Date: Wed, 12 May 2010 09:03:15 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [Patch 2/3] Allow arch-specific cleanup before breakpoint
	unregistration
Message-ID: <20100512033315.GC6384@in.ibm.com>
References: <20100512022527.857904312@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Ingo Molnar <mingo@elte.hu>,
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
@@ -203,6 +203,17 @@ static void toggle_bp_slot(struct perf_e
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
@@ -280,6 +291,7 @@ void release_bp_slot(struct perf_event *
 {
 	mutex_lock(&nr_bp_mutex);
 
+	arch_unregister_hw_breakpoint(bp);
 	__release_bp_slot(bp);
 
 	mutex_unlock(&nr_bp_mutex);
