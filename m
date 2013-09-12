Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5336E2C0346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 11:12:01 +1000 (EST)
Message-ID: <1378948229.12204.486.camel@snotra.buserror.net>
Subject: Re: [PATCH v4] powerpc/mpc85xx: Update the clock device tree nodes
From: Scott Wood <scottwood@freescale.com>
To: <Yuantian.Tang@freescale.com>
Date: Wed, 11 Sep 2013 20:10:29 -0500
In-Reply-To: <1378882632-9053-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1378882632-9053-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 14:57 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> The following SoCs will be affected: p2041, p3041, p4080,
> p5020, p5040, b4420, b4860, t4240
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> v4:
> 	- add binding document
> 	- update compatible string
> 	- update the reg property
> v3:
> 	- fix typo
> v2:
> 	- add t4240, b4420, b4860 support
> 	- remove pll/4 clock from p2041, p3041 and p5020 board
> 
>  .../devicetree/bindings/clock/corenet-clock.txt    |  80 +++++++++++++++
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  34 ++++++-
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   2 +
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |  34 ++++++-
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  59 ++++++++++-
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  59 ++++++++++-
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        | 111 ++++++++++++++++++++-
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   8 ++
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  41 +++++++-
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   2 +
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  59 ++++++++++-
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  84 +++++++++++++++-
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  12 +++
>  17 files changed, 593 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/corenet-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> new file mode 100644
> index 0000000..51eab75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> @@ -0,0 +1,80 @@
> +Device Tree Clock bindings for Freescale PowerPC corenet platform
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one or more of the following:

Shall include...

> +	- "fsl,<chip>-clockgen": for chip specific clock block
> +	- "fsl,qoriq-clockgen-[1,2].0": for chassis 1.0 and 2.0 clock
> +		block respectively.
> +	- "fsl,qoriq-chassis[1,2]-core-pll" - for a core PLL clock
> +	- "fsl,qoriq-chassis[1,2]-core-mux" - for a core multiplexer clock.
> +		Divided from the core PLL clock

Hmm, there's a bit of a mismatch here between "chassis2" and the "2.0"
on the clockgen node... perhaps it should be "fsl,qoriq-core-pll-2.0",
etc.

> +	- "fixed-clock" - from common clock binding; should be output clock
> +		of oscillator
> +- reg : shall be the control register offset from clock block base address.

This description of "reg" is overly specific (assumes how the parent
node's ranges are set up), incomplete (there's a size as well as the
offset), and does not apply to the clockgen node itself (you probably
shouldn't lump them together like this).

> +- clocks : shall be the input parent clock phandle for the clock.

Not required on the clockgen node

-Scott
