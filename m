Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s0Yq0gQyzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 16:57:18 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4O6sJAP081304
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:57:16 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j5qhdtfb9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:57:16 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 24 May 2018 07:57:14 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v4 06/10] tools: bpftool: resolve calls without using
 imm field
Date: Thu, 24 May 2018 12:26:50 +0530
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
Message-Id: <ecf6487b56ad963dabd5a66df7915a2d435216cc.1527143877.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we resolve the callee's address for a JITed function
call by using the imm field of the call instruction as an offset
from __bpf_call_base. If bpf_jit_kallsyms is enabled, we further
use this address to get the callee's kernel symbol's name.

For some architectures, such as powerpc64, the imm field is not
large enough to hold this offset. So, instead of assigning this
offset to the imm field, the verifier now assigns the subprog
id. Also, a list of kernel symbol addresses for all the JITed
functions is provided in the program info. We now use the imm
field as an index for this list to lookup a callee's symbol's
address and resolve its name.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
v3:
 - Avoid using redundant pointers.
 - Fix indentation.

v2:
 - Order variables from longest to shortest.
 - Make sure that ksyms_ptr and ksyms_len are always initialized.
 - Simplify code.
---
 tools/bpf/bpftool/prog.c          | 24 ++++++++++++++++++++++++
 tools/bpf/bpftool/xlated_dumper.c | 10 +++++++++-
 tools/bpf/bpftool/xlated_dumper.h |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9bdfdf2d3fbe..e05ab58d39e2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -420,7 +420,9 @@ static int do_show(int argc, char **argv)
 
 static int do_dump(int argc, char **argv)
 {
+	unsigned long *func_ksyms = NULL;
 	struct bpf_prog_info info = {};
+	unsigned int nr_func_ksyms;
 	struct dump_data dd = {};
 	__u32 len = sizeof(info);
 	unsigned int buf_size;
@@ -496,10 +498,22 @@ static int do_dump(int argc, char **argv)
 		return -1;
 	}
 
+	nr_func_ksyms = info.nr_jited_ksyms;
+	if (nr_func_ksyms) {
+		func_ksyms = malloc(nr_func_ksyms * sizeof(__u64));
+		if (!func_ksyms) {
+			p_err("mem alloc failed");
+			close(fd);
+			goto err_free;
+		}
+	}
+
 	memset(&info, 0, sizeof(info));
 
 	*member_ptr = ptr_to_u64(buf);
 	*member_len = buf_size;
+	info.jited_ksyms = ptr_to_u64(func_ksyms);
+	info.nr_jited_ksyms = nr_func_ksyms;
 
 	err = bpf_obj_get_info_by_fd(fd, &info, &len);
 	close(fd);
@@ -513,6 +527,11 @@ static int do_dump(int argc, char **argv)
 		goto err_free;
 	}
 
+	if (info.nr_jited_ksyms > nr_func_ksyms) {
+		p_err("too many addresses returned");
+		goto err_free;
+	}
+
 	if ((member_len == &info.jited_prog_len &&
 	     info.jited_prog_insns == 0) ||
 	    (member_len == &info.xlated_prog_len &&
@@ -558,6 +577,9 @@ static int do_dump(int argc, char **argv)
 			dump_xlated_cfg(buf, *member_len);
 	} else {
 		kernel_syms_load(&dd);
+		dd.nr_jited_ksyms = info.nr_jited_ksyms;
+		dd.jited_ksyms = (__u64 *) info.jited_ksyms;
+
 		if (json_output)
 			dump_xlated_json(&dd, buf, *member_len, opcodes);
 		else
@@ -566,10 +588,12 @@ static int do_dump(int argc, char **argv)
 	}
 
 	free(buf);
+	free(func_ksyms);
 	return 0;
 
 err_free:
 	free(buf);
+	free(func_ksyms);
 	return -1;
 }
 
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 7a3173b76c16..efdc8fecf2bb 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -174,7 +174,11 @@ static const char *print_call_pcrel(struct dump_data *dd,
 				    unsigned long address,
 				    const struct bpf_insn *insn)
 {
-	if (sym)
+	if (!dd->nr_jited_ksyms)
+		/* Do not show address for interpreted programs */
+		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+			"%+d", insn->off);
+	else if (sym)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "%+d#%s", insn->off, sym->name);
 	else
@@ -203,6 +207,10 @@ static const char *print_call(void *private_data,
 	unsigned long address = dd->address_call_base + insn->imm;
 	struct kernel_sym *sym;
 
+	if (insn->src_reg == BPF_PSEUDO_CALL &&
+	    (__u32) insn->imm < dd->nr_jited_ksyms)
+		address = dd->jited_ksyms[insn->imm];
+
 	sym = kernel_syms_search(dd, address);
 	if (insn->src_reg == BPF_PSEUDO_CALL)
 		return print_call_pcrel(dd, sym, address, insn);
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index b34affa7ef2d..eafbb49c8d0b 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -49,6 +49,8 @@ struct dump_data {
 	unsigned long address_call_base;
 	struct kernel_sym *sym_mapping;
 	__u32 sym_count;
+	__u64 *jited_ksyms;
+	__u32 nr_jited_ksyms;
 	char scratch_buff[SYM_MAX_NAME + 8];
 };
 
-- 
2.14.3
