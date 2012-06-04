Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 15:42:13 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, olof@lixom.net,
 michael@ellerman.id.au
Subject: [PATCH 1/5] powerpc/pseries: Disable interrupts around IOMMU percpu
 data accesses
Message-ID: <20120604154213.173feecb@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


tce_buildmulti_pSeriesLP uses a per cpu page to communicate with the
hypervisor. We currently rely on the IOMMU table spinlock but
subsequent patches will be removing that so disable interrupts
around all accesses of tce_page.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/iommu.c	2012-06-04 10:25:34.420492862 +1000
+++ linux-build/arch/powerpc/platforms/pseries/iommu.c	2012-06-04 10:25:39.300597880 +1000
@@ -192,12 +192,15 @@ static int tce_buildmulti_pSeriesLP(stru
 	long l, limit;
 	long tcenum_start = tcenum, npages_start = npages;
 	int ret = 0;
+	unsigned long flags;
 
 	if (npages == 1) {
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 		                           direction, attrs);
 	}
 
+	local_irq_save(flags);	/* to protect tcep and the page behind it */
+
 	tcep = __get_cpu_var(tce_page);
 
 	/* This is safe to do since interrupts are off when we're called
@@ -207,6 +210,7 @@ static int tce_buildmulti_pSeriesLP(stru
 		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
+			local_irq_restore(flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -240,6 +244,8 @@ static int tce_buildmulti_pSeriesLP(stru
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
+	local_irq_restore(flags);
+
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
 		tce_freemulti_pSeriesLP(tbl, tcenum_start,
