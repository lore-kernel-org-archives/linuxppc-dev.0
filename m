Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D35E4B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 19:50:58 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id p6C9WixV006944
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 15:02:44 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6C9ofSg1503354
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 15:20:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6C9oeAM008583
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 19:50:41 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] [v3] kexec-tools: ppc32: Fixup ThreadPointer for purgatory
	code
To: Simon Horman<horms@verge.net.au>
Date: Tue, 12 Jul 2011 15:20:40 +0530
Message-ID: <20110712095029.18466.30735.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>, kexec <kexec@lists.infradead.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC32 ELF ABI expects r2 to be loaded with Thread Pointer, which is 0x7000
bytes past the end of TCB. Though the purgatory is single threaded, it uses
TCB scratch space in vsnprintf(). This patch allocates a 1024byte TCB
and populates the TP with the address accordingly.

Changes from V2: Avoid address overflow in TP allocation.
Changes from V1: Fixed the addr calculation for uImage support.


Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: Ryan S. Arnold <rsa@us.ibm.com>
---

 kexec/arch/ppc/kexec-elf-ppc.c     |   19 +++++++++++++++++++
 kexec/arch/ppc/kexec-uImage-ppc.c  |   17 +++++++++++++++++
 purgatory/arch/ppc/purgatory-ppc.c |    2 +-
 purgatory/arch/ppc/v2wrap_32.S     |    4 ++++
 4 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index f4443b4..ecbbbeb 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -414,6 +414,25 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	elf_rel_set_symbol(&info->rhdr, "stack", &addr, sizeof(addr));
 #undef PUL_STACK_SIZE
 
+	/*
+	 * Fixup ThreadPointer(r2) for purgatory.
+	 * PPC32 ELF ABI expects : 
+	 * ThreadPointer (TP) = TCB + 0x7000
+	 * We manually allocate a TCB space and set the TP
+	 * accordingly.
+	 */
+#define TCB_SIZE 1024
+#define TCB_TP_OFFSET 0x7000	/* PPC32 ELF ABI */
+
+	addr = locate_hole(info, TCB_SIZE, 0, 0,
+				((unsigned long)elf_max_addr(&ehdr) - TCB_TP_OFFSET),
+				1);
+	addr += TCB_SIZE + TCB_TP_OFFSET;
+	elf_rel_set_symbol(&info->rhdr, "my_thread_ptr", &addr, sizeof(addr));
+
+#undef TCB_SIZE
+#undef TCB_TP_OFFSET
+
 	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
 	info->entry = (void *)addr;
 #endif
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 1d71374..216c82d 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -228,6 +228,23 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	/* No allocation past here in order not to overwrite the stack */
 #undef PUL_STACK_SIZE
 
+	/*
+	 * Fixup ThreadPointer(r2) for purgatory.
+	 * PPC32 ELF ABI expects : 
+	 * ThreadPointer (TP) = TCB + 0x7000
+	 * We manually allocate a TCB space and set the TP
+	 * accordingly.
+	 */
+#define TCB_SIZE 	1024
+#define TCB_TP_OFFSET 	0x7000	/* PPC32 ELF ABI */
+	addr = locate_hole(info, TCB_SIZE, 0, 0,
+				((unsigned long)-1 - TCB_TP_OFFSET),
+				1);
+	addr += TCB_SIZE + TCB_TP_OFFSET;
+	elf_rel_set_symbol(&info->rhdr, "my_thread_ptr", &addr, sizeof(addr));
+#undef TCB_TP_OFFSET
+#undef TCB_SIZE
+
 	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
 	info->entry = (void *)addr;
 
diff --git a/purgatory/arch/ppc/purgatory-ppc.c b/purgatory/arch/ppc/purgatory-ppc.c
index 349e750..3e6b354 100644
--- a/purgatory/arch/ppc/purgatory-ppc.c
+++ b/purgatory/arch/ppc/purgatory-ppc.c
@@ -26,7 +26,7 @@ unsigned int panic_kernel = 0;
 unsigned long backup_start = 0;
 unsigned long stack = 0;
 unsigned long dt_offset = 0;
-unsigned long my_toc = 0;
+unsigned long my_thread_ptr = 0;
 unsigned long kernel = 0;
 
 void setup_arch(void)
diff --git a/purgatory/arch/ppc/v2wrap_32.S b/purgatory/arch/ppc/v2wrap_32.S
index 8442d16..8b60677 100644
--- a/purgatory/arch/ppc/v2wrap_32.S
+++ b/purgatory/arch/ppc/v2wrap_32.S
@@ -56,6 +56,10 @@ master:
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
 
+	lis	6,my_thread_ptr@h
+	ori	6,6,my_thread_ptr@l
+	lwz	2,0(6)		# setup ThreadPointer(TP)
+
 	lis	6,stack@h
 	ori	6,6,stack@l
 	lwz     1,0(6)          #setup stack
