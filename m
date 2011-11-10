Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 9636F10091A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:09:01 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 11/17] powerpc/e500: Use the correct assembler flags for
 e500mc and e5500
Date: Wed,  9 Nov 2011 19:07:09 -0500
Message-Id: <1320883635-17194-12-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "-me500" assembler option is intended only for use on e500v1 or
e500v2 systems.  On modern binutils it will refuse to assemble standard
floating point opcodes, and it will translate "lwsync" into "sync".

This fixes the e500mc/e5500 kernel build on recent binutils.

For e500mc/e5500 with standard PowerPC floating point, the assembler
options "-me500mc" or "-me500mc64" should be used, although they are not
strictly necessary depending on which opcodes are in use.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c17bc29..bd443ee2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -133,7 +133,8 @@ endif
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
-cpu-as-$(CONFIG_E500)		+= -Wa,-me500
+cpu-as-$(CONFIG_FSL_E500_V1_V2)	+= -Wa,-me500
+cpu-as-$(CONFIG_FSL_E500MC)	+= -Wa,-me500mc
 cpu-as-$(CONFIG_FSL_E200)	+= -Wa,-me200
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
1.7.2.5
