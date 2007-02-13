Return-Path: <bgill@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E42F2DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 07:19:58 +1100 (EST)
Date: Tue, 13 Feb 2007 14:16:08 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc/ppc: Drop use of SYNC macro in head_fsl_booke.S
Message-ID: <Pine.LNX.4.61.0702131409570.28978@ld2044.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eliminate needless invocation of the SYNC macro (which always evaluates to
nothing on BookE) from head_fsl_booke.S

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit 6007a6b0235e2060556c8136f1fa2ddfea2228d3
tree d6b96565246807ae10f9fa64e24280eb2664e8ec
parent 2a5f6e78c834e1824a9d6ef3d561920cbda61a5e
author Becky Bruce <becky.bruce@freescale.com> Mon, 12 Feb 2007 17:55:50 -0600
committer Becky Bruce <becky.bruce@freescale.com> Mon, 12 Feb 2007 17:55:50 -0600

 arch/powerpc/kernel/head_fsl_booke.S |    2 --
 arch/ppc/kernel/head_fsl_booke.S     |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 54f40d9..1f155d3 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -892,7 +892,6 @@ load_up_spe:
 	REST_GPR(9, r11)
 	REST_GPR(12, r11)
 	lwz	r11,GPR11(r11)
-	SYNC
 	rfi
 
 /*
@@ -956,7 +955,6 @@ _GLOBAL(giveup_altivec)
 _GLOBAL(giveup_spe)
 	mfmsr	r5
 	oris	r5,r5,MSR_SPE@h
-	SYNC
 	mtmsr	r5			/* enable use of SPE now */
 	isync
 	cmpi	0,r3,0
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
index 54f40d9..1f155d3 100644
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -892,7 +892,6 @@ load_up_spe:
 	REST_GPR(9, r11)
 	REST_GPR(12, r11)
 	lwz	r11,GPR11(r11)
-	SYNC
 	rfi
 
 /*
@@ -956,7 +955,6 @@ _GLOBAL(giveup_altivec)
 _GLOBAL(giveup_spe)
 	mfmsr	r5
 	oris	r5,r5,MSR_SPE@h
-	SYNC
 	mtmsr	r5			/* enable use of SPE now */
 	isync
 	cmpi	0,r3,0
