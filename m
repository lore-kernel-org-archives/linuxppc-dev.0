Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 16892100EED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:09:05 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 13/17] powerpc/e500: Add a new CONFIG_FSL_E5500 option for
 the e5500
Date: Wed,  9 Nov 2011 19:07:11 -0500
Message-Id: <1320883635-17194-14-git-send-email-Kyle.D.Moffett@boeing.com>
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

As part of splitting CONFIG_E500 into separate options for e500v1/v2 and
e500mc/e5500, some code only needs to be built when e5500 support is
required.

This adds a new internal-use config option for both 32-bit and 64-bit
builds that enables only the e5500 support code.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/platforms/85xx/Kconfig    |    2 +-
 arch/powerpc/platforms/Kconfig.cputype |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 248f87c..72488d4 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -231,8 +231,8 @@ endif # PPC32
 config P5020_DS
 	bool "Freescale P5020 DS"
 	depends on FSL_E500MC || PPC_BOOK3E_64
+	select FSL_E5500
 	select DEFAULT_UIMAGE
-	select E500
 	select PHYS_64BIT_DT_REQUIRED
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index fd37bb2..cff45e3 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -144,6 +144,10 @@ config 8xx
 config PPC_85xx
 	bool
 
+config FSL_E5500
+	bool
+	select E500
+
 config E500
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
-- 
1.7.2.5
