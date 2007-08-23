Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18126.6446.158988.391247@cargo.ozlabs.ibm.com>
Date: Fri, 24 Aug 2007 09:33:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: 2.6.23-rc3 broken on G5
In-Reply-To: <jetzqvk9of.fsf@sykes.suse.de>
References: <jelkccftt6.fsf@sykes.suse.de>
	<18116.52843.212978.281399@cargo.ozlabs.ibm.com>
	<jefy2j6qtq.fsf@sykes.suse.de>
	<18118.41979.148016.177427@cargo.ozlabs.ibm.com>
	<jey7g9i3qk.fsf@sykes.suse.de>
	<18119.42120.893384.555002@cargo.ozlabs.ibm.com>
	<jetzqvk9of.fsf@sykes.suse.de>
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

> That didn't change anything visibly.

OK, please try this one and let me know if it fixes it.

Paul.

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a73d2d7..1ca87eb 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -89,7 +89,7 @@ void slb_flush_and_rebolt(void)
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
-	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET) {
+	if ((ksp_esid_data & ESID_MASK) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
 		slb_shadow_clear(2);
 	} else {
