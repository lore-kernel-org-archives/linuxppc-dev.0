Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0862D68867
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 07:46:38 +1100 (EST)
Date: Thu, 1 Dec 2005 21:46:32 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051201204632.GA3764@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] powerpc: hide CONFIG_ALTIVEC on iSeries
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Do not offer CONFIG_ALTIVEC for legacy iSeries. They predate the 970.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.15-rc4-olh.orig/arch/powerpc/Kconfig
+++ linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
@@ -169,7 +169,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on 6xx || POWER4
+	depends on (6xx || POWER4) && !PPC_ISERIES
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
