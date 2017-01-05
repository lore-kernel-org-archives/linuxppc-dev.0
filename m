Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvZWF2MTZzDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 04:32:25 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05HVkHG083980
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 12:32:23 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27srbfx7wq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 12:32:23 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 Jan 2017 03:32:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A48A62BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 04:32:17 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05HWJCv55967774
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 04:32:19 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05HWGTV032477
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 04:32:17 +1100
Subject: [PATCH v4 3/5] powerpc/fadump: remove dependency with CONFIG_KEXEC
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, ebiederm@xmission.com,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 vgoyal@redhat.com
Date: Thu, 05 Jan 2017 23:02:09 +0530
In-Reply-To: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148363751120.11570.5394055766937537863.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that crashkernel parameter parsing and vmcoreinfo related code is
moved under CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE, remove
dependency with CONFIG_KEXEC for CONFIG_FA_DUMP. While here, get rid
of definitions of fadump_append_elf_note() & fadump_final_note()
functions to reuse similar functions compiled under CONFIG_CRASH_CORE.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig               |   10 ++++++----
 arch/powerpc/include/asm/fadump.h  |    2 ++
 arch/powerpc/kernel/crash.c        |    2 --
 arch/powerpc/kernel/fadump.c       |   34 +++-------------------------------
 arch/powerpc/kernel/setup-common.c |    5 +++++
 5 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a8ee573..b9726be 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -513,21 +513,23 @@ config RELOCATABLE_TEST
 	  relocation code.
 
 config CRASH_DUMP
-	bool "Build a kdump crash kernel"
+	bool "Build a dump capture kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
 	select RELOCATABLE if (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
 	help
-	  Build a kernel suitable for use as a kdump capture kernel.
+	  Build a kernel suitable for use as a dump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
 	  capture kernel.
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-	depends on PPC64 && PPC_RTAS && CRASH_DUMP && KEXEC_CORE
+	depends on PPC64 && PPC_RTAS
+	select CRASH_CORE
+	select CRASH_DUMP
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
-	  instead firmware assists in booting the kdump kernel
+	  instead firmware assists in booting the capture kernel
 	  while preserving memory contents. Firmware-assisted dump
 	  is meant to be a kdump replacement offering robustness and
 	  speed not possible without system firmware assistance.
diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 0031806..60b9108 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -73,6 +73,8 @@
 	reg_entry++;							\
 })
 
+extern int crashing_cpu;
+
 /* Kernel Dump section info */
 struct fadump_section {
 	__be32	request_flag;
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 47b63de..cbabb5a 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -43,8 +43,6 @@
 #define IPI_TIMEOUT		10000
 #define REAL_MODE_TIMEOUT	10000
 
-/* This keeps a track of which one is the crashing cpu. */
-int crashing_cpu = -1;
 static int time_to_dump;
 
 #define CRASH_HANDLER_MAX 3
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8f0c7c5..db0b339 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -486,34 +486,6 @@ fadump_read_registers(struct fadump_reg_entry *reg_entry, struct pt_regs *regs)
 	return reg_entry;
 }
 
-static u32 *fadump_append_elf_note(u32 *buf, char *name, unsigned type,
-						void *data, size_t data_len)
-{
-	struct elf_note note;
-
-	note.n_namesz = strlen(name) + 1;
-	note.n_descsz = data_len;
-	note.n_type   = type;
-	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) + 3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
-	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
-
-	return buf;
-}
-
-static void fadump_final_note(u32 *buf)
-{
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
-}
-
 static u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 {
 	struct elf_prstatus prstatus;
@@ -524,8 +496,8 @@ static u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 	 * prstatus.pr_pid = ????
 	 */
 	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
-	buf = fadump_append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
-				&prstatus, sizeof(prstatus));
+	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+			      &prstatus, sizeof(prstatus));
 	return buf;
 }
 
@@ -666,7 +638,7 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 			note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
 		}
 	}
-	fadump_final_note(note_buf);
+	final_note(note_buf);
 
 	if (fdh) {
 		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f516ac5..60badb1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -116,6 +116,11 @@ int ppc_do_canonicalize_irqs;
 EXPORT_SYMBOL(ppc_do_canonicalize_irqs);
 #endif
 
+#ifdef CONFIG_CRASH_CORE
+/* This keeps a track of which one is the crashing cpu. */
+int crashing_cpu = -1;
+#endif
+
 /* also used by kexec */
 void machine_shutdown(void)
 {
