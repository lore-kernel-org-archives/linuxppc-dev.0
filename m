Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FDF4DDF63
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 18:21:08 +1000 (EST)
Date: Wed, 28 Mar 2007 02:21:04 -0600 (CST)
Subject: [PATCH 2/4] bootwrapper: remove unused variable
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-3-02.miltonm@bga.com>
In-Reply-To: <boot-3-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gunzip_util.c has a static variable state, obsured in every function
by the first passed parameter.  Looks like this got missed in an API
change during development.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/gunzip_util.c
===================================================================
--- kernel.orig/arch/powerpc/boot/gunzip_util.c	2007-03-27 16:02:08.000000000 -0500
+++ kernel/arch/powerpc/boot/gunzip_util.c	2007-03-27 16:02:11.000000000 -0500
@@ -14,8 +14,6 @@
 #include "ops.h"
 #include "gunzip_util.h"
 
-struct gunzip_state state;
-
 #define HEAD_CRC	2
 #define EXTRA_FIELD	4
 #define ORIG_NAME	8
