Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mhQS1XW9zF1Rp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 16:35:59 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4H6ZLwk106276
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:35:57 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j13cqtw8g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:35:57 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 17 May 2018 07:35:55 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH bpf 1/6] bpf: support 64-bit offsets for bpf function calls
Date: Thu, 17 May 2018 12:05:43 +0530
In-Reply-To: <20180517063548.6373-1-sandipan@linux.vnet.ibm.com>
References: <20180517063548.6373-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20180517063548.6373-2-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The imm field of a bpf instruction is a signed 32-bit integer.
For JIT bpf-to-bpf function calls, it stores the offset of the
start address of the callee's JITed image from __bpf_call_base.

For some architectures, such as powerpc64, this offset may be
as large as 64 bits and cannot be accomodated in the imm field
without truncation.

We resolve this by:

[1] Additionally using the auxillary data of each function to
    keep a list of start addresses of the JITed images for all
    functions determined by the verifier.

[2] Retaining the subprog id inside the off field of the call
    instructions and using it to index into the list mentioned
    above and lookup the callee's address.

To make sure that the existing JIT compilers continue to work
without requiring changes, we keep the imm field as it is.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 kernel/bpf/verifier.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5e1a6c4165d..aa76879f4fd1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5373,11 +5373,24 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			    insn->src_reg != BPF_PSEUDO_CALL)
 				continue;
 			subprog = insn->off;
-			insn->off = 0;
 			insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
 				func[subprog]->bpf_func -
 				__bpf_call_base;
 		}
+
+		/* we use the aux data to keep a list of the start addresses
+		 * of the JITed images for each function in the program
+		 *
+		 * for some architectures, such as powerpc64, the imm field
+		 * might not be large enough to hold the offset of the start
+		 * address of the callee's JITed image from __bpf_call_base
+		 *
+		 * in such cases, we can lookup the start address of a callee
+		 * by using its subprog id, available from the off field of
+		 * the call instruction, as an index for this list
+		 */
+		func[i]->aux->func = func;
+		func[i]->aux->func_cnt = env->subprog_cnt + 1;
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-- 
2.14.3
