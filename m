Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 1850B1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 17:56:50 +1000 (AEST)
Message-Id: <20150725074600.033410118@telegraphics.com.au>
Date: Sat, 25 Jul 2015 17:46:01 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC v5 02/26] char/nvram: Use bitwise OR to obtain Atari video mode
 data
References: <20150725074559.543547894@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Christian T. Steigies <cts@debian.org>

---
 drivers/char/nvram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-07-25 17:42:34.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-07-25 17:45:25.000000000 +1000
@@ -702,7 +702,7 @@ static void atari_proc_infos(unsigned ch
 		seq_printf(seq, "%ds%s\n", nvram[10],
 		    nvram[10] < 8 ? ", no memory test" : "");
 
-	vmode = (nvram[14] << 8) || nvram[15];
+	vmode = (nvram[14] << 8) | nvram[15];
 	seq_printf(seq,
 	    "Video mode       : %s colors, %d columns, %s %s monitor\n",
 	    colors[vmode & 7],
