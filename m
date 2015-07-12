Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 1ECE61A0216
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2015 20:40:38 +1000 (AEST)
Message-Id: <20150712102527.865918129@telegraphics.com.au>
Date: Sun, 12 Jul 2015 20:25:29 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC v4 02/25] char/nvram: Use bitwise OR to obtain Atari video mode
 data
References: <20150712102527.356151908@telegraphics.com.au>
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

---
 drivers/char/nvram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-07-12 20:24:54.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-07-12 20:24:55.000000000 +1000
@@ -702,7 +702,7 @@ static void atari_proc_infos(unsigned ch
 		seq_printf(seq, "%ds%s\n", nvram[10],
 		    nvram[10] < 8 ? ", no memory test" : "");
 
-	vmode = (nvram[14] << 8) || nvram[15];
+	vmode = (nvram[14] << 8) | nvram[15];
 	seq_printf(seq,
 	    "Video mode       : %s colors, %d columns, %s %s monitor\n",
 	    colors[vmode & 7],
