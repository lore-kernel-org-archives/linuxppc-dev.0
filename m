Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbMgQ09V5zDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:30 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 21:27:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0F9D62CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2VBRHVI17236166
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2VBQrnK024880
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:26:53 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@fb.com>, "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4/4] samples/bpf: Enable powerpc support
Date: Thu, 31 Mar 2016 16:55:44 +0530
Message-Id: <28a3811d03f6e8f7dca989a4ade536bf9aa8c7ce.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the necessary definitions for building bpf samples on ppc.

Since ppc doesn't store function return address on the stack, modify how
PT_REGS_RET() and PT_REGS_FP() work.

Also, introduce PT_REGS_IP() to access the instruction pointer. I have
fixed this to work with x86_64 and arm64, but not s390.

Cc: Alexei Starovoitov <ast@fb.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 samples/bpf/bpf_helpers.h   | 26 ++++++++++++++++++++++++++
 samples/bpf/spintest_kern.c |  2 +-
 samples/bpf/tracex2_kern.c  |  4 ++--
 samples/bpf/tracex4_kern.c  |  2 +-
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/bpf_helpers.h b/samples/bpf/bpf_helpers.h
index 9363500..343423c 100644
--- a/samples/bpf/bpf_helpers.h
+++ b/samples/bpf/bpf_helpers.h
@@ -82,6 +82,7 @@ static int (*bpf_l4_csum_replace)(void *ctx, int off, int from, int to, int flag
 #define PT_REGS_FP(x) ((x)->bp)
 #define PT_REGS_RC(x) ((x)->ax)
 #define PT_REGS_SP(x) ((x)->sp)
+#define PT_REGS_IP(x) ((x)->ip)
 
 #elif defined(__s390x__)
 
@@ -94,6 +95,7 @@ static int (*bpf_l4_csum_replace)(void *ctx, int off, int from, int to, int flag
 #define PT_REGS_FP(x) ((x)->gprs[11]) /* Works only with CONFIG_FRAME_POINTER */
 #define PT_REGS_RC(x) ((x)->gprs[2])
 #define PT_REGS_SP(x) ((x)->gprs[15])
+#define PT_REGS_IP(x) ((x)->ip)
 
 #elif defined(__aarch64__)
 
@@ -106,6 +108,30 @@ static int (*bpf_l4_csum_replace)(void *ctx, int off, int from, int to, int flag
 #define PT_REGS_FP(x) ((x)->regs[29]) /* Works only with CONFIG_FRAME_POINTER */
 #define PT_REGS_RC(x) ((x)->regs[0])
 #define PT_REGS_SP(x) ((x)->sp)
+#define PT_REGS_IP(x) ((x)->pc)
+
+#elif defined(__powerpc__)
+
+#define PT_REGS_PARM1(x) ((x)->gpr[3])
+#define PT_REGS_PARM2(x) ((x)->gpr[4])
+#define PT_REGS_PARM3(x) ((x)->gpr[5])
+#define PT_REGS_PARM4(x) ((x)->gpr[6])
+#define PT_REGS_PARM5(x) ((x)->gpr[7])
+#define PT_REGS_RC(x) ((x)->gpr[3])
+#define PT_REGS_SP(x) ((x)->sp)
+#define PT_REGS_IP(x) ((x)->nip)
 
 #endif
+
+#ifdef __powerpc__
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)		{ (ip) = (ctx)->link; }
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)	BPF_KPROBE_READ_RET_IP(ip, ctx)
+#else
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)						\
+		bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx))
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)					\
+		bpf_probe_read(&(ip), sizeof(ip),				\
+				(void *)(PT_REGS_FP(ctx) + sizeof(ip)))
+#endif
+
 #endif
diff --git a/samples/bpf/spintest_kern.c b/samples/bpf/spintest_kern.c
index 4b27619..ce0167d 100644
--- a/samples/bpf/spintest_kern.c
+++ b/samples/bpf/spintest_kern.c
@@ -34,7 +34,7 @@ struct bpf_map_def SEC("maps") stackmap = {
 #define PROG(foo) \
 int foo(struct pt_regs *ctx) \
 { \
-	long v = ctx->ip, *val; \
+	long v = PT_REGS_IP(ctx), *val; \
 \
 	val = bpf_map_lookup_elem(&my_map, &v); \
 	bpf_map_update_elem(&my_map, &v, &v, BPF_ANY); \
diff --git a/samples/bpf/tracex2_kern.c b/samples/bpf/tracex2_kern.c
index 09c1adc..6d6eefd 100644
--- a/samples/bpf/tracex2_kern.c
+++ b/samples/bpf/tracex2_kern.c
@@ -27,10 +27,10 @@ int bpf_prog2(struct pt_regs *ctx)
 	long init_val = 1;
 	long *value;
 
-	/* x64/s390x specific: read ip of kfree_skb caller.
+	/* read ip of kfree_skb caller.
 	 * non-portable version of __builtin_return_address(0)
 	 */
-	bpf_probe_read(&loc, sizeof(loc), (void *)PT_REGS_RET(ctx));
+	BPF_KPROBE_READ_RET_IP(loc, ctx);
 
 	value = bpf_map_lookup_elem(&my_map, &loc);
 	if (value)
diff --git a/samples/bpf/tracex4_kern.c b/samples/bpf/tracex4_kern.c
index ac46714..6dd8e38 100644
--- a/samples/bpf/tracex4_kern.c
+++ b/samples/bpf/tracex4_kern.c
@@ -40,7 +40,7 @@ int bpf_prog2(struct pt_regs *ctx)
 	long ip = 0;
 
 	/* get ip address of kmem_cache_alloc_node() caller */
-	bpf_probe_read(&ip, sizeof(ip), (void *)(PT_REGS_FP(ctx) + sizeof(ip)));
+	BPF_KRETPROBE_READ_RET_IP(ip, ctx);
 
 	struct pair v = {
 		.val = bpf_ktime_get_ns(),
-- 
2.7.4
