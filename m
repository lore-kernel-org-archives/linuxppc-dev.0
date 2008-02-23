Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D907DE263
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 09:10:33 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NMCRnG003287
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:12:27 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NMAUNV293498
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:10:30 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NMAUq0027946
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:10:30 -0500
Received: from zod.rchland.ibm.com (wecm-9-67-149-29.wecm.ibm.com
	[9.67.149.29])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1NMAUQQ027929
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:10:30 -0500
Date: Sat, 23 Feb 2008 16:09:57 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3][POWERPC] 4xx: Add platform support for the AMCC
	Yosemite board
Message-ID: <20080223160957.11ec195f@zod.rchland.ibm.com>
In-Reply-To: <20080223160813.2f8d282b@zod.rchland.ibm.com>
References: <20080223160813.2f8d282b@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The AMCC 440EP Yosemite board is very similar to the original AMCC Bamboo
board.  This adds a YOSEMITE option to Kconfig, and reuses the existing
bamboo board support in the kernel.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/platforms/44x/Kconfig  |    9 +++++++++
 arch/powerpc/platforms/44x/Makefile |    1 +
 2 files changed, 10 insertions(+)

--- linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig
+++ linux-2.6/arch/powerpc/platforms/44x/Kconfig
@@ -67,6 +67,15 @@ config WARP
 	  See http://www.pikatechnologies.com/ and follow the "PIKA for Computer
 	  Telephony Developers" link for more information.
 
+config YOSEMITE
+	bool "Yosemite"
+	depends on 44x
+	default n
+	select 440EP
+	select PCI
+	help
+	  This option enables support for the AMCC PPC440EP evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
--- linux-2.6.orig/arch/powerpc/platforms/44x/Makefile
+++ linux-2.6/arch/powerpc/platforms/44x/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_BAMBOO)	+= bamboo.o
+obj-$(CONFIG_YOSEMITE)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
 obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
