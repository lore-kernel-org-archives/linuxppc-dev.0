Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11B4C67A79
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2005 05:35:20 +1000 (EST)
Date: Sun, 10 Jul 2005 19:35:14 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <20050710193514.6.ltcoQv2417.2247.olh@nectarine.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/82] remove linux/version.h include from arch/ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

use system_utsname for CONFIG_BOOTX_TEXT welcome message

Signed-off-by: Olaf Hering <olh@suse.de>

arch/ppc/syslib/btext.c     |    6 ++++--
arch/ppc/syslib/prom.c      |    1 -
arch/ppc/syslib/prom_init.c |    1 -
3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/ppc/syslib/btext.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc/syslib/btext.c
+++ linux-2.6.13-rc2-mm1/arch/ppc/syslib/btext.c
@@ -7,7 +7,7 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
+#include <linux/utsname.h>

#include <asm/sections.h>
#include <asm/bootx.h>
@@ -81,7 +81,9 @@ btext_welcome(void)
unsigned long pvr;
boot_infos_t* bi = &disp_bi;

-	btext_drawstring("Welcome to Linux, kernel " UTS_RELEASE "n");
+	btext_drawstring("Welcome to Linux, kernel ");
+	btext_drawstring(system_utsname.version);
+	btext_drawstring("n");
btext_drawstring("nlinked at        : 0x");
btext_drawhex(KERNELBASE);
btext_drawstring("nframe buffer at  : 0x");
Index: linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc/syslib/prom.c
+++ linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom.c
@@ -13,7 +13,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/threads.h>
#include <linux/spinlock.h>
#include <linux/ioport.h>
Index: linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom_init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc/syslib/prom_init.c
+++ linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom_init.c
@@ -9,7 +9,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/threads.h>
#include <linux/spinlock.h>
#include <linux/ioport.h>
