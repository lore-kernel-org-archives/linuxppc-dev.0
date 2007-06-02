Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2ED18DDEDB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 19:13:35 +1000 (EST)
Subject: [PATCH] don't allow PMAC_APM_EMU for 64-bit
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 11:13:44 +0200
Message-Id: <1180775624.11026.43.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In b302887854d6f0c6f9fc3f1080535e7c1bd53134 I switched the apm emulation
code to use the generic code but accidentally dropped the PPC32
dependency from the configuration symbol. This adds it back.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Of course, selecting it on 64 bit doesn't make sense (no portables with
64-bit and PMU) and doesn't build either.

--- linux-2.6.orig/drivers/macintosh/Kconfig	2007-06-02 11:11:17.465515541 +0200
+++ linux-2.6/drivers/macintosh/Kconfig	2007-06-02 11:11:24.305515541 +0200
@@ -114,7 +114,7 @@ config PMAC_SMU
 config PMAC_APM_EMU
 	tristate "APM emulation"
 	select APM_EMULATION
-	depends on ADB_PMU && PM
+	depends on ADB_PMU && PM && PPC32
 
 config PMAC_MEDIABAY
 	bool "Support PowerBook hotswap media bay"
