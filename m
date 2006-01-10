Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 0655D689EF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 00:02:25 +1100 (EST)
Date: Tue, 10 Jan 2006 14:02:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org
Message-ID: <20060110130222.GI3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] arch/powerpc/Kconfig: fix GENERIC_TBSYNC dependencies
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the dependencies of GENERIC_TBSYNC (this bug was found 
by Jean-Luc Leger <reiga@dspnet.fr.eu.org>).

Additionally, it removes the superfluous "default n".


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/arch/powerpc/Kconfig.old	2006-01-10 13:59:33.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/powerpc/Kconfig	2006-01-10 13:59:57.000000000 +0100
@@ -406,8 +406,7 @@
 
 config GENERIC_TBSYNC
 	bool
-	default y if CONFIG_PPC32 && CONFIG_SMP
-	default n
+	default y if PPC32 && SMP
 
 source "drivers/cpufreq/Kconfig"
 
