Return-Path: <mjeanson@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41677M1kN3zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 01:38:23 +1000 (AEST)
From: Michael Jeanson <mjeanson@efficios.com>
To: 
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kumar Gala <galak@kernel.crashing.org>, Vakul Garg <vakul.garg@nxp.com>,
 Scott Wood <swood@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] powerpc/e500mc: Set assembler machine type to e500mc
Date: Thu, 14 Jun 2018 11:27:42 -0400
Message-Id: <20180614152742.21075-1-mjeanson@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In binutils 2.26 a new opcode for the "wait" instruction was added for the
POWER9 and has precedence over the one specific to the e500mc. Commit
ebf714ff3756 ("powerpc/e500mc: Add support for the wait instruction in
e500_idle") uses this instruction specifically on the e500mc to work around
an erratum.

This results in an invalid instruction in idle_e500 when we build for the
e500mc on bintutils >= 2.26 with the default assembler machine type.

Since multiplatform between e500 and non-e500 is not supported, set the
assembler machine type globaly when CONFIG_PPC_E500MC=y.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Vakul Garg <vakul.garg@nxp.com>
CC: Scott Wood <swood@redhat.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
CC: stable@vger.kernel.org
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..bb2523b4bd8f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -251,6 +251,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
-- 
2.17.1
