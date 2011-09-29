Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DC4B1007E0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 01:08:22 +1000 (EST)
Received: from /spool/local by in.ibm.com with XMail ESMTP
	for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
	Thu, 29 Sep 2011 20:38:21 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8TF8IU73526854
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 20:38:18 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8U1acZ6016121
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 07:06:38 +0530
Subject: [RFC PATCH v2 06/10] fadump: Add PT_NOTE program header for vmcoreinfo
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 29 Sep 2011 20:37:44 +0530
Message-ID: <20110929150744.26689.43842.stgit@mars.in.ibm.com>
In-Reply-To: <20110929150117.26689.62053.stgit@mars.in.ibm.com>
References: <20110929150117.26689.62053.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>, Milton Miller <miltonm@bga.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Introduce a PT_NOTE program header that points to physical address of
vmcoreinfo_note buffer declared in kernel/kexec.c. The vmcoreinfo
note buffer is populated during crash_fadump() at the time of system
crash.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d7c8767..13c830c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -772,6 +772,19 @@ static void setup_crash_memory_ranges(void)
 	}
 }
 
+/*
+ * If the given physical address falls within the boot memory region then
+ * return the relocated address that points to the dump region reserved
+ * for saving initial boot memory contents.
+ */
+static inline unsigned long relocate(unsigned long paddr)
+{
+	if (paddr > RMR_START && paddr < fw_dump.boot_memory_size)
+		return fdm.rmr_region.destination_address + paddr;
+	else
+		return paddr;
+}
+
 static int create_elfcore_headers(char *bufp)
 {
 	struct elfhdr *elf;
@@ -804,6 +817,22 @@ static int create_elfcore_headers(char *bufp)
 	/* Increment number of program headers. */
 	(elf->e_phnum)++;
 
+	/* setup ELF PT_NOTE for vmcoreinfo */
+	phdr = (struct elf_phdr *)bufp;
+	bufp += sizeof(struct elf_phdr);
+	phdr->p_type	= PT_NOTE;
+	phdr->p_flags	= 0;
+	phdr->p_vaddr	= 0;
+	phdr->p_align	= 0;
+
+	phdr->p_paddr	= relocate(paddr_vmcoreinfo_note());
+	phdr->p_offset	= phdr->p_paddr;
+	phdr->p_memsz	= vmcoreinfo_max_size;
+	phdr->p_filesz	= vmcoreinfo_max_size;
+
+	/* Increment number of program headers. */
+	(elf->e_phnum)++;
+
 	/* setup PT_LOAD sections. */
 
 	for (i = 0; i < crash_mem_ranges; i++) {
