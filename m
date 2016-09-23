Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgld94F8ZzDsrB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 06:41:17 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8NKWmH1062943
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:41:15 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb6hf9h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:41:15 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 24 Sep 2016 06:41:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AD2973578058
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 06:41:10 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8NKfA6k3670444
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 06:41:10 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8NKf9eB008785
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 06:41:10 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Alexei Starovoitov" <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Ananth N Mavinakayanahalli" <ananth@in.ibm.com>
Subject: [PATCH 2/2] bpf samples: update tracex5 sample to use __seccomp_filter
Date: Sat, 24 Sep 2016 02:10:05 +0530
In-Reply-To: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
References: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
References: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <8e5ab9853508240e901260b1af36243c4d744083.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

seccomp_phase1() does not exist anymore. Instead, update sample to use
__seccomp_filter(). While at it, set max locked memory to unlimited.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
I am not completely sure if __seccomp_filter is the right place to hook
in. This works for me though. Please review.

Thanks,
Naveen


 samples/bpf/tracex5_kern.c | 16 +++++++---------
 samples/bpf/tracex5_user.c |  3 +++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index f95f232..fd12d71 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -19,20 +19,18 @@ struct bpf_map_def SEC("maps") progs = {
 	.max_entries = 1024,
 };
 
-SEC("kprobe/seccomp_phase1")
+SEC("kprobe/__seccomp_filter")
 int bpf_prog1(struct pt_regs *ctx)
 {
-	struct seccomp_data sd;
-
-	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM1(ctx));
+	int sc_nr = (int)PT_REGS_PARM1(ctx);
 
 	/* dispatch into next BPF program depending on syscall number */
-	bpf_tail_call(ctx, &progs, sd.nr);
+	bpf_tail_call(ctx, &progs, sc_nr);
 
 	/* fall through -> unknown syscall */
-	if (sd.nr >= __NR_getuid && sd.nr <= __NR_getsid) {
+	if (sc_nr >= __NR_getuid && sc_nr <= __NR_getsid) {
 		char fmt[] = "syscall=%d (one of get/set uid/pid/gid)\n";
-		bpf_trace_printk(fmt, sizeof(fmt), sd.nr);
+		bpf_trace_printk(fmt, sizeof(fmt), sc_nr);
 	}
 	return 0;
 }
@@ -42,7 +40,7 @@ PROG(__NR_write)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
-	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM1(ctx));
+	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
 	if (sd.args[2] == 512) {
 		char fmt[] = "write(fd=%d, buf=%p, size=%d)\n";
 		bpf_trace_printk(fmt, sizeof(fmt),
@@ -55,7 +53,7 @@ PROG(__NR_read)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
-	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM1(ctx));
+	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
 	if (sd.args[2] > 128 && sd.args[2] <= 1024) {
 		char fmt[] = "read(fd=%d, buf=%p, size=%d)\n";
 		bpf_trace_printk(fmt, sizeof(fmt),
diff --git a/samples/bpf/tracex5_user.c b/samples/bpf/tracex5_user.c
index a04dd3c..36b5925 100644
--- a/samples/bpf/tracex5_user.c
+++ b/samples/bpf/tracex5_user.c
@@ -6,6 +6,7 @@
 #include <sys/prctl.h>
 #include "libbpf.h"
 #include "bpf_load.h"
+#include <sys/resource.h>
 
 /* install fake seccomp program to enable seccomp code path inside the kernel,
  * so that our kprobe attached to seccomp_phase1() can be triggered
@@ -27,8 +28,10 @@ int main(int ac, char **argv)
 {
 	FILE *f;
 	char filename[256];
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	setrlimit(RLIMIT_MEMLOCK, &r);
 
 	if (load_bpf_file(filename)) {
 		printf("%s", bpf_log_buf);
-- 
2.9.3
