Return-Path: <SRS0+f7c478659b117b62100c+1213+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07B7BDDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 20:55:13 +1100 (EST)
Subject: [PATCH] Probe Efika platform before CHRP.
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 09:54:56 +0000
Message-Id: <1166522096.25827.76.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Efika matches chrp_probe() too, so put its own probe first to make
sure we get it right in a multiplatform build.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- linux-2.6.19.ppc/arch/powerpc/platforms/Makefile~	2006-12-17 14:55:49.000000000 +0000
+++ linux-2.6.19.ppc/arch/powerpc/platforms/Makefile	2006-12-17 17:16:52.000000000 +0000
@@ -5,9 +5,9 @@ ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
+obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
-obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/

-- 
dwmw2
