Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC7F2DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 03:52:18 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m4IHqD4W031812
	for <linuxppc-dev@ozlabs.org>; Sun, 18 May 2008 12:52:14 -0500
Date: Sun, 18 May 2008 12:52:13 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.64.0805181252001.23820@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 716532d62cb1bf4087dc90c11b7e361cdcd28db4 Mon Sep 17 00:00:00 2001
From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 16 May 2008 14:10:03 -0500
Subject: [PATCH v3] [POWERPC] Add a comment about the Book-e tophys/tovirt macros

The Book-E versions of tophys/tovirt are not simple noops to
ensure compatibility with their "classic" ppc brethren.

---

Lets try this version based on paul's feedback.

 include/asm-powerpc/ppc_asm.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 2dbd4e7..5499c13 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -356,6 +356,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define toreal(rd)
 #define fromreal(rd)

+/*
+ * We use addis to ensure compatibility with the "classic" ppc versions of
+ * these macros.  use rs = 0 to get the tophys offset in rd, rather than
+ * converting the address in r0, and so this version has to do that too
+ * (i.e. set register rd to 0 when rs == 0)
+ */
 #define tophys(rd,rs)				\
 	addis	rd,rs,0

-- 
1.5.4.5
