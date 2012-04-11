Return-Path: <anton@samba.org>
Date: Wed, 11 Apr 2012 12:20:54 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@canb.auug.org.au
Subject: [PATCH 1/3] powerpc: Clean up lppaca->cede_latency_hint
Message-ID: <20120411122054.6297f2fb@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have a union containing fields from the old iseries hypervisor
that has been reused for the cede latency hint. Since we no
longer support iseries, remove the union completely.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/lppaca.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/lppaca.h	2012-04-11 11:59:57.632828804 +1000
+++ linux-build/arch/powerpc/include/asm/lppaca.h	2012-04-11 12:05:54.767606593 +1000
@@ -107,19 +107,9 @@ struct lppaca {
 	// pass the target SRR0/1 from SLIC to PLIC on a SetAsrAndRfid.
 	u64	saved_srr0;		// Saved SRR0                   x10-x17
 	u64	saved_srr1;		// Saved SRR1                   x18-x1F
-
-	// Used to pass parms from the OS to PLIC for SetAsrAndRfid
-	u64	saved_gpr3;		// Saved GPR3                   x20-x27
-	u64	saved_gpr4;		// Saved GPR4                   x28-x2F
-	union {
-		u64	saved_gpr5;	/* Saved GPR5               x30-x37 */
-		struct {
-			u8	cede_latency_hint;  /*			x30 */
-			u8	reserved[7];        /*		    x31-x36 */
-		} fields;
-	} gpr5_dword;
-
-
+	u64	reserved5[2];		/*			    x20-x2F */
+	u8	cede_latency_hint;	/*				x30 */
+	u8	reserved[7];		/*			    x31-x37 */
 	u8	dtl_enable_mask;	// Dispatch Trace Log mask	x38-x38
 	u8	donate_dedicated_cpu;	// Donate dedicated CPU cycles  x39-x39
 	u8	fpregs_in_use;		// FP regs in use               x3A-x3A
Index: linux-build/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h	2012-04-11 11:59:57.652829173 +1000
+++ linux-build/arch/powerpc/platforms/pseries/plpar_wrappers.h	2012-04-11 12:00:13.473120748 +1000
@@ -22,12 +22,12 @@ static inline long poll_pending(void)
 
 static inline u8 get_cede_latency_hint(void)
 {
-	return get_lppaca()->gpr5_dword.fields.cede_latency_hint;
+	return get_lppaca()->cede_latency_hint;
 }
 
 static inline void set_cede_latency_hint(u8 latency_hint)
 {
-	get_lppaca()->gpr5_dword.fields.cede_latency_hint = latency_hint;
+	get_lppaca()->cede_latency_hint = latency_hint;
 }
 
 static inline long cede_processor(void)
