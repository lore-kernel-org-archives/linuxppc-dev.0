Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 695FDB7B9A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 06:20:22 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 41FFFDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 06:20:20 +1000 (EST)
Date: Tue, 15 Sep 2009 00:20:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v3 2/5] powerpc/85xx/86xx: Add suspend/resume support
Message-ID: <20090914202017.GA14428@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193718.GB17519@oksana.dev.rtsoft.ru>
	<20090914172811.GA9074@b07421-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090914172811.GA9074@b07421-ec1.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds suspend/resume support for MPC8540, MPC8569 and
MPC8641D-compatible CPUs.

MPC8540 and MPC8641D-compatible PMCs are trivial: we just write
the SLP bit into the PM control and status register.

MPC8569 is a bit trickier, QE turns off during suspend, thus on
resume we must reload QE microcode and reset QE.

So far we don't support Deep Sleep mode as found in newer MPC85xx
CPUs (i.e. MPC8536). It can be relatively easy implemented though,
and for it we reserve 'mem' suspend type.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Mon, Sep 14, 2009 at 12:28:11PM -0500, Scott Wood wrote:
[...]
> > So far we don't support Deep Sleep mode as found in newer MPC85xx
> > CPUs (i.e. MPC8536). It can be relatively easy implemented though,
> > and for it we reserve 'mem' suspend type.
> 
> We've got some code floating around here for that; it's just been falling
> through the cracks as far as getting a chance to clean up and push
> upstream.  Hopefully it'll happen soon.

Nice.

[...]
> > +++ b/arch/powerpc/Kconfig
> > @@ -212,7 +212,8 @@ config ARCH_HIBERNATION_POSSIBLE
> >  
> >  config ARCH_SUSPEND_POSSIBLE
> >  	def_bool y
> > -	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
> > +	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
> > +		   PPC_85xx || PPC_86xx
> 
> This isn't directed at this patch, but why do we need this list?  Can't
> each platform figure out for itself whether it can actually register that
> suspend_ops struct, just like any other driver?

Good question. Disabling PM also makes some drivers less
tested, since there are a lot of #ifdef CONFIG_PM in the
drivers.

Though in this patch I'm just following current practice, if
a cleanup patch for all platforms is desired, I can readily
implement it.

[...]
> > +config FSL_PMC
> > +	bool
> > +	default y
> > +	depends on SUSPEND && (PPC_85xx || PPC_86xx)
> > +	help
> > +	  Freescale MPC85xx/MPC86xx power management controller support
> > +	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
> 
> I wish we had a better name for 85xx+86xx than "FSL". :-(

Ditto. It took me quite some time to pick the name, couldn't find
anything better.

> > +static int pmc_suspend_enter(suspend_state_t state)
> > +{
> > +	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
> > +	/* At this point, the CPU is asleep. */
> 
> I'm not sure that we're guaranteed that the sleep has taken effect
> immediately -- we may need to do a loop waiting for it to clear (on
> 85xx), probably with some delays to give the bus a chance to become idle.

Brilliant idea, thanks!

But it works vice versa: upon write, the code flow stops immediately
(on 85xx and 86xx), so there wouldn't any point in trying to readback
the pmcsr. But upon resume, on 86xx (and most probably on 85xx,
though we don't see it), the SLP bit doesn't clear immediately, we
have to wait for it. This eliminates the need for clearing the bit
for 86xx (i.e. the clearing operation worked as a small delay).

> I'm not sure how much of that is necessary under certain conditions,
> versus just paranoia, though.
> 
> Something like what you have here worked
> well enough for us in testing -- but having that clear immediately after
> makes me nervous.  At least a read-back seems appropriate (which I
> suppose the clbits32 does, but I'd prefer something more explicit).
> 
> > +	/* For 86xx we need to clear the bit on resume, 85xx don't care. */
> > +	clrbits32(&pmc_regs->pmcsr, PMCSR_SLP);
> 
> Hmm, how does this work?  Does it only enter sleep mode on the rising
> edge of that bit?

No, it appears it is the same as in 85xx, the bit clears by itself,
but we must wait for it. So your idea about looping and reading the
register actually eliminates the need for clrbits32(). Without the
clrbit32 (aka delay) or proper looping we would let device drivers
to resume too early, and things, obviously, didn't work.

> The 8610 manual says that that bit should only be set as part of a
> sequence also involving the use of MSR[POW] (section 23.5.1.4).

Well, 23.4.1.12 says:

| Sleep status
| 0 The device is not attempting to reach sleep mode.
| 1 The device is attempting to enter sleep mode because
| POWMGTCSR[SLP] is set, or HID0[SLEEP] and MSR[POW] in
                         ^^
| the e600 core are set. The core has halted fetching, snooping
| to the L1 and L2 caches is disabled, ....

The same in 85xx specs.

I can confirm this on real hw, after setting the SLP bit, the 8610
actually goes into sleep mode, no code flow happens until a wakeup
event. So playing with MSR[POW] doesn't seem to be necessary. The
same for 85xx.

> > +	if (pmc_qefw) {
> > +		int ret;
> > +
> > +		ret = qe_upload_firmware(pmc_qefw);
> > +		if (ret)
> > +			dev_err(pmc_dev, "could not upload firmware\n");
> > +
> > +		qe_reset();
> > +	}
> 
> Does this really belong here, or should the QE subsystem have a device
> struct with suspend/resume ops?

This exact snippet could be moved to the "qe" device driver, yes.
But I didn't bother because fsl_pmc have to request the QE firmware.

You can't request the firmware in the qe driver's ->suspend()
routine necause the firmware may be on e.g. NFS filesystem or USB
stick (implies having QE Ethernet or QE USB fully functional).

We can solve that by implementing ppc_md.suspend_prepare() (must
be called from userspace context), there we could request the
firmware. Then QE device driver would reload it in its resume()
callback. Needless to say that it makes things a bit more
complicated to follow.

The current code vanishes without QE anyway. But if you insist,
I can do the suspend_prepare() thing, although I'd prefer it as
a cleanup patch for 2.6.33, since it would touch more code,
specifically I'm concerned about ppc generic files.

How about this patch?

Thanks!

 arch/powerpc/Kconfig          |   11 +++-
 arch/powerpc/sysdev/Makefile  |    1 +
 arch/powerpc/sysdev/fsl_pmc.c |  131 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_pmc.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d00131c..a0743a7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -212,7 +212,8 @@ config ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
-	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
+		   PPC_85xx || PPC_86xx
 
 config PPC_DCR_NATIVE
 	bool
@@ -642,6 +643,14 @@ config FSL_PCI
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
+config FSL_PMC
+	bool
+	default y
+	depends on SUSPEND && (PPC_85xx || PPC_86xx)
+	help
+	  Freescale MPC85xx/MPC86xx power management controller support
+	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
+
 config 4xx_SOC
 	bool
 
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9d4b174..5642924 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
+obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
new file mode 100644
index 0000000..916a21a
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -0,0 +1,131 @@
+/*
+ * Suspend/resume support
+ *
+ * Copyright © 2009  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/suspend.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/of_platform.h>
+#include <linux/firmware.h>
+#include <asm/qe.h>
+
+struct pmc_regs {
+	__be32 devdisr;
+	__be32 devdisr2;
+	__be32 :32;
+	__be32 :32;
+	__be32 pmcsr;
+#define PMCSR_SLP	(1 << 17)
+};
+
+struct pmc_data {
+	unsigned int flags;
+#define PMC_NEED_QE_RELOAD (1 << 0)
+
+	const char *fw_name;
+};
+
+static struct device *pmc_dev;
+static struct pmc_regs __iomem *pmc_regs;
+static const struct pmc_data *pmc_data;
+static struct qe_firmware *pmc_qefw;
+
+static int pmc_suspend_enter(suspend_state_t state)
+{
+	int ret;
+
+	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
+	/* At this point, the CPU is asleep. */
+
+	/* Upon resume, wait for SLP bit to be clear. */
+	ret = spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP) == 0,
+				 10000, 10) ? 0 : -ETIMEDOUT;
+	if (ret)
+		dev_err(pmc_dev, "tired waiting for SLP bit to clear\n");
+
+	if (pmc_qefw) {
+		int ret;
+
+		ret = qe_upload_firmware(pmc_qefw);
+		if (ret)
+			dev_err(pmc_dev, "could not upload firmware\n");
+
+		qe_reset();
+	}
+	return ret;
+}
+
+static int pmc_suspend_valid(suspend_state_t state)
+{
+	if (state != PM_SUSPEND_STANDBY)
+		return 0;
+
+	if (pmc_data && pmc_data->flags & PMC_NEED_QE_RELOAD && !pmc_qefw) {
+		const struct firmware *fw;
+		int ret;
+
+		ret = request_firmware(&fw, pmc_data->fw_name, pmc_dev);
+		if (ret) {
+			dev_err(pmc_dev, "could not request firmware %s\n",
+				pmc_data->fw_name);
+			return 0;
+		}
+
+		pmc_qefw = (struct qe_firmware *)fw->data;
+	}
+
+	return 1;
+}
+
+static struct platform_suspend_ops pmc_suspend_ops = {
+	.valid = pmc_suspend_valid,
+	.enter = pmc_suspend_enter,
+};
+
+static int pmc_probe(struct of_device *ofdev, const struct of_device_id *id)
+{
+	pmc_regs = of_iomap(ofdev->node, 0);
+	if (!pmc_regs)
+		return -ENOMEM;
+
+	pmc_dev = &ofdev->dev;
+	pmc_data = id->data;
+	suspend_set_ops(&pmc_suspend_ops);
+	return 0;
+}
+
+static struct pmc_data mpc8569_pmc_data = {
+	.flags = PMC_NEED_QE_RELOAD,
+	.fw_name = "fsl_qe_ucode_8569.bin",
+};
+
+static const struct of_device_id pmc_ids[] = {
+	{ .compatible = "fsl,mpc8569-pmc", .data = &mpc8569_pmc_data, },
+	{ .compatible = "fsl,mpc8548-pmc", },
+	{ .compatible = "fsl,mpc8641d-pmc", },
+	{ },
+};
+
+static struct of_platform_driver pmc_driver = {
+	.driver.name = "fsl-pmc",
+	.match_table = pmc_ids,
+	.probe = pmc_probe,
+};
+
+static int __init pmc_init(void)
+{
+	return of_register_platform_driver(&pmc_driver);
+}
+device_initcall(pmc_init);
-- 
1.6.3.3
