Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXx00Z9VzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:44 +1000 (AEST)
Message-Id: <dd602a320d7a1a627774be65fa58315fa1922a0b.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 01/12] powerpc/8xx: Simplify CONFIG_8xx checks in Makefile
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:40 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The entire 8xx directory is omitted if CONFIG_8xx is not enabled, so
within the 8xx/Makefile CONFIG_8xx is always y. So convert
obj-$(CONFIG_8xx) to the more obvious obj-y.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 This serie applies on top of Michael's serie begining with '[1/9] powerpc/47x:
  Guard 47x cputable entries with CONFIG_PPC_47x' added to bundle mce'

 arch/powerpc/platforms/8xx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 76a81c3350a8..161f367ebf1e 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the PowerPC 8xx linux kernel.
 #
-obj-$(CONFIG_PPC_8xx)	  += m8xx_setup.o
+obj-y			+= m8xx_setup.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
-- 
2.13.3
