Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] spufs: Fix endless protection fault on LS writes by SPE.
Date: Fri, 24 Mar 2006 19:49:27 +0100
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
In-Reply-To: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241949.28218.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <abergman@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If an SPE attempts a DMA put to a local store after already doing
a get, the kernel must update the HW PTE to allow the write access.
This case was not being handled correctly.

From: Mike Kistler <mkistler@us.ibm.com>
Signed-off-by: Mike Kistler <mkistler@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
diff -ur linux-2.6.15/arch/powerpc/platforms/cell/spu_base.c linux-2.6.15.fixed/arch/powerpc/platforms/cell/spu_base.c
--- linux-2.6.15/arch/powerpc/platforms/cell/spu_base.c	2006-03-22 12:30:07.000000000 -0600
+++ linux-2.6.15.fixed/arch/powerpc/platforms/cell/spu_base.c	2006-03-22 10:21:26.000000000 -0600
@@ -486,14 +486,13 @@
 
 	ea = spu->dar;
 	dsisr = spu->dsisr;
-	if (dsisr & MFC_DSISR_PTE_NOT_FOUND) {
+	if (dsisr & (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED)) {
 		access = (_PAGE_PRESENT | _PAGE_USER);
 		access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
 		if (hash_page(ea, access, 0x300) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
 	}
-	if ((error & CLASS1_ENABLE_STORAGE_FAULT_INTR) ||
-	    (dsisr & MFC_DSISR_ACCESS_DENIED)) {
+	if (error & CLASS1_ENABLE_STORAGE_FAULT_INTR) {
 		if ((ret = spu_handle_mm_fault(spu)) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
 		else
