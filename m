Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CFD2DDDF25
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:06:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0OL6vGQ029163
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:06:57 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL6u7j029127
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:06:56 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnIVK008091
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:19 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 231054B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:06:55 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL6sco010544
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:06:54 -0600
Date: Wed, 24 Jan 2007 15:06:54 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/18] Include autoconf.h from the bootwrapper.
Message-ID: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will be required by the u-boot compatibility code to obtain a
compatible bd_t layout, to determine how to calculate the timebase, and
to know what soc fields need to be modified.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 98392fb..906b166 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -31,7 +31,8 @@ ifeq ($(call cc-option-yn, -fstack-prote
 BOOTCFLAGS	+= -fno-stack-protector
 endif
 
-BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) \
+                   -include $(srctree)/include/linux/autoconf.h
 
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
-- 
1.4.4
