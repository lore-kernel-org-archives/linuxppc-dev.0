Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CA381A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 21:12:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/6] powerpc: Add cpu name to dump stack arch description
Date: Tue,  5 May 2015 21:12:13 +1000
Message-Id: <1430824337-15339-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
References: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
Cc: tj@kernel.org, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As soon as we know the name of the cpu we're on, add it to the dump
stack arch description, which is printed in case of an oops.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 60262fdf35ba..cf5e0c9b80cb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -15,6 +15,7 @@
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/printk.h>
 
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
@@ -2174,6 +2175,8 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 	}
 #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
 
+	dump_stack_add_arch_desc(t->cpu_name);
+
 	return t;
 }
 
-- 
2.1.0
