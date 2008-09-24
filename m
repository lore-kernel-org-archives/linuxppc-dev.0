Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E6A5DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 23:29:55 +1000 (EST)
Subject: [PATCH] powerpc: make 64-bit hibernation depend on !64K_PAGES
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 15:29:02 +0200
Message-Id: <1222262942.4257.9.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For reasons I haven't tried to figure out yet, and which are quite
possibly my own fault, the hibernation code doesn't work with 64K pages.
Until somebody is able to figure out why (if anyone cares; I seem to be
the only person on earth actually using this code once a while) make it
depend on !PPC_64K_PAGES.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -194,7 +194,7 @@ config HIBERNATE_32
 
 config HIBERNATE_64
 	bool
-	depends on BROKEN || (PPC_PMAC64 && EXPERIMENTAL)
+	depends on BROKEN || (PPC_PMAC64 && !PPC_64K_PAGES && EXPERIMENTAL)
 	default y
 
 config ARCH_HIBERNATION_POSSIBLE
