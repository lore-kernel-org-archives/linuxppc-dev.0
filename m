Return-Path: <anton@ozlabs.org>
Date: Mon, 27 Mar 2006 11:23:29 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove some ifdefs in oprofile_impl.h
Message-ID: <20060327002329.GA4962@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


- No one uses op_counter_config.valid, so remove it
- No need to ifdef around function protypes.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/oprofile_impl.h	2006-03-26 12:17:23.000000000 +1100
+++ linux-2.6/include/asm-powerpc/oprofile_impl.h	2006-03-26 12:21:13.000000000 +1100
@@ -17,9 +17,6 @@
 
 /* Per-counter configuration as set via oprofilefs.  */
 struct op_counter_config {
-#ifdef __powerpc64__
-	unsigned long valid;
-#endif
 	unsigned long enabled;
 	unsigned long event;
 	unsigned long count;
@@ -56,17 +53,12 @@ struct op_powerpc_model {
 	int num_counters;
 };
 
-#ifdef CONFIG_FSL_BOOKE
 extern struct op_powerpc_model op_model_fsl_booke;
-#else /* Otherwise, it's classic */
-
-#ifdef CONFIG_PPC64
 extern struct op_powerpc_model op_model_rs64;
 extern struct op_powerpc_model op_model_power4;
-
-#else /* Otherwise, CONFIG_PPC32 */
 extern struct op_powerpc_model op_model_7450;
-#endif
+
+#ifndef CONFIG_FSL_BOOKE
 
 /* All the classic PPC parts use these */
 static inline unsigned int ctr_read(unsigned int i)
