Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 708CDDDF52
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 02:28:43 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so539357wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 09:28:42 -0700 (PDT)
Date: Thu, 3 Jul 2008 10:28:09 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080703162809.GH2284@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 09:51:59AM -0400, Jon Smirl wrote:
> DMA, needs to be split out. Efika is AC97 on the MPC5200 and needs to
> share DMA code. The new Phytec pcm030 baseboard is AC97 too.

I agree, but I'm not sure the best way to organize a split.  I'm not
doing anything with the Efika at the moment and I haven't dug into the
details of what needs to be done for AC97.

> What does the device tree look like?

Here is the relevant excerpt, but it is not documented yet.  I haven't
made any attempt encode the layout into the device tree (clocking, etc.)

	spi@f00 {
		#address-cells = <1>;
		#size-cells = <0>;
		compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
		reg = <0xf00 0x20>;
		num-slaves = <32>;
		interrupts = <2 13 0 2 14 0>;
		interrupt-parent = <&mpc5200_pic>;

		codec1: codec@2 {
			compatible = "ti,tlv320aic26";
			linux,modalias = "tlv320aic26";
			max-speed = <1000000>;
			reg = <2>;
		};

		codec2: codec@3 {
			compatible = "ti,tlv320aic26";
			linux,modalias = "tlv320aic26";
			max-speed = <1000000>;
			reg = <3>;
		};
	};

	i2s@2200 {		// PSC2
		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
		cell-index = <1>;
		reg = <0x2200 0x100>;
		interrupts = <2 2 0>;
		interrupt-parent = <&mpc5200_pic>;
		codec-handle = <&codec1>;
	};
	i2s@2400 {		// PSC3
		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
		cell-index = <2>;
		reg = <0x2400 0x100>;
		interrupts = <2 3 0>;
		interrupt-parent = <&mpc5200_pic>;
		codec-handle = <&codec2>;
	};
