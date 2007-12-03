Return-Path: <jtyner@eon.cs.ucr.edu>
Received: from mail.cs.ucr.edu (mail.cs.ucr.edu [138.23.169.83])
	by ozlabs.org (Postfix) with ESMTP id 2CEE5DDE9C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 07:58:40 +1100 (EST)
Received: from mail.cs.ucr.edu (localhost.localdomain [127.0.0.1])
	by mail.cs.ucr.edu (Postfix) with ESMTP id CEB2F2AEB9D
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 12:58:37 -0800 (PST)
Received: from eon.cs.ucr.edu (eon.cs.ucr.edu [138.23.169.9])
	by mail.cs.ucr.edu (Postfix) with ESMTP id 7D18A2AEB8B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 12:58:37 -0800 (PST)
Received: from eon.cs.ucr.edu (localhost.localdomain [127.0.0.1])
	by eon.cs.ucr.edu (Postfix) with ESMTP id 65FE6F3FC9
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 12:58:38 -0800 (PST)
Received: (from jtyner@localhost)
	by eon.cs.ucr.edu (8.13.1/8.13.1/Submit) id lB3KwcND027038
	for linuxppc-dev@ozlabs.org; Mon, 3 Dec 2007 12:58:38 -0800
Date: Mon, 3 Dec 2007 12:58:38 -0800
From: John Tyner <jtyner@cs.ucr.edu>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix 8xx compile errors
Message-ID: <20071203205837.GA22557@cs.ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Building for 8xx fails to compile due to errors in a couple of places. 
The first is due to the casting of an lvalue (if I remember correctly), 
and the second was due to the cpmp variable being declared static even 
though the headers previously defined it as extern. The following patch 
corrects these errors. The patch is against 2.4 since that's what I'm 
working with. (I've been unable to get 2.6 to run properly on my 
hardware so far.)

Please CC me on any responses since I'm not subscribed.

Thanks,
John



--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="8xx_compile.patch"

diff -ruNa linux-2.4.35.4.orig/arch/ppc/8xx_io/uart.c linux-2.4.35.4/arch/ppc/8xx_io/uart.c
--- linux-2.4.35.4.orig/arch/ppc/8xx_io/uart.c	2007-11-17 09:23:15.000000000 -0800
+++ linux-2.4.35.4/arch/ppc/8xx_io/uart.c	2007-11-27 11:28:09.000000000 -0800
@@ -2292,7 +2292,8 @@
 
 		/* Get the address of the host memory buffer.*/
 		info = &consinfo;
-		info->tx_bd_base = (cbd_t *)bdbase = (cbd_t *)&cpmp->cp_dpmem[up->smc_tbase];
+		bdbase = (cbd_t *)&cpmp->cp_dpmem[up->smc_tbase];
+		info->tx_bd_base = (cbd_t *)bdbase;
 		info->tx_cur = (cbd_t *)bdbase;
 	}
 	max_tx_size = console_tx_buf_len;
diff -ruNa linux-2.4.35.4.orig/arch/ppc/boot/simple/m8xx_tty.c linux-2.4.35.4/arch/ppc/boot/simple/m8xx_tty.c
--- linux-2.4.35.4.orig/arch/ppc/boot/simple/m8xx_tty.c	2007-11-17 09:23:15.000000000 -0800
+++ linux-2.4.35.4/arch/ppc/boot/simple/m8xx_tty.c	2007-11-27 11:28:42.000000000 -0800
@@ -30,7 +30,7 @@
 #define SMC_INDEX	0
 #endif
 
-static cpm8xx_t	*cpmp = (cpm8xx_t *)&(((immap_t *)IMAP_ADDR)->im_cpm);
+cpm8xx_t	*cpmp = (cpm8xx_t *)&(((immap_t *)IMAP_ADDR)->im_cpm);
 
 unsigned long
 serial_init(int ignored, bd_t *bd)

--n8g4imXOkfNTN/H1--
