Return-Path: <apw@shadowen.org>
Received: from localhost.localdomain (81-179-233-34.dsl.pipex.com
	[81.179.233.34]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18AB868834
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 06:44:32 +1100 (EST)
Date: Tue, 29 Nov 2005 19:25:54 +0000
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051129192554.GA28332@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Andy Whitcroft <apw@shadowen.org>
Cc: linuxppc-dev@ozlabs.org, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] powerpc ppc32 fix definition of distribute_irqs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that I can attempt to compile powerpc/ppc32 it appears there is 
a problem with the definition of distribute_irqs, this patch
seems to fix it for me.

-apw

=== 8< ===
powerpc: ppc32 fix definition of distribute_irqs

When we select ppc32 under the powerpc architecture we get the
error below.  This relates to defining distribute_irqs when this
configuratiom option is undefined.

      CC      arch/powerpc/sysdev/mpic.o
    .../arch/powerpc/sysdev/mpic.c: In function `mpic_setup_this_cpu':
    .../arch/powerpc/sysdev/mpic.c:788: error: `CONFIG_IRQ_ALL_CPUS'
	undeclared (first use in this function)

Against 2.6.15-rc3.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/arch/powerpc/sysdev/mpic.c current/arch/powerpc/sysdev/mpic.c
--- reference/arch/powerpc/sysdev/mpic.c
+++ current/arch/powerpc/sysdev/mpic.c
@@ -45,7 +45,11 @@ static struct mpic *mpic_primary;
 static DEFINE_SPINLOCK(mpic_lock);
 
 #ifdef CONFIG_PPC32	/* XXX for now */
-#define distribute_irqs	CONFIG_IRQ_ALL_CPUS
+#ifdef CONFIG_IRQ_ALL_CPUS
+#define distribute_irqs	(1)
+#else
+#define distribute_irqs	(0)
+#endif
 #endif
 
 /*
