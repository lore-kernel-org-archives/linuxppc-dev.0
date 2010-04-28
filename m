Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15B0AB7D55
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 00:43:00 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SEZdFt021044
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 08:35:39 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3SEgrhZ127924
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 08:42:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3SEgpO0022422
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 08:42:51 -0600
Date: Wed, 28 Apr 2010 10:42:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2] powerpc/4xx: Add optional "reset_type" property to
	control reboot via dts
Message-ID: <20100428144249.GB29593@zod.rchland.ibm.com>
References: <1272442414-8018-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272442414-8018-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 10:13:34AM +0200, Stefan Roese wrote:
>By setting "reset_type" to one of the following values, the default
>software reset mechanism may be overidden. Here the possible values of
>"reset_type":
>
>  1 - PPC4xx core reset
>  2 - PPC4xx chip reset
>  3 - PPC4xx system reset (default)
>
>This will be used by a new PPC440SPe board port, which needs a "chip
>reset" instead of the default "system reset" to be asserted.
>
>Signed-off-by: Stefan Roese <sr@denx.de>
>Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>---
>v2:
>- Add small property description to Documentation
>- Add sanity check for property value

Thanks for the quick respin.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Ben, I don't have anything else pending for -next at the moment.  Can you pick
this up yourself, or do you want me to create a pull request for just this
patch?

josh

>
> Documentation/powerpc/dts-bindings/4xx/reboot.txt |   18 +++++++++++++++
> arch/powerpc/sysdev/ppc4xx_soc.c                  |   24 +++++++++++++++++++-
> 2 files changed, 40 insertions(+), 2 deletions(-)
> create mode 100644 Documentation/powerpc/dts-bindings/4xx/reboot.txt
>
>diff --git a/Documentation/powerpc/dts-bindings/4xx/reboot.txt b/Documentation/powerpc/dts-bindings/4xx/reboot.txt
>new file mode 100644
>index 0000000..d721726
>--- /dev/null
>+++ b/Documentation/powerpc/dts-bindings/4xx/reboot.txt
>@@ -0,0 +1,18 @@
>+Reboot property to control system reboot on PPC4xx systems:
>+
>+By setting "reset_type" to one of the following values, the default
>+software reset mechanism may be overidden. Here the possible values of
>+"reset_type":
>+
>+      1 - PPC4xx core reset
>+      2 - PPC4xx chip reset
>+      3 - PPC4xx system reset (default)
>+
>+Example:
>+
>+		cpu@0 {
>+			device_type = "cpu";
>+			model = "PowerPC,440SPe";
>+			...
>+			reset-type = <2>;	/* Use chip-reset */
>+		};
>diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
>index 5c01435..d3d6ce3 100644
>--- a/arch/powerpc/sysdev/ppc4xx_soc.c
>+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
>@@ -191,11 +191,31 @@ static int __init ppc4xx_l2c_probe(void)
> arch_initcall(ppc4xx_l2c_probe);
>
> /*
>- * At present, this routine just applies a system reset.
>+ * Apply a system reset. Alternatively a board specific value may be
>+ * provided via the "reset-type" property in the cpu node.
>  */
> void ppc4xx_reset_system(char *cmd)
> {
>-	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_RST_SYSTEM);
>+	struct device_node *np;
>+	u32 reset_type = DBCR0_RST_SYSTEM;
>+	const u32 *prop;
>+
>+	np = of_find_node_by_type(NULL, "cpu");
>+	if (np) {
>+		prop = of_get_property(np, "reset-type", NULL);
>+
>+		/*
>+		 * Check if property exists and if it is in range:
>+		 * 1 - PPC4xx core reset
>+		 * 2 - PPC4xx chip reset
>+		 * 3 - PPC4xx system reset (default)
>+		 */
>+		if ((prop) && ((prop[0] >= 1) && (prop[0] <= 3)))
>+			reset_type = prop[0] << 28;
>+	}
>+
>+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | reset_type);
>+
> 	while (1)
> 		;	/* Just in case the reset doesn't work */
> }
>-- 
>1.7.1
>
