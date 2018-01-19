Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNbyY3kVtzF0xZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jan 2018 10:05:25 +1100 (AEDT)
Received: by mail-ot0-f194.google.com with SMTP id r4so2759928oti.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 15:05:25 -0800 (PST)
Date: Fri, 19 Jan 2018 17:05:21 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/6] dt-bindings: gpio: Add binding for Wii GPIO controller
Message-ID: <20180119230521.st5uon74fpi4jghc@rob-hp-laptop>
References: <20180115031401.19577-1-j.neuschaefer@gmx.net>
 <20180115031401.19577-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180115031401.19577-5-j.neuschaefer@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2018 at 04:13:59AM +0100, Jonathan Neuschäfer wrote:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/gpio/nintendo,hollywood-gpio.txt      | 27 ++++++++++++++++++++++
>  .../devicetree/bindings/powerpc/nintendo/wii.txt   |  9 +-------
>  2 files changed, 28 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt b/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
> new file mode 100644
> index 000000000000..a97ce6b5b724
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
> @@ -0,0 +1,27 @@
> +Nintendo Wii (Hollywood) GPIO controller
> +
> +Required properties:
> +- compatible: "nintendo,hollywood-gpio
> +- reg: Physical base address and length of the controller's registers.
> +- gpio-controller: Marks the device node as a GPIO controller.
> +- #gpio-cells: Should be <2>. The first cell is the pin number and the
> +  second cell is used to specify optional parameters:
> +   - bit 0 specifies polarity (0 for normal, 1 for inverted).
> +
> +Optional properties:
> +- ngpios: see Documentation/devicetree/bindings/gpio/gpio.txt
> +- interrupt-controller: Marks the device node as an interrupt controller.
> +- #interrupt-cells: Should be two.
> +- interrupts: Interrupt specifier for the controller's Broadway (PowerPC)
> +  interrupt.
> +- interrupt-parent: phandle of the parent interrupt controller.
> +
> +Example:
> +
> +	GPIO: gpio@0d8000c0 {

Drop the leading 0.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
