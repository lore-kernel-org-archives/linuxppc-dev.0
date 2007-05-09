Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 15:20:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Loeliger Jon-LOELIGER <jdl@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>, jdl@jdl.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Olof Johansson <olof@lixom.net>, arnd@ardnb.de,
	Tabi Timur-B04825 <timur@freescale.com>
Subject: Re: Current powerpc.git build failures
Message-ID: <20070509052037.GA9781@localhost.localdomain>
References: <20070508191758.GA26879@lixom.net>
	<20070509010941.GC4198@localhost.localdomain>
	<AF0367BA48C55940A43CCF08DF35553C012AA6B2@az33exm24.fsl.freescale.net>
	<20070509015146.GF4198@localhost.localdomain>
	<20070509015753.GH4198@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070509015753.GH4198@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 09, 2007 at 11:57:54AM +1000, David Gibson wrote:
> On Wed, May 09, 2007 at 11:51:46AM +1000, David Gibson wrote:
> > On Tue, May 08, 2007 at 06:18:29PM -0700, Jon Loeliger wrote:
> > > > Looks like.  AFAICT, the generic nopud.h and nopmd.h headers expect
> > > > page.h to be included before pgtable.h.  I think this patch should fix
> > > > the problem, but I don't have a suitable board to test with.
> > > > 
> > > 
> > > That would be me.  I'll give it a spin.
> > 
> > Duh, of course, I wasn't thinking at that point and realizing I could
> > at least test the build was fixed.  Which I've now done; and found
> > some other warnings caused by my patch.  Improved fix below.  Unless
> > you report that it breaks something, I'll ask Paul to pull it.
> 
> Gah, sorry.  Really below, this time:

Double gah.  How about the *right* patch this time.

Further fixes for the removal of 4level-fixup hack from ppc32

Commit d1953c8888ef034b912ee33bc2ea2cce6a414402 removed the use of
4level-fixup.h for 32-bit systems under arch/powerpc.  However, I
missed a few things activated on some configurations, resulting in
some warnings (at least with STRICT_MM_TYPECHECKS enabled) and build
errors in some circumstances.  Fixes below.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/platforms/86xx/mpc86xx_smp.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_smp.c	2007-05-09 11:08:15.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/86xx/mpc86xx_smp.c	2007-05-09 11:08:33.000000000 +1000
@@ -15,8 +15,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/pci-bridge.h>
 #include <asm-powerpc/mpic.h>
 #include <asm/mpc86xx.h>
Index: working-2.6/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/ppc_mmu_32.c	2007-05-09 11:30:22.000000000 +1000
+++ working-2.6/arch/powerpc/mm/ppc_mmu_32.c	2007-05-09 11:31:09.000000000 +1000
@@ -185,7 +185,7 @@ void hash_preload(struct mm_struct *mm, 
 
 	if (Hash == 0)
 		return;
-	pmd = pmd_offset(pgd_offset(mm, ea), ea);
+	pmd = pmd_offset(pud_offset(pgd_offset(mm, ea), ea), ea);
 	if (!pmd_none(*pmd))
 		add_hash_page(mm->context.id, ea, pmd_val(*pmd));
 }
Index: working-2.6/arch/powerpc/mm/tlb_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/tlb_32.c	2007-05-09 11:31:52.000000000 +1000
+++ working-2.6/arch/powerpc/mm/tlb_32.c	2007-05-09 11:32:17.000000000 +1000
@@ -111,7 +111,7 @@ static void flush_range(struct mm_struct
 	if (start >= end)
 		return;
 	end = (end - 1) | ~PAGE_MASK;
-	pmd = pmd_offset(pgd_offset(mm, start), start);
+	pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);
 	for (;;) {
 		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
 		if (pmd_end > end)
@@ -169,7 +169,7 @@ void flush_tlb_page(struct vm_area_struc
 		return;
 	}
 	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
-	pmd = pmd_offset(pgd_offset(mm, vmaddr), vmaddr);
+	pmd = pmd_offset(pud_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr);
 	if (!pmd_none(*pmd))
 		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 	FINISH_FLUSH;


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
