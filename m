Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BB501007D6
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 20:56:10 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 7 Nov 2011 09:44:41 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA79u70J884970
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 20:56:07 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA79u7jj013406
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 20:56:07 +1100
Subject: [RFC PATCH v4 06/10] fadump: Add PT_NOTE program header for vmcoreinfo
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 07 Nov 2011 15:26:04 +0530
Message-ID: <20111107095603.1997.39898.stgit@mars.in.ibm.com>
In-Reply-To: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Amerigo Wang <amwang@redhat.com>, Milton Miller <miltonm@bga.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Anton Blanchard <anton@samba.org>
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
index 70d6287..e68ee3a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -816,6 +816,19 @@ static void setup_crash_memory_ranges(void)
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
@@ -847,6 +860,22 @@ static int create_elfcore_headers(char *bufp)
 
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
