Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3026DDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 01:59:50 +1100 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id m14Evuxp019115
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 17:57:56 +0300
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id m14Evubl019112
	for linuxppc-dev@ozlabs.org; Mon, 4 Feb 2008 17:57:56 +0300
Date: Mon, 4 Feb 2008 17:57:55 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: add missing native dcr dcr_ind_lock spinlock
Message-ID: <20080204145755.GA19078@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47A71C60.1030406@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The include/asm-powerpc/dcr-native.h declares extern spinlock_t dcr_ind_lock;
but it's actually isn't defined. This patch adds a missing dcr_ind_lock.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/dcr.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/sysdev/dcr.c linux-2.6/arch/powerpc/sysdev/dcr.c
--- linux-2.6.orig/arch/powerpc/sysdev/dcr.c	2008-01-31 16:58:32.000000000 +0300
+++ linux-2.6/arch/powerpc/sysdev/dcr.c	2008-02-01 23:17:35.000000000 +0300
@@ -137,5 +137,6 @@ void dcr_unmap(dcr_host_t host, unsigned
 	h.token = NULL;
 }
 EXPORT_SYMBOL_GPL(dcr_unmap);
-
-#endif /* !defined(CONFIG_PPC_DCR_NATIVE) */
+#else	/* defined(CONFIG_PPC_DCR_NATIVE) */
+DEFINE_SPINLOCK(dcr_ind_lock);
+#endif	/* !defined(CONFIG_PPC_DCR_NATIVE) */
