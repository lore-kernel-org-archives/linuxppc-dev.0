Return-Path: <anton@samba.org>
Date: Wed, 11 Apr 2012 12:22:12 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@canb.auug.org.au
Subject: [PATCH 2/3] powerpc: Remove iseries specific fields in lppaca
Message-ID: <20120411122212.15e42ac5@kryten>
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


Remove all the iseries specific fields in the lppaca.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/lppaca.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/lppaca.h	2012-04-11 12:05:54.000000000 +1000
+++ linux-build/arch/powerpc/include/asm/lppaca.h	2012-04-11 12:07:53.537907718 +1000
@@ -28,7 +28,7 @@
 //=============================================================================
 //
 //	This control block contains the data that is shared between the
-//	hypervisor (PLIC) and the OS.
+//	hypervisor and the OS.
 //
 //
 //----------------------------------------------------------------------------
@@ -49,9 +49,6 @@
 struct lppaca {
 //=============================================================================
 // CACHE_LINE_1 0x0000 - 0x007F Contains read-only data
-// NOTE: The xDynXyz fields are fields that will be dynamically changed by
-// PLIC when preparing to bring a processor online or when dispatching a
-// virtual processor!
 //=============================================================================
 	u32	desc;			// Eye catcher 0xD397D781	x00-x03
 	u16	size;			// Size of this struct		x04-x05
@@ -59,75 +56,32 @@ struct lppaca {
 	u16	reserved2:14;		// Reserved			x08-x09
 	u8	shared_proc:1;		// Shared processor indicator	...
 	u8	secondary_thread:1;	// Secondary thread indicator	...
-	volatile u8 dyn_proc_status:8;	// Dynamic Status of this proc	x0A-x0A
-	u8	secondary_thread_count;	// Secondary thread count	x0B-x0B
-	volatile u16 dyn_hv_phys_proc_index;// Dynamic HV Physical Proc Index0C-x0D
-	volatile u16 dyn_hv_log_proc_index;// Dynamic HV Logical Proc Indexx0E-x0F
-	u32	decr_val;   		// Value for Decr programming 	x10-x13
-	u32	pmc_val;       		// Value for PMC regs         	x14-x17
+	u8	reserved3[14];		//				x0A-x17
 	volatile u32 dyn_hw_node_id;	// Dynamic Hardware Node id	x18-x1B
 	volatile u32 dyn_hw_proc_id;	// Dynamic Hardware Proc Id	x1C-x1F
-	volatile u32 dyn_pir;		// Dynamic ProcIdReg value	x20-x23
-	u32	dsei_data;           	// DSEI data                  	x24-x27
-	u64	sprg3;               	// SPRG3 value                	x28-x2F
-	u8	reserved3[40];		// Reserved			x30-x57
+	u8	reserved4[56];		// Reserved			x20-x57
 	volatile u8 vphn_assoc_counts[8]; // Virtual processor home node
 					// associativity change counters x58-x5F
-	u8	reserved4[32];		// Reserved			x60-x7F
+	u8	reserved5[32];		// Reserved			x60-x7F
 
 //=============================================================================
 // CACHE_LINE_2 0x0080 - 0x00FF Contains local read-write data
 //=============================================================================
-	// This Dword contains a byte for each type of interrupt that can occur.
-	// The IPI is a count while the others are just a binary 1 or 0.
-	union {
-		u64	any_int;
-		struct {
-			u16	reserved;	// Reserved - cleared by #mpasmbl
-			u8	xirr_int;	// Indicates xXirrValue is valid or Immed IO
-			u8	ipi_cnt;	// IPI Count
-			u8	decr_int;	// DECR interrupt occurred
-			u8	pdc_int;	// PDC interrupt occurred
-			u8	quantum_int;	// Interrupt quantum reached
-			u8	old_plic_deferred_ext_int;	// Old PLIC has a deferred XIRR pending
-		} fields;
-	} int_dword;
-
-	// Whenever any fields in this Dword are set then PLIC will defer the
-	// processing of external interrupts.  Note that PLIC will store the
-	// XIRR directly into the xXirrValue field so that another XIRR will
-	// not be presented until this one clears.  The layout of the low
-	// 4-bytes of this Dword is up to SLIC - PLIC just checks whether the
-	// entire Dword is zero or not.  A non-zero value in the low order
-	// 2-bytes will result in SLIC being granted the highest thread
-	// priority upon return.  A 0 will return to SLIC as medium priority.
-	u64	plic_defer_ints_area;	// Entire Dword
-
-	// Used to pass the real SRR0/1 from PLIC to SLIC as well as to
-	// pass the target SRR0/1 from SLIC to PLIC on a SetAsrAndRfid.
-	u64	saved_srr0;		// Saved SRR0                   x10-x17
-	u64	saved_srr1;		// Saved SRR1                   x18-x1F
-	u64	reserved5[2];		/*			    x20-x2F */
+
+	u8	reserved6[48];		//				x00-x2f
 	u8	cede_latency_hint;	/*				x30 */
-	u8	reserved[7];		/*			    x31-x37 */
+	u8	reserved7[7];		/*			    x31-x37 */
 	u8	dtl_enable_mask;	// Dispatch Trace Log mask	x38-x38
 	u8	donate_dedicated_cpu;	// Donate dedicated CPU cycles  x39-x39
 	u8	fpregs_in_use;		// FP regs in use               x3A-x3A
 	u8	pmcregs_in_use;		// PMC regs in use              x3B-x3B
-	volatile u32 saved_decr;	// Saved Decr Value             x3C-x3F
-	volatile u64 emulated_time_base;// Emulated TB for this thread  x40-x47
-	volatile u64 cur_plic_latency;	// Unaccounted PLIC latency     x48-x4F
-	u64	tot_plic_latency;	// Accumulated PLIC latency     x50-x57
+	u8	reserved8[28];		//				x3C-x57
 	u64	wait_state_cycles;	// Wait cycles for this proc    x58-x5F
-	u64	end_of_quantum;		// TB at end of quantum         x60-x67
-	u64	pdc_saved_sprg1;	// Saved SPRG1 for PMC int      x68-x6F
-	u64	pdc_saved_srr0;		// Saved SRR0 for PMC int       x70-x77
-	volatile u32 virtual_decr;	// Virtual DECR for shared procsx78-x7B
+	u8	reserved9[28];		//				x60-x7B
 	u16	slb_count;		// # of SLBs to maintain        x7C-x7D
 	u8	idle;			// Indicate OS is idle          x7E
 	u8	vmxregs_in_use;		// VMX registers in use         x7F
 
-
 //=============================================================================
 // CACHE_LINE_3 0x0100 - 0x017F: This line is shared with other processors
 //=============================================================================
@@ -141,15 +95,15 @@ struct lppaca {
 	volatile u32 dispersion_count;	// dispatch changed phys cpu    x04-x07
 	volatile u64 cmo_faults;	// CMO page fault count         x08-x0F
 	volatile u64 cmo_fault_time;	// CMO page fault time          x10-x17
-	u8	reserved7[104];		// Reserved                     x18-x7F
+	u8	reserved10[104];		// Reserved                     x18-x7F
 
 //=============================================================================
 // CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
 //=============================================================================
 	u32	page_ins;		// CMO Hint - # page ins by OS  x00-x03
-	u8	reserved8[148];		// Reserved                     x04-x97
+	u8	reserved11[148];		// Reserved                     x04-x97
 	volatile u64 dtl_idx;		// Dispatch Trace Log head idx	x98-x9F
-	u8	reserved9[96];		// Reserved                     xA0-xFF
+	u8	reserved12[96];		// Reserved                     xA0-xFF
 } __attribute__((__aligned__(0x400)));
 
 extern struct lppaca lppaca[];
Index: linux-build/arch/powerpc/kernel/paca.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/paca.c	2012-04-11 12:05:15.000000000 +1000
+++ linux-build/arch/powerpc/kernel/paca.c	2012-04-11 12:06:43.012541685 +1000
@@ -36,10 +36,7 @@ struct lppaca lppaca[] = {
 	[0 ... (NR_LPPACAS-1)] = {
 		.desc = 0xd397d781,	/* "LpPa" */
 		.size = sizeof(struct lppaca),
-		.dyn_proc_status = 2,
-		.decr_val = 0x00ff0000,
 		.fpregs_in_use = 1,
-		.end_of_quantum = 0xfffffffffffffffful,
 		.slb_count = 64,
 		.vmxregs_in_use = 0,
 		.page_ins = 0,
Index: linux-build/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/asm-offsets.c	2012-04-11 12:05:15.000000000 +1000
+++ linux-build/arch/powerpc/kernel/asm-offsets.c	2012-04-11 12:06:43.012541685 +1000
@@ -188,10 +188,6 @@ int main(void)
 	DEFINE(SLBSHADOW_STACKESID,
 	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid));
 	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
-	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
-	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
-	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
-	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
 	DEFINE(LPPACA_PMCINUSE, offsetof(struct lppaca, pmcregs_in_use));
 	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
 	DEFINE(LPPACA_YIELDCOUNT, offsetof(struct lppaca, yield_count));
