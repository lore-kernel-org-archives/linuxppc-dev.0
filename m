Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kzZ24hSJzF3X1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 21:51:38 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4EBnOd5012773
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 07:51:35 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hy8mguekq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 07:51:35 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Mon, 14 May 2018 12:51:33 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@fb.com, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [RFC][PATCH bpf v3 5/5] tools: bpftool: resolve call addresses
 without using imm field
Date: Mon, 14 May 2018 17:21:18 +0530
In-Reply-To: <20180514115118.8149-1-sandipan@linux.vnet.ibm.com>
References: <20180514115118.8149-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20180514115118.8149-5-sandipan@linux.vnet.ibm.com>
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
---
 tools/bpf/bpftool/prog.c          | 33 +++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/xlated_dumper.c | 24 +++++++++++++++++-------
 tools/bpf/bpftool/xlated_dumper.h |  2 ++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9bdfdf2d3fbe..0ba947c7deec 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -428,6 +428,8 @@ static int do_dump(int argc, char **argv)
 	bool opcodes = false;
 	bool visual = false;
 	unsigned char *buf;
+	__u64 *addrs = NULL;
+	__u32 nr_addrs = 0;
 	__u32 *member_len;
 	__u64 *member_ptr;
 	ssize_t n;
@@ -496,11 +498,27 @@ static int do_dump(int argc, char **argv)
 		return -1;
 	}
 
+	if (info.nr_jited_funcs) {
+		nr_addrs = info.nr_jited_funcs;
+		addrs = (__u64 *) malloc(nr_addrs * sizeof(__u64));
+		if (!addrs) {
+			p_err("mem alloc failed");
+			free(buf);
+			close(fd);
+			return -1;
+		}
+	}
+
 	memset(&info, 0, sizeof(info));
 
 	*member_ptr = ptr_to_u64(buf);
 	*member_len = buf_size;
 
+	if (nr_addrs) {
+		info.jited_funcs = ptr_to_u64(addrs);
+		info.nr_jited_funcs = nr_addrs;
+	}
+
 	err = bpf_obj_get_info_by_fd(fd, &info, &len);
 	close(fd);
 	if (err) {
@@ -513,6 +531,11 @@ static int do_dump(int argc, char **argv)
 		goto err_free;
 	}
 
+	if (info.nr_jited_funcs > nr_addrs) {
+		p_err("too many addresses returned");
+		goto err_free;
+	}
+
 	if ((member_len == &info.jited_prog_len &&
 	     info.jited_prog_insns == 0) ||
 	    (member_len == &info.xlated_prog_len &&
@@ -558,6 +581,12 @@ static int do_dump(int argc, char **argv)
 			dump_xlated_cfg(buf, *member_len);
 	} else {
 		kernel_syms_load(&dd);
+
+		if (info.nr_jited_funcs) {
+			dd.jited_funcs = (u64 *) info.jited_funcs;
+			dd.nr_jited_funcs = info.nr_jited_funcs;
+		}
+
 		if (json_output)
 			dump_xlated_json(&dd, buf, *member_len, opcodes);
 		else
@@ -566,10 +595,14 @@ static int do_dump(int argc, char **argv)
 	}
 
 	free(buf);
+	if (nr_addrs)
+		free(addrs);
 	return 0;
 
 err_free:
 	free(buf);
+	if (nr_addrs)
+		free(addrs);
 	return -1;
 }
 
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 7a3173b76c16..70943612b667 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -178,8 +178,12 @@ static const char *print_call_pcrel(struct dump_data *dd,
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "%+d#%s", insn->off, sym->name);
 	else
-		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "%+d#0x%lx", insn->off, address);
+		if (address)
+			snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+				 "%+d#0x%lx", insn->off, address);
+		else
+			snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+				 "%+d", insn->off);
 	return dd->scratch_buff;
 }
 
@@ -200,14 +204,20 @@ static const char *print_call(void *private_data,
 			      const struct bpf_insn *insn)
 {
 	struct dump_data *dd = private_data;
-	unsigned long address = dd->address_call_base + insn->imm;
-	struct kernel_sym *sym;
+	unsigned long address = 0;
+	struct kernel_sym *sym = NULL;
 
-	sym = kernel_syms_search(dd, address);
-	if (insn->src_reg == BPF_PSEUDO_CALL)
+	if (insn->src_reg == BPF_PSEUDO_CALL) {
+		if (dd->nr_jited_funcs) {
+			address = dd->jited_funcs[insn->imm];
+			sym = kernel_syms_search(dd, address);
+		}
 		return print_call_pcrel(dd, sym, address, insn);
-	else
+	} else {
+		address = dd->address_call_base + insn->imm;
+		sym = kernel_syms_search(dd, address);
 		return print_call_helper(dd, sym, address);
+	}
 }
 
 static const char *print_imm(void *private_data,
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index b34affa7ef2d..6afc03a5fbad 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -47,6 +47,8 @@ struct kernel_sym {
 
 struct dump_data {
 	unsigned long address_call_base;
+	unsigned long *jited_funcs;
+	unsigned int nr_jited_funcs;
 	struct kernel_sym *sym_mapping;
 	__u32 sym_count;
 	char scratch_buff[SYM_MAX_NAME + 8];
-- 
2.14.3
