Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r2P613SvzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 03:16:25 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MHFCi5122934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:23 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4pm52t18-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:22 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:16:20 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v3 01/10] bpf: support 64-bit offsets for bpf
 function calls
Date: Tue, 22 May 2018 22:46:04 +0530
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
Message-Id: <6d0a491b74c233af3299282dd8763d09a6c6c8cd.1527008646.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The imm field of a bpf instruction is a signed 32-bit integer.
For JITed bpf-to-bpf function calls, it holds the offset of the
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
index a9e4b1372da6..559cb74ba29e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5383,11 +5383,24 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
+		func[i]->aux->func_cnt = env->subprog_cnt;
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-- 
2.14.3
