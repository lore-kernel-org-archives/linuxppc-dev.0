Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts16-srv.bellnexxia.net (tomts16.bellnexxia.net
	[209.226.175.4]) by ozlabs.org (Postfix) with ESMTP id B6BEADDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:33:16 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts16-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070205193310.YKOE12977.tomts16-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 14:33:10 -0500
Date: Mon, 5 Feb 2007 14:33:10 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
Message-ID: <20070205193310.GA12412@Krystal>
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

Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h

A missing structure forward declaration causes a lot of warnings when
compiling for a powerpc 405. Because this header is used for assembly
too, the declaration must be put within #ifndef __ASSEMBLY__, as should
be the function prototypes.

This patch applies on 2.6.20.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-powerpc/dcr.h
+++ b/include/asm-powerpc/dcr.h
@@ -33,10 +33,13 @@
  * base from the device-tree
  */
 #ifdef CONFIG_PPC_MERGE
+#ifndef __ASSEMBLY__
+struct device_node;
 extern unsigned int dcr_resource_start(struct device_node *np,
 				       unsigned int index);
 extern unsigned int dcr_resource_len(struct device_node *np,
 				     unsigned int index);
+#endif
 #endif /* CONFIG_PPC_MERGE */
=20
 #endif /* CONFIG_PPC_DCR */
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
