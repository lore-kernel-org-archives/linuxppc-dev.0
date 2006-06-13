Return-Path: <boutcher@cs.umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17550.2960.198776.598118@hound.rchland.ibm.com>
Date: Mon, 12 Jun 2006 19:49:20 -0500
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: check firmware state before suspending
From: boutcher@cs.umn.edu (Dave C Boutcher)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Currently the kernel blindly halts all the processors and calls the
ibm,suspend-me rtas call.  If the firmware is not in the correct
state, we then re-start all the processors and return.  It is much
smarter to first check the firmware state, and only if it is waiting,
call the ibm,suspend-me call.

---

 arch/powerpc/kernel/rtas.c   |   22 ++++++++++++++++++++++
 include/asm-powerpc/hvcall.h |   10 ++++++++++
 include/asm-powerpc/rtas.h   |    1 +
 3 files changed, 33 insertions(+), 0 deletions(-)

579349d70b1395df6a139a0d1bc66b55ebc7a050
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 13496f3..fd15e3e 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -593,9 +593,31 @@ out:
 static int rtas_ibm_suspend_me(struct rtas_args *args)
 {
 	int i;
+	long state;
+	long rc;
+	unsigned long dummy;
 
 	struct rtas_suspend_me_data data;
 
+	/* Make sure the state is valid */
+	rc = plpar_hcall(H_VASI_STATE,
+			 ((u64)args->args[0] << 32) | args->args[1],
+			 0, 0, 0,
+			 &state, &dummy, &dummy);
+
+	if (rc) {
+		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
+		return rc;
+	} else if (state == H_VASI_ENABLED) {
+		args->args[args->nargs] = RTAS_NOT_SUSPENDABLE;
+		return 0;
+	} else if (state != H_VASI_SUSPENDING) {
+		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned state %ld\n",
+		       state);
+		args->args[args->nargs] = -1;
+		return 0;
+	}
+
 	data.waiting = 1;
 	data.args = args;
 
diff --git a/include/asm-powerpc/hvcall.h b/include/asm-powerpc/hvcall.h
index 6cc7e1f..0d3c4e8 100644
--- a/include/asm-powerpc/hvcall.h
+++ b/include/asm-powerpc/hvcall.h
@@ -102,6 +102,15 @@
 #define H_PP1			(1UL<<(63-62))
 #define H_PP2			(1UL<<(63-63))
 
+/* VASI States */
+#define H_VASI_INVALID          0
+#define H_VASI_ENABLED          1
+#define H_VASI_ABORTED          2
+#define H_VASI_SUSPENDING       3
+#define H_VASI_SUSPENDED        4
+#define H_VASI_RESUMED          5
+#define H_VASI_COMPLETED        6
+
 /* DABRX flags */
 #define H_DABRX_HYPERVISOR	(1UL<<(63-61))
 #define H_DABRX_KERNEL		(1UL<<(63-62))
@@ -190,6 +199,7 @@
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
 #define H_JOIN			0x298
+#define H_VASI_STATE            0x2A4
 #define H_ENABLE_CRQ		0x2B0
 
 #ifndef __ASSEMBLY__
diff --git a/include/asm-powerpc/rtas.h b/include/asm-powerpc/rtas.h
index a3b4e55..02e213e 100644
--- a/include/asm-powerpc/rtas.h
+++ b/include/asm-powerpc/rtas.h
@@ -24,6 +24,7 @@
 #define RTAS_RMOBUF_MAX (64 * 1024)
 
 /* RTAS return status codes */
+#define RTAS_NOT_SUSPENDABLE	-9004
 #define RTAS_BUSY		-2    /* RTAS Busy */
 #define RTAS_EXTENDED_DELAY_MIN	9900
 #define RTAS_EXTENDED_DELAY_MAX	9905
-- 
1.2.4.gc98264
