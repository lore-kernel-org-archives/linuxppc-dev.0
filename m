Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08B30DDEFC
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 01:30:35 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
Date: Wed, 18 Jul 2007 17:30:19 +0200
Message-Id: <11847726193856-git-send-email-segher@kernel.crashing.org>
Message-Id: <5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some old software on ppc32 executes from pages it hasn't marked
executable.  Since "classic" hardware doesn't distinguish between
execute and read accesses, the do_page_fault() code shouldn't
either.  This makes glibc-2.2 work again on such hardware.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
[Resend again, ozlabs' greylisting doesn't like me at all.]

Tested by Scott on 32-bit, glibc-2.2.5 and glibc-2.3.3 (no new
failures and problem solved), and by Johannes on his glibc-2.4
"---p" testcase.  Could use testing on ppc64 and BookE too, for
good measure.

This reverts the previous change and makes the bugfix behave
more like the arch/ppc code.
 arch/powerpc/mm/fault.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 115b25f..5d7add0 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -278,14 +278,17 @@ good_area:
 		goto bad_area;
 #endif /* CONFIG_8xx */
 
+#ifdef CONFIG_PPC64
 	if (is_exec) {
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 		/* protection fault */
 		if (error_code & DSISR_PROTFAULT)
 			goto bad_area;
 		if (!(vma->vm_flags & VM_EXEC))
 			goto bad_area;
-#else
+	} else
+		/* A read or write, code continues below...  */
+#elsif defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+	if (is_exec) {
 		pte_t *ptep;
 		pmd_t *pmdp;
 
@@ -310,9 +313,12 @@ good_area:
 			}
 			pte_unmap_unlock(ptep, ptl);
 		}
+	} else
+		/* A read or write, code continues below...  */
 #endif
-	/* a write */
-	} else if (is_write) {
+
+	/* A read or write.  Classic PPC32 execute is considered a read.  */
+	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	/* a read */
-- 
1.5.2.1.144.gabc40-dirty
