Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.3.70])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA0952BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 21:49:06 +1000 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EBn05Y022741
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 13:49:00 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DAEC.1040107@246tNt.com>
Date: Tue, 14 Sep 2004 13:50:04 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] Small updates for Freescale MPC52xx
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
#   2004/09/14 00:02:45+02:00 tnt@246tNt.com
#   ppc: Use dummy_con for conswitchp on Freescale MPC52xx platforms
#  
#   Apparently needed for when virtual consoles are enabled.
#  
#   Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
#   Signed-off-by: Sylvain Munaut <tnt246tNt.com>
#
# arch/ppc/platforms/lite5200.c
#   2004/09/14 00:02:31+02:00 tnt@246tNt.com +4 -0
#   ppc: Use dummy_con for conswitchp on Freescale MPC52xx platforms
#
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:37 +02:00
+++ b/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:37 +02:00
@@ -147,5 +147,9 @@
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
        ppc_md.progress         = mpc52xx_progress;
 #endif
+
+#ifdef CONFIG_DUMMY_CONSOLE
+       conswitchp = &dummy_con;
+#endif
 }
