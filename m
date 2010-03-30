Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E2EFB7CF8
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:00:17 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2U9uvkU006389
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 20:56:57 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2UA0GP01433840
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:00:16 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2UA0FKl028392
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:00:16 +1100
Date: Tue, 30 Mar 2010 15:29:25 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [Patch 1/2] PPC64-HWBKPT: Disable interrupts for data breakpoint
	exceptions
Message-ID: <20100330095925.GB14403@in.ibm.com>
References: <20100330095040.565675261@pr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Data address breakpoint exceptions are currently handled along with page-faults
which require interrupts to remain in enabled state. Since exception handling
for data breakpoints aren't pre-empt safe, we handle them separately.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   13 ++++++++++++-
 arch/powerpc/mm/fault.c              |    5 +++--
 2 files changed, 15 insertions(+), 3 deletions(-)

Index: linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/exceptions-64s.S
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
@@ -735,8 +735,11 @@ _STATIC(do_hash_page)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 
-	andis.	r0,r4,0xa450		/* weird error? */
+	andis.	r0,r4,0xa410		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
+	andis.  r0,r4,DSISR_DABRMATCH@h
+	bne-    handle_dabr_fault
+
 BEGIN_FTR_SECTION
 	andis.	r0,r4,0x0020		/* Is it a segment table fault? */
 	bne-	do_ste_alloc		/* If so handle it */
@@ -823,6 +826,14 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 	bl	.raw_local_irq_restore
 	b	11f
 
+/* We have a data breakpoint exception - handle it */
+handle_dabr_fault:
+	ld      r4,_DAR(r1)
+	ld      r5,_DSISR(r1)
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      .do_dabr
+	b       .ret_from_except_lite
+
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
 	ENABLE_INTS
Index: linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/mm/fault.c
+++ linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
@@ -151,13 +151,14 @@ int __kprobes do_page_fault(struct pt_re
 	if (!user_mode(regs) && (address >= TASK_SIZE))
 		return SIGSEGV;
 
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || \
+			     defined(CONFIG_PPC_BOOK3S_64))
   	if (error_code & DSISR_DABRMATCH) {
 		/* DABR match */
 		do_dabr(regs, address, error_code);
 		return 0;
 	}
-#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
+#endif
 
 	if (in_atomic() || mm == NULL) {
 		if (!user_mode(regs))
