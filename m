Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7E2BDDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 04:24:37 +1000 (EST)
Date: Wed, 25 Jun 2008 20:24:25 +0200
From: Sebastian Siewior <sebastian@breakpoint.cc>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH v2] USB: isp1760: Support board-specific hardware
	configurations
Message-ID: <20080625182425.GA29841@Chamillionaire.breakpoint.cc>
References: <1213719098-28002-1-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1213719098-28002-1-git-send-email-ncase@xes-inc.com>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Nate Case | 2008-06-17 11:11:38 [-0500]:

>This adds support for hardware configurations that don't match the
>chip default register settings (e.g., 16-bit data bus, DACK and
>DREQ pulled up instead of down, analog overcurrent mode).
>
>These settings are passed in via the OF device tree.  The PCI
>interface still assumes the same default values.
>
>Signed-off-by: Nate Case <ncase@xes-inc.com>
Acked-by: Sebastian Siewior <sebastian@breakpoint.cc>

>diff --git a/drivers/usb/host/isp1760-if.c b/drivers/usb/host/isp1760-if.c
>index 440bf94..56e2ad6 100644
>--- a/drivers/usb/host/isp1760-if.c
>+++ b/drivers/usb/host/isp1760-if.c
>@@ -35,6 +35,8 @@ static int of_isp1760_probe(struct of_device *dev,
> 	int virq;
> 	u64 res_len;
> 	int ret;
>+	const unsigned int *prop;
>+	unsigned int devflags = 0;
> 
> 	ret = of_address_to_resource(dp, 0, &memory);
> 	if (ret)
>@@ -55,8 +57,32 @@ static int of_isp1760_probe(struct of_device *dev,
> 	virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
> 			oirq.size);
> 
>+	if (of_device_is_compatible(dp, "nxp,usb-isp1761"))
>+		devflags |= ISP1760_FLAG_ISP1761;
>+
>+	if (of_get_property(dp, "port1-disable", NULL) != NULL)
>+		devflags |= ISP1760_FLAG_PORT1_DIS;
>+
>+	/* Some systems wire up only 16 of the 32 data lines */
>+	prop = of_get_property(dp, "bus-width", NULL);
>+	if (prop && *prop == 16)
>+		devflags |= ISP1760_FLAG_BUS_WIDTH_16;

The only thing I'm not 100% sure is whether it is okey for bus-width to
be detected like that and of_device_is_compatible() vs a special data
entry in of_isp1760_match to distinguish the two chip from each other.
Since nobody of the linuxppc spoke up so far, then I guess it is okey.

Kumar / Josh: Should we describe those DT entries in
Documentation/powerpc/booting-without-of.txt? In the yes case: which
section do you recommend?

>+
>+	if (of_get_property(dp, "port1-otg", NULL) != NULL)
>+		devflags |= ISP1760_FLAG_OTG_EN;
>+
>+	if (of_get_property(dp, "analog-oc", NULL) != NULL)
>+		devflags |= ISP1760_FLAG_ANALOG_OC;
>+
>+	if (of_get_property(dp, "dack-polarity", NULL) != NULL)
>+		devflags |= ISP1760_FLAG_DACK_POL_HIGH;
>+
>+	if (of_get_property(dp, "dreq-polarity", NULL) != NULL)
>+		devflags |= ISP1760_FLAG_DREQ_POL_HIGH;
>+
> 	hcd = isp1760_register(memory.start, res_len, virq,
>-		IRQF_SHARED | IRQF_DISABLED, &dev->dev, dev->dev.bus_id);
>+		IRQF_SHARED | IRQF_DISABLED, &dev->dev, dev->dev.bus_id,
>+		devflags);
> 	if (IS_ERR(hcd)) {
> 		ret = PTR_ERR(hcd);
> 		goto release_reg;
>@@ -87,6 +113,9 @@ static struct of_device_id of_isp1760_match[] = {
> 	{
> 		.compatible = "nxp,usb-isp1760",
> 	},
>+	{
>+		.compatible = "nxp,usb-isp1761",
>+	},
> 	{ },
> };

Sebastian
