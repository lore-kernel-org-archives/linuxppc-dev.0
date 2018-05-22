Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r2PN6V0WzDqlp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 03:16:40 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MHFMg8020159
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:38 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4m00484t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:35 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:16:30 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v3 04/10] bpf: get kernel symbol addresses via syscall
Date: Tue, 22 May 2018 22:46:07 +0530
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
Message-Id: <c4575f3d547407c020c665e52de5381171746591.1527008646.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds new two new fields to struct bpf_prog_info. For
multi-function programs, these fields can be used to pass
a list of kernel symbol addresses for all functions in a
given program to userspace using the bpf system call with
the BPF_OBJ_GET_INFO_BY_FD command.

When bpf_jit_kallsyms is enabled, we can get the address
of the corresponding kernel symbol for a callee function
and resolve the symbol's name. The address is determined
by adding the value of the call instruction's imm field
to __bpf_call_base. This offset gets assigned to the imm
field by the verifier.

For some architectures, such as powerpc64, the imm field
is not large enough to hold this offset.

We resolve this by:

[1] Assigning the subprog id to the imm field of a call
    instruction in the verifier instead of the offset of
    the callee's symbol's address from __bpf_call_base.

[2] Determining the address of a callee's corresponding
    symbol by using the imm field as an index for the
    list of kernel symbol addresses now available from
    the program info.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
v3:
 - Copy addresses to jited_ksyms only if bpf_dump_raw_ok()
   is true.
 - Move new fields to the end of bpf_prog_info to avoid
   breaking userspace.
---
 include/uapi/linux/bpf.h |  2 ++
 kernel/bpf/syscall.c     | 25 +++++++++++++++++++++++++
 kernel/bpf/verifier.c    |  7 +------
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 97446bbe2ca5..c44105f27da9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2205,6 +2205,8 @@ struct bpf_prog_info {
 	__u32 gpl_compatible:1;
 	__u64 netns_dev;
 	__u64 netns_ino;
+	__u32 nr_jited_ksyms;
+	__aligned_u64 jited_ksyms;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bfcde949c7f8..f0ad4b5f0224 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1933,6 +1933,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	if (!capable(CAP_SYS_ADMIN)) {
 		info.jited_prog_len = 0;
 		info.xlated_prog_len = 0;
+		info.nr_jited_ksyms = 0;
 		goto done;
 	}
 
@@ -1981,6 +1982,30 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 		}
 	}
 
+	ulen = info.nr_jited_ksyms;
+	info.nr_jited_ksyms = prog->aux->func_cnt;
+	if (info.nr_jited_ksyms && ulen) {
+		if (bpf_dump_raw_ok()) {
+			u64 __user *user_ksyms;
+			ulong ksym_addr;
+			u32 i;
+
+			/* copy the address of the kernel symbol
+			 * corresponding to each function
+			 */
+			ulen = min_t(u32, info.nr_jited_ksyms, ulen);
+			user_ksyms = u64_to_user_ptr(info.jited_ksyms);
+			for (i = 0; i < ulen; i++) {
+				ksym_addr = (ulong) prog->aux->func[i]->bpf_func;
+				ksym_addr &= PAGE_MASK;
+				if (put_user((u64) ksym_addr, &user_ksyms[i]))
+					return -EFAULT;
+			}
+		} else {
+			info.jited_ksyms = 0;
+		}
+	}
+
 done:
 	if (copy_to_user(uinfo, &info, info_len) ||
 	    put_user(info_len, &uattr->info.info_len))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 559cb74ba29e..8c4d9d0fd3ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5426,17 +5426,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	 * later look the same as if they were interpreted only.
 	 */
 	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		unsigned long addr;
-
 		if (insn->code != (BPF_JMP | BPF_CALL) ||
 		    insn->src_reg != BPF_PSEUDO_CALL)
 			continue;
 		insn->off = env->insn_aux_data[i].call_imm;
 		subprog = find_subprog(env, i + insn->off + 1);
-		addr  = (unsigned long)func[subprog]->bpf_func;
-		addr &= PAGE_MASK;
-		insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
-			    addr - __bpf_call_base;
+		insn->imm = subprog;
 	}
 
 	prog->jited = 1;
-- 
2.14.3
