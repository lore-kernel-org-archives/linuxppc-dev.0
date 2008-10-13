Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 271C3DDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 15:51:33 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 0E0C11C87DD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:51:38 -0200 (BRST)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id R8-qx90XKFmG for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Oct 2008 01:51:33 -0200 (BRST)
Received: from chagas.nectar.ath.cx (189-39-150-147.gru.flash.tv.br
	[189.39.150.147])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id E45071C87C5
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:51:32 -0200 (BRST)
Date: Mon, 13 Oct 2008 01:51:17 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: enable heap randomization for linkstations
Message-ID: <20081013045116.GA11637@ime.usp.br>
References: <20081013040703.GA11059@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20081013040703.GA11059@ime.usp.br>
Cc: rbrito@ime.usp.br, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current defconfig for Linkstation/Kuroboxes has the "Disable Heap
Randomization" option enabled.

Since some of these machines are facing the internet, it helps to have
heap randomization enabled. This patch enables it.


Signed-off-by: Rogério Brito <rbrito@ime.usp.br>

---

--- linux/arch/powerpc/configs/linkstation_defconfig.old	2008-10-13 00:33:00.000000000 -0300
+++ linux/arch/powerpc/configs/linkstation_defconfig	2008-10-13 01:11:28.000000000 -0300
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc4
-# Thu Aug 21 00:52:05 2008
+# Linux kernel version: 2.6.27
+# Mon Oct 13 01:11:21 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -101,7 +101,7 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_COMPAT_BRK=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -1211,7 +1211,6 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_ALAUDA is not set
 # CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
-# CONFIG_USB_STORAGE_SIERRA is not set
 # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
