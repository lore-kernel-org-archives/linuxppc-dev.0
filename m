Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 2D8E5101502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:09:19 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 17/17] powerpc/e500: Finally remove "CONFIG_E500"
Date: Wed,  9 Nov 2011 19:07:15 -0500
Message-Id: <1320883635-17194-18-git-send-email-Kyle.D.Moffett@boeing.com>
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

This ambiguous config option is now only present as a Kconfig stub.
Remove it and fix up the users.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/platforms/Kconfig.cputype |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 22df19d..d4faa6f 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -32,14 +32,16 @@ config FSL_E200
 config FSL_E500_V1_V2
 	bool "Freescale e500v1/e500v2 (also known as MPC85xx)"
 	select PHYS_64BIT_SUPPORTED
-	select E500
+	select FSL_EMB_PERFMON
+	select PPC_FSL_BOOK3E
 	select PPC_85xx
 
 config FSL_E500MC
 	bool "Freescale e500mc (also e5500 in 32-bit mode)"
 	select PHYS_64BIT_SUPPORTED
 	select PPC_FPU
-	select E500
+	select FSL_EMB_PERFMON
+	select PPC_FSL_BOOK3E
 	select PPC_85xx
 
 config PPC_8xx
@@ -146,12 +148,8 @@ config PPC_85xx
 
 config FSL_E5500
 	bool
-	select E500
-
-config E500
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
-	bool
 
 config PPC_FPU
 	bool
-- 
1.7.2.5
