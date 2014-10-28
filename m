Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0132.outbound.protection.outlook.com [207.46.100.132])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF9961A0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 10:09:05 +1100 (AEDT)
Message-ID: <1414537731.23458.120.camel@snotra.buserror.net>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Tue, 28 Oct 2014 18:08:51 -0500
In-Reply-To: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Rainer Boschung <rainer.boschung@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>, Holger
 Brunck <holger.brunck@keymile.com>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>,
 Linux I2C <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-17 at 11:27 +0200, Valentin Longchamp wrote:
> With "fsl-i2c" compatibility the i2c frequency is not set
> correctly, because it sets no prescaler. According to the AN2919 from
> Freescale and the QorIQ (P2041) documentation, the source clock is 1/2
> the platform clock. This implies that a prescaler of 2 must be used.
> 
> This changes the compatibility of the qoriq-i2c .dtsi files to pick the
> mpc8543, which uses the same driver but sets the correct prescaler.
> 
> Signed-off-by: Rainer Boschung <rainer.boschung@keymile.com>
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
> 
>  arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi | 4 ++--
>  arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
> index 5f9bf7d..aa6c366 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
> @@ -36,7 +36,7 @@ i2c@118000 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	cell-index = <0>;
> -	compatible = "fsl-i2c";
> +	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
>  	reg = <0x118000 0x100>;
>  	interrupts = <38 2 0 0>;
>  	dfsrr;
> @@ -46,7 +46,7 @@ i2c@118100 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	cell-index = <1>;
> -	compatible = "fsl-i2c";
> +	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
>  	reg = <0x118100 0x100>;
>  	interrupts = <38 2 0 0>;
>  	dfsrr;

Are all chips that use this dtsi 100% compatible with mpc8543's i2c, or
just in ways the Linux driver cares about?

What about fsl,mpc8544-i2c, which has additional special handling in the
driver, but is only used in socrates.dts (not mpc8544ds.dts)?

What about pq3-i2c-*.dtsi?

-Scott
