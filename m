Return-Path: <tnt@246tNt.com>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.3.3])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06B822BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 05:40:29 +1000 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8FJeMsP007576
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 21:40:22 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41489AE8.7060203@246tNt.com>
Date: Wed, 15 Sep 2004 21:41:28 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20040915143520.6335.qmail@web53507.mail.yahoo.com>
In-Reply-To: <20040915143520.6335.qmail@web53507.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] mpc52xx: fix early text output
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Roger,

roger blofeld wrote:

>This patch fixes early serial text output
>-rb
>  
>
Thanks for pointing that out. The output is nicer ;)

However, I would leave the test to add a \r in front of a \n.
Even if it doesn't happen in current code, someone may use it (I know I 
did at somepoint in the debug ... )

Applied to my public tree. I'll post it as [PATCH 10/9] in the group of 
updates I'm trying to push upstream.


    Sylvain


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/15 21:23:46+02:00 tnt@246tNt.com
#   ppc: Fix output of low-level serial debug on Freescale MPC52xx
#  
#   Thanks to Roger Blofeld for pointing that out.
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/15 21:23:06+02:00 tnt@246tNt.com +14 -10
#   ppc: Fix output of low-level serial debug on Freescale MPC52xx
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-15 21:24:24 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-15 21:24:24 +02:00
@@ -100,24 +100,28 @@
 #error "mpc52xx PSC for console not selected"
 #endif
 
+static void
+mpc52xx_psc_putc(struct mpc52xx_psc * psc, unsigned char c)
+{
+       while (!(in_be16(&psc->mpc52xx_psc_status) &
+                MPC52xx_PSC_SR_TXRDY));
+       out_8(&psc->mpc52xx_psc_buffer_8, c);
+}
+
 void
 mpc52xx_progress(char *s, unsigned short hex)
 {
        struct mpc52xx_psc *psc = (struct mpc52xx_psc *)MPC52xx_CONSOLE;
        char c;
 
-               /* Don't we need to disable serial interrupts ? */
-      
        while ((c = *s++) != 0) {
-               if (c == '\n') {
-                       while (!(in_be16(&psc->mpc52xx_psc_status) &
-                                MPC52xx_PSC_SR_TXRDY)) ;
-                       out_8(&psc->mpc52xx_psc_buffer_8, '\r');
-               }
-               while (!(in_be16(&psc->mpc52xx_psc_status) &
-                        MPC52xx_PSC_SR_TXRDY)) ;
-               out_8(&psc->mpc52xx_psc_buffer_8, c);
+               if (c == '\n')
+                       mpc52xx_psc_putc(psc, '\r');
+               mpc52xx_psc_putc(psc, c);
        }
+      
+       mpc52xx_psc_putc(psc, '\r');
+       mpc52xx_psc_putc(psc, '\n');
 }
 
 #endif  /* CONFIG_SERIAL_TEXT_DEBUG */
