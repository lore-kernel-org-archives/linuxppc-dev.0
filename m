Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3B1B3DDDF5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 16:13:26 +1100 (EST)
Date: Wed, 7 Nov 2007 16:13:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [POWERPC] Stop the TOC overflowing for large builds.
Message-Id: <20071107161329.ec078635.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

With this patch and my patch "Fix link errors for allyesconfig", the
allyesconfig will build again.

I am not sure of the performance effects (if any) of this patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ca51f0c..9374bc9 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,7 +3,7 @@
 #
 
 ifeq ($(CONFIG_PPC64),y)
-EXTRA_CFLAGS	+= -mno-minimal-toc
+CFLAGS_prom_init.o	+= -mno-minimal-toc
 endif
 ifeq ($(CONFIG_PPC32),y)
 CFLAGS_prom_init.o      += -fPIC
-- 
1.5.3.5
