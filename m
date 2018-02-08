Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zccKK0dKDzF18D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 23:03:16 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w18BYFB8040231
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 07:03:14 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g0kpp744w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 07:03:14 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 8 Feb 2018 12:03:12 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@fb.com, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [RFC][PATCH bpf 1/2] bpf: allow 64-bit offsets for bpf function calls
Date: Thu,  8 Feb 2018 17:33:05 +0530
Message-Id: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
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

To resolve this, we additionally use the aux data within each
bpf_prog associated with the caller functions to store the
addresses of their respective callees.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5fb69a85d967..52088b4ca02f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5282,6 +5282,19 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	 * run last pass of JIT
 	 */
 	for (i = 0; i <= env->subprog_cnt; i++) {
+		u32 flen = func[i]->len, callee_cnt = 0;
+		struct bpf_prog **callee;
+
+		/* for now assume that the maximum number of bpf function
+		 * calls that can be made by a caller must be at most the
+		 * number of bpf instructions in that function
+		 */
+		callee = kzalloc(sizeof(func[i]) * flen, GFP_KERNEL);
+		if (!callee) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
 			if (insn->code != (BPF_JMP | BPF_CALL) ||
@@ -5292,6 +5305,26 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
 				func[subprog]->bpf_func -
 				__bpf_call_base;
+
+			/* the offset to the callee from __bpf_call_base
+			 * may be larger than what the 32 bit integer imm
+			 * can accomodate which will truncate the higher
+			 * order bits
+			 *
+			 * to avoid this, we additionally utilize the aux
+			 * data of each caller function for storing the
+			 * addresses of every callee associated with it
+			 */
+			callee[callee_cnt++] = func[subprog];
+		}
+
+		/* free up callee list if no function calls were made */
+		if (!callee_cnt) {
+			kfree(callee);
+			callee = NULL;
+		} else {
+			func[i]->aux->func = callee;
+			func[i]->aux->func_cnt = callee_cnt;
 		}
 	}
 	for (i = 0; i <= env->subprog_cnt; i++) {
@@ -5338,8 +5371,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	return 0;
 out_free:
 	for (i = 0; i <= env->subprog_cnt; i++)
-		if (func[i])
+		if (func[i]) {
+			/* cleanup callee list */
+			if (func[i]->aux->func)
+				kfree(func[i]->aux->func);
 			bpf_jit_free(func[i]);
+		}
 	kfree(func);
 	/* cleanup main prog to be interpreted */
 	prog->jit_requested = 0;
-- 
2.14.3
