Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 3238B100B2F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:08:39 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 06/17] powerpc/e500: Split FreeScale e500v1/v2 and e500mc
 config options
Date: Wed,  9 Nov 2011 19:07:04 -0500
Message-Id: <1320883635-17194-7-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>, Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernels built for e500 and e500mc are fundamentally incompatible with
each other due to different cacheline sizes, support for SPE
instructions, etc.

Unfortuantely, there is a lot of support code with a morass of config
options which mostly mean the same things (E500/E500MC/PPC_85xx/etc).

As preparation for fixing up all the support code, split the config
options into two separate parts.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/platforms/Kconfig.cputype |   34 +++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0ab01b0..1108586 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -10,13 +10,15 @@ choice
 	prompt "Processor Type"
 	depends on PPC32
 	help
-	  There are five families of 32 bit PowerPC chips supported.
+	  There are six families of 32 bit PowerPC chips supported.
+
 	  The most common ones are the desktop and server CPUs (601, 603,
 	  604, 740, 750, 74xx) CPUs from Freescale and IBM, with their
 	  embedded 512x/52xx/82xx/83xx/86xx counterparts.
-	  The other embeeded parts, namely 4xx, 8xx, e200 (55xx) and e500
-	  (85xx) each form a family of their own that is not compatible
-	  with the others.
+
+	  The other embedded parts, namely 4xx, 8xx, e200, e500, and e500mc
+	  each form a family of their own that is not compatible with the
+	  others.
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
@@ -24,10 +26,21 @@ config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
-config PPC_85xx
-	bool "Freescale 85xx"
+config FSL_E200
+	bool "Freescale e200 (also known as MPC5xx/MPC55xx)"
+	select E200
+
+config FSL_E500_V1_V2
+	bool "Freescale e500v1/e500v2 (also known as MPC85xx)"
 	select PHYS_64BIT_SUPPORTED
 	select E500
+	select PPC_85xx
+
+config FSL_E500MC
+	bool "Freescale e500mc (also e5500 in 32-bit mode)"
+	select PHYS_64BIT_SUPPORTED
+	select E500
+	select PPC_85xx
 
 config PPC_8xx
 	bool "Freescale 8xx"
@@ -51,9 +64,6 @@ config 44x
 	select PHYS_64BIT_SUPPORTED
 	select PHYS_64BIT_DT_REQUIRED
 
-config E200
-	bool "Freescale e200"
-
 endchoice
 
 choice
@@ -131,6 +141,12 @@ config TUNE_CELL
 config 8xx
 	bool
 
+config E200
+	bool
+
+config PPC_85xx
+	bool
+
 config E500
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
-- 
1.7.2.5
