Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 13:06:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/3] sbc834x: Add device tree source for Wind River
	SBC834x board.
Message-ID: <20080110020644.GA17816@localhost.localdomain>
References: <ac667c5b2e8acb0f92d31b8e3b590432bb939df9.1199850992.git.paul.gortmaker@windriver.com>
	<b9cda8aa586eba852f0763db2347d545a5b31be6.1199850992.git.paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b9cda8aa586eba852f0763db2347d545a5b31be6.1199850992.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 12:49:31AM -0500, Paul Gortmaker wrote:
> This adds the device tree source for the Wind River SBC834x board.
> It is based on the MPC834x_MDS DTS, with the biggest difference being
> the lack of BCSR and the PCI2 that the MDS gets via the PIB. That,
> and this file is also dts-v1 format.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/boot/dts/sbc8349.dts |  247 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 247 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts

[snip]
> +		wdt@200 {
> +			device_type = "watchdog";
> +			compatible = "mpc83xx_wdt";

Grah!  Hasn't someone fixed this so that the driver doesn't need the
crap device_type?

[snip]
> +		spi@7000 {
> +			device_type = "spi";
> +			compatible = "fsl_spi";

And again here.

[snip]
> +		usb@22000 {
> +			device_type = "usb";
> +			compatible = "fsl-usb2-mph";

And here.

[snip
> +		/* May need to remove if on a part without crypto engine */
> +		crypto@30000 {
> +			device_type = "crypto";
> +			model = "SEC2";
> +			compatible = "talitos";

I'm almost certain this one was fixed, hasn't it been merged yet?

[snip]
> +		ipic: pic@700 {

By generic names best practice this should be
"interrupt-controller@700", although that's probably not your error.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
