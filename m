Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.2.101])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B0552BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 21:53:35 +1000 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EBrLmV015679
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 13:53:21 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DBEF.60803@246tNt.com>
Date: Tue, 14 Sep 2004 13:54:23 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9] Small updates for Freescale MPC52xx
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
#   2004/09/14 00:25:36+02:00 tnt@246tNt.com
#   ppc: Fix spurious iounmap in Freescale MPC52xx syslib
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/14 00:25:27+02:00 tnt@246tNt.com +0 -2
#   ppc: Fix spurious iounmap in Freescale MPC52xx syslib
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:51 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:51 +02:00
@@ -148,8 +148,6 @@
                if (((sdram_config_1 & 0x1f) >= 0x13) &&
                                ((sdram_config_1 & 0xfff00000) == ramsize))
                        ramsize += 1 << ((sdram_config_1 & 0xf) + 17);
-
-               iounmap(mmap_ctl);
        }

        return ramsize;
