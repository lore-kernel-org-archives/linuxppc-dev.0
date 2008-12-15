Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:44:24 +1100
Subject: [PATCH 5/16] powerpc/mm: Add local_flush_tlb_mm() to SW loaded TLB
	implementations
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054523.2D75DDDFB0@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a local_flush_tlb_mm() call as a pre-requisite for some
SMP work for BookE processors

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/tlbflush.h |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-work.orig/arch/powerpc/include/asm/tlbflush.h	2008-12-03 14:33:02.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/tlbflush.h	2008-12-03 14:33:22.000000000 +1100
@@ -40,6 +40,11 @@ extern void _tlbil_va(unsigned long addr
 extern void _tlbia(void);
 #endif
 
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	_tlbil_pid(mm->context.id);
+}
+
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
 	_tlbil_pid(mm->context.id);
