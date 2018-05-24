Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s0Yv1NVGzF1KG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 16:57:22 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4O6sGGc039644
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:57:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j5mte060p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:57:20 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 24 May 2018 07:57:19 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v4 08/10] bpf: get JITed image lengths of functions
 via syscall
Date: Thu, 24 May 2018 12:26:52 +0530
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
Message-Id: <0548a1e5b7713ebfed0ac8c279dd14d8a2299048.1527143877.git.sandipan@linux.vnet.ibm.com>
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
a list of the JITed image lengths of each function for a
given program to userspace using the bpf system call with
the BPF_OBJ_GET_INFO_BY_FD command.

This can be used by userspace applications like bpftool
to split up the contiguous JITed dump, also obtained via
the system call, into more relatable chunks corresponding
to each function.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 include/uapi/linux/bpf.h |  2 ++
 kernel/bpf/syscall.c     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0be90965867d..344d2ddcef49 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2206,7 +2206,9 @@ struct bpf_prog_info {
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
+	__u32 nr_jited_func_lens;
 	__aligned_u64 jited_ksyms;
+	__aligned_u64 jited_func_lens;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c8e987a612b5..788456c18617 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2037,6 +2037,26 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 		}
 	}
 
+	ulen = info.nr_jited_func_lens;
+	info.nr_jited_func_lens = prog->aux->func_cnt;
+	if (info.nr_jited_func_lens && ulen) {
+		if (bpf_dump_raw_ok()) {
+			u32 __user *user_lens;
+			u32 func_len, i;
+
+			/* copy the JITed image lengths for each function */
+			ulen = min_t(u32, info.nr_jited_func_lens, ulen);
+			user_lens = u64_to_user_ptr(info.jited_func_lens);
+			for (i = 0; i < ulen; i++) {
+				func_len = prog->aux->func[i]->jited_len;
+				if (put_user(func_len, &user_lens[i]))
+					return -EFAULT;
+			}
+		} else {
+			info.jited_func_lens = 0;
+		}
+	}
+
 done:
 	if (copy_to_user(uinfo, &info, info_len) ||
 	    put_user(info_len, &uattr->info.info_len))
-- 
2.14.3
