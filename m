Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4Ms1fg7zDrMZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:16 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/24] powerpc/mm: Move exception_enter/exit to a
 do_page_fault wrapper
Date: Wed, 19 Jul 2017 14:49:23 +1000
Message-Id: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will allow simplifying the returns from do_page_fault

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4c422632047b..faddc87d0205 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -195,10 +195,9 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
  * The return value is 0 if the fault was handled, or the signal
  * number if this is a kernel fault that can't be handled here.
  */
-int do_page_fault(struct pt_regs *regs, unsigned long address,
-			    unsigned long error_code)
+static int __do_page_fault(struct pt_regs *regs, unsigned long address,
+			   unsigned long error_code)
 {
-	enum ctx_state prev_state = exception_enter();
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
@@ -523,6 +522,15 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	rc = SIGSEGV;
 
 bail:
+	return rc;
+}
+NOKPROBE_SYMBOL(__do_page_fault);
+
+int do_page_fault(struct pt_regs *regs, unsigned long address,
+		  unsigned long error_code)
+{
+	enum ctx_state prev_state = exception_enter();
+	int rc = __do_page_fault(regs, address, error_code);
 	exception_exit(prev_state);
 	return rc;
 }
-- 
2.13.3
