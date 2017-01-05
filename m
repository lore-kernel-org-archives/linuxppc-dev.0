Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvZVf2wl3zDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 04:31:54 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05HTk0H055608
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 12:31:51 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27srbxeega-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 12:31:51 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 Jan 2017 03:31:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5EEF53578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 04:31:46 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05HVkfg5243314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 04:31:46 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05HVjBx031994
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 04:31:46 +1100
Subject: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, ebiederm@xmission.com,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 vgoyal@redhat.com
Date: Thu, 05 Jan 2017 23:01:39 +0530
In-Reply-To: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get rid of multiple definitions of append_elf_note() & final_note()
functions. Reuse these functions compiled under CONFIG_CRASH_CORE
Also, define Elf_Word and use it instead of generic u32 or the more
specific Elf64_Word.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes from v3:
* Dropped hard-coded values and used DIV_ROUND_UP().

Changes from v2:
* Added a definition for Elf_Word.
* Used IA64 version of append_elf_note() and final_note() functions.


 arch/ia64/kernel/crash.c   |   22 ----------------------
 include/linux/crash_core.h |    4 ++++
 include/linux/elf.h        |    2 ++
 kernel/crash_core.c        |   34 ++++++++++++++--------------------
 kernel/kexec_core.c        |   28 ----------------------------
 5 files changed, 20 insertions(+), 70 deletions(-)

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
index 18d0f94..541a197 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -55,6 +55,10 @@ extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 extern size_t vmcoreinfo_size;
 extern size_t vmcoreinfo_max_size;
 
+Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
+			  void *data, size_t data_len);
+void final_note(Elf_Word *buf);
+
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 20fa8d8..ba069e8 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -29,6 +29,7 @@ extern Elf32_Dyn _DYNAMIC [];
 #define elf_note	elf32_note
 #define elf_addr_t	Elf32_Off
 #define Elf_Half	Elf32_Half
+#define Elf_Word	Elf32_Word
 
 #else
 
@@ -39,6 +40,7 @@ extern Elf64_Dyn _DYNAMIC [];
 #define elf_note	elf64_note
 #define elf_addr_t	Elf64_Off
 #define Elf_Half	Elf64_Half
+#define Elf_Word	Elf64_Word
 
 #endif
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 80b441d..362dace 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -291,32 +291,26 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned int type,
-			    void *data, size_t data_len)
+Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
+			  void *data, size_t data_len)
 {
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
+	struct elf_note *note = (struct elf_note *)buf;
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = data_len;
+	note->n_type   = type;
+	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
+	memcpy(buf, name, note->n_namesz);
+	buf += DIV_ROUND_UP(note->n_namesz, sizeof(Elf_Word));
+	memcpy(buf, data, data_len);
+	buf += DIV_ROUND_UP(data_len, sizeof(Elf_Word));
 
 	return buf;
 }
 
-static void final_note(u32 *buf)
+void final_note(Elf_Word *buf)
 {
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
+	memset(buf, 0, sizeof(struct elf_note));
 }
 
 static void update_vmcoreinfo_note(void)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2179a16..263d764 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -990,34 +990,6 @@ int crash_shrink_memory(unsigned long new_size)
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
