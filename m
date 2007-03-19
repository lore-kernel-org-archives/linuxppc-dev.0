Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 967EFDDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:46 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:04 -0600 (CST)
Subject: [PATCH 2/7] boot: rebuild when wrapper changes
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-02.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
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
--- 
 Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-19 08:11:18.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-19 08:12:14.000000000 -0500
@@ -101,7 +101,8 @@ extra-y		:= $(obj)/wrapper.a $(obj-plat)
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
+			$(wrapper)
 
 #############
 # Bits for building various flavours of zImage
