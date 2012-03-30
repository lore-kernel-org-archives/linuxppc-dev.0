Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 18EFBB6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 07:05:25 +1100 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 10/15] powerpc: mark const init data with __initconst
 instead of __initdata
Date: Fri, 30 Mar 2012 22:05:00 +0200
Message-Id: <1333137905-13809-10-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20120330200358.GV15647@pengutronix.de>
References: <20120330200358.GV15647@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Paul Mackerras <paulus@samba.org>, kernel@pengutronix.de,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As long as there is no other non-const variable marked __initdata in the
same compilation unit it doesn't hurt. If there were one however
compilation would fail with

	error: $variablename causes a section type conflict

because a section containing const variables is marked read only and so
cannot contain non-const variables.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Josh Boyer <jwboyer@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: cbe-oss-dev@lists.ozlabs.org
---
changes since (implicit) v1:
 - drop wrong changes to several files:
   - arch/powerpc/platforms/40x/ppc40x_simple.c
   - arch/powerpc/platforms/512x/mpc5121_generic.c
   - arch/powerpc/platforms/52xx/lite5200.c
   - arch/powerpc/platforms/52xx/media5200.c
   - arch/powerpc/platforms/52xx/mpc5200_simple.c
   - arch/powerpc/platforms/83xx/mpc830x_rdb.c
   - arch/powerpc/platforms/83xx/mpc831x_rdb.c
   - arch/powerpc/platforms/83xx/mpc837x_rdb.c
   - arch/powerpc/platforms/85xx/tqm85xx.c

 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    2 +-
 arch/powerpc/platforms/cell/qpace_setup.c |    2 +-
 arch/powerpc/platforms/cell/setup.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index bfb11e0..e2d401a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -93,7 +93,7 @@ struct mpc52xx_pci {
 };
 
 /* MPC5200 device tree match tables */
-const struct of_device_id mpc52xx_pci_ids[] __initdata = {
+const struct of_device_id mpc52xx_pci_ids[] __initconst = {
 	{ .type = "pci", .compatible = "fsl,mpc5200-pci", },
 	{ .type = "pci", .compatible = "mpc5200-pci", },
 	{}
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index 7f9b674..6e3409d 100644
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -61,7 +61,7 @@ static void qpace_progress(char *s, unsigned short hex)
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static const struct of_device_id qpace_bus_ids[] __initdata = {
+static const struct of_device_id qpace_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "spider", },
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index fa3e294..4ab0876 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -140,7 +140,7 @@ static int __devinit cell_setup_phb(struct pci_controller *phb)
 	return 0;
 }
 
-static const struct of_device_id cell_bus_ids[] __initdata = {
+static const struct of_device_id cell_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "spider", },
-- 
1.7.9.5
