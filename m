Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A90EBDDF1B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:52:16 +1000 (EST)
Date: Fri, 11 May 2007 12:52:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] U-boot passes the initrd as start/end, not start/size.
Message-ID: <20070511175202.GA14644@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-83xx.c |    2 +-
 arch/powerpc/boot/cuboot-85xx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
index 6cbc20a..9af554e 100644
--- a/arch/powerpc/boot/cuboot-83xx.c
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -57,7 +57,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 
 	memcpy(&bd, (bd_t *)r3, sizeof(bd));
 	loader_info.initrd_addr = r4;
-	loader_info.initrd_size = r4 ? r5 : 0;
+	loader_info.initrd_size = r4 ? r5 - r4 : 0;
 	loader_info.cmdline = (char *)r6;
 	loader_info.cmdline_len = r7 - r6;
 
diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/cuboot-85xx.c
index f88ba00..e256031 100644
--- a/arch/powerpc/boot/cuboot-85xx.c
+++ b/arch/powerpc/boot/cuboot-85xx.c
@@ -58,7 +58,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 
 	memcpy(&bd, (bd_t *)r3, sizeof(bd));
 	loader_info.initrd_addr = r4;
-	loader_info.initrd_size = r4 ? r5 : 0;
+	loader_info.initrd_size = r4 ? r5 - r4 : 0;
 	loader_info.cmdline = (char *)r6;
 	loader_info.cmdline_len = r7 - r6;
 
-- 
1.5.0.3
