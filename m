Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C49BDE272
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:20:11 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m4GJK6sb008033
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 14:20:07 -0500
Date: Fri, 16 May 2008 14:20:06 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC v2] Add a comment about the Book-e tophys/tovirt
	macros
Message-ID: <Pine.LNX.4.64.0805161419430.7053@blarg.am.freescale.net>
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

The Book-E versions of tophys/tovirt are not simple noops to
ensure compatibility with their "classic" ppc brethren.

---

Fix my grammar.. why I bother is beyond me.

- k

 include/asm-powerpc/ppc_asm.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 2dbd4e7..668c887 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -356,6 +356,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define toreal(rd)
 #define fromreal(rd)

+/*
+ * We use addis to ensure compatiblity with the "classic" ppc versions
+ * of these macros that might have rs as 0, which means a value of 0
+ * not r0
+ */
 #define tophys(rd,rs)				\
 	addis	rd,rs,0

-- 
1.5.4.5
