Return-Path: <blofeldus@yahoo.com>
Received: from web53507.mail.yahoo.com (web53507.mail.yahoo.com
	[206.190.37.68]) by ozlabs.org (Postfix) with SMTP id DCA422BD71
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 00:42:01 +1000 (EST)
Message-ID: <20040915143520.6335.qmail@web53507.mail.yahoo.com>
Date: Wed, 15 Sep 2004 07:35:20 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
To: tnt@246tNt.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc52xx: fix early text output
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes early serial text output
-rb

===== arch/ppc/syslib/mpc52xx_setup.c 1.4 vs edited =====
--- 1.4/arch/ppc/syslib/mpc52xx_setup.c 2004-09-14 09:29:40 -05:00
+++ edited/arch/ppc/syslib/mpc52xx_setup.c      2004-09-15 09:13:10
-05:00
@@ -100,6 +100,14 @@
 #error "mpc52xx PSC for console not selected"
 #endif
 
+static void
+mpc52xx_psc_putc(struct mpc52xx_psc * psc, unsigned char c)
+{
+       while (!(in_be16(&psc->mpc52xx_psc_status) &
+                MPC52xx_PSC_SR_TXRDY)) ;
+       out_8(&psc->mpc52xx_psc_buffer_8, c);
+}
+
 void
 mpc52xx_progress(char *s, unsigned short hex)
 {
@@ -109,15 +117,10 @@
                /* Don't we need to disable serial interrupts ? */
 
        while ((c = *s++) != 0) {
-               if (c == '\n') {
-                       while (!(in_be16(&psc->mpc52xx_psc_status) &
-                                MPC52xx_PSC_SR_TXRDY)) ;
-                       out_8(&psc->mpc52xx_psc_buffer_8, '\r');
-               }
-               while (!(in_be16(&psc->mpc52xx_psc_status) &
-                        MPC52xx_PSC_SR_TXRDY)) ;
-               out_8(&psc->mpc52xx_psc_buffer_8, c);
+               mpc52xx_psc_putc(psc, c);
        }
+       mpc52xx_psc_putc(psc, '\r');
+       mpc52xx_psc_putc(psc, '\n');
 }
 
 #endif  /* CONFIG_SERIAL_TEXT_DEBUG */



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
