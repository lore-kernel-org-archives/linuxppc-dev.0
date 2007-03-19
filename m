Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38FABDDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:45 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:05 -0600 (CST)
Subject: [PATCH 6/7] bootwrapper: allow platforms to call library zImage_start
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-06.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some platforms might need to run some code before the zImage start, but
could otherwise use the bss clear and relocation code.   Export the
start address strongly as zImage_start_lib.

--- 
Compiles and links with test user, stack set properly.
 crt0.S |    2 ++
 1 file changed, 2 insertions(+)

Index: kernel/arch/powerpc/boot/crt0.S
===================================================================
--- kernel.orig/arch/powerpc/boot/crt0.S	2007-03-19 04:15:03.000000000 -0500
+++ kernel/arch/powerpc/boot/crt0.S	2007-03-19 04:15:03.000000000 -0500
@@ -19,6 +19,8 @@ _zimage_start_opd:
 	.weak	_zimage_start
 	.globl	_zimage_start
 _zimage_start:
+	.globl	_zimage_start_lib
+_zimage_start_lib:
 	/* Work out the offset between the address we were linked at
 	   and the address where we're running. */
 	bl	1f
