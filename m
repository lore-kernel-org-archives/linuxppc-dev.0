Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABBDB1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 03/12] powerpc/module: Create a special stub for
 ftrace_caller()
Date: Thu, 25 Feb 2016 01:28:26 +1100
Message-Id: <1456324115-21144-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support the new -mprofile-kernel ABI, we need to be able to
call from the module back to ftrace_caller() (in the kernel) without
using the module's r2. That is because the function in this module which
is calling ftrace_caller() may not have setup r2, if it doesn't
otherwise need it (ie. it accesses no globals).

To make that work we add a new stub which is used for calling
ftrace_caller(), which uses the kernel toc instead of the module toc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/module_64.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9629966e614b..e711d40a3b8f 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -671,10 +671,56 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#define PACATOC offsetof(struct paca_struct, kernel_toc)
+
+static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
+{
+	struct ppc64_stub_entry *entry;
+	unsigned int i, num_stubs;
+	static u32 stub_insns[] = {
+		0xe98d0000 | PACATOC, 	/* ld      r12,PACATOC(r13)	*/
+		0x3d8c0000,		/* addis   r12,r12,<high>	*/
+		0x398c0000, 		/* addi    r12,r12,<low>	*/
+		0x7d8903a6, 		/* mtctr   r12			*/
+		0x4e800420, 		/* bctr				*/
+	};
+	long reladdr;
+
+	num_stubs = sechdrs[me->arch.stubs_section].sh_size / sizeof(*entry);
+
+	/* Find the next available stub entry */
+	entry = (void *)sechdrs[me->arch.stubs_section].sh_addr;
+	for (i = 0; i < num_stubs && stub_func_addr(entry->funcdata); i++, entry++);
+
+	if (i >= num_stubs) {
+		pr_err("%s: Unable to find a free slot for ftrace stub.\n", me->name);
+		return 0;
+	}
+
+	memcpy(entry->jump, stub_insns, sizeof(stub_insns));
+
+	/* Stub uses address relative to kernel_toc */
+	reladdr = (unsigned long)ftrace_caller - get_paca()->kernel_toc;
+	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
+		pr_err("%s: Address of ftrace_caller out of range of kernel_toc.\n", me->name);
+		return 0;
+	}
+
+	entry->jump[1] |= PPC_HA(reladdr);
+	entry->jump[2] |= PPC_LO(reladdr);
+
+	/* Eventhough we don't use funcdata in the stub, it's needed elsewhere. */
+	entry->funcdata = func_desc((unsigned long)ftrace_caller);
+	entry->magic = STUB_MAGIC;
+
+	return (unsigned long)entry;
+}
+
 int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
 {
 	mod->arch.toc = my_r2(sechdrs, mod);
-	mod->arch.tramp = stub_for_addr(sechdrs, (unsigned long)ftrace_caller, mod);
+	mod->arch.tramp = create_ftrace_stub(sechdrs, mod);
 
 	if (!mod->arch.tramp)
 		return -ENOENT;
-- 
2.5.0
