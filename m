Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18119.42120.893384.555002@cargo.ozlabs.ibm.com>
Date: Sun, 19 Aug 2007 12:01:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: 2.6.23-rc3 broken on G5
In-Reply-To: <jey7g9i3qk.fsf@sykes.suse.de>
References: <jelkccftt6.fsf@sykes.suse.de>
	<18116.52843.212978.281399@cargo.ozlabs.ibm.com>
	<jefy2j6qtq.fsf@sykes.suse.de>
	<18118.41979.148016.177427@cargo.ozlabs.ibm.com>
	<jey7g9i3qk.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> 1.25 GB.  It also has an nvidia gfx card, in case it matters.

Could you try this patch and see if it fixes it?  It puts the code
back to being a bit closer to what it was before.

Paul.

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a73d2d7..1cef209 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -226,8 +226,12 @@ void slb_initialize(void)
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+	asm volatile("isync":::"memory");
+	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+	asm volatile("isync; slbia; isync":::"memory");
+
 	slb_shadow_update(PAGE_OFFSET, lflags, 0);
-	asm volatile("isync; slbia; sync; slbmte  %0,%1; isync" ::
+	asm volatile("slbmte  %0,%1; isync" ::
 		     "r" (get_slb_shadow()->save_area[0].vsid),
 		     "r" (get_slb_shadow()->save_area[0].esid) : "memory");
 
