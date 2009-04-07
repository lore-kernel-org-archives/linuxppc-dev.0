Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52418DDF4B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 13:21:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18906.50854.952483.793456@drongo.ozlabs.ibm.com>
Date: Tue, 7 Apr 2009 13:21:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix oops when loading modules
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a problem reported by Sean MacLennan where loading any
module would cause an oops.  We weren't marking the pages containing
the module text as having hardware execute permission, due to a bug
introduced in commit 8d1cf34e ("powerpc/mm: Tweak PTE bit combination
definitions"), hence trying to execute the module text caused an
exception on processors that support hardware execute permission.

This adds _PAGE_HWEXEC to the definitions of PAGE_KERNEL_X and
PAGE_KERNEL_ROX to fix this problem.

Reported-by: Sean MacLennan <smaclennan@pikatech.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/pte-common.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index d9740e8..a7e210b 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -151,9 +151,11 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 				 _PAGE_NO_CACHE)
 #define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
 				 _PAGE_NO_CACHE | _PAGE_GUARDED)
-#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC)
+#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC | \
+				 _PAGE_HWEXEC)
 #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
-#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC)
+#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC | \
+				 _PAGE_HWEXEC)
 
 /* Protection used for kernel text. We want the debuggers to be able to
  * set breakpoints anywhere, so don't write protect the kernel text
