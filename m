Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 98204DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 21:53:54 +1100 (EST)
Date: Mon, 5 Mar 2007 11:53:50 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 0/7] MPC5200 and Lite5200b low power modes
Message-ID: <20070305105350.GX4397@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
	<45E89887.1070604@246tNt.com>
	<20070303073336.GC3276@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070303073336.GC3276@nd47.coderock.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 03/03/07 08:33 +0100, Domen Puncer wrote:
> On 02/03/07 22:35 +0100, Sylvain Munaut wrote:
> > Hi,
> > 
> > Thanks for providing theses.
> > I hadn't a chance to test them yet, I'll try that this week end. A
> > couple of comments already though :
> > 
> >  - Is saving the SDMA / PIC registers necessary ? Doesn't the cpu keep
> > those when at sleep ?
> 
> For deep-sleep this is true, but not for low-power mode (the CPU
> isn't even powered in that case).
> 
> >  - And if it is, won't a memcpy_io of the whole zone do the trick ?
> 
> Oh, nice. I wasn't aware of _memcpy_{to,from}io. I'll try it.

OK, one can't copy the whole zone :-(
Ie. reading from MBAR+0x3B00 seems to freeze Linux.

Currently I'm having something like (obsoletes PIC and SDMA patches):


Index: grant.git/arch/powerpc/platforms/52xx/lite5200_pm.c
===================================================================
--- /dev/null
+++ grant.git/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -0,0 +1,125 @@
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <asm/io.h>
+#include <asm/mpc52xx.h>
+#include "mpc52xx_pic.h"
+#include "bestcomm.h"
+
+extern void lite5200_low_power(void *sram, void *mbar);
+extern int mpc52xx_pm_enter(suspend_state_t);
+extern int mpc52xx_pm_prepare(suspend_state_t);
+
+static void __iomem *mbar;
+
+static int lite5200_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int lite5200_pm_prepare(suspend_state_t state)
+{
+	/* deep sleep? let mpc52xx code handle that */
+	if (state == PM_SUSPEND_STANDBY)
+		return mpc52xx_pm_prepare(state);
+
+	if (state != PM_SUSPEND_MEM)
+		return -EINVAL;
+
+	/* map registers */
+	mbar = ioremap_nocache(0xf0000000, 0x8000);
+	if (!mbar) {
+		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+/* save and restore registers not bound to any real devices */
+static struct mpc52xx_cdm __iomem *cdm;
+static struct mpc52xx_cdm scdm;
+static struct mpc52xx_intr __iomem *pic;
+static struct mpc52xx_intr spic;
+static struct mpc52xx_sdma __iomem *bes;
+static struct mpc52xx_sdma sbes;
+static struct mpc52xx_xlb __iomem *xlb;
+static struct mpc52xx_xlb sxlb;
+static struct mpc52xx_gpio __iomem *gps;
+static struct mpc52xx_gpio sgps;
+static struct mpc52xx_gpio_wkup __iomem *gpw;
+static struct mpc52xx_gpio_wkup sgpw;
+extern char saved_sram[0x4000];
+
+static void lite5200_save_regs(void)
+{
+	_memcpy_fromio(&sbes, bes, sizeof(*bes));
+	_memcpy_fromio(&spic, pic, sizeof(*pic));
+	_memcpy_fromio(&scdm, cdm, sizeof(*cdm));
+	_memcpy_fromio(&sxlb, xlb, sizeof(*xlb));
+	_memcpy_fromio(&sgps, gps, sizeof(*gps));
+	_memcpy_fromio(&sgpw, gpw, sizeof(*gpw));
+
+	memcpy(saved_sram, sdma.sram, sdma.sram_size);
+}
+
+static void lite5200_restore_regs(void)
+{
+	memcpy(sdma.sram, saved_sram, sdma.sram_size);
+
+	_memcpy_toio(gpw, &sgpw, sizeof(*gpw));
+	_memcpy_toio(gps, &sgps, sizeof(*gps));
+	_memcpy_toio(xlb, &sxlb, sizeof(*xlb));
+	_memcpy_toio(cdm, &scdm, sizeof(*cdm));
+	_memcpy_toio(pic, &spic, sizeof(*pic));
+	_memcpy_toio(bes, &sbes, sizeof(*bes));
+}
+
+static int lite5200_pm_enter(suspend_state_t state)
+{
+	/* deep sleep? let mpc52xx code handle that */
+	if (state == PM_SUSPEND_STANDBY) {
+		return mpc52xx_pm_enter(state);
+	}
+
+	cdm = mbar + 0x200;
+	pic = mbar + 0x500;
+	gps = mbar + 0xb00;
+	gpw = mbar + 0xc00;
+	bes = mbar + 0x1200;
+	xlb = mbar + 0x1f00;
+	lite5200_save_regs();
+
+	lite5200_low_power(sdma.sram, mbar);
+
+	lite5200_restore_regs();
+
+	iounmap(mbar);
+	return 0;
+}
+
+static int lite5200_pm_finish(suspend_state_t state)
+{
+	return 0;
+}
+
+static struct pm_ops lite5200_pm_ops = {
+	.valid		= lite5200_pm_valid,
+	.prepare	= lite5200_pm_prepare,
+	.enter		= lite5200_pm_enter,
+	.finish		= lite5200_pm_finish,
+};
+
+static int __init lite5200_pm_init(void)
+{
+	pm_set_ops(&lite5200_pm_ops);
+	return 0;
+}
+
+arch_initcall(lite5200_pm_init);
