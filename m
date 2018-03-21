Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mcn4p4lzDrHw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:43:53 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LAhlmu029165
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 06:43:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gum3fd30j-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 06:43:50 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 10:43:48 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: [PATCH v2 3/5] powerpc64/module: Tighten detection of mcount call
 sites with -mprofile-kernel
Date: Wed, 21 Mar 2018 16:13:20 +0530
In-Reply-To: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e5d3f19b68d9c808dfb9879f343e119761e85e5c.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For R_PPC64_REL24 relocations, we suppress emitting instructions for TOC
load/restore in the relocation stub if the relocation is for _mcount()
call when using -mprofile-kernel ABI.

To detect this, we check if the preceding instructions are per the
standard set of instructions emitted by gcc: either the two instruction
sequence of 'mflr r0; std r0,16(r1)', or the more optimized variant of a
single 'mflr r0'. This is not sufficient since nothing prevents users
from hand coding sequences involving a 'mflr r0' followed by a 'bl'.

For removing the toc save instruction from the stub, we additionally
check if the symbol is "_mcount". Add the same check here as well.

Also rename is_early_mcount_callsite() to is_mprofile_mcount_callsite()
since that is what is being checked. The use of "early" is misleading
since there is nothing involving this function that qualifies as early.

Fixes: 153086644fd1f ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/module_64.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index a2636c250b7b..8413be31d6a4 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -463,8 +463,11 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 }
 
 #ifdef CC_USING_MPROFILE_KERNEL
-static bool is_early_mcount_callsite(u32 *instruction)
+static bool is_mprofile_mcount_callsite(const char *name, u32 *instruction)
 {
+	if (strcmp("_mcount", name))
+		return false;
+
 	/*
 	 * Check if this is one of the -mprofile-kernel sequences.
 	 */
@@ -496,8 +499,7 @@ static void squash_toc_save_inst(const char *name, unsigned long addr)
 #else
 static void squash_toc_save_inst(const char *name, unsigned long addr) { }
 
-/* without -mprofile-kernel, mcount calls are never early */
-static bool is_early_mcount_callsite(u32 *instruction)
+static bool is_mprofile_mcount_callsite(const char *name, u32 *instruction)
 {
 	return false;
 }
@@ -505,11 +507,11 @@ static bool is_early_mcount_callsite(u32 *instruction)
 
 /* We expect a noop next: if it is, replace it with instruction to
    restore r2. */
-static int restore_r2(u32 *instruction, struct module *me)
+static int restore_r2(const char *name, u32 *instruction, struct module *me)
 {
 	u32 *prev_insn = instruction - 1;
 
-	if (is_early_mcount_callsite(prev_insn))
+	if (is_mprofile_mcount_callsite(name, prev_insn))
 		return 1;
 
 	/*
@@ -650,7 +652,8 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				value = stub_for_addr(sechdrs, value, me);
 				if (!value)
 					return -ENOENT;
-				if (!restore_r2((u32 *)location + 1, me))
+				if (!restore_r2(strtab + sym->st_name,
+							(u32 *)location + 1, me))
 					return -ENOEXEC;
 
 				squash_toc_save_inst(strtab + sym->st_name, value);
-- 
2.16.2
