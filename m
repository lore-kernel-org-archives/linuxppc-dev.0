Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5CB16DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 21:53:02 +1100 (EST)
Date: Thu, 19 Mar 2009 21:53:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: linux-next: cpus4096 tree build failure
Message-Id: <20090319215300.1833d28e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next build (powerpc allyesconfig) failed like this:

In file included from include/linux/mmzone.h:776,
                 from include/linux/gfp.h:5,
                 from include/linux/kmod.h:23,
                 from include/linux/module.h:14,
                 from init/version.c:11:
arch/powerpc/include/asm/mmzone.h:32: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'numa_cpumask_lookup_table'

and many more.

Probably caused by commit 082edb7bf443eb8eda15b482d16ad9dd8137ad24 ("numa,
cpumask: move numa_node_id default implementation to topology.h") from
the cpus4096 tree which removed the include of linux/topology.h from
linux/mmzone.h.

I have added the following patch for today.  There may be a better fix.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Mar 2009 21:35:24 +1100
Subject: [PATCH] powerpc: mmzone.h needs cpumask_t to be defined

Commit 082edb7bf443eb8eda15b482d16ad9dd8137ad24 ("numa,cpumask: move
numa_node_id default implementation to topology.h") removed the include
of linux/topology.h from linux/mmzone.h which exposed this lack.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/mmzone.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 19f299b..35acac9 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -8,6 +8,7 @@
 #define _ASM_MMZONE_H_
 #ifdef __KERNEL__
 
+#include <linux/cpumask.h>
 
 /*
  * generic non-linear memory support:
-- 
1.6.2.1
