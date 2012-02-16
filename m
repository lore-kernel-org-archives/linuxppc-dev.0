Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDBE0B6FBA
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 22:16:25 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 16 Feb 2012 16:46:23 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1GBFkks4006046
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 16:45:46 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1GBFiKp014659
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 16:45:45 +0530
Subject: [RFC PATCH v7 06/10] fadump: Add PT_NOTE program header for vmcoreinfo
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2012 16:44:53 +0530
Message-ID: <20120216111452.4733.91579.stgit@mars>
In-Reply-To: <20120216111050.4733.38034.stgit@mars>
References: <20120216111050.4733.38034.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>,
 Kexec-ml <kexec@lists.infradead.org>, Milton Miller <miltonm@bga.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
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
index cab56e7..5689954 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -814,6 +814,19 @@ static void fadump_setup_crash_memory_ranges(void)
 	}
 }
 
+/*
+ * If the given physical address falls within the boot memory region then
+ * return the relocated address that points to the dump region reserved
+ * for saving initial boot memory contents.
+ */
+static inline unsigned long fadump_relocate(unsigned long paddr)
+{
+	if (paddr > RMA_START && paddr < fw_dump.boot_memory_size)
+		return fdm.rmr_region.destination_address + paddr;
+	else
+		return paddr;
+}
+
 static int fadump_create_elfcore_headers(char *bufp)
 {
 	struct elfhdr *elf;
@@ -845,6 +858,22 @@ static int fadump_create_elfcore_headers(char *bufp)
 
 	(elf->e_phnum)++;
 
+	/* setup ELF PT_NOTE for vmcoreinfo */
+	phdr = (struct elf_phdr *)bufp;
+	bufp += sizeof(struct elf_phdr);
+	phdr->p_type	= PT_NOTE;
+	phdr->p_flags	= 0;
+	phdr->p_vaddr	= 0;
+	phdr->p_align	= 0;
+
+	phdr->p_paddr	= fadump_relocate(paddr_vmcoreinfo_note());
+	phdr->p_offset	= phdr->p_paddr;
+	phdr->p_memsz	= vmcoreinfo_max_size;
+	phdr->p_filesz	= vmcoreinfo_max_size;
+
+	/* Increment number of program headers. */
+	(elf->e_phnum)++;
+
 	/* setup PT_LOAD sections. */
 
 	for (i = 0; i < crash_mem_ranges; i++) {
