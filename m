Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B958DDFBB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:02:52 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF2nFB008504
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:02:49 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF2meM008503
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:02:48 -0600 (CST)
Date: Wed, 21 Mar 2007 09:02:48 -0600 (CST)
Subject: [PATCH 5/8] boot: rebuild when wrapper changes
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-05.miltonm@bga.com>
In-Reply-To: <boot-2-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since there is magic defined per platform in the wrapper script, the
zImage targets should depend on it.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-21 01:40:16.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-21 02:15:16.000000000 -0500
@@ -101,7 +101,8 @@ extra-y		:= $(obj)/wrapper.a $(obj-plat)
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
+			$(wrapper)
 
 #############
 # Bits for building various flavours of zImage
