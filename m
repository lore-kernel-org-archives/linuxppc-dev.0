Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 7034668737
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 12:26:10 +1100 (EST)
Date: Sun, 13 Nov 2005 02:26:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051113012608.GH21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<20051112215304.GB21448@stusta.de>
	<200511122257.05552.mbuesch@freenet.de>
	<20051112222045.GC21448@stusta.de>
	<1131834667.7406.49.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131834667.7406.49.camel@gaston>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] PPC_PREP: remove unneeded exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 13, 2005 at 09:31:06AM +1100, Benjamin Herrenschmidt wrote:
> 
> > ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> > any way.
> > 
> > _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.
> 
> Therse are old PREP stuffs
>...

Is the patch below OK?

> Ben.

cu
Adrian


<--  snip  -->


This patch removes the EXPORT_SYMBOL'ed but completely unused variable 
ucSystemType and removes the unneeded EXPORT_SYMBOL(_prep_type).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/powerpc/kernel/ppc_ksyms.c |    5 -----
 arch/ppc/kernel/ppc_ksyms.c     |    4 ----
 arch/ppc/platforms/prep_setup.c |    1 -
 include/asm-powerpc/processor.h |    1 -
 4 files changed, 11 deletions(-)

--- linux-2.6.15-rc1/include/asm-powerpc/processor.h.old	2005-11-13 01:44:12.000000000 +0100
+++ linux-2.6.15-rc1/include/asm-powerpc/processor.h	2005-11-13 01:44:25.000000000 +0100
@@ -68,7 +68,6 @@
  * vendor. Board revision is also made available. This will be moved
  * elsewhere soon
  */
-extern unsigned char ucSystemType;
 extern unsigned char ucBoardRev;
 extern unsigned char ucBoardRevMaj, ucBoardRevMin;
 
--- linux-2.6.15-rc1/arch/ppc/platforms/prep_setup.c.old	2005-11-13 01:44:36.000000000 +0100
+++ linux-2.6.15-rc1/arch/ppc/platforms/prep_setup.c	2005-11-13 01:44:40.000000000 +0100
@@ -72,7 +72,6 @@
 
 TODC_ALLOC();
 
-unsigned char ucSystemType;
 unsigned char ucBoardRev;
 unsigned char ucBoardRevMaj, ucBoardRevMin;
 
--- linux-2.6.15-rc1/arch/ppc/kernel/ppc_ksyms.c.old	2005-11-13 01:44:49.000000000 +0100
+++ linux-2.6.15-rc1/arch/ppc/kernel/ppc_ksyms.c	2005-11-13 01:44:54.000000000 +0100
@@ -82,10 +82,6 @@
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-#if defined(CONFIG_PPC_PREP)
-EXPORT_SYMBOL(_prep_type);
-EXPORT_SYMBOL(ucSystemType);
-#endif
 
 #if !defined(__INLINE_BITOPS)
 EXPORT_SYMBOL(set_bit);
--- linux-2.6.15-rc1/arch/powerpc/kernel/ppc_ksyms.c.old	2005-11-13 01:45:06.000000000 +0100
+++ linux-2.6.15-rc1/arch/powerpc/kernel/ppc_ksyms.c	2005-11-13 01:45:12.000000000 +0100
@@ -76,11 +76,6 @@
 EXPORT_SYMBOL(sys_sigreturn);
 #endif
 
-#if defined(CONFIG_PPC_PREP)
-EXPORT_SYMBOL(_prep_type);
-EXPORT_SYMBOL(ucSystemType);
-#endif
-
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
