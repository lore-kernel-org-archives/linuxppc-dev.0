Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99314DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 15:07:34 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 044841C881D
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:07:27 -0200 (BRST)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id h8quWJGAmmv8 for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Oct 2008 01:07:20 -0200 (BRST)
Received: from chagas.nectar.ath.cx (189-39-150-147.gru.flash.tv.br
	[189.39.150.147])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id 3F9911C8735
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:07:20 -0200 (BRST)
Date: Mon, 13 Oct 2008 01:07:03 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: compile kernel for linkstations optimized for size
Message-ID: <20081013040703.GA11059@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: rbrito@ime.usp.br, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Rogério Brito <rbrito@ime.usp.br>

Since Linkstations and Kuroboxes often have *very* little memory (as
they are embedded systems), it is desirable to get their kernels
compiled optimized for size.

Signed-off-by: Rogério Brito <rbrito@ime.usp.br>

---

I have been using kernels optimized for size on my Kurobox (standard)
for many different releases and I have experienced no problem with this
option enabled. Thus, this patch.

--- linux/arch/powerpc/configs/linkstation_defconfig.old	2008-10-13 00:33:00.000000000 -0300
+++ linux/arch/powerpc/configs/linkstation_defconfig	2008-10-13 00:38:58.000000000 -0300
@@ -90,7 +90,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
 CONFIG_SYSCTL_SYSCALL=y


-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
