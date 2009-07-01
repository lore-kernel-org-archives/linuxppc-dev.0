Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74D22B70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:12:14 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A5FDFDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:12:13 +1000 (EST)
Date: Thu, 2 Jul 2009 01:12:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] [spi_mpc83xx] Always enable legacy support.
Message-ID: <20090701211212.GA26231@oksana.dev.rtsoft.ru>
References: <1246475772-10645-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1246475772-10645-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 01, 2009 at 09:16:12PM +0200, Joakim Tjernlund wrote:
> There are out of tree boards that need this legacy support too.

Heh.

> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
> I hope this is OK. I just discovered that spi didn't work for
> me in 2.6.30 and I have no time to work on coverting my boards.

I'd convert them for you if they were in-tree. :-) But I don't
think that moving the kernel backwards because of out-of-tree
boards is a good thing.

> I don't have a clue either on how to do that, any pointers
> how to add a few spidev devices via OF?

Something like this will work:

		spi@4c0 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <0>;
			compatible = "fsl,spi";
			reg = <0x4c0 0x40>;
			interrupts = <2>;
			interrupt-parent = <&qeic>;
			/* provide chip-selects here */
			gpios = <&qe_pio_d 13 0   /* CS0 */
				 &qe_pio_d 14 0>; /* CS1 */
			mode = "cpu-qe";

			device@0 {
				compatible = "spidev";
				reg = <0>; /* CS0*/
				spi-max-frequency = <50000000>;
			};

			device@0 {
				compatible = "spidev";
				reg = <1>; /* CS1 */
				spi-max-frequency = <50000000>;
			};
		};

You can look at arch/powerpc/boot/dts/mpc832x_rdb.dts as an
example.

Note that "spidev" isn't correct compatible entry to use,
but it's quick and dirty solution. A proper solution is to
add a proper compatible entry into the device-tree, and
add "spidev" alias into drivers/of/base.c:of_modalias_table.

>  drivers/spi/spi_mpc83xx.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> index f4573a9..d167577 100644
> --- a/drivers/spi/spi_mpc83xx.c
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -882,7 +882,6 @@ static struct of_platform_driver of_mpc83xx_spi_driver = {
>  	.remove		= __devexit_p(of_mpc83xx_spi_remove),
>  };
>  
> -#ifdef CONFIG_MPC832x_RDB
>  /*
>   * 				XXX XXX XXX
>   * This is "legacy" platform driver, was used by the MPC8323E-RDB boards
> @@ -941,10 +940,6 @@ static void __exit legacy_driver_unregister(void)
>  		return;
>  	platform_driver_unregister(&mpc83xx_spi_driver);
>  }
> -#else
> -static void __init legacy_driver_register(void) {}
> -static void __exit legacy_driver_unregister(void) {}
> -#endif /* CONFIG_MPC832x_RDB */
>  
>  static int __init mpc83xx_spi_init(void)
>  {
> -- 
> 1.6.2.3
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
