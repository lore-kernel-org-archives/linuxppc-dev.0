Return-Path: <tnt@246tNt.com>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.3.51])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFF222BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 06:45:38 +1000 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8FKjT6N012807
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 22:45:30 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4148AA34.3000003@246tNt.com>
Date: Wed, 15 Sep 2004 22:46:44 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/9] Small updates for Freescale MPC52xx - Late one ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

Sorry for this late one, I just got it and it belongs with the others.
I've added it to the bk tree I sent earlier ( 
bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending )
so please pull from that tree.

The unified diff along with the patch description is below.

Thanks,

    Sylvain



# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/15 22:03:38+02:00 tnt@246tNt.com
#   ppc: Fix output of low-level serial debug on Freescale MPC52xx
#  
#   Thanks to Roger Blofeld for pointing that out.
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/15 22:02:23+02:00 tnt@246tNt.com +14 -10
#   ppc: Fix output of low-level serial debug on Freescale MPC52xx
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-15 22:36:07 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-15 22:36:07 +02:00
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
