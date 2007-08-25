Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18127.40596.224163.488277@cargo.ozlabs.ibm.com>
Date: Sat, 25 Aug 2007 13:14:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [2.6.23 PATCH] Fix SLB initialization at boot time
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This partially reverts edd0622bd2e8f755c960827e15aa6908c3c5aa94.

It turns out that the part of that commit that aimed to ensure that we
created an SLB entry for the kernel stack on secondary CPUs when
starting the CPU didn't achieve its aim, and in fact caused a
regression, because get_paca()->kstack is not initialized at the point
where slb_initialize is called.

This therefore just reverts that part of that commit, while keeping
the change to slb_flush_and_rebolt, which is correct and necessary.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a73d2d7..ff1811a 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -74,6 +74,22 @@ static inline void slb_shadow_clear(unsigned long entry)
 	get_slb_shadow()->save_area[entry].esid = 0;
 }
 
+static inline void create_shadowed_slbe(unsigned long ea, unsigned long flags,
+					unsigned long entry)
+{
+	/*
+	 * Updating the shadow buffer before writing the SLB ensures
+	 * we don't get a stale entry here if we get preempted by PHYP
+	 * between these two statements.
+	 */
+	slb_shadow_update(ea, flags, entry);
+
+	asm volatile("slbmte  %0,%1" :
+		     : "r" (mk_vsid_data(ea, flags)),
+		       "r" (mk_esid_data(ea, entry))
+		     : "memory" );
+}
+
 void slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
@@ -226,12 +242,16 @@ void slb_initialize(void)
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
-	slb_shadow_update(PAGE_OFFSET, lflags, 0);
-	asm volatile("isync; slbia; sync; slbmte  %0,%1; isync" ::
-		     "r" (get_slb_shadow()->save_area[0].vsid),
-		     "r" (get_slb_shadow()->save_area[0].esid) : "memory");
-
-	slb_shadow_update(VMALLOC_START, vflags, 1);
-
-	slb_flush_and_rebolt();
+	asm volatile("isync":::"memory");
+	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+	asm volatile("isync; slbia; isync":::"memory");
+	create_shadowed_slbe(PAGE_OFFSET, lflags, 0);
+
+	create_shadowed_slbe(VMALLOC_START, vflags, 1);
+
+	/* We don't bolt the stack for the time being - we're in boot,
+	 * so the stack is in the bolted segment.  By the time it goes
+	 * elsewhere, we'll call _switch() which will bolt in the new
+	 * one. */
+	asm volatile("isync":::"memory");
 }
