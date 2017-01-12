Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzb1vHxzDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:39 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 03/18] powerpc/64: Always enable radix support for 64-bit Book
 3S kernels
Date: Thu, 12 Jan 2017 20:07:11 +1100
Message-Id: <1484212046-29591-4-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the ability for the user to choose whether or not to
include support for the radix MMU in kernels built to run on 64-bit
Book 3S machines.  Excluding radix support saves only about 25kiB
of text and 13kiB of data, a total of little over half a page.
Having the option expands the space of option combinations that
need to be tested, which is an ongoing burden on developers.
Given that the space savings are small, let's remove the option.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/platforms/Kconfig.cputype | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6e89e5a..de88156 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -334,13 +334,8 @@ config PPC_STD_MMU_64
 	depends on PPC_STD_MMU && PPC64
 
 config PPC_RADIX_MMU
-	bool "Radix MMU Support"
+	def_bool y
 	depends on PPC_BOOK3S_64
-	default y
-	help
-	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-	  is only implemented by IBM Power9 CPUs, if you don't have one of them
-	  you can probably disable this.
 
 config PPC_MMU_NOHASH
 	def_bool y
-- 
2.7.4
