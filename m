Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXHNQ6DMYzDvhn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 19:04:38 +1100 (AEDT)
Date: Mon, 5 Dec 2016 19:03:39 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 2/3] powerpc/64: Always enable radix support for 64-bit
 Book 3S kernels
Message-ID: <20161205080339.GB13528@fergus.ozlabs.ibm.com>
References: <20161205080219.GA13528@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161205080219.GA13528@fergus.ozlabs.ibm.com>
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
need to be tested, which is an ongoing burden on developers,
as well as increasing the number of #ifdefs in the code.
Given that the space savings are small, let's remove the option.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/platforms/Kconfig.cputype | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ca2da30..52a71ca 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -333,13 +333,8 @@ config PPC_STD_MMU_64
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
