Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id F02C0DDF0F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 20:37:19 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH,
	RESEND] powerpc/cell/oprofile: fix mutex locking for spu-oprofile
Date: Wed, 15 Oct 2008 11:37:01 +0200
References: <1224033396.8157.386.camel@pasglop>
	<20081015083516.GL23557@erda.amd.com>
	<200810151041.29069.arnd@arndb.de>
In-Reply-To: <200810151041.29069.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810151137.02518.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom aa5810fa545515c9f383e3e649bd120bef9c7f29 Mon Sep 17 00:00:00 2001
=46rom: Carl Love <cel@us.ibm.com>
Date: Fri, 8 Aug 2008 15:38:36 -0700
Subject: [PATCH] powerpc/cell/oprofile: fix mutex locking for spu-oprofile

The issue is the SPU code is not holding the kernel mutex lock while
adding samples to the kernel buffer.

This patch creates per SPU buffers to hold the data.  Data
is added to the buffers from in interrupt context.  The data
is periodically pushed to the kernel buffer via a new Oprofile
function oprofile_put_buff(). The oprofile_put_buff() function
is called via a work queue enabling the funtion to acquire the
mutex lock.

The existing user controls for adjusting the per CPU buffer
size is used to control the size of the per SPU buffers.
Similarly, overflows of the SPU buffers are reported by
incrementing the per CPU buffer stats.  This eliminates the
need to have architecture specific controls for the per SPU
buffers which is not acceptable to the OProfile user tool
maintainer.

The export of the oprofile add_event_entry() is removed as it
is no longer needed given this patch.

Note, this patch has not addressed the issue of indexing arrays
by the spu number.  This still needs to be fixed as the spu
numbering is not guarenteed to be 0 to max_num_spus-1.

Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Acked-by: Robert Richter <robert.richter@amd.com>
=2D--
 arch/powerpc/oprofile/cell/pr_util.h       |   13 ++
 arch/powerpc/oprofile/cell/spu_profiler.c  |    4 +-
 arch/powerpc/oprofile/cell/spu_task_sync.c |  236 ++++++++++++++++++++++++=
+---
 drivers/oprofile/buffer_sync.c             |   24 +++
 drivers/oprofile/cpu_buffer.c              |   15 ++-
 drivers/oprofile/event_buffer.h            |    7 +
 include/linux/oprofile.h                   |   16 +-
 7 files changed, 279 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/oprofile/cell/pr_util.h b/arch/powerpc/oprofile/c=
ell/pr_util.h
index 22e4e8d..628009c 100644
=2D-- a/arch/powerpc/oprofile/cell/pr_util.h
+++ b/arch/powerpc/oprofile/cell/pr_util.h
@@ -24,6 +24,11 @@
 #define SKIP_GENERIC_SYNC 0
 #define SYNC_START_ERROR -1
 #define DO_GENERIC_SYNC 1
+#define SPUS_PER_NODE   8
+#define DEFAULT_TIMER_EXPIRE  (HZ / 10)
+
+extern struct delayed_work spu_work;
+extern int spu_prof_running;
=20
 struct spu_overlay_info {	/* map of sections within an SPU overlay */
 	unsigned int vma;	/* SPU virtual memory address from elf */
@@ -62,6 +67,14 @@ struct vma_to_fileoffset_map {	/* map of sections within=
 an SPU program */
=20
 };
=20
+struct spu_buffer {
+	int last_guard_val;
+	int ctx_sw_seen;
+	unsigned long *buff;
+	unsigned int head, tail;
+};
+
+
 /* The three functions below are for maintaining and accessing
  * the vma-to-fileoffset map.
  */
diff --git a/arch/powerpc/oprofile/cell/spu_profiler.c b/arch/powerpc/oprof=
ile/cell/spu_profiler.c
index 380d7e2..6edaebd 100644
=2D-- a/arch/powerpc/oprofile/cell/spu_profiler.c
+++ b/arch/powerpc/oprofile/cell/spu_profiler.c
@@ -23,12 +23,11 @@
=20
 static u32 *samples;
=20
=2Dstatic int spu_prof_running;
+int spu_prof_running;
 static unsigned int profiling_interval;
=20
 #define NUM_SPU_BITS_TRBUF 16
 #define SPUS_PER_TB_ENTRY   4
=2D#define SPUS_PER_NODE	     8
=20
 #define SPU_PC_MASK	     0xFFFF
=20
@@ -208,6 +207,7 @@ int start_spu_profiling(unsigned int cycles_reset)
=20
 	spu_prof_running =3D 1;
 	hrtimer_start(&timer, kt, HRTIMER_MODE_REL);
+	schedule_delayed_work(&spu_work, DEFAULT_TIMER_EXPIRE);
=20
 	return 0;
 }
diff --git a/arch/powerpc/oprofile/cell/spu_task_sync.c b/arch/powerpc/opro=
file/cell/spu_task_sync.c
index 2a9b4a0..2949126 100644
=2D-- a/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ b/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -35,7 +35,102 @@ static DEFINE_SPINLOCK(buffer_lock);
 static DEFINE_SPINLOCK(cache_lock);
 static int num_spu_nodes;
 int spu_prof_num_nodes;
=2Dint last_guard_val[MAX_NUMNODES * 8];
+
+struct spu_buffer spu_buff[MAX_NUMNODES * SPUS_PER_NODE];
+struct delayed_work spu_work;
+static unsigned max_spu_buff;
+
+static void spu_buff_add(unsigned long int value, int spu)
+{
+	/* spu buff is a circular buffer.  Add entries to the
+	 * head.  Head is the index to store the next value.
+	 * The buffer is full when there is one available entry
+	 * in the queue, i.e. head and tail can't be equal.
+	 * That way we can tell the difference between the
+	 * buffer being full versus empty.
+	 *
+	 *  ASSUPTION: the buffer_lock is held when this function
+	 *             is called to lock the buffer, head and tail.
+	 */
+	int full =3D 1;
+
+	if (spu_buff[spu].head >=3D spu_buff[spu].tail) {
+		if ((spu_buff[spu].head - spu_buff[spu].tail)
+		    <  (max_spu_buff - 1))
+			full =3D 0;
+
+	} else if (spu_buff[spu].tail > spu_buff[spu].head) {
+		if ((spu_buff[spu].tail - spu_buff[spu].head)
+		    > 1)
+			full =3D 0;
+	}
+
+	if (!full) {
+		spu_buff[spu].buff[spu_buff[spu].head] =3D value;
+		spu_buff[spu].head++;
+
+		if (spu_buff[spu].head >=3D max_spu_buff)
+			spu_buff[spu].head =3D 0;
+	} else {
+		/* From the user's perspective make the SPU buffer
+		 * size management/overflow look like we are using
+		 * per cpu buffers.  The user uses the same
+		 * per cpu parameter to adjust the SPU buffer size.
+		 * Increment the sample_lost_overflow to inform
+		 * the user the buffer size needs to be increased.
+		 */
+		oprofile_cpu_buffer_inc_smpl_lost();
+	}
+}
+
+/* This function copies the per SPU buffers to the
+ * OProfile kernel buffer.
+ */
+void sync_spu_buff(void)
+{
+	int spu;
+	unsigned long flags;
+	int curr_head;
+
+	for (spu =3D 0; spu < num_spu_nodes; spu++) {
+		/* In case there was an issue and the buffer didn't
+		 * get created skip it.
+		 */
+		if (spu_buff[spu].buff =3D=3D NULL)
+			continue;
+
+		/* Hold the lock to make sure the head/tail
+		 * doesn't change while spu_buff_add() is
+		 * deciding if the buffer is full or not.
+		 * Being a little paranoid.
+		 */
+		spin_lock_irqsave(&buffer_lock, flags);
+		curr_head =3D spu_buff[spu].head;
+		spin_unlock_irqrestore(&buffer_lock, flags);
+
+		/* Transfer the current contents to the kernel buffer.
+		 * data can still be added to the head of the buffer.
+		 */
+		oprofile_put_buff(spu_buff[spu].buff,
+				  spu_buff[spu].tail,
+				  curr_head, max_spu_buff);
+
+		spin_lock_irqsave(&buffer_lock, flags);
+		spu_buff[spu].tail =3D curr_head;
+		spin_unlock_irqrestore(&buffer_lock, flags);
+	}
+
+}
+
+static void wq_sync_spu_buff(struct work_struct *work)
+{
+	/* move data from spu buffers to kernel buffer */
+	sync_spu_buff();
+
+	/* only reschedule if profiling is not done */
+	if (spu_prof_running)
+		schedule_delayed_work(&spu_work, DEFAULT_TIMER_EXPIRE);
+}
=20
 /* Container for caching information about an active SPU task. */
 struct cached_info {
@@ -305,14 +400,21 @@ static int process_context_switch(struct spu *spu, un=
signed long objectId)
=20
 	/* Record context info in event buffer */
 	spin_lock_irqsave(&buffer_lock, flags);
=2D	add_event_entry(ESCAPE_CODE);
=2D	add_event_entry(SPU_CTX_SWITCH_CODE);
=2D	add_event_entry(spu->number);
=2D	add_event_entry(spu->pid);
=2D	add_event_entry(spu->tgid);
=2D	add_event_entry(app_dcookie);
=2D	add_event_entry(spu_cookie);
=2D	add_event_entry(offset);
+	spu_buff_add(ESCAPE_CODE, spu->number);
+	spu_buff_add(SPU_CTX_SWITCH_CODE, spu->number);
+	spu_buff_add(spu->number, spu->number);
+	spu_buff_add(spu->pid, spu->number);
+	spu_buff_add(spu->tgid, spu->number);
+	spu_buff_add(app_dcookie, spu->number);
+	spu_buff_add(spu_cookie, spu->number);
+	spu_buff_add(offset, spu->number);
+
+	/* Set flag to indicate SPU PC data can now be written out.  If
+	 * the SPU program counter data is seen before an SPU context
+	 * record is seen, the postprocessing will fail.
+	 */
+	spu_buff[spu->number].ctx_sw_seen =3D 1;
+
 	spin_unlock_irqrestore(&buffer_lock, flags);
 	smp_wmb();	/* insure spu event buffer updates are written */
 			/* don't want entries intermingled... */
@@ -360,6 +462,47 @@ static int number_of_online_nodes(void)
         return nodes;
 }
=20
+static int oprofile_spu_buff_create(void)
+{
+	int spu;
+
+	max_spu_buff =3D oprofile_get_cpu_buffer_size();
+
+	for (spu =3D 0; spu < num_spu_nodes; spu++) {
+		/* create circular buffers to store the data in.
+		 * use locks to manage accessing the buffers
+		 */
+		spu_buff[spu].head =3D 0;
+		spu_buff[spu].tail =3D 0;
+
+		/*
+		 * Create a buffer for each SPU.  Can't reliably
+		 * create a single buffer for all spus due to not
+		 * enough contiguous kernel memory.
+		 */
+
+		spu_buff[spu].buff =3D kzalloc((max_spu_buff
+					      * sizeof(unsigned long)),
+					     GFP_KERNEL);
+
+		if (!spu_buff[spu].buff) {
+			printk(KERN_ERR "SPU_PROF: "
+			       "%s, line %d:  oprofile_spu_buff_create "
+		       "failed to allocate spu buffer %d.\n",
+			       __func__, __LINE__, spu);
+
+			/* release the spu buffers that have been allocated */
+			while (spu >=3D 0) {
+				kfree(spu_buff[spu].buff);
+				spu_buff[spu].buff =3D 0;
+				spu--;
+			}
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
 /* The main purpose of this function is to synchronize
  * OProfile with SPUFS by registering to be notified of
  * SPU task switches.
@@ -372,20 +515,35 @@ static int number_of_online_nodes(void)
  */
 int spu_sync_start(void)
 {
=2D	int k;
+	int spu;
 	int ret =3D SKIP_GENERIC_SYNC;
 	int register_ret;
 	unsigned long flags =3D 0;
=20
 	spu_prof_num_nodes =3D number_of_online_nodes();
 	num_spu_nodes =3D spu_prof_num_nodes * 8;
+	INIT_DELAYED_WORK(&spu_work, wq_sync_spu_buff);
+
+	/* create buffer for storing the SPU data to put in
+	 * the kernel buffer.
+	 */
+	ret =3D oprofile_spu_buff_create();
+	if (ret)
+		goto out;
=20
 	spin_lock_irqsave(&buffer_lock, flags);
=2D	add_event_entry(ESCAPE_CODE);
=2D	add_event_entry(SPU_PROFILING_CODE);
=2D	add_event_entry(num_spu_nodes);
+	for (spu =3D 0; spu < num_spu_nodes; spu++) {
+		spu_buff_add(ESCAPE_CODE, spu);
+		spu_buff_add(SPU_PROFILING_CODE, spu);
+		spu_buff_add(num_spu_nodes, spu);
+	}
 	spin_unlock_irqrestore(&buffer_lock, flags);
=20
+	for (spu =3D 0; spu < num_spu_nodes; spu++) {
+		spu_buff[spu].ctx_sw_seen =3D 0;
+		spu_buff[spu].last_guard_val =3D 0;
+	}
+
 	/* Register for SPU events  */
 	register_ret =3D spu_switch_event_register(&spu_active);
 	if (register_ret) {
@@ -393,8 +551,6 @@ int spu_sync_start(void)
 		goto out;
 	}
=20
=2D	for (k =3D 0; k < (MAX_NUMNODES * 8); k++)
=2D		last_guard_val[k] =3D 0;
 	pr_debug("spu_sync_start -- running.\n");
 out:
 	return ret;
@@ -446,13 +602,20 @@ void spu_sync_buffer(int spu_num, unsigned int *sampl=
es,
 		 * use.	 We need to discard samples taken during the time
 		 * period which an overlay occurs (i.e., guard value changes).
 		 */
=2D		if (grd_val && grd_val !=3D last_guard_val[spu_num]) {
=2D			last_guard_val[spu_num] =3D grd_val;
+		if (grd_val && grd_val !=3D spu_buff[spu_num].last_guard_val) {
+			spu_buff[spu_num].last_guard_val =3D grd_val;
 			/* Drop the rest of the samples. */
 			break;
 		}
=20
=2D		add_event_entry(file_offset | spu_num_shifted);
+		/* We must ensure that the SPU context switch has been written
+		 * out before samples for the SPU.  Otherwise, the SPU context
+		 * information is not available and the postprocessing of the
+		 * SPU PC will fail with no available anonymous map information.
+		 */
+		if (spu_buff[spu_num].ctx_sw_seen)
+			spu_buff_add((file_offset | spu_num_shifted),
+					 spu_num);
 	}
 	spin_unlock(&buffer_lock);
 out:
@@ -463,20 +626,41 @@ out:
 int spu_sync_stop(void)
 {
 	unsigned long flags =3D 0;
=2D	int ret =3D spu_switch_event_unregister(&spu_active);
=2D	if (ret) {
+	int ret;
+	int k;
+
+	ret =3D spu_switch_event_unregister(&spu_active);
+
+	if (ret)
 		printk(KERN_ERR "SPU_PROF: "
=2D			"%s, line %d: spu_switch_event_unregister returned %d\n",
=2D			__func__, __LINE__, ret);
=2D		goto out;
=2D	}
+		       "%s, line %d: spu_switch_event_unregister "	\
+		       "returned %d\n",
+		       __func__, __LINE__, ret);
+
+	/* flush any remaining data in the per SPU buffers */
+	sync_spu_buff();
=20
 	spin_lock_irqsave(&cache_lock, flags);
 	ret =3D release_cached_info(RELEASE_ALL);
 	spin_unlock_irqrestore(&cache_lock, flags);
=2Dout:
+
+	/* remove scheduled work queue item rather then waiting
+	 * for every queued entry to execute.  Then flush pending
+	 * system wide buffer to event buffer.
+	 */
+	cancel_delayed_work(&spu_work);
+
+	for (k =3D 0; k < num_spu_nodes; k++) {
+		spu_buff[k].ctx_sw_seen =3D 0;
+
+		/*
+		 * spu_sys_buff will be null if there was a problem
+		 * allocating the buffer.  Only delete if it exists.
+		 */
+		kfree(spu_buff[k].buff);
+		spu_buff[k].buff =3D 0;
+	}
 	pr_debug("spu_sync_stop -- done.\n");
 	return ret;
 }
=20
=2D
diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index 9304c45..4a70180 100644
=2D-- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -551,3 +551,27 @@ void sync_buffer(int cpu)
=20
 	mutex_unlock(&buffer_mutex);
 }
+
+/* The function can be used to add a buffer worth of data directly to
+ * the kernel buffer. The buffer is assumed to be a circular buffer.
+ * Take the entries from index start and end at index end, wrapping
+ * at max_entries.
+ */
+void oprofile_put_buff(unsigned long *buf, unsigned int start,
+		       unsigned int stop, unsigned int max)
+{
+	int i;
+
+	i =3D start;
+
+	mutex_lock(&buffer_mutex);
+	while (i !=3D stop) {
+		add_event_entry(buf[i++]);
+
+		if (i >=3D max)
+			i =3D 0;
+	}
+
+	mutex_unlock(&buffer_mutex);
+}
+
diff --git a/drivers/oprofile/cpu_buffer.c b/drivers/oprofile/cpu_buffer.c
index 7ba78e6..366b5d2 100644
=2D-- a/drivers/oprofile/cpu_buffer.c
+++ b/drivers/oprofile/cpu_buffer.c
@@ -37,13 +37,26 @@ static int work_enabled;
 void free_cpu_buffers(void)
 {
 	int i;
=2D=20
+
 	for_each_online_cpu(i) {
 		vfree(per_cpu(cpu_buffer, i).buffer);
 		per_cpu(cpu_buffer, i).buffer =3D NULL;
 	}
 }
=20
+unsigned long oprofile_get_cpu_buffer_size(void)
+{
+	return fs_cpu_buffer_size;
+}
+
+void oprofile_cpu_buffer_inc_smpl_lost(void)
+{
+	struct oprofile_cpu_buffer *cpu_buf
+		=3D &__get_cpu_var(cpu_buffer);
+
+	cpu_buf->sample_lost_overflow++;
+}
+
 int alloc_cpu_buffers(void)
 {
 	int i;
diff --git a/drivers/oprofile/event_buffer.h b/drivers/oprofile/event_buffe=
r.h
index 5076ed1..84bf324 100644
=2D-- a/drivers/oprofile/event_buffer.h
+++ b/drivers/oprofile/event_buffer.h
@@ -17,6 +17,13 @@ int alloc_event_buffer(void);
=20
 void free_event_buffer(void);
 =20
+/**
+ * Add data to the event buffer.
+ * The data passed is free-form, but typically consists of
+ * file offsets, dcookies, context information, and ESCAPE codes.
+ */
+void add_event_entry(unsigned long data);
+
 /* wake up the process sleeping on the event file */
 void wake_up_buffer_waiter(void);
=20
diff --git a/include/linux/oprofile.h b/include/linux/oprofile.h
index 041bb31..1ef7fce 100644
=2D-- a/include/linux/oprofile.h
+++ b/include/linux/oprofile.h
@@ -84,13 +84,6 @@ int oprofile_arch_init(struct oprofile_operations * ops);
 void oprofile_arch_exit(void);
=20
 /**
=2D * Add data to the event buffer.
=2D * The data passed is free-form, but typically consists of
=2D * file offsets, dcookies, context information, and ESCAPE codes.
=2D */
=2Dvoid add_event_entry(unsigned long data);
=2D
=2D/**
  * Add a sample. This may be called from any context. Pass
  * smp_processor_id() as cpu.
  */
@@ -160,5 +153,14 @@ int oprofilefs_ulong_from_user(unsigned long * val, ch=
ar const __user * buf, siz
=20
 /** lock for read/write safety */
 extern spinlock_t oprofilefs_lock;
+
+/**
+ * Add the contents of a circular buffer to the event buffer.
+ */
+void oprofile_put_buff(unsigned long *buf, unsigned int start,
+			unsigned int stop, unsigned int max);
+
+unsigned long oprofile_get_cpu_buffer_size(void);
+void oprofile_cpu_buffer_inc_smpl_lost(void);
 =20
 #endif /* OPROFILE_H */
=2D-=20
1.5.4.3
