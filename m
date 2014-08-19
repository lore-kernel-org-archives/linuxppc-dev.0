Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 226A81A001A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 07:01:07 +1000 (EST)
Received: by mail-yk0-f174.google.com with SMTP id q9so5862629ykb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:01:05 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Fix build failure when MEMORY_HOTPLUG=y
Date: Tue, 19 Aug 2014 17:01:05 -0400
Message-Id: <1408482065-18457-1-git-send-email-bobby.prani@gmail.com>
Cc: Andew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ARCH_ENABLE_MEMORY_HOTPLUG is enabled by default for powerpc. This causes build
failures when SPARSEMEM=n as memory hotplug needs definition which are defined
only when SPARSEMEM=y. The error is as follows:

arch/powerpc/platforms/pseries/hotplug-memory.c:27:31: error: 'SECTION_SIZE_BITS' undeclared (first use in this function)
arch/powerpc/platforms/pseries/hotplug-memory.c:27:31: note: each undeclared identifier is reported only once for each function it appears in
arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'pseries_remove_memblock':
arch/powerpc/platforms/pseries/hotplug-memory.c:98:34: error: 'SECTION_SIZE_BITS' undeclared (first use in this function)
make[2]: *** [arch/powerpc/platforms/pseries/hotplug-memory.o] Error 1

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
CC: Andew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9c1aa77..da16ffe 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -383,6 +383,7 @@ config ARCH_CPU_PROBE_RELEASE
 
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
+	depends on SPARSEMEM
 
 config ARCH_HAS_WALK_MEMORY
 	def_bool y
-- 
1.9.1
