Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hBBM4w7NzF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 23:40:11 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id f6-v6so1055291plo.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 06:40:11 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: powerpc-utils-devel@googlegroups.com
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc64_cpu: utilize cpu/present info to cope with dynamic sysfs
Date: Thu,  2 Aug 2018 21:39:52 +0800
Message-Id: <1533217192-11280-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, ppc64_cpu takes the assumption of statically contiguous cpu
ids, i.e from 0 to threads_in_system. This does not face problem, since
the kernel code ensures the continuity. But due to kexec-tools needs the
CPU_ADD/_REMOVE udev event message, instead of CPU_ONLINE/_OFFLINE, the
kernel will resort to register_cpu/unregister_cpu API to acheive this.
Now, unplugging a core will make a hole in cpu_present_mask, which breaks
the continuity. To address this, this patch utilizes the cpu/present to
build a bitmap, and iterate over bitmap to cope with discontinuity.
By this way, ppc64_cpu can work with old/new kernel.

Notes about the kexec-tools issue: (tested with Fedora28)
Some user space tools such as kexec-tools resorts to the event add/remove
to automatically rebuild dtb. If the dtb is not rebuilt correctly, we
may hang on 2nd kernel due to lack the info of boot-cpu-hwid in dtb.

The steps to trigger the bug: (suppose 8 threads/core)
    drmgr -c cpu -r -q 1
    systemctl restart kdump.service
    drmgr -c cpu -a -q 1
    taskset -c 11 sh -c "echo c > /proc/sysrq-trigger"

Then, failure info:
    [  205.299528] SysRq : Trigger a crash
    [  205.299551] Unable to handle kernel paging request for data at address 0x00000000
    [  205.299558] Faulting instruction address: 0xc0000000006001a0
    [  205.299564] Oops: Kernel access of bad area, sig: 11 [#1]
    [  205.299569] SMP NR_CPUS=2048 NUMA pSeries
    [-- cut --]
    [  205.301829] Sending IPI to other CPUs
    [  205.302846] IPI complete
    I'm in purgatory
          -- > hang up here

Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 src/ppc64_cpu.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 176 insertions(+), 29 deletions(-)

diff --git a/src/ppc64_cpu.c b/src/ppc64_cpu.c
index 34654b4..cd5997d 100644
--- a/src/ppc64_cpu.c
+++ b/src/ppc64_cpu.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <dirent.h>
+#include <malloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -49,7 +50,8 @@
 
 #define PPC64_CPU_VERSION	"1.2"
 
-#define SYSFS_CPUDIR	"/sys/devices/system/cpu/cpu%d"
+#define SYSFS_CPUDIR "/sys/devices/system/cpu"
+#define SYSFS_PERCPUDIR	"/sys/devices/system/cpu/cpu%d"
 #define SYSFS_SUBCORES	"/sys/devices/system/cpu/subcores_per_core"
 #define DSCR_DEFAULT_PATH "/sys/devices/system/cpu/dscr_default"
 #define INTSERV_PATH	"/proc/device-tree/cpus/%s/ibm,ppc-interrupt-server#s"
@@ -75,17 +77,161 @@ struct cpu_freq {
 
 static int threads_per_cpu = 0;
 static int cpus_in_system = 0;
-static int threads_in_system = 0;
 
 static int do_info(void);
 
+/* 64 bits system */
+#define BITS_PER_LONG	64
+#define BIT_MASK(nr)	(1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)	((nr) / BITS_PER_LONG)
+
+static unsigned long *cpu_present_mask;
+static unsigned int max_cpu_id = (unsigned int)-1;
+
+/* @n: the position prior to the place to search */
+static unsigned int cpumask_next(int nr, unsigned long *addr)
+{
+	unsigned int bit_num, i, j;
+	unsigned long *p;
+
+	p = addr + BIT_WORD(nr);
+	for (i = nr+1; i < max_cpu_id; ) {
+		for (j = i % BITS_PER_LONG; j < BITS_PER_LONG; j++) {
+			if ((*p >> j) & 0x1) {
+				bit_num = BIT_WORD(i)*BITS_PER_LONG + j;
+				return bit_num;
+			}
+		}
+		p++;
+		i = ((i >> 6) + 1) << 6;
+	}
+	return -1;
+}
+
+#define for_each_cpu(cpu, mask)				\
+	for ((cpu) = -1;				\
+		(cpu) = cpumask_next((cpu), (mask)),	\
+		(cpu) < max_cpu_id;)
+
+static inline int test_bit(int nr, const unsigned long *addr)
+{
+	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+}
+
+static inline void set_bit(int nr, const unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+
+	*p  |= mask;
+}
+
+static void set_bitmap(int start, int end, const unsigned long *addr)
+{
+	int i;
+
+	for ( i = start; i <= end; i++)
+		set_bit(i, addr);
+}
+
+/* @n: the place prior to search */
+static unsigned int cpumask_next_hthread(int nr, const unsigned long *mask)
+{
+	int i, start;
+
+	start = (nr/threads_per_cpu +1)*threads_per_cpu;
+	for (i = start; i < max_cpu_id; i += threads_per_cpu) {
+		if (test_bit(i, mask))
+			return i;
+	}
+	return -1;
+}
+
+/* @bitmap: allocated internally
+ * max_idx: the max cpu logical id
+ * return the num of bits in bitmap
+ */
+static int parse_cpu_mask(char *buf, int bz, unsigned long **bitmap,
+	unsigned int *max_idx)
+{
+	int a, b, i, bm_sz;
+	bool range = false;
+	char *s, *p;
+#define TMP_BUF_SIZE 32
+	char tbuf[TMP_BUF_SIZE];
+
+	a = b = i = 0;
+	/* get the max id in order to alloc bitmap */
+
+	for (s = p = buf + bz; s >= buf; s--) {
+		if (*s == '-' ||*s == ',') {
+			break;
+		}
+	}
+	memset(tbuf, '\0', TMP_BUF_SIZE);
+	memcpy(tbuf, s+1, p-s-1);
+	sscanf(tbuf, "%d", &b);
+	if (max_idx)
+		*max_idx = b;
+	/* in worst case waste 7 bytes */
+	bm_sz = (b + BITS_PER_LONG-1)/8;
+	*bitmap = memalign(sizeof(unsigned long), bm_sz);
+	memset(*bitmap, 0, bm_sz);
+
+	/* set the bitmap */
+
+	range = false;
+	for (s = p = buf; p - buf < bz; p++) {
+		if (*p == '-')
+			range = true;
+		if (*p == ',' || *p == '\n') {
+			memset(tbuf, '\0', TMP_BUF_SIZE);
+			memcpy(tbuf, s, p-s);
+			if (range) {
+				sscanf(tbuf, "%d-%d", &a, &b);
+				set_bitmap(a, b, *bitmap);
+				i += (b -a) +1;
+			} else {
+				sscanf(tbuf, "%d", &a);
+				set_bitmap(a, a, *bitmap);
+				i++;
+			}
+			range = false;
+			if (*p == ',' )
+				s = p + 1;
+			else
+				break;
+		}
+	}
+	return i;
+}
+
+static int get_cpu_present_mask(void)
+{
+	char path[SYSFS_PATH_MAX];
+	char buf[256] = {0};
+	int fd, sz, ret = 0;
+
+	sprintf(path, SYSFS_CPUDIR"/%s", "present");
+	fd = open(path, O_RDONLY);
+	sz = read(fd, buf, 256);
+	close(fd);
+	if (sz > 0)
+		parse_cpu_mask(buf, sz, &cpu_present_mask, &max_cpu_id);
+	else {
+		ret = -1;
+		printf("can not parse %s\n", path);
+	}
+	return ret;
+}
+
 static int test_sysattr(char *attribute, int perms)
 {
 	char path[SYSFS_PATH_MAX];
 	int i;
 
-	for (i = 0; i < threads_in_system; i++) {
-		sprintf(path, SYSFS_CPUDIR"/%s", i, attribute);
+	for_each_cpu(i, cpu_present_mask) {
+		sprintf(path, SYSFS_PERCPUDIR"/%s", i, attribute);
 		if (access(path, F_OK))
 			continue;
 
@@ -160,7 +306,7 @@ static int cpu_online(int thread)
 	char path[SYSFS_PATH_MAX];
 	int rc, online;
 
-	sprintf(path, SYSFS_CPUDIR"/online", thread);
+	sprintf(path, SYSFS_PERCPUDIR"/online", thread);
 	rc = get_attribute(path, "%d", &online);
 
 	/* This attribute does not exist in kernels without hotplug enabled */
@@ -180,13 +326,13 @@ static int get_system_attribute(char *attribute, const char *fmt, int *value,
 	int i, rc;
 	int system_attribute = -1;
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		int cpu_attribute;
 
 		if (!cpu_online(i))
 			continue;
 
-		sprintf(path, SYSFS_CPUDIR"/%s", i, attribute);
+		sprintf(path, SYSFS_PERCPUDIR"/%s", i, attribute);
 		rc = get_attribute(path, fmt, &cpu_attribute);
 		if (rc)
 			return rc;
@@ -208,8 +354,8 @@ static int set_system_attribute(char *attribute, const char *fmt, int state)
 	char path[SYSFS_PATH_MAX];
 	int i, rc;
 
-	for (i = 0; i < threads_in_system; i++) {
-		sprintf(path, SYSFS_CPUDIR"/%s", i, attribute);
+	for_each_cpu(i, cpu_present_mask) {
+		sprintf(path, SYSFS_PERCPUDIR"/%s", i, attribute);
 		rc = set_attribute(path, fmt, state);
 		/* When a CPU is offline some sysfs files are removed from the CPU
 		 * directory, for example smt_snooze_delay and dscr. The absence of the
@@ -360,14 +506,13 @@ static int get_cpu_info(void)
 	}
 
 	closedir(d);
-	threads_in_system = cpus_in_system * threads_per_cpu;
 
 	subcores = num_subcores();
 	if (is_subcore_capable() && subcores > 0) {
 		threads_per_cpu /= subcores;
 		cpus_in_system *= subcores;
 	}
-	return 0;
+	return get_cpu_present_mask();
 }
 
 static int is_smt_capable(void)
@@ -376,8 +521,8 @@ static int is_smt_capable(void)
 	char path[SYSFS_PATH_MAX];
 	int i;
 
-	for (i = 0; i < threads_in_system; i++) {
-		sprintf(path, SYSFS_CPUDIR"/smt_snooze_delay", i);
+	for_each_cpu(i, cpu_present_mask) {
+		sprintf(path, SYSFS_PERCPUDIR"/smt_snooze_delay", i);
 		if (stat(path, &sb))
 			continue;
 		return 1;
@@ -431,7 +576,7 @@ static int set_one_smt_state(int thread, int online_threads)
 	int i, rc = 0;
 
 	for (i = 0; i < threads_per_cpu; i++) {
-		snprintf(path, SYSFS_PATH_MAX, SYSFS_CPUDIR"/%s", thread + i,
+		snprintf(path, SYSFS_PATH_MAX, SYSFS_PERCPUDIR"/%s", thread + i,
 			 "online");
 		if (i < online_threads)
 			rc = online_thread(path);
@@ -452,7 +597,8 @@ static int set_one_smt_state(int thread, int online_threads)
 
 static int set_smt_state(int smt_state)
 {
-	int i, j, rc;
+	unsigned int i;
+	int j, rc;
 	int ssd, update_ssd = 1;
 	int inconsistent = 0;
 	int error = 0;
@@ -465,8 +611,9 @@ static int set_smt_state(int smt_state)
 	rc = get_smt_snooze_delay(&ssd, &inconsistent);
 	if (rc)
 		update_ssd = 0;
+	if (smt_state )
 
-	for (i = 0; i < threads_in_system; i += threads_per_cpu) {
+	for (i = 0; i < max_cpu_id; ) {
 		/* Online means any thread on this core running, so check all
 		 * threads in the core, not just the first. */
 		for (j = 0; j < threads_per_cpu; j++) {
@@ -481,6 +628,7 @@ static int set_smt_state(int smt_state)
 				error = 1;
 			break;
 		}
+		i = cpumask_next_hthread(i, cpu_present_mask);
 	}
 
 	if (update_ssd)
@@ -501,9 +649,8 @@ static int is_dscr_capable(void)
 
 	if (dscr_default_exists())
 		return 1;
-
-	for (i = 0; i < threads_in_system; i++) {
-		sprintf(path, SYSFS_CPUDIR"/dscr", i);
+	for_each_cpu(i, cpu_present_mask) {
+		sprintf(path, SYSFS_PERCPUDIR"/dscr", i);
 		if (stat(path, &sb))
 			continue;
 		return 1;
@@ -863,7 +1010,7 @@ static int setup_counters(struct cpu_freq *cpu_freqs)
 	/* Record how long the event ran for */
 	attr.read_format |= PERF_FORMAT_TOTAL_TIME_RUNNING;
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		if (!cpu_online(i)) {
 			cpu_freqs[i].offline = 1;
 			continue;
@@ -890,7 +1037,7 @@ static void start_counters(struct cpu_freq *cpu_freqs)
 {
 	int i;
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		if (cpu_freqs[i].offline)
 			continue;
 
@@ -902,7 +1049,7 @@ static void stop_counters(struct cpu_freq *cpu_freqs)
 {
 	int i;
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		if (cpu_freqs[i].offline)
 			continue;
 
@@ -920,7 +1067,7 @@ static void read_counters(struct cpu_freq *cpu_freqs)
 	int i;
 	struct read_format vals;
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		size_t res;
 
 		if (cpu_freqs[i].offline)
@@ -945,7 +1092,7 @@ static void check_threads(struct cpu_freq *cpu_freqs)
 {
 	int i;
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		if (cpu_freqs[i].offline)
 			continue;
 
@@ -1051,7 +1198,7 @@ static void report_system_power_mode(void)
 static void setrlimit_open_files(void)
 {
 	struct rlimit old_rlim, new_rlim;
-	int new = threads_in_system + 8;
+	int new = max_cpu_id + 8;
 
 	getrlimit(RLIMIT_NOFILE, &old_rlim);
 
@@ -1077,7 +1224,7 @@ static int do_cpu_frequency(int sleep_time)
 
 	setrlimit_open_files();
 
-	cpu_freqs = calloc(threads_in_system, sizeof(*cpu_freqs));
+	cpu_freqs = calloc(max_cpu_id, sizeof(*cpu_freqs));
 	if (!cpu_freqs)
 		return -ENOMEM;
 
@@ -1088,7 +1235,7 @@ static int do_cpu_frequency(int sleep_time)
 	}
 
 	/* Start a soak thread on each CPU */
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		if (cpu_freqs[i].offline)
 			continue;
 
@@ -1111,7 +1258,7 @@ static int do_cpu_frequency(int sleep_time)
 	check_threads(cpu_freqs);
 	read_counters(cpu_freqs);
 
-	for (i = 0; i < threads_in_system; i++) {
+	for_each_cpu(i, cpu_present_mask) {
 		double frequency;
 
 		if (cpu_freqs[i].offline)
@@ -1163,7 +1310,7 @@ static int set_all_threads_off(int cpu, int smt_state)
 	int rc = 0;
 
 	for (i = cpu + smt_state - 1; i >= cpu; i--) {
-		snprintf(path, SYSFS_PATH_MAX, SYSFS_CPUDIR"/%s", i, "online");
+		snprintf(path, SYSFS_PATH_MAX, SYSFS_PERCPUDIR"/%s", i, "online");
 		rc = offline_thread(path);
 		if (rc == -1)
 			printf("Unable to take cpu%d offline", i);
-- 
2.7.4
