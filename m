Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 750A2DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 00:05:42 +1000 (EST)
Received: from localhost (mail0.scram.de [78.47.204.202])
	by localhost (Postfix) with ESMTP id B58B9548F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 16:05:31 +0200 (CEST)
Received: from mail0.scram.de ([78.47.204.202])
	by localhost (amavis.colab.de [88.198.23.89]) (amavisd-new, port 10024)
	with ESMTP id 8yzo5X99uvJr for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 16:05:26 +0200 (CEST)
Received: from [192.168.95.6] (p54B1ECC0.dip.t-dialin.net [84.177.236.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: scram287)
	by mail0.scram.de (Postfix) with ESMTP id 68147548CB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 16:05:26 +0200 (CEST)
Message-ID: <46EBE6B1.9090209@scram.de>
Date: Sat, 15 Sep 2007 16:05:37 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [PPC] Compile fix for 8xx CPM Ehernet driver
Content-Type: multipart/mixed; boundary="------------060303070409080306000605"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060303070409080306000605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Add #include <asm/cacheflush.h> for flush_dcache_range
to make the driver compile again.

  CC      arch/ppc/8xx_io/enet.o
arch/ppc/8xx_io/enet.c: In function 'scc_enet_start_xmit':
arch/ppc/8xx_io/enet.c:240: error: implicit declaration of function
'flush_dcache_range'
make[1]: *** [arch/ppc/8xx_io/enet.o] Error 1
make: *** [arch/ppc/8xx_io] Error 2

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/ppc/8xx_io/enet.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--------------060303070409080306000605
Content-Type: text/x-patch;
 name="bc5766a0a6e25ccdf6bc1068960cf197ebe5acf5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bc5766a0a6e25ccdf6bc1068960cf197ebe5acf5.diff"

diff --git a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
index 703d47e..eace3bc 100644
--- a/arch/ppc/8xx_io/enet.c
+++ b/arch/ppc/8xx_io/enet.c
@@ -44,6 +44,7 @@
 #include <asm/mpc8xx.h>
 #include <asm/uaccess.h>
 #include <asm/commproc.h>
+#include <asm/cacheflush.h>
 
 /*
  *				Theory of Operation


--------------060303070409080306000605--
