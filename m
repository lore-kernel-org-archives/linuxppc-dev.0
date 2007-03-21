Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F87ADDFAA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:02:56 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF2rwo008508
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:02:53 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF2rfQ008507
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:02:53 -0600 (CST)
Date: Wed, 21 Mar 2007 09:02:53 -0600 (CST)
Subject: [PATCH 3/8] bootwrapper: allow platforms to call library zImage_start
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-03.miltonm@bga.com>
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

Some platforms might need to run some code before the zImage start, but
could otherwise use the bss clear and relocation code.   Export the
start address strongly as zImage_start_lib.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Compiles and links with usage, stack set properly.

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
