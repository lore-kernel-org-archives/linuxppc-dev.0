Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2483867B55
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 17:49:57 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7S98p83014788
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 03:08:51 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7S7nrDx003598
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 02:49:54 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [QUESTION] Enable coherency for all pages on 83xx to fix PCI data
	corruption
Date: Mon, 28 Aug 2006 15:49:51 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511B945@zch01exm21.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

I want to know which PCI errata is solved by this patch
and if this patch did test on real hardware.

I know this patch turn on the 'M' bit -memory coherency.
But I don't believe this can solved the "PCI read multi-line"
errata.

-DAve

http://ozlabs.org/pipermail/linuxppc-dev/2006-February/021267.html

On the 83xx platform to ensure the PCI inbound memory is handled
properly we
have to turn on coherency for all pages in the MMU.  Otherwise we see
corruption if inbound "prefetching/streaming" is enabled on the PCI
controller.

Signed-off-by: Randy Vinson <rvinson at mvista.com>
Signed-off-by: Kumar Gala <galak at kernel.crashing.org>

---

(For 2.6.16 if we can get it in)

commit 4b2f4b1585f15d1c30cd2eda6d5f9a2ca7dcf998
tree 7aebf508d10127831cf92fb7ce919230924ad85d
parent 7cfb7344aae902edfd5d51dd5f734cbf2585649c
author Kumar Gala <galak at kernel.crashing.org> Wed, 22 Feb 2006
09:53:34 -0600
committer Kumar Gala <galak at kernel.crashing.org> Wed, 22 Feb 2006
09:53:34 -0600

 include/asm-powerpc/cputable.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-powerpc/cputable.h
b/include/asm-powerpc/cputable.h
index 6421054..90d005b 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -159,9 +159,11 @@ extern void do_cpu_ftr_fixups(unsigned l
 #endif
=20
 /* We need to mark all pages as being coherent if we're SMP or we
- * have a 74[45]x and an MPC107 host bridge.
+ * have a 74[45]x and an MPC107 host bridge. Also 83xx requires
+ * it for PCI "streaming/prefetch" to work properly.
  */
-#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
+#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
+	|| defined(CONFIG_PPC_83xx)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
 #define CPU_FTR_COMMON                  0
@@ -277,7 +279,8 @@ enum {
 	CPU_FTRS_G2_LE =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE
|
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
CPU_FTR_HAS_HIGH_BATS,
 	CPU_FTRS_E300 =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE
|
-	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
CPU_FTR_HAS_HIGH_BATS,
+	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
CPU_FTR_HAS_HIGH_BATS |
+	    CPU_FTR_COMMON,
 	CPU_FTRS_CLASSIC32 =3D CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	CPU_FTRS_POWER3_32 =3D CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
