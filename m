Return-Path: <tnt@246tNt.com>
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.2.202])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81A0F2BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 22:02:04 +1000 (EST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EC1nCP012390
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 14:01:50 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DDE8.6060200@246tNt.com>
Date: Tue, 14 Sep 2004 14:02:48 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] Small updates for Freescale MPC52xx
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
#   2004/09/14 12:39:19+02:00 tnt@246tNt.com
#   ppc: Add Freescale MPC52xx I2C Support using i2c-mpc.c
#   
#   Just adds the necessary OCP def entry.
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/platforms/mpc5200.c
#   2004/09/14 12:39:00+02:00 tnt@246tNt.com +24 -0
#   ppc: Add Freescale MPC52xx I2C Support using i2c-mpc.c
#
diff -Nru a/arch/ppc/platforms/mpc5200.c b/arch/ppc/platforms/mpc5200.c
--- a/arch/ppc/platforms/mpc5200.c      2004-09-14 12:48:21 +02:00
+++ b/arch/ppc/platforms/mpc5200.c      2004-09-14 12:48:21 +02:00
@@ -16,6 +16,12 @@
 #include <asm/ocp.h>
 #include <asm/mpc52xx.h>

+
+struct ocp_fs_i2c_data mpc5200_i2c_def = {
+        .flags  = FS_I2C_CLOCK_5200,
+};
+
+
 /* Here is the core_ocp struct.
  * With all the devices common to all board. Even if port multiplexing is
  * not setup for them (if the user don't want them, just don't select the
@@ -23,6 +29,24 @@
  * board specific file.
  */
 struct ocp_def core_ocp[] = {
+       {
+               .vendor         = OCP_VENDOR_FREESCALE,
+               .function       = OCP_FUNC_IIC,
+               .index          = 0,
+               .paddr          = MPC52xx_I2C1,
+               .irq            = OCP_IRQ_NA,   /* MPC52xx_IRQ_I2C1 - 
Buggy */
+               .pm             = OCP_CPM_NA,
+               .additions      = &mpc5200_i2c_def,
+       },
+       {
+               .vendor         = OCP_VENDOR_FREESCALE,
+               .function       = OCP_FUNC_IIC,
+               .index          = 1,
+               .paddr          = MPC52xx_I2C2,
+               .irq            = OCP_IRQ_NA,   /* MPC52xx_IRQ_I2C2 - 
Buggy */
+               .pm             = OCP_CPM_NA,
+               .additions      = &mpc5200_i2c_def,
+       },
        {       /* Terminating entry */
                .vendor         = OCP_VENDOR_INVALID
        }
