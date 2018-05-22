Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r2PQ26F5zDqmX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 03:16:42 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MHF69h007550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4q6e14qv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:38 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:16:35 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v3 07/10] bpf: fix multi-function JITed dump obtained
 via syscall
Date: Tue, 22 May 2018 22:46:10 +0530
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
Message-Id: <6f245a366d5a2957e2256f4bd89ab56ade6508d5.1527008647.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, for multi-function programs, we cannot get the JITed
instructions using the bpf system call's BPF_OBJ_GET_INFO_BY_FD
command. Because of this, userspace tools such as bpftool fail
to identify a multi-function program as being JITed or not.

With the JIT enabled and the test program running, this can be
verified as follows:

  # cat /proc/sys/net/core/bpf_jit_enable
  1

Before applying this patch:

  # bpftool prog list
  1: kprobe  name foo  tag b811aab41a39ad3d  gpl
          loaded_at 2018-05-16T11:43:38+0530  uid 0
          xlated 216B  not jited  memlock 65536B
  ...

  # bpftool prog dump jited id 1
  no instructions returned

After applying this patch:

  # bpftool prog list
  1: kprobe  name foo  tag b811aab41a39ad3d  gpl
          loaded_at 2018-05-16T12:13:01+0530  uid 0
          xlated 216B  jited 308B  memlock 65536B
  ...

  # bpftool prog dump jited id 1
     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
    18:   addi    r31,r1,48
    1c:   li      r3,10
  ...

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 kernel/bpf/syscall.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f0ad4b5f0224..1c4cba91e523 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1970,13 +1970,43 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	 * for offload.
 	 */
 	ulen = info.jited_prog_len;
-	info.jited_prog_len = prog->jited_len;
+	if (prog->aux->func_cnt) {
+		u32 i;
+
+		info.jited_prog_len = 0;
+		for (i = 0; i < prog->aux->func_cnt; i++)
+			info.jited_prog_len += prog->aux->func[i]->jited_len;
+	} else {
+		info.jited_prog_len = prog->jited_len;
+	}
+
 	if (info.jited_prog_len && ulen) {
 		if (bpf_dump_raw_ok()) {
 			uinsns = u64_to_user_ptr(info.jited_prog_insns);
 			ulen = min_t(u32, info.jited_prog_len, ulen);
-			if (copy_to_user(uinsns, prog->bpf_func, ulen))
-				return -EFAULT;
+
+			/* for multi-function programs, copy the JITed
+			 * instructions for all the functions
+			 */
+			if (prog->aux->func_cnt) {
+				u32 len, free, i;
+				u8 *img;
+
+				free = ulen;
+				for (i = 0; i < prog->aux->func_cnt; i++) {
+					len = prog->aux->func[i]->jited_len;
+					img = (u8 *) prog->aux->func[i]->bpf_func;
+					if (len > free)
+						break;
+					if (copy_to_user(uinsns, img, len))
+						return -EFAULT;
+					uinsns += len;
+					free -= len;
+				}
+			} else {
+				if (copy_to_user(uinsns, prog->bpf_func, ulen))
+					return -EFAULT;
+			}
 		} else {
 			info.jited_prog_insns = 0;
 		}
-- 
2.14.3
