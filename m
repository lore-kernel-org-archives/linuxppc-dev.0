Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F3CDDDF32
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 18:58:16 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5Q8wBqH029489
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 03:58:12 -0500
Date: Thu, 26 Jun 2008 03:58:11 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/bootwrapper: Pad .dtb by default
Message-ID: <Pine.LNX.4.64.0806260357520.15915@blarg.am.freescale.net>
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

Since most bootloaders or wrappers tend to update or add some information
to the .dtb they a handled they need some working space to do that in.

By default add 1K of padding via a default setting of DTS_FLAGS.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 25d9fb0..85b45f1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -35,6 +35,8 @@ endif

 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(srctree)/$(src)/libfdt

+DTS_FLAGS	?= -p 1024
+
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
-- 
1.5.5.1
