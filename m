Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.2.201])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60C4E2BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 22:00:43 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EC0bRt025378
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 14:00:37 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DDA7.1060304@246tNt.com>
Date: Tue, 14 Sep 2004 14:01:43 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] Small updates for Freescale MPC52xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/14 12:30:28+02:00 tnt@246tNt.com
#   ppc: Allow the Freescale MPC52xx to NAP when idle on LITE5200 platform
#  
#   NAP allows some powersave. It's provided mainly as an example on how 
to do it.
#   However, when a BDI is plugged it causes early crashes so be aware !
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/platforms/lite5200.c
#   2004/09/14 12:30:11+02:00 tnt@246tNt.com +7 -0
#   ppc: Allow the Freescale MPC52xx to NAP when idle on LITE5200 platform
#
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2004-09-14 12:48:13 +02:00
+++ b/arch/ppc/platforms/lite5200.c     2004-09-14 12:48:13 +02:00
@@ -36,6 +36,8 @@
 #include <asm/mpc52xx.h>


+extern int powersave_nap;
+
 /* Board data given by U-Boot */
 bd_t __res;
 EXPORT_SYMBOL(__res);  /* For modules */
@@ -123,6 +125,11 @@
        /* No ISA bus AFAIK */
        isa_io_base             = 0;
        isa_mem_base            = 0;
+
+       /* Powersave */
+#ifndef CONFIG_BDI_SWITCH      /* NAP & BDI is a bad combination ... */
+       powersave_nap = 1;      /* We allow this platform to NAP */
+#endif

        /* Setup the ppc_md struct */
        ppc_md.setup_arch       = lite5200_setup_arch;
