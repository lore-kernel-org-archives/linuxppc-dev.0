Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8610BDDE04
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:58:37 +1100 (EST)
Date: Fri, 1 Feb 2008 23:36:34 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: add missing native dcr dcr_ind_lock spinlock
Message-ID: <20080201203634.GA21024@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The include/asm-powerpc/dcr-native.h declares extern spinlock_t dcr_ind_lock,
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
+spinlock_t dcr_ind_lock;
+#endif	/* !defined(CONFIG_PPC_DCR_NATIVE) */
