Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r2PZ0h5CzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 03:16:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MHFAGZ120323
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:47 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4nwj5agk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:47 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:16:44 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
Date: Tue, 22 May 2018 22:46:13 +0530
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
Message-Id: <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This splits up the contiguous JITed dump obtained via the bpf
system call into more relatable chunks for each function in
the program. If the kernel symbols corresponding to these are
known, they are printed in the header for each JIT image dump
otherwise the masked start address is printed.

Before applying this patch:

  # bpftool prog dump jited id 1

     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
  ...
    a8:   mr      r3,r8
    ac:   blr
    b0:   nop
    b4:   nop
    b8:   mflr    r0
    bc:   std     r0,16(r1)
    c0:   stdu    r1,-112(r1)
    c4:   std     r31,104(r1)
  ...
   138:   mr      r3,r8
   13c:   blr

After applying this patch:

  # echo 0 > /proc/sys/net/core/bpf_jit_kallsyms
  # bpftool prog dump jited id 1

  d00000000acc0000:
     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
  ...
    a8:   mr      r3,r8
    ac:   blr

  d00000000ad20000:
     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
  ...
    88:   mr      r3,r8
    8c:   blr

  # echo 1 > /proc/sys/net/core/bpf_jit_kallsyms
  # bpftool prog dump jited id 1

  bpf_prog_8852b2ccb8ec75a7_F:
     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
  ...
    a8:   mr      r3,r8
    ac:   blr

  bpf_prog_196af774a3477707_F:
     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
  ...
    88:   mr      r3,r8
    8c:   blr

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/bpf/bpftool/prog.c          | 51 ++++++++++++++++++++++++++++++++++++++-
 tools/bpf/bpftool/xlated_dumper.c |  4 +--
 tools/bpf/bpftool/xlated_dumper.h |  1 +
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e05ab58d39e2..8ab7a683ac67 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -422,7 +422,9 @@ static int do_dump(int argc, char **argv)
 {
 	unsigned long *func_ksyms = NULL;
 	struct bpf_prog_info info = {};
+	unsigned int *func_lens = NULL;
 	unsigned int nr_func_ksyms;
+	unsigned int nr_func_lens;
 	struct dump_data dd = {};
 	__u32 len = sizeof(info);
 	unsigned int buf_size;
@@ -508,12 +510,24 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
+	nr_func_lens = info.nr_jited_func_lens;
+	if (nr_func_lens) {
+		func_lens = malloc(nr_func_lens * sizeof(__u32));
+		if (!func_lens) {
+			p_err("mem alloc failed");
+			close(fd);
+			goto err_free;
+		}
+	}
+
 	memset(&info, 0, sizeof(info));
 
 	*member_ptr = ptr_to_u64(buf);
 	*member_len = buf_size;
 	info.jited_ksyms = ptr_to_u64(func_ksyms);
 	info.nr_jited_ksyms = nr_func_ksyms;
+	info.jited_func_lens = ptr_to_u64(func_lens);
+	info.nr_jited_func_lens = nr_func_lens;
 
 	err = bpf_obj_get_info_by_fd(fd, &info, &len);
 	close(fd);
@@ -532,6 +546,11 @@ static int do_dump(int argc, char **argv)
 		goto err_free;
 	}
 
+	if (info.nr_jited_func_lens > nr_func_lens) {
+		p_err("too many values returned");
+		goto err_free;
+	}
+
 	if ((member_len == &info.jited_prog_len &&
 	     info.jited_prog_insns == 0) ||
 	    (member_len == &info.xlated_prog_len &&
@@ -569,7 +588,35 @@ static int do_dump(int argc, char **argv)
 				goto err_free;
 		}
 
-		disasm_print_insn(buf, *member_len, opcodes, name);
+		if (info.nr_jited_func_lens && info.jited_func_lens) {
+			struct kernel_sym *sym = NULL;
+			unsigned char *img = buf;
+			__u64 *ksyms = NULL;
+			__u32 *lens;
+			__u32 i;
+
+			if (info.nr_jited_ksyms) {
+				kernel_syms_load(&dd);
+				ksyms = (__u64 *) info.jited_ksyms;
+			}
+
+			lens = (__u32 *) info.jited_func_lens;
+			for (i = 0; i < info.nr_jited_func_lens; i++) {
+				if (ksyms) {
+					sym = kernel_syms_search(&dd, ksyms[i]);
+					if (sym)
+						printf("%s:\n", sym->name);
+					else
+						printf("%016llx:\n", ksyms[i]);
+				}
+
+				disasm_print_insn(img, lens[i], opcodes, name);
+				img += lens[i];
+				printf("\n");
+			}
+		} else {
+			disasm_print_insn(buf, *member_len, opcodes, name);
+		}
 	} else if (visual) {
 		if (json_output)
 			jsonw_null(json_wtr);
@@ -589,11 +636,13 @@ static int do_dump(int argc, char **argv)
 
 	free(buf);
 	free(func_ksyms);
+	free(func_lens);
 	return 0;
 
 err_free:
 	free(buf);
 	free(func_ksyms);
+	free(func_lens);
 	return -1;
 }
 
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index efdc8fecf2bb..b97f1da60dd1 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -102,8 +102,8 @@ void kernel_syms_destroy(struct dump_data *dd)
 	free(dd->sym_mapping);
 }
 
-static struct kernel_sym *kernel_syms_search(struct dump_data *dd,
-					     unsigned long key)
+struct kernel_sym *kernel_syms_search(struct dump_data *dd,
+				      unsigned long key)
 {
 	struct kernel_sym sym = {
 		.address = key,
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index eafbb49c8d0b..33d86e2b369b 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -56,6 +56,7 @@ struct dump_data {
 
 void kernel_syms_load(struct dump_data *dd);
 void kernel_syms_destroy(struct dump_data *dd);
+struct kernel_sym *kernel_syms_search(struct dump_data *dd, unsigned long key);
 void dump_xlated_json(struct dump_data *dd, void *buf, unsigned int len,
 		      bool opcodes);
 void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
-- 
2.14.3
