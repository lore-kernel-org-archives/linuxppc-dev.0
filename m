Message-ID: <3E4D3804.4080503@mvista.com>
Date: Fri, 14 Feb 2003 11:40:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for 745x cache invalidate (in bootwrapper)
Content-Type: multipart/mixed;
 boundary="------------000802020703010304000308"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000802020703010304000308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There are some differences in the L2CR register between the 75x/74x0 and
the 745x processors that weren't accounted for in the arch/ppc/boot/...
bootwrapper code.  Also, there was no bootwrapper code to turn off L3
cache on 745x processors.

The attached patch does the following:
a) Modify arch/ppc/boot/common/util.S:_setup_L2CR to poll on the proper
bit when doing an L2 global invalidate.  On 75x & 74x0 processors, that
means polling the L2IP bit; on 745x processors, that means polling on
the L2I bit.  BTW, the code is already correct in arch/ppc/kernel/l2cr.S.
b) Add arch/ppc/boot/common/util.S:_setup_l3CR routine which turns off
L3 cache and does a global invalidate on it.
c) Modify arch/ppc/boot/simple/head.S:start_ to call _setup_L3CR if
running on a 745x processor.  This is #ifdef'd out for all platforms
except CONFIG_FORCE, CONFIG_K2, CONFIG_EV64260, and CONFIG_PAL4--the
#ifdef was already there.

This patch has been successfully tested on a few platforms inside
MontaVista.  However, those of you that use the bootwrapper on 745x
platforms may want to test it as well.  If you do test it, please
respond to this email with your results.  If there are no responses by
mid-week next week, say, I will assume the patch is fine and ask that it
get applied to the public linuxppc_2_4_devel source.

Thanks,

Mark

--------------000802020703010304000308
Content-Type: text/plain;
 name="745x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="745x.patch"

===== arch/ppc/boot/common/util.S 1.10 vs edited =====
--- 1.10/arch/ppc/boot/common/util.S	Wed Feb 12 13:34:20 2003
+++ edited/arch/ppc/boot/common/util.S	Fri Feb 14 10:01:45 2003
@@ -100,7 +100,7 @@
 	isync
 	mfspr	r8,L2CR
 	rlwinm	r8,r8,0,1,31
-	oris	r8,r8,0x0020
+	oris	r8,r8,L2CR_L2I@h
 	sync
 	isync
 	mtspr	L2CR,r8
@@ -108,14 +108,51 @@
 	isync

 	/* Wait for the invalidation to complete */
-1:	mfspr	r8,L2CR
-	rlwinm.	r9,r8,0,31,31
+	mfspr   r8,PVR
+	srwi    r8,r8,16
+	cmplwi  r8,(PVR_7450 >> 16)
+	bne     2f
+
+1:	mfspr	r8,L2CR		/* On 745x, poll L2I bit (bit 10) */
+	rlwinm.	r9,r8,0,10,10
 	bne	1b
+	b	3f
+
+2:      mfspr   r8,L2CR		/* On 75x & 74x0, poll L2IP bit (bit 31) */
+	rlwinm. r9,r8,0,31,31
+	bne     2b

-	rlwinm	r8,r8,0,11,9		/* Turn off L2I bit */
+3:	rlwinm	r8,r8,0,11,9	/* Turn off L2I bit */
 	sync
 	isync
 	mtspr	L2CR,r8
+	sync
+	isync
+	blr
+
+	.globl	_setup_L3CR
+_setup_L3CR:
+	/* Invalidate/disable L3 cache */
+	sync
+	isync
+	mfspr	r8,L3CR
+	rlwinm	r8,r8,0,1,31
+	ori	r8,r8,L3CR_L3I@l
+	sync
+	isync
+	mtspr	L3CR,r8
+	sync
+	isync
+
+	/* Wait for the invalidation to complete */
+1:	mfspr	r8,L3CR
+	rlwinm.	r9,r8,0,21,21
+	bne	1b
+
+	rlwinm	r8,r8,0,22,20		/* Turn off L3I bit */
+	sync
+	isync
+	mtspr	L3CR,r8
 	sync
 	isync
 	blr
===== arch/ppc/boot/simple/head.S 1.7 vs edited =====
--- 1.7/arch/ppc/boot/simple/head.S	Tue Jan 14 08:45:33 2003
+++ edited/arch/ppc/boot/simple/head.S	Thu Feb 13 17:20:30 2003
@@ -76,6 +76,14 @@
 #if defined(CONFIG_FORCE) || defined(CONFIG_K2)		\
 	|| defined(CONFIG_EV64260) || defined(CONFIG_PAL4)
 	bl	_setup_L2CR
+
+	/* If 745x, turn off L3CR as well */
+	mfspr	r8,PVR
+	srwi	r8,r8,16
+	cmplwi	r8,(PVR_7450 >> 16)
+	bne	1f
+	bl	_setup_L3CR
+1:
 #endif
 #endif


--------------000802020703010304000308--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
