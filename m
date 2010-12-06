Return-Path: <mikey@neuling.org>
Message-Id: <20101206234049.649828609@neuling.org>
Date: Tue, 07 Dec 2010 10:40:44 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 1/7] Add csd_locked function
References: <20101206234043.083045003@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add csd_locked function to determine if a struct call_single_data is
currently locked.  This can be used to see if an IPI can be called
again using this call_single_data.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 kernel/smp.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux-lazy/kernel/smp.c
===================================================================
--- linux-lazy.orig/kernel/smp.c
+++ linux-lazy/kernel/smp.c
@@ -12,6 +12,7 @@
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/hardirq.h>
 
 static struct {
 	struct list_head	queue;
@@ -131,6 +132,22 @@
 }
 
 /*
+ * Determine if a csd is currently locked.  This can be used to
+ * determine if an IPI is currently pending using this csd already.
+ */
+int csd_locked(struct call_single_data *data)
+{
+	WARN_ON(preemptible());
+
+	/* Ensure flags have propagated */
+	smp_mb();
+
+	if (data->flags & CSD_FLAG_LOCK)
+		return 1;
+	return 0;
+}
+
+/*
  * Insert a previously allocated call_single_data element
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
