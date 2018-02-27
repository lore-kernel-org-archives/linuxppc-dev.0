Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrHft42ZKzF1M9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 23:13:57 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1RCAimA013246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 07:13:55 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gd6kh1bkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 07:13:55 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 12:13:51 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: daniel@iogearbox.net, naveen.n.rao@linux.vnet.ibm.com
Cc: ast@fb.com, mpe@ellerman.id.au, jakub.kicinski@netronome.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC][PATCH bpf] tools: bpftool: Fix tags for bpf-to-bpf calls
Date: Tue, 27 Feb 2018 17:43:46 +0530
In-Reply-To: <1519153431.im5wioxel1.naveen@linux.ibm.com>
References: <1519153431.im5wioxel1.naveen@linux.ibm.com>
Message-Id: <20180227121346.16199-1-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" wrote:
> I'm wondering if we can instead encode the bpf prog id in
> imm32. That way, we should be able to indicate the BPF
> function being called into.  Daniel, is that something we
> can consider?

Since each subprog does not get a separate id, we cannot fetch
the fd and therefore the tag of a subprog. Instead we can use
the tag of the complete program as shown below.

"Daniel Borkmann" wrote:
> I think one limitation that would still need to be addressed later
> with such approach would be regarding the xlated prog dump in bpftool,
> see 'BPF calls via JIT' in 7105e828c087 ("bpf: allow for correlation
> of maps and helpers in dump"). Any ideas for this (potentially if we
> could use off + imm for calls, we'd get to 48 bits, but that seems
> still not be enough as you say)?

As an alternative, this is what I am thinking of:

Currently, for bpf-to-bpf calls, if bpf_jit_kallsyms is enabled,
bpftool looks up the name of the corresponding symbol for the
JIT-ed subprogram and shows it in the xlated dump alongside the
actual call instruction. However, the lookup is based on the
target address which is calculated using the imm field of the
instruction. So, once again, if imm is truncated, we will end
up with the wrong address. Also, the subprog aux data (which
has been proposed as a mitigation for this) is not accessible
from this tool.

We can still access the tag for the complete bpf program and use
this with the correct offset in an objdump-like notation as an
alterative for the name of the subprog that is the target of a
bpf-to-bpf call instruction.

Currently, an xlated dump looks like this:
   0: (85) call pc+2#bpf_prog_5f76847930402518_F
   1: (b7) r0 = 1
   2: (95) exit
   3: (b7) r0 = 2
   4: (95) exit

With this patch, it will look like this:
   0: (85) call pc+2#bpf_prog_8f85936f29a7790a+3
   1: (b7) r0 = 1
   2: (95) exit
   3: (b7) r0 = 2
   4: (95) exit

where 8f85936f29a7790a is the tag of the bpf program and 3 is
the offset to the start of the subprog from the start of the
program.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/bpf/bpftool/prog.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e8e2baaf93c2..93746d5d1e3c 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -415,9 +415,11 @@ struct kernel_sym {
 };
 
 struct dump_data {
+	unsigned char prog_tag[BPF_TAG_SIZE];
 	unsigned long address_call_base;
 	struct kernel_sym *sym_mapping;
 	__u32 sym_count;
+	unsigned int curr_line;
 	char scratch_buff[SYM_MAX_NAME];
 };
 
@@ -499,16 +501,16 @@ static void print_insn(struct bpf_verifier_env *env, const char *fmt, ...)
 }
 
 static const char *print_call_pcrel(struct dump_data *dd,
-				    struct kernel_sym *sym,
-				    unsigned long address,
 				    const struct bpf_insn *insn)
 {
-	if (sym)
-		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "%+d#%s", insn->off, sym->name);
-	else
-		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "%+d#0x%lx", insn->off, address);
+	snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+		 "+%d#bpf_prog_%02x%02x%02x%02x%02x%02x%02x%02x+%d",
+		 insn->off,
+		 dd->prog_tag[0], dd->prog_tag[1],
+		 dd->prog_tag[2], dd->prog_tag[3],
+		 dd->prog_tag[4], dd->prog_tag[5],
+		 dd->prog_tag[6], dd->prog_tag[7],
+		 dd->curr_line + insn->off + 1);
 	return dd->scratch_buff;
 }
 
@@ -534,7 +536,7 @@ static const char *print_call(void *private_data,
 
 	sym = kernel_syms_search(dd, address);
 	if (insn->src_reg == BPF_PSEUDO_CALL)
-		return print_call_pcrel(dd, sym, address, insn);
+		return print_call_pcrel(dd, insn);
 	else
 		return print_call_helper(dd, sym, address);
 }
@@ -576,6 +578,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
 		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
 
 		printf("% 4d: ", i);
+		dd->curr_line = i;
 		print_bpf_insn(&cbs, NULL, insn + i, true);
 
 		if (opcodes) {
@@ -628,6 +631,7 @@ static void dump_xlated_json(struct dump_data *dd, void *buf,
 
 		jsonw_start_object(json_wtr);
 		jsonw_name(json_wtr, "disasm");
+		dd->curr_line = i;
 		print_bpf_insn(&cbs, NULL, insn + i, true);
 
 		if (opcodes) {
@@ -788,6 +792,7 @@ static int do_dump(int argc, char **argv)
 
 			disasm_print_insn(buf, *member_len, opcodes, name);
 		} else {
+			memcpy(dd.prog_tag, info.tag, sizeof(info.tag));
 			kernel_syms_load(&dd);
 			if (json_output)
 				dump_xlated_json(&dd, buf, *member_len, opcodes);
-- 
2.14.3
