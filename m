Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts20-srv.bellnexxia.net (tomts20-srv.bellnexxia.net
	[209.226.175.74]) by ozlabs.org (Postfix) with ESMTP id 50CBCDDEC4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 11:04:48 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts20-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070208000445.NRSE24907.tomts20-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 19:04:45 -0500
Date: Wed, 7 Feb 2007 19:04:44 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] arch/powerpc missing export vgacon_remap_base
Message-ID: <20070208000444.GC26092@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc missing export vgacon_remap_base

The following macro :
include/asm-powerpc/vga.h:#define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
is used by drivers/video/console/vgacon.c which can be compiled as a module
(drivers/video/vga16fb.ko).

Therefore, vgacon_remap_base must be exported.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -65,6 +65,7 @@ int have_of =3D 1;
=20
 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vgacon_remap_base;
+EXPORT_SYMBOL(vgacon_remap_base);
 #endif
=20
 /*
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 3c506af..5856341 100644
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
