Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgTVW3HWmzF0th
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 15:06:11 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1D44Qim113509
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 23:06:08 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g3h4feams-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 23:06:07 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 04:06:05 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@fb.com, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [RFC][PATCH bpf v2 1/2] bpf: allow 64-bit offsets for bpf function
 calls
Date: Tue, 13 Feb 2018 09:35:59 +0530
Message-Id: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The imm field of a bpf_insn is a signed 32-bit integer. For
JIT-ed bpf-to-bpf function calls, it stores the offset from
__bpf_call_base to the start of the callee function.

For some architectures, such as powerpc64, it was found that
this offset may be as large as 64 bits because of which this
cannot be accomodated in the imm field without truncation.

To resolve this, we additionally make aux->func within each
bpf_prog associated with the functions to point to the list
of all function addresses determined by the verifier.

We keep the value assigned to the off field of the bpf_insn
as a way to index into aux->func and also set aux->func_cnt
so that this can be used for performing basic upper bound
checks for the off field.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
v2: Make aux->func point to the list of functions determined
    by the verifier rather than allocating a separate callee
    list for each function.
---
 kernel/bpf/verifier.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5fb69a85d967..1c4d9cd485ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5288,11 +5288,25 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			    insn->src_reg != BPF_PSEUDO_CALL)
 				continue;
 			subprog = insn->off;
-			insn->off = 0;
 			insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
 				func[subprog]->bpf_func -
 				__bpf_call_base;
 		}
+
+		/* the offset to a callee function from __bpf_call_base
+		 * may be larger than what the 32 bit integer imm can
+		 * accomodate which will truncate the higher order bits
+		 *
+		 * to avoid this, we additionally utilize the aux data
+		 * of each function to point to a list of all function
+		 * addresses determined by the verifier
+		 *
+		 * the off field of the instruction provides the index
+		 * in this list where the start address of a function
+		 * is available
+		 */
+		func[i]->aux->func = func;
+		func[i]->aux->func_cnt = env->subprog_cnt + 1;
 	}
 	for (i = 0; i <= env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-- 
2.14.3
