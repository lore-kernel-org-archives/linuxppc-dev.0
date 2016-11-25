Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQDy0746qzDvxV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 22:54:16 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPBs6oC108346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 06:54:14 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26xj5g9t7q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 06:54:14 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 21:54:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9E9162CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 22:54:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAPBs74k52429014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 22:54:07 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAPBs6WE005208
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 22:54:07 +1100
Subject: [PATCH v2 2/5] ia64: reuse append_elf_note() and final_note()
 functions
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, ebiederm@xmission.com,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 vgoyal@redhat.com
Date: Fri, 25 Nov 2016 17:24:03 +0530
In-Reply-To: <148007477669.1053.4107773905913128028.stgit@hbathini.in.ibm.com>
References: <148007477669.1053.4107773905913128028.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148007484315.1053.12317233313990302812.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get rid of multiple definitions of append_elf_note() & final_note()
functions. Reuse these functions compiled under CONFIG_CRASH_CORE.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ia64/kernel/crash.c   |   22 ----------------------
 include/linux/crash_core.h |    4 ++++
 kernel/crash_core.c        |    6 +++---
 kernel/kexec_core.c        |   28 ----------------------------
 4 files changed, 7 insertions(+), 53 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 2955f35..75859a0 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -27,28 +27,6 @@ static int kdump_freeze_monarch;
 static int kdump_on_init = 1;
 static int kdump_on_fatal_mca = 1;
 
-static inline Elf64_Word
-*append_elf_note(Elf64_Word *buf, char *name, unsigned type, void *data,
-		size_t data_len)
-{
-	struct elf_note *note = (struct elf_note *)buf;
-	note->n_namesz = strlen(name) + 1;
-	note->n_descsz = data_len;
-	note->n_type   = type;
-	buf += (sizeof(*note) + 3)/4;
-	memcpy(buf, name, note->n_namesz);
-	buf += (note->n_namesz + 3)/4;
-	memcpy(buf, data, data_len);
-	buf += (data_len + 3)/4;
-	return buf;
-}
-
-static void
-final_note(void *buf)
-{
-	memset(buf, 0, sizeof(struct elf_note));
-}
-
 extern void ia64_dump_cpu_regs(void *);
 
 static DEFINE_PER_CPU(struct elf_prstatus, elf_prstatus);
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 9a4f4b0..2ae20b1 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -61,6 +61,10 @@ extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 extern size_t vmcoreinfo_size;
 extern size_t vmcoreinfo_max_size;
 
+u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
+		     void *data, size_t data_len);
+void final_note(u32 *buf);
+
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 60a98fc..9223976 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -291,8 +291,8 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
-			    void *data, size_t data_len)
+u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
+		     void *data, size_t data_len)
 {
 	struct elf_note note;
 
@@ -309,7 +309,7 @@ static u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
 	return buf;
 }
 
-static void final_note(u32 *buf)
+void final_note(u32 *buf)
 {
 	struct elf_note note;
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3aa21f3..596cb32 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -988,34 +988,6 @@ int crash_shrink_memory(unsigned long new_size)
 	return ret;
 }
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
-			    size_t data_len)
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
-static void final_note(u32 *buf)
-{
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
-}
-
 void crash_save_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;
