Return-Path: <anton@samba.org>
Date: Wed, 11 Apr 2012 12:22:53 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@canb.auug.org.au
Subject: [PATCH 3/3] powerpc: Reformat lppaca.h
Message-ID: <20120411122253.16764ec6@kryten>
In-Reply-To: <20120411122054.6297f2fb@kryten>
References: <20120411122054.6297f2fb@kryten>
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


Reformat lppaca.h to match Linux coding standards.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/lppaca.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/lppaca.h	2012-04-11 12:07:53.000000000 +1000
+++ linux-build/arch/powerpc/include/asm/lppaca.h	2012-04-11 12:08:25.794532160 +1000
@@ -20,18 +20,16 @@
 #define _ASM_POWERPC_LPPACA_H
 #ifdef __KERNEL__
 
-/* These definitions relate to hypervisors that only exist when using
+/*
+ * These definitions relate to hypervisors that only exist when using
  * a server type processor
  */
 #ifdef CONFIG_PPC_BOOK3S
 
-//=============================================================================
-//
-//	This control block contains the data that is shared between the
-//	hypervisor and the OS.
-//
-//
-//----------------------------------------------------------------------------
+/*
+ * This control block contains the data that is shared between the
+ * hypervisor and the OS.
+ */
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <asm/types.h>
@@ -43,67 +41,65 @@
  */
 #define NR_LPPACAS	1
 
-
-/* The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
- * alignment is sufficient to prevent this */
+/*
+ * The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
+ * alignment is sufficient to prevent this
+ */
 struct lppaca {
-//=============================================================================
-// CACHE_LINE_1 0x0000 - 0x007F Contains read-only data
-//=============================================================================
-	u32	desc;			// Eye catcher 0xD397D781	x00-x03
-	u16	size;			// Size of this struct		x04-x05
-	u16	reserved1;		// Reserved			x06-x07
-	u16	reserved2:14;		// Reserved			x08-x09
-	u8	shared_proc:1;		// Shared processor indicator	...
-	u8	secondary_thread:1;	// Secondary thread indicator	...
-	u8	reserved3[14];		//				x0A-x17
-	volatile u32 dyn_hw_node_id;	// Dynamic Hardware Node id	x18-x1B
-	volatile u32 dyn_hw_proc_id;	// Dynamic Hardware Proc Id	x1C-x1F
-	u8	reserved4[56];		// Reserved			x20-x57
-	volatile u8 vphn_assoc_counts[8]; // Virtual processor home node
-					// associativity change counters x58-x5F
-	u8	reserved5[32];		// Reserved			x60-x7F
-
-//=============================================================================
-// CACHE_LINE_2 0x0080 - 0x00FF Contains local read-write data
-//=============================================================================
-
-	u8	reserved6[48];		//				x00-x2f
-	u8	cede_latency_hint;	/*				x30 */
-	u8	reserved7[7];		/*			    x31-x37 */
-	u8	dtl_enable_mask;	// Dispatch Trace Log mask	x38-x38
-	u8	donate_dedicated_cpu;	// Donate dedicated CPU cycles  x39-x39
-	u8	fpregs_in_use;		// FP regs in use               x3A-x3A
-	u8	pmcregs_in_use;		// PMC regs in use              x3B-x3B
-	u8	reserved8[28];		//				x3C-x57
-	u64	wait_state_cycles;	// Wait cycles for this proc    x58-x5F
-	u8	reserved9[28];		//				x60-x7B
-	u16	slb_count;		// # of SLBs to maintain        x7C-x7D
-	u8	idle;			// Indicate OS is idle          x7E
-	u8	vmxregs_in_use;		// VMX registers in use         x7F
-
-//=============================================================================
-// CACHE_LINE_3 0x0100 - 0x017F: This line is shared with other processors
-//=============================================================================
-	// This is the yield_count.  An "odd" value (low bit on) means that
-	// the processor is yielded (either because of an OS yield or a PLIC
-	// preempt).  An even value implies that the processor is currently
-	// executing.
-	// NOTE: This value will ALWAYS be zero for dedicated processors and
-	// will NEVER be zero for shared processors (ie, initialized to a 1).
-	volatile u32 yield_count;	// PLIC increments each dispatchx00-x03
-	volatile u32 dispersion_count;	// dispatch changed phys cpu    x04-x07
-	volatile u64 cmo_faults;	// CMO page fault count         x08-x0F
-	volatile u64 cmo_fault_time;	// CMO page fault time          x10-x17
-	u8	reserved10[104];		// Reserved                     x18-x7F
-
-//=============================================================================
-// CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
-//=============================================================================
-	u32	page_ins;		// CMO Hint - # page ins by OS  x00-x03
-	u8	reserved11[148];		// Reserved                     x04-x97
-	volatile u64 dtl_idx;		// Dispatch Trace Log head idx	x98-x9F
-	u8	reserved12[96];		// Reserved                     xA0-xFF
+	/* cacheline 1 contains read-only data */
+
+	u32	desc;			/* Eye catcher 0xD397D781 */
+	u16	size;			/* Size of this struct */
+	u16	reserved1;
+	u16	reserved2:14;
+	u8	shared_proc:1;		/* Shared processor indicator */
+	u8	secondary_thread:1;	/* Secondary thread indicator */
+	u8	reserved3[14];
+	volatile u32 dyn_hw_node_id;	/* Dynamic hardware node id */
+	volatile u32 dyn_hw_proc_id;	/* Dynamic hardware proc id */
+	u8	reserved4[56];
+	volatile u8 vphn_assoc_counts[8]; /* Virtual processor home node */
+					  /* associativity change counters */
+	u8	reserved5[32];
+
+	/* cacheline 2 contains local read-write data */
+
+	u8	reserved6[48];
+	u8	cede_latency_hint;
+	u8	reserved7[7];
+	u8	dtl_enable_mask;	/* Dispatch Trace Log mask */
+	u8	donate_dedicated_cpu;	/* Donate dedicated CPU cycles */
+	u8	fpregs_in_use;
+	u8	pmcregs_in_use;
+	u8	reserved8[28];
+	u64	wait_state_cycles;	/* Wait cycles for this proc */
+	u8	reserved9[28];
+	u16	slb_count;		/* # of SLBs to maintain */
+	u8	idle;			/* Indicate OS is idle */
+	u8	vmxregs_in_use;
+
+	/* cacheline 3 is shared with other processors */
+
+	/*
+	 * This is the yield_count.  An "odd" value (low bit on) means that
+	 * the processor is yielded (either because of an OS yield or a
+	 * hypervisor preempt).  An even value implies that the processor is
+	 * currently executing.
+	 * NOTE: This value will ALWAYS be zero for dedicated processors and
+	 * will NEVER be zero for shared processors (ie, initialized to a 1).
+	 */
+	volatile u32 yield_count;
+	volatile u32 dispersion_count;	/* dispatch changed physical cpu */
+	volatile u64 cmo_faults;	/* CMO page fault count */
+	volatile u64 cmo_fault_time;	/* CMO page fault time */
+	u8	reserved10[104];
+
+	/* cacheline 4-5 */
+
+	u32	page_ins;		/* CMO Hint - # page ins by OS */
+	u8	reserved11[148];
+	volatile u64 dtl_idx;		/* Dispatch Trace Log head index */
+	u8	reserved12[96];
 } __attribute__((__aligned__(0x400)));
 
 extern struct lppaca lppaca[];
@@ -116,13 +112,13 @@ extern struct lppaca lppaca[];
  * ESID is stored in the lower 64bits, then the VSID.
  */
 struct slb_shadow {
-	u32	persistent;		// Number of persistent SLBs	x00-x03
-	u32	buffer_length;		// Total shadow buffer length	x04-x07
-	u64	reserved;		// Alignment			x08-x0f
+	u32	persistent;		/* Number of persistent SLBs */
+	u32	buffer_length;		/* Total shadow buffer length */
+	u64	reserved;
 	struct	{
 		u64     esid;
 		u64	vsid;
-	} save_area[SLB_NUM_BOLTED];	//				x10-x40
+	} save_area[SLB_NUM_BOLTED];
 } ____cacheline_aligned;
 
 extern struct slb_shadow slb_shadow[];
