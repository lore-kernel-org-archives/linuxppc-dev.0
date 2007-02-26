Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU profiling updated patch
Date: Tue, 27 Feb 2007 00:50:59 +0100
References: <1172102523.5233.31.camel@dyn9047021078.beaverton.ibm.com>
In-Reply-To: <1172102523.5233.31.camel@dyn9047021078.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <200702270051.00393.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 February 2007, Carl Love wrote:
> This patch updates the existing arch/powerpc/oprofile/op_model_cell.c
> to add in the SPU profiling capabilities. =A0In addition, a 'cell' subdir=
ectory
> was added to arch/powerpc/oprofile to hold Cell-specific SPU profiling
> code.

There was a significant amount of whitespace breakage in this patch,
which I cleaned up. The patch below consists of the other things
I changed as a further cleanup. Note that I changed the format
of the context switch record, which I found too complicated, as
I described on IRC last week.

	Arnd <><

=2D-
Subject: cleanup spu oprofile code

=46rom: Arnd Bergmann <arnd.bergmann@de.ibm.com>
This cleans up some of the new oprofile code. It's mostly
cosmetic changes, like way multi-line comments are formatted.
The most significant change is a simplification of the
context-switch record format.

It does mean the oprofile report tool needs to be adapted,
but I'm sure that it pays off in the end.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/oprofile/cell/spu_task_sync.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ linux-2.6/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -61,11 +61,12 @@ static void destroy_cached_info(struct k
 static struct cached_info * get_cached_info(struct spu * the_spu, int spu_=
num)
 {
 	struct kref * ref;
=2D	struct cached_info * ret_info =3D NULL;
+	struct cached_info * ret_info;
 	if (spu_num >=3D num_spu_nodes) {
 		printk(KERN_ERR "SPU_PROF: "
 		       "%s, line %d: Invalid index %d into spu info cache\n",
 		       __FUNCTION__, __LINE__, spu_num);
+		ret_info =3D NULL;
 		goto out;
 	}
 	if (!spu_info[spu_num] && the_spu) {
@@ -89,9 +90,9 @@ static struct cached_info * get_cached_i
 static int
 prepare_cached_spu_info(struct spu * spu, unsigned int objectId)
 {
=2D	unsigned long flags =3D 0;
+	unsigned long flags;
 	struct vma_to_fileoffset_map * new_map;
=2D	int retval =3D 0;
+	int retval;
 	struct cached_info * info;
=20
 	/* We won't bother getting cache_lock here since
@@ -112,6 +113,7 @@ prepare_cached_spu_info(struct spu * spu
 		printk(KERN_ERR "SPU_PROF: "
 		       "%s, line %d: create vma_map failed\n",
 		       __FUNCTION__, __LINE__);
+		retval =3D -ENOMEM;
 		goto err_alloc;
 	}
 	new_map =3D create_vma_map(spu, objectId);
@@ -119,6 +121,7 @@ prepare_cached_spu_info(struct spu * spu
 		printk(KERN_ERR "SPU_PROF: "
 		       "%s, line %d: create vma_map failed\n",
 		       __FUNCTION__, __LINE__);
+		retval =3D -ENOMEM;
 		goto err_alloc;
 	}
=20
@@ -144,7 +147,7 @@ prepare_cached_spu_info(struct spu * spu
 	goto out;
=20
 err_alloc:
=2D	retval =3D -1;
+	kfree(info);
 out:
 	return retval;
 }
@@ -215,11 +218,9 @@ static inline unsigned long fast_get_dco
 static unsigned long
 get_exec_dcookie_and_offset(struct spu * spu, unsigned int * offsetp,
 			    unsigned long * spu_bin_dcookie,
=2D			    unsigned long * shlib_dcookie,
 			    unsigned int spu_ref)
 {
 	unsigned long app_cookie =3D 0;
=2D	unsigned long * image_cookie =3D NULL;
 	unsigned int my_offset =3D 0;
 	struct file * app =3D NULL;
 	struct vm_area_struct * vma;
@@ -252,24 +253,17 @@ get_exec_dcookie_and_offset(struct spu *
 			 my_offset, spu_ref,
 			 vma->vm_file->f_dentry->d_name.name);
 		*offsetp =3D my_offset;
=2D		if (my_offset =3D=3D 0)
=2D			image_cookie =3D spu_bin_dcookie;
=2D		else if (vma->vm_file !=3D app)
=2D			image_cookie =3D shlib_dcookie;
 		break;
 	}
=20
=2D	if (image_cookie) {
=2D		*image_cookie =3D fast_get_dcookie(vma->vm_file->f_dentry,
+	*spu_bin_dcookie =3D fast_get_dcookie(vma->vm_file->f_dentry,
 						 vma->vm_file->f_vfsmnt);
=2D		pr_debug("got dcookie for %s\n",
=2D			 vma->vm_file->f_dentry->d_name.name);
=2D	}
+	pr_debug("got dcookie for %s\n", vma->vm_file->f_dentry->d_name.name);
=20
=2D out:
+out:
 	return app_cookie;
=20
=2D fail_no_image_cookie:
+fail_no_image_cookie:
 	printk(KERN_ERR "SPU_PROF: "
 		"%s, line %d: Cannot find dcookie for SPU binary\n",
 		__FUNCTION__, __LINE__);
@@ -285,18 +279,18 @@ get_exec_dcookie_and_offset(struct spu *
 static int process_context_switch(struct spu * spu, unsigned int objectId)
 {
 	unsigned long flags;
=2D	int retval =3D 0;
=2D	unsigned int offset =3D 0;
=2D	unsigned long spu_cookie =3D 0, app_dcookie =3D 0, shlib_cookie =3D 0;
+	int retval;
+	unsigned int offset;
+	unsigned long spu_cookie, app_dcookie;
+
 	retval =3D prepare_cached_spu_info(spu, objectId);
=2D	if (retval =3D=3D -1) {
+	if (retval)
 		goto out;
=2D	}
+
 	/* Get dcookie first because a mutex_lock is taken in that
 	 * code path, so interrupts must not be disabled.
 	 */
=2D	app_dcookie =3D get_exec_dcookie_and_offset(spu, &offset, &spu_cookie,
=2D						  &shlib_cookie, objectId);
+	app_dcookie =3D get_exec_dcookie_and_offset(spu, &offset, &spu_cookie, ob=
jectId);
=20
 	/* Record context info in event buffer */
 	spin_lock_irqsave(&buffer_lock, flags);
@@ -306,27 +300,8 @@ static int process_context_switch(struct
 	add_event_entry(spu->pid);
 	add_event_entry(spu->tgid);
 	add_event_entry(app_dcookie);
=2D
=2D	if (offset) {
=2D		/* When offset is non-zero, the SPU ELF was embedded;
=2D		 * otherwise, it was loaded from a separate binary file. For
=2D		 * embedded case, we record the offset into the embedding file
=2D		 * where the SPU ELF was placed.  The embedding file may be
=2D		 * either the executable application binary or shared library.
=2D		 * For the non-embedded case, we record a dcookie that
=2D		 * points to the location of the separate SPU binary that was
=2D		 * loaded.
=2D		 */
=2D		if (shlib_cookie) {
=2D			add_event_entry(SPU_SHLIB_COOKIE_CODE);
=2D			add_event_entry(shlib_cookie);
=2D		}
=2D		add_event_entry(SPU_OFFSET_CODE);
=2D		add_event_entry(offset);
=2D	} else {
=2D		add_event_entry(SPU_COOKIE_CODE);
=2D		add_event_entry(spu_cookie);
=2D	}
+	add_event_entry(spu_cookie);
+	add_event_entry(offset);
 	spin_unlock_irqrestore(&buffer_lock, flags);
 	smp_wmb();
 out:
@@ -343,8 +318,8 @@ static int spu_active_notify(struct noti
 				void * data)
 {
 	int retval;
=2D	unsigned long flags =3D 0;
=2D	struct spu * the_spu =3D data;
+	unsigned long flags;
+	struct spu *the_spu =3D data;
 	pr_debug("SPU event notification arrived\n");
 	if (!val){
 		spin_lock_irqsave(&cache_lock, flags);
@@ -403,8 +378,7 @@ void spu_sync_buffer(int spu_num, unsign
 		     int num_samples)
 {
 	unsigned long long file_offset;
=2D	unsigned long cache_lock_flags =3D 0;
=2D	unsigned long buffer_lock_flags =3D 0;
+	unsigned long flags;
 	int i;
 	struct vma_to_fileoffset_map * map;
 	struct spu * the_spu;
@@ -417,29 +391,27 @@ void spu_sync_buffer(int spu_num, unsign
 	 * corresponding to this cached_info may end, thus resulting
 	 * in the destruction of the cached_info.
 	 */
=2D	spin_lock_irqsave(&cache_lock, cache_lock_flags);
+	spin_lock_irqsave(&cache_lock, flags);
 	c_info =3D get_cached_info(NULL, spu_num);
=2D	if (c_info =3D=3D NULL) {
+	if (!c_info) {
 	/* This legitimately happens when the SPU task ends before all
 	 * samples are recorded.  No big deal -- so we just drop a few samples.
 	 */
 		pr_debug("SPU_PROF: No cached SPU contex "
 			  "for SPU #%d. Dropping samples.\n", spu_num);
=2D		spin_unlock_irqrestore(&cache_lock, cache_lock_flags);
=2D		return ;
+		goto out;
 	}
=20
 	map =3D c_info->map;
 	the_spu =3D c_info->the_spu;
=2D	spin_lock_irqsave(&buffer_lock, buffer_lock_flags);
+	spin_lock(&buffer_lock);
 	for (i =3D 0; i < num_samples; i++) {
 		unsigned int sample =3D *(samples+i);
 		int grd_val =3D 0;
 		file_offset =3D 0;
 		if (sample =3D=3D 0)
 			continue;
=2D		file_offset =3D vma_map_lookup(
=2D			map, sample, the_spu, &grd_val);
+		file_offset =3D vma_map_lookup( map, sample, the_spu, &grd_val);
=20
 		/* If overlays are used by this SPU application, the guard
 		 * value is non-zero, indicating which overlay section is in
@@ -460,8 +432,9 @@ void spu_sync_buffer(int spu_num, unsign
 			continue;
 		add_event_entry(file_offset | spu_num_shifted);
 	}
=2D	spin_unlock_irqrestore(&buffer_lock, buffer_lock_flags);
=2D	spin_unlock_irqrestore(&cache_lock, cache_lock_flags);
+	spin_unlock(&buffer_lock);
+out:
+	spin_unlock_irqrestore(&cache_lock, flags);
 }
=20
=20
Index: linux-2.6/arch/powerpc/oprofile/op_model_cell.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/arch/powerpc/oprofile/op_model_cell.c
+++ linux-2.6/arch/powerpc/oprofile/op_model_cell.c
@@ -40,7 +40,8 @@
 #include "../platforms/cell/cbe_regs.h"
 #include "cell/pr_util.h"
=20
=2D/* spu_cycle_reset is the number of cycles between samples.
+/*
+ * spu_cycle_reset is the number of cycles between samples.
  * This variable is used for SPU profiling and should ONLY be set
  * at the beginning of cell_reg_setup; otherwise, it's read-only.
  */
@@ -73,7 +74,6 @@ struct pmc_cntrl_data {
 /*
  * ibm,cbe-perftools rtas parameters
  */
=2D
 struct pm_signal {
 	u16 cpu;		/* Processor to modify */
 	u16 sub_unit;		/* hw subunit this applies to (if applicable)*/
@@ -123,7 +123,8 @@ static DEFINE_PER_CPU(unsigned long[NR_P
=20
 static struct pmc_cntrl_data pmc_cntrl[NUM_THREADS][NR_PHYS_CTRS];
=20
=2D/* The CELL profiling code makes rtas calls to setup the debug bus to
+/*
+ * The CELL profiling code makes rtas calls to setup the debug bus to
  * route the performance signals.  Additionally, SPU profiling requires
  * a second rtas call to setup the hardware to capture the SPU PCs.
  * The EIO error value is returned if the token lookups or the rtas
@@ -137,16 +138,21 @@ static struct pmc_cntrl_data pmc_cntrl[N
  * either.
  */
=20
=2D/* Interpetation of hdw_thread:
+/*
+ * Interpetation of hdw_thread:
  * 0 - even virtual cpus 0, 2, 4,...
  * 1 - odd virtual cpus 1, 3, 5, ...
+ *
+ * FIXME: this is strictly wrong, we need to clean this up in a number
+ * of places. It works for now. -arnd
  */
 static u32 hdw_thread;
=20
 static u32 virt_cntr_inter_mask;
 static struct timer_list timer_virt_cntr;
=20
=2D/* pm_signal needs to be global since it is initialized in
+/*
+ * pm_signal needs to be global since it is initialized in
  * cell_reg_setup at the time when the necessary information
  * is available.
  */
@@ -167,7 +173,6 @@ static unsigned char input_bus[NUM_INPUT
 /*
  * Firmware interface functions
  */
=2D
 static int
 rtas_ibm_cbe_perftools(int subfunc, int passthru,
 		       void *address, unsigned long length)
@@ -183,12 +188,13 @@ static void pm_rtas_reset_signals(u32 no
 	int ret;
 	struct pm_signal pm_signal_local;
=20
=2D	/*  The debug bus is being set to the passthru disable state.
=2D	 *  However, the FW still expects atleast one legal signal routing
=2D	 *  entry or it will return an error on the arguments.	If we don't
=2D	 *  supply a valid entry, we must ignore all return values.  Ignoring
=2D	 *  all return values means we might miss an error we should be
=2D	 *  concerned about.
+	/*
+	 * The debug bus is being set to the passthru disable state.
+	 * However, the FW still expects atleast one legal signal routing
+	 * entry or it will return an error on the arguments.	If we don't
+	 * supply a valid entry, we must ignore all return values.  Ignoring
+	 * all return values means we might miss an error we should be
+	 * concerned about.
 	 */
=20
 	/*  fw expects physical cpu #. */
@@ -203,7 +209,8 @@ static void pm_rtas_reset_signals(u32 no
 				     sizeof(struct pm_signal));
=20
 	if (unlikely(ret))
=2D		/* Not a fatal error. For Oprofile stop, the oprofile
+		/*
+		 * Not a fatal error. For Oprofile stop, the oprofile
 		 * functions do not support returning an error for
 		 * failure to stop OProfile.
 		 */
@@ -217,7 +224,8 @@ static int pm_rtas_activate_signals(u32=20
 	int i, j;
 	struct pm_signal pm_signal_local[NR_PHYS_CTRS];
=20
=2D	/* There is no debug setup required for the cycles event.
+	/*
+	 * There is no debug setup required for the cycles event.
 	 * Note that only events in the same group can be used.
 	 * Otherwise, there will be conflicts in correctly routing
 	 * the signals on the debug bus.  It is the responsiblity
@@ -295,7 +303,8 @@ static void set_pm_event(u32 ctr, int ev
 	pm_regs.pm07_cntrl[ctr] |=3D PM07_CTR_POLARITY(polarity);
 	pm_regs.pm07_cntrl[ctr] |=3D PM07_CTR_INPUT_CONTROL(input_control);
=20
=2D	/* Some of the islands signal selection is based on 64 bit words.
+	/*
+	 * Some of the islands signal selection is based on 64 bit words.
 	 * The debug bus words are 32 bits, the input words to the performance
 	 * counters are defined as 32 bits.  Need to convert the 64 bit island
 	 * specification to the appropriate 32 input bit and bus word for the
@@ -345,7 +354,8 @@ out:
=20
 static void write_pm_cntrl(int cpu)
 {
=2D	/* Oprofile will use 32 bit counters, set bits 7:10 to 0
+	/*
+	 * Oprofile will use 32 bit counters, set bits 7:10 to 0
 	 * pmregs.pm_cntrl is a global
 	 */
=20
@@ -362,7 +372,8 @@ static void write_pm_cntrl(int cpu)
 	if (pm_regs.pm_cntrl.freeze =3D=3D 1)
 		val |=3D CBE_PM_FREEZE_ALL_CTRS;
=20
=2D	/* Routine set_count_mode must be called previously to set
+	/*
+	 * Routine set_count_mode must be called previously to set
 	 * the count mode based on the user selection of user and kernel.
 	 */
 	val |=3D CBE_PM_COUNT_MODE_SET(pm_regs.pm_cntrl.count_mode);
@@ -372,7 +383,8 @@ static void write_pm_cntrl(int cpu)
 static inline void
 set_count_mode(u32 kernel, u32 user)
 {
=2D	/* The user must specify user and kernel if they want them. If
+	/*
+	 * The user must specify user and kernel if they want them. If
 	 *  neither is specified, OProfile will count in hypervisor mode.
 	 *  pm_regs.pm_cntrl is a global
 	 */
@@ -413,17 +425,18 @@ static inline void enable_ctr(u32 cpu, u
  * pair of per-cpu arrays is used for storing the previous and next
  * pmc values for a given node.
  * NOTE: We use the per-cpu variable to improve cache performance.
+ *
+ * This routine will alternate loading the virtual counters for
+ * virtual CPUs
  */
 static void cell_virtual_cntr(unsigned long data)
 {
=2D	/* This routine will alternate loading the virtual counters for
=2D	 * virtual CPUs
=2D	 */
 	int i, prev_hdw_thread, next_hdw_thread;
 	u32 cpu;
 	unsigned long flags;
=20
=2D	/* Make sure that the interrupt_hander and the virt counter are
+	/*
+	 * Make sure that the interrupt_hander and the virt counter are
 	 * not both playing with the counters on the same node.
 	 */
=20
@@ -435,22 +448,25 @@ static void cell_virtual_cntr(unsigned l
 	hdw_thread =3D 1 ^ hdw_thread;
 	next_hdw_thread =3D hdw_thread;
=20
=2D	for (i =3D 0; i < num_counters; i++)
=2D	/* There are some per thread events.  Must do the
+	/*
+	 * There are some per thread events.  Must do the
 	 * set event, for the thread that is being started
 	 */
+	for (i =3D 0; i < num_counters; i++)
 		set_pm_event(i,
 			pmc_cntrl[next_hdw_thread][i].evnts,
 			pmc_cntrl[next_hdw_thread][i].masks);
=20
=2D	/* The following is done only once per each node, but
+	/*
+	 * The following is done only once per each node, but
 	 * we need cpu #, not node #, to pass to the cbe_xxx functions.
 	 */
 	for_each_online_cpu(cpu) {
 		if (cbe_get_hw_thread_id(cpu))
 			continue;
=20
=2D		/* stop counters, save counter values, restore counts
+		/*
+		 * stop counters, save counter values, restore counts
 		 * for previous thread
 		 */
 		cbe_disable_pm(cpu);
@@ -479,13 +495,15 @@ static void cell_virtual_cntr(unsigned l
 						      next_hdw_thread)[i]);
 		}
=20
=2D		/* Switch to the other thread. Change the interrupt
+		/*
+		 * Switch to the other thread. Change the interrupt
 		 * and control regs to be scheduled on the CPU
 		 * corresponding to the thread to execute.
 		 */
 		for (i =3D 0; i < num_counters; i++) {
 			if (pmc_cntrl[next_hdw_thread][i].enabled) {
=2D				/* There are some per thread events.
+				/*
+				 * There are some per thread events.
 				 * Must do the set event, enable_cntr
 				 * for each cpu.
 				 */
@@ -517,9 +535,8 @@ static void start_virt_cntrs(void)
 }
=20
 /* This function is called once for all cpus combined */
=2Dstatic int
=2Dcell_reg_setup(struct op_counter_config *ctr,
=2D	       struct op_system_config *sys, int num_ctrs)
+static int cell_reg_setup(struct op_counter_config *ctr,
+			struct op_system_config *sys, int num_ctrs)
 {
 	int i, j, cpu;
 	spu_cycle_reset =3D 0;
@@ -527,7 +544,8 @@ cell_reg_setup(struct op_counter_config=20
 	if (ctr[0].event =3D=3D SPU_CYCLES_EVENT_NUM) {
 		spu_cycle_reset =3D ctr[0].count;
=20
=2D		/* Each node will need to make the rtas call to start
+		/*
+		 * Each node will need to make the rtas call to start
 		 * and stop SPU profiling.  Get the token once and store it.
 		 */
 		spu_rtas_token =3D rtas_token("ibm,cbe-spu-perftools");
@@ -542,7 +560,8 @@ cell_reg_setup(struct op_counter_config=20
=20
 	pm_rtas_token =3D rtas_token("ibm,cbe-perftools");
=20
=2D	/* For all events excetp PPU CYCLEs, each node will need to make
+	/*
+	 * For all events excetp PPU CYCLEs, each node will need to make
 	 * the rtas cbe-perftools call to setup and reset the debug bus.
 	 * Make the token lookup call once and store it in the global
 	 * variable pm_rtas_token.
@@ -579,7 +598,8 @@ cell_reg_setup(struct op_counter_config=20
 			per_cpu(pmc_values, j)[i] =3D 0;
 	}
=20
=2D	/* Setup the thread 1 events, map the thread 0 event to the
+	/*
+	 * Setup the thread 1 events, map the thread 0 event to the
 	 * equivalent thread 1 event.
 	 */
 	for (i =3D 0; i < num_ctrs; ++i) {
@@ -603,7 +623,8 @@ cell_reg_setup(struct op_counter_config=20
 	for (i =3D 0; i < NUM_INPUT_BUS_WORDS; i++)
 		input_bus[i] =3D 0xff;
=20
=2D	/* Our counters count up, and "count" refers to
+	/*
+	 * Our counters count up, and "count" refers to
 	 * how much before the next interrupt, and we interrupt
 	 * on overflow.	 So we calculate the starting value
 	 * which will give us "count" until overflow.
@@ -667,19 +688,19 @@ static int cell_cpu_setup(struct op_coun
 		}
 	}
=20
=2D	/* the pm_rtas_activate_signals will return -EIO if the FW
+	/*
+	 * The pm_rtas_activate_signals will return -EIO if the FW
 	 * call failed.
 	 */
=2D	return (pm_rtas_activate_signals(cbe_cpu_to_node(cpu), num_enabled));
=2D
+	return pm_rtas_activate_signals(cbe_cpu_to_node(cpu), num_enabled);
 }
=20
 #define ENTRIES	 303
 #define MAXLFSR	 0xFFFFFF
=20
 /* precomputed table of 24 bit LFSR values */
=2Dint initial_lfsr[] =3D
=2D{8221349, 12579195, 5379618, 10097839, 7512963, 7519310, 3955098, 107534=
24,
+static int initial_lfsr[] =3D {
+ 8221349, 12579195, 5379618, 10097839, 7512963, 7519310, 3955098, 10753424,
  15507573, 7458917, 285419, 2641121, 9780088, 3915503, 6668768, 1548716,
  4885000, 8774424, 9650099, 2044357, 2304411, 9326253, 10332526, 4421547,
  3440748, 10179459, 13332843, 10375561, 1313462, 8375100, 5198480, 6071392,
@@ -716,7 +737,8 @@ int initial_lfsr[] =3D
  3258216, 12505185, 6007317, 9218111, 14661019, 10537428, 11731949, 902700=
3,
  6641507, 9490160, 200241, 9720425, 16277895, 10816638, 1554761, 10431375,
  7467528, 6790302, 3429078, 14633753, 14428997, 11463204, 3576212, 2003426,
=2D 6123687, 820520, 9992513, 15784513, 5778891, 6428165, 8388607};
+ 6123687, 820520, 9992513, 15784513, 5778891, 6428165, 8388607
+};
=20
 /*
  * The hardware uses an LFSR counting sequence to determine when to capture
@@ -777,28 +799,25 @@ int initial_lfsr[] =3D
=20
 static int calculate_lfsr(int n)
 {
=2D	/* The ranges and steps are in powers of 2 so the calculations
+	/*
+	 * The ranges and steps are in powers of 2 so the calculations
 	 * can be done using shifts rather then divide.
 	 */
 	int index;
=20
=2D	if ((n >> 16) =3D=3D 0) {
+	if ((n >> 16) =3D=3D 0)
 		index =3D 0;
=2D
=2D	} else if (((n - V2_16) >> 19) =3D=3D 0) {
+	else if (((n - V2_16) >> 19) =3D=3D 0)
 		index =3D ((n - V2_16) >> 12) + 1;
=2D
=2D	} else if (((n - V2_16 - V2_19) >> 22) =3D=3D 0) {
+	else if (((n - V2_16 - V2_19) >> 22) =3D=3D 0)
 		index =3D ((n - V2_16 - V2_19) >> 15 ) + 1 + 128;
+	else if (((n - V2_16 - V2_19 - V2_22) >> 24) =3D=3D 0)
+		index =3D ((n - V2_16 - V2_19 - V2_22) >> 18 ) + 1 + 256;
+	else
+		index =3D ENTRIES-1;
=20
=2D	} else if (((n - V2_16 - V2_19 - V2_22) >> 24) =3D=3D 0) {
=2D		index =3D ((n - V2_16 - V2_19 - V2_22) >> 18 )
=2D			+ 1 + 256;
=2D	}
=2D
=2D	if ((index > ENTRIES) || (index < 0))	/* make sure index is
=2D						 * valid
=2D						 */
+	/* make sure index is valid */
+	if ((index > ENTRIES) || (index < 0))
 		index =3D ENTRIES-1;
=20
 	return initial_lfsr[index];
@@ -809,15 +828,17 @@ static int pm_rtas_activate_spu_profilin
 	int ret, i;
 	struct pm_signal pm_signal_local[NR_PHYS_CTRS];
=20
=2D	/* Set up the rtas call to configure the debug bus to
=2D	 * route the SPU PCs.  Setup the pm_signal for each SPU */
+	/*
+	 * Set up the rtas call to configure the debug bus to
+	 * route the SPU PCs.  Setup the pm_signal for each SPU
+	 */
 	for (i =3D 0; i < NUM_SPUS_PER_NODE; i++) {
 		pm_signal_local[i].cpu =3D node;
 		pm_signal_local[i].signal_group =3D 41;
=2D		pm_signal_local[i].bus_word =3D 1 << i / 2; /* spu i on
=2D							   * word (i/2)
=2D							   */
=2D		pm_signal_local[i].sub_unit =3D i;	/* spu i */
+		/* spu i on word (i/2) */
+		pm_signal_local[i].bus_word =3D 1 << i / 2;
+		/* spu i */
+		pm_signal_local[i].sub_unit =3D i;
 		pm_signal_local[i].bit =3D 63;
 	}
=20
@@ -858,8 +879,8 @@ static int cell_global_start_spu(struct=20
 	int subfunc, rtn_value;
 	unsigned int lfsr_value;
 	int cpu;
=2D	int ret =3D 0;
=2D	int rtas_error =3D 0;
+	int ret;
+	int rtas_error;
 	unsigned int cpu_khzfreq =3D 0;
=20
 	/* The SPU profiling uses time-based profiling based on
@@ -884,24 +905,23 @@ static int cell_global_start_spu(struct=20
 	for_each_online_cpu(cpu) {
 		if (cbe_get_hw_thread_id(cpu))
 			continue;
=2D		/* Setup SPU cycle-based profiling.
+
+		/*
+		 * Setup SPU cycle-based profiling.
 		 * Set perf_mon_control bit 0 to a zero before
 		 * enabling spu collection hardware.
 		 */
 		cbe_write_pm(cpu, pm_control, 0);
=20
 		if (spu_cycle_reset > MAX_SPU_COUNT)
=2D			/* use largest possible value
=2D			 */
+			/* use largest possible value */
 			lfsr_value =3D calculate_lfsr(MAX_SPU_COUNT-1);
 		else
=2D		    lfsr_value =3D calculate_lfsr(spu_cycle_reset);
+			lfsr_value =3D calculate_lfsr(spu_cycle_reset);
=20
=2D		if (lfsr_value =3D=3D 0) {	/* must use a non zero value.  Zero
=2D					 * disables data collection.
=2D					 */
=2D				lfsr_value =3D calculate_lfsr(1);
=2D		}
+		/* must use a non zero value. Zero disables data collection. */
+		if (lfsr_value =3D=3D 0)
+			lfsr_value =3D calculate_lfsr(1);
=20
 		lfsr_value =3D lfsr_value << 8; /* shift lfsr to correct
 						* register location
@@ -916,7 +936,7 @@ static int cell_global_start_spu(struct=20
 		}
=20
=20
=2D		subfunc =3D 2;	// 2 - activate SPU tracing, 3 - deactivate
+		subfunc =3D 2;	/* 2 - activate SPU tracing, 3 - deactivate */
=20
 		/* start profiling */
 		rtn_value =3D rtas_call(spu_rtas_token, 3, 1, NULL, subfunc,
@@ -976,7 +996,8 @@ static int cell_global_start_ppu(struct=20
 	oprofile_running =3D 1;
 	smp_wmb();
=20
=2D	/* NOTE: start_virt_cntrs will result in cell_virtual_cntr() being
+	/*
+	 * NOTE: start_virt_cntrs will result in cell_virtual_cntr() being
 	 * executed which manipulates the PMU.	We start the "virtual counter"
 	 * here so that we do not need to synchronize access to the PMU in
 	 * the above for-loop.
@@ -986,7 +1007,6 @@ static int cell_global_start_ppu(struct=20
 	return 0;
 }
=20
=2D
 static int cell_global_start(struct op_counter_config *ctr)
 {
 	if (spu_cycle_reset) {
@@ -996,14 +1016,15 @@ static int cell_global_start(struct op_c
 	}
 }
=20
=2Dstatic void cell_global_stop_spu(void)
=2D/* Note the generic OProfile stop calls do not support returning
+/*
+ * Note the generic OProfile stop calls do not support returning
  * an error on stop.  Hence, will not return an error if the FW
  * calls fail on stop.	Failure to reset the debug bus is not an issue.
  * Failure to disable the SPU profiling is not an issue.  The FW calls
  * to enable the performance counters and debug bus will work even if
  * the hardware was not cleanly reset.
  */
+static void cell_global_stop_spu(void)
 {
 	int subfunc, rtn_value;
 	unsigned int lfsr_value;
@@ -1020,7 +1041,8 @@ static void cell_global_stop_spu(void)
 		if (cbe_get_hw_thread_id(cpu))
 			continue;
=20
=2D		subfunc =3D 3;	/* 2 - activate SPU tracing,
+		subfunc =3D 3;	/*
+				 * 2 - activate SPU tracing,
 				 * 3 - deactivate
 				 */
 		lfsr_value =3D 0x8f100000;
@@ -1046,7 +1068,8 @@ static void cell_global_stop_ppu(void)
 {
 	int cpu;
=20
=2D	/* This routine will be called once for the system.
+	/*
+	 * This routine will be called once for the system.
 	 * There is one performance monitor per node, so we
 	 * only need to perform this function once per node.
 	 */
@@ -1079,8 +1102,8 @@ static void cell_global_stop(void)
 	}
 }
=20
=2Dstatic void
=2Dcell_handle_interrupt(struct pt_regs *regs, struct op_counter_config *ct=
r)
+static void cell_handle_interrupt(struct pt_regs *regs,
+				struct op_counter_config *ctr)
 {
 	u32 cpu;
 	u64 pc;
@@ -1091,13 +1114,15 @@ cell_handle_interrupt(struct pt_regs *re
=20
 	cpu =3D smp_processor_id();
=20
=2D	/* Need to make sure the interrupt handler and the virt counter
+	/*
+	 * Need to make sure the interrupt handler and the virt counter
 	 * routine are not running at the same time. See the
 	 * cell_virtual_cntr() routine for additional comments.
 	 */
 	spin_lock_irqsave(&virt_cntr_lock, flags);
=20
=2D	/* Need to disable and reenable the performance counters
+	/*
+	 * Need to disable and reenable the performance counters
 	 * to get the desired behavior from the hardware.  This
 	 * is hardware specific.
 	 */
@@ -1106,7 +1131,8 @@ cell_handle_interrupt(struct pt_regs *re
=20
 	interrupt_mask =3D cbe_get_and_clear_pm_interrupts(cpu);
=20
=2D	/* If the interrupt mask has been cleared, then the virt cntr
+	/*
+	 * If the interrupt mask has been cleared, then the virt cntr
 	 * has cleared the interrupt.  When the thread that generated
 	 * the interrupt is restored, the data count will be restored to
 	 * 0xffffff0 to cause the interrupt to be regenerated.
@@ -1124,7 +1150,8 @@ cell_handle_interrupt(struct pt_regs *re
 			}
 		}
=20
=2D		/* The counters were frozen by the interrupt.
+		/*
+		 * The counters were frozen by the interrupt.
 		 * Reenable the interrupt and restart the counters.
 		 * If there was a race between the interrupt handler and
 		 * the virtual counter routine.	 The virutal counter
@@ -1134,7 +1161,8 @@ cell_handle_interrupt(struct pt_regs *re
 		cbe_enable_pm_interrupts(cpu, hdw_thread,
 					 virt_cntr_inter_mask);
=20
=2D		/* The writes to the various performance counters only writes
+		/*
+		 * The writes to the various performance counters only writes
 		 * to a latch.	The new values (interrupt setting bits, reset
 		 * counter value etc.) are not copied to the actual registers
 		 * until the performance monitor is enabled.  In order to get
@@ -1147,7 +1175,8 @@ cell_handle_interrupt(struct pt_regs *re
 	spin_unlock_irqrestore(&virt_cntr_lock, flags);
 }
=20
=2D/* This function is called from the generic OProfile
+/*
+ * This function is called from the generic OProfile
  * driver.  When profiling PPUs, we need to do the
  * generic sync start; otherwise, do spu_sync_start.
  */
@@ -1167,7 +1196,6 @@ static int cell_sync_stop(void)
 		return 1;
 }
=20
=2D
 struct op_powerpc_model op_model_cell =3D {
 	.reg_setup =3D cell_reg_setup,
 	.cpu_setup =3D cell_cpu_setup,
