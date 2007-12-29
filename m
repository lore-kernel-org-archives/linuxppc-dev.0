Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5-srv.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id A701DDDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 03:14:24 +1100 (EST)
Received: from toip7.srvr.bell.ca ([209.226.175.124])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20071229161422.BKHC17217.tomts5-srv.bellnexxia.net@toip7.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 11:14:22 -0500
Date: Sat, 29 Dec 2007 11:09:21 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Adrian Bunk <adrian.bunk@movial.fi>
Subject: [2.6.24 patch] Fix Cell OProfile support
Message-ID: <20071229160921.GB12262@Krystal>
References: <20071228185649.GC4738@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071228185649.GC4738@stusta.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, phil.el@wanadoo.fr,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch restores the Cell OProfile support that was killed by
commit 09cadedbdc01f1a4bea1f427d4fb4642eaa19da9.

It puts it in arch/powerpc/Kconfig. Since I don't see any good reason to leave
this as a supplementary user-selectable option, it is now automatically enabled
whenever SPU_FS and OPROFILE are enabled.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Adrian Bunk <adrian.bunk@movial.fi>
CC: Randy Dunlap <randy.dunlap@oracle.com>
CC: phil.el@wanadoo.fr
CC: paulus@samba.org
CC: linuxppc-dev@ozlabs.org
CC: oprofile-list@lists.sourceforge.net
---
 arch/powerpc/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-lttng/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/Kconfig	2007-12-28 17:00:24.000000000 -0500
+++ linux-2.6-lttng/arch/powerpc/Kconfig	2007-12-28 17:00:39.000000000 -0500
@@ -163,6 +163,10 @@ config PPC_OF_PLATFORM_PCI
 	depends on PPC64 # not supported on 32 bits yet
 	default n
 
+config OPROFILE_CELL
+	def_bool y
+	depends on (SPU_FS = y && OPROFILE = m) || (SPU_FS = y && OPROFILE = y)
+
 source "init/Kconfig"
 
 source "arch/powerpc/platforms/Kconfig"

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
