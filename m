Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id ADDB1DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 15:27:07 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so9077199wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jan 2008 20:27:06 -0800 (PST)
Message-ID: <9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
Date: Tue, 1 Jan 2008 23:27:06 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <11981089894052-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>  sound/soc/fsl/fsl_ssi.c                      |  614 +++++++++++++++++++
>  sound/soc/fsl/fsl_ssi.h                      |  224 +++++++

I'm confused about this part. You built a driver for the mpc8610 ssi
port.  This port has a device tree entry.

+		ssi@16000 {
+			compatible = "fsl,ssi";
+			cell-index = <0>;
+			reg = <16000 100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <3e 2>;
+			fsl,mode = "i2s-slave";
+			codec {
+				compatible = "cirrus,cs4270";
+				/* MCLK source is a stand-alone oscillator */
+				bus-frequency = <bb8000>;
+			};
+		};

But then you don't create an of_platform_driver for this device.
Instead you create one for the fabric driver, struct
of_platform_driver mpc8610_hpcd_of_driver, and directly link the SSI
driver into it.

+static struct of_device_id mpc8610_hpcd_match[] = {
+	{
+		.compatible = "fsl,ssi",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
+
+static struct of_platform_driver mpc8610_hpcd_of_driver = {
+	.owner  	= THIS_MODULE,
+	.name   	= "mpc8610_hpcd",
+	.match_table    = mpc8610_hpcd_match,
+	.probe  	= mpc8610_hpcd_probe,
+	.remove 	= mpc8610_hpcd_remove,
+};

static int mpc8610_hpcd_probe(struct of_device *ofdev,
	const struct of_device_id *match)
{
.....
	machine_data->dai.cpu_dai = fsl_ssi_create_dai(&ssi_info);

Isn't this two separate drivers that have been combined into one
driver? Or does the fsl_ssi channel only work on the mpc8610_hpcd?

This is the problem of knowing how to load the fabric driver that I
was talking about in the other threads. A device that can occur on
more than one chip ".compatible = "fsl,ssi"," is being used to pull in
a platform specific fabric driver, "mpc8610_hpcd". You can use the
kernel config system to select the right driver for ".compatible =
"fsl,ssi"," that matches you hardware and compile it in.

But that doesn't work in my environment. My generic channel is
"fsl,i2s". I have four different systems booting off from a shared
network drive. Each of these systems needs the common "fsl,i2s" driver
but they all four need different fabric drivers.

-- 
Jon Smirl
jonsmirl@gmail.com
