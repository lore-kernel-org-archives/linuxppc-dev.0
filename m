Return-Path: <lars@metafoo.de>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125]) by ozlabs.org (Postfix) with ESMTP id B24812C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 22:15:34 +1000 (EST)
Message-ID: <51F9001B.6070203@metafoo.de>
Date: Wed, 31 Jul 2013 14:16:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: fsl: Add S/PDIF CPU DAI driver
References: <cover.1375271745.git.b42378@freescale.com>
 <30e7b0fec9e813b8765514e48296ebecc6ca1039.1375271745.git.b42378@freescale.com>
In-Reply-To: <30e7b0fec9e813b8765514e48296ebecc6ca1039.1375271745.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org,
 timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[...]
a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> new file mode 100644
> index 0000000..a655800
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> @@ -0,0 +1,63 @@
> +Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Freescale S/PDIF audio block is a stereo transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +  - compatible : Compatible list, contains "fsl,spdif".

That's not what the driver says though.

> +
> +  - reg : Offset and length of the register set for the device.
> +
> +  - interrupts : <a b> where a is the interrupt number and b is a field that
> +    represents an encoding of the sense and level information for the interrupt.
> +    This should be encoded based on the information in section 2) depending on
> +    the type of interrupt controller you have.

The exact layout of the cell depends on the parent interrupt controller, so
you probably shouldn't describe it here.

> +
> +  - clocks : The phandle for the clock ID number registered in clock tree.
> +
> +  - fsl,spdif-dma-events: The dma event ID numbers for Tx and Rx.
> +

Use the generic DMA bindings.

> +Optional properties:
> +
> +  - rx-clk-source : The clock cource for Rx. Need to set this source according
> +  to the SoC datasheet in SPDIF_SRPC section. If absent, the default source is
> +  value 0x0 - if (DPLL Locked) SPDIF_RxClk else extal.
> +
> +  - tx-clk-source : The clock cources for Tx. There're three sources, each for
> +  different supported sample rate, sequentially 32000Hz, 44100Hz and 48000Hz.
> +  Need to set this source according to the SoC datasheet in SPDIF_STC section.
> +  If absent, the default source is value 0x1 - CCM spdif0_clk_root input.
> +
> +  - tx-clk-div : The clock divider factor for Tx clock. There're three values,
> +  each for different supported sample rate, sequentially 32000Hz 44100Hz 48000Hz.
> +  Need to set this source according to the clock rate from the clock source.
> +  If absent, the default divider factor is <37 23 37> by using spdif0_clk source.

Can't the driver figure out the divider values on its own based on the input
clock rate?

- Lars
