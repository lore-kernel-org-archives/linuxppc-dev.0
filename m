Return-Path: <jonsmirl@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id C7361DED62
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 02:32:30 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so440151rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 09:32:29 -0700 (PDT)
Message-ID: <9e4733910807070932q108da172n117c0670238db8a5@mail.gmail.com>
Date: Mon, 7 Jul 2008 12:32:29 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
In-Reply-To: <20080701235335.16923.43253.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
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

On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
>  This is an I2S bus driver for the MPC5200 PSC device.  It is probably
>  will not be merged as-is because it uses v1 of the ASoC API, but I want
>  to get it out there for comments.
>  ---

I need some slight tweaks since we are using PSC1 in cellphone mode to
distribute the audio clock.

		i2s@2000 { /* PSC1 in i2s mode */
			compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
			cell-index = <0>;
			reg = <0x2000 0x100>;
			interrupts = <0x2 0x1 0x0>;
			interrupt-parent = <&mpc5200_pic>;
		};

		i2s@2200 { /* PSC2 in i2s mode */
			compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
			cell-index = <1>;
			reg = <0x2200 0x100>;
			interrupts = <0x2 0x2 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			codec-handle = <&tas0>;
			fsl5200-cellslave;
		};

Our PSC1 is in master mode, but it doesn't have a codec hooked to it.
I needed to modify the driver to initialize the PSC to i2s master mode
but then not start all of the ALSA support. You can detect this state
since there is no codec node. Putting PSC1 into master mode lets us
get our external audio clock inside the mpc5200.

PSC2 is a cellphone slave. It gets its clock from PSC1. Everything is
the same as what you are doing except I need to set
MPC52xx_PSC_SICR_CELLSLAVE and MPC52xx_PSC_SICR_GENCLK when the
fsl5200-cellslave attribute is present.

We need to tie the two PSCs up like this to get the audio clock in via
PSC1 and then have PSC2 generate the frame clock when the i2s data is
transmitted.

Do you want a diff, or do you have a new version with DMA broken out?


-- 
Jon Smirl
jonsmirl@gmail.com
