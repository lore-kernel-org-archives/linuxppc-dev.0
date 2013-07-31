Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50EEE2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 00:12:26 +1000 (EST)
From: Chen Guangyu-B42378 <B42378@freescale.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Wed, 31 Jul 2013 14:12:18 +0000
Message-ID: <E31481825E4C03459FC878EE97CB2EFD0CC2E0AA@039-SN2MPN1-023.039d.mgd.msft.net>
References: <cover.1375271745.git.b42378@freescale.com>
 <30e7b0fec9e813b8765514e48296ebecc6ca1039.1375271745.git.b42378@freescale.com>,
 <51F9001B.6070203@metafoo.de>
In-Reply-To: <51F9001B.6070203@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>, "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lars

Thank you for the sage advices.

I'll revise the patch and send the v2.
________________________________________
From: Lars-Peter Clausen [lars@metafoo.de]
Sent: Wednesday, July 31, 2013 8:16 PM
To: Chen Guangyu-B42378
Cc: broonie@kernel.org; timur@tabi.org; alsa-devel@alsa-project.org; linuxp=
pc-dev@lists.ozlabs.org; devicetree-discuss@lists.ozlabs.org; rob.herring@c=
alxeda.com
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: fsl: Add S/PDIF CPU DAI driver

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
> +  - interrupts : <a b> where a is the interrupt number and b is a field =
that
> +    represents an encoding of the sense and level information for the in=
terrupt.
> +    This should be encoded based on the information in section 2) depend=
ing on
> +    the type of interrupt controller you have.

The exact layout of the cell depends on the parent interrupt controller, so
you probably shouldn't describe it here.

> +
> +  - clocks : The phandle for the clock ID number registered in clock tre=
e.
> +
> +  - fsl,spdif-dma-events: The dma event ID numbers for Tx and Rx.
> +

Use the generic DMA bindings.

> +Optional properties:
> +
> +  - rx-clk-source : The clock cource for Rx. Need to set this source acc=
ording
> +  to the SoC datasheet in SPDIF_SRPC section. If absent, the default sou=
rce is
> +  value 0x0 - if (DPLL Locked) SPDIF_RxClk else extal.
> +
> +  - tx-clk-source : The clock cources for Tx. There're three sources, ea=
ch for
> +  different supported sample rate, sequentially 32000Hz, 44100Hz and 480=
00Hz.
> +  Need to set this source according to the SoC datasheet in SPDIF_STC se=
ction.
> +  If absent, the default source is value 0x1 - CCM spdif0_clk_root input=
.
> +
> +  - tx-clk-div : The clock divider factor for Tx clock. There're three v=
alues,
> +  each for different supported sample rate, sequentially 32000Hz 44100Hz=
 48000Hz.
> +  Need to set this source according to the clock rate from the clock sou=
rce.
> +  If absent, the default divider factor is <37 23 37> by using spdif0_cl=
k source.

Can't the driver figure out the divider values on its own based on the inpu=
t
clock rate?

- Lars
