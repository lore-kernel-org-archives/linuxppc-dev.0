Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB9CADDF45
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 03:19:40 +1000 (EST)
Date: Thu, 26 Apr 2007 12:19:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] bootwrapper: cuboot-83xx: Exclude upper 1MB from heap.
Message-ID: <20070426171931.GA13647@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The uppermost part of memory is where u-boot puts the stack, so don't
include that in the heap.  It's not currently causing problems, as the
current code allocates from the bottom of the heap, but this will keep
things from potentially breaking if a future implementation were to
allocate from the top.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-83xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
index 8f11d1e..6cbc20a 100644
--- a/arch/powerpc/boot/cuboot-83xx.c
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -61,7 +61,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	loader_info.cmdline = (char *)r6;
 	loader_info.cmdline_len = r7 - r6;
 
-	simple_alloc_init(_end, avail_ram, 32, 64);
+	simple_alloc_init(_end, avail_ram - 1024*1024, 32, 64);
 	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
-- 
1.5.0.3
