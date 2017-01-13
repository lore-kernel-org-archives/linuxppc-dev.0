Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0TfJ19cSzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:10:31 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0DH9H9t141543
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 12:10:29 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27xxh4ug1y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 12:10:28 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 13 Jan 2017 22:40:25 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CEE2E394005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 22:40:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0DHAM3w25493676
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 22:40:22 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0DHAG0o010692
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 22:40:18 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ast@fb.com,
 daniel@iogearbox.net, davem@davemloft.net
Subject: [PATCH 1/3] powerpc: bpf: remove redundant check for non-null image
Date: Fri, 13 Jan 2017 22:40:00 +0530
Message-Id: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Daniel Borkmann <daniel@iogearbox.net>

We have a check earlier to ensure we don't proceed if image is NULL. As
such, the redundant check can be removed.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[Added similar changes for classic BPF JIT]
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 17 +++++++++--------
 arch/powerpc/net/bpf_jit_comp64.c | 16 ++++++++--------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7e706f3..f9941b3 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -662,16 +662,17 @@ void bpf_jit_compile(struct bpf_prog *fp)
 		 */
 		bpf_jit_dump(flen, proglen, pass, code_base);
 
-	if (image) {
-		bpf_flush_icache(code_base, code_base + (proglen/4));
+	bpf_flush_icache(code_base, code_base + (proglen/4));
+
 #ifdef CONFIG_PPC64
-		/* Function descriptor nastiness: Address + TOC */
-		((u64 *)image)[0] = (u64)code_base;
-		((u64 *)image)[1] = local_paca->kernel_toc;
+	/* Function descriptor nastiness: Address + TOC */
+	((u64 *)image)[0] = (u64)code_base;
+	((u64 *)image)[1] = local_paca->kernel_toc;
 #endif
-		fp->bpf_func = (void *)image;
-		fp->jited = 1;
-	}
+
+	fp->bpf_func = (void *)image;
+	fp->jited = 1;
+
 out:
 	kfree(addrs);
 	return;
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 0fe98a5..89b6a86 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1046,16 +1046,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		 */
 		bpf_jit_dump(flen, proglen, pass, code_base);
 
-	if (image) {
-		bpf_flush_icache(bpf_hdr, image + alloclen);
+	bpf_flush_icache(bpf_hdr, image + alloclen);
+
 #ifdef PPC64_ELF_ABI_v1
-		/* Function descriptor nastiness: Address + TOC */
-		((u64 *)image)[0] = (u64)code_base;
-		((u64 *)image)[1] = local_paca->kernel_toc;
+	/* Function descriptor nastiness: Address + TOC */
+	((u64 *)image)[0] = (u64)code_base;
+	((u64 *)image)[1] = local_paca->kernel_toc;
 #endif
-		fp->bpf_func = (void *)image;
-		fp->jited = 1;
-	}
+
+	fp->bpf_func = (void *)image;
+	fp->jited = 1;
 
 out:
 	kfree(addrs);
-- 
2.10.2
