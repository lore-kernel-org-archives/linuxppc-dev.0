Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 724DFDDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 02:13:30 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1TFDJKM011930
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:13:19 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1TFDJuE170104
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:13:19 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1TFDImD002857
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:13:19 -0500
Date: Fri, 29 Feb 2008 09:11:20 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 3/5] [POWERPC] Add Canyonlands DTS
Message-ID: <20080229091120.1611ec56@zod.rchland.ibm.com>
In-Reply-To: <1203800881-13837-1-git-send-email-sr@denx.de>
References: <1203800881-13837-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 23 Feb 2008 22:08:01 +0100
Stefan Roese <sr@denx.de> wrote:

> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> And now the I2C device-types are removed. Sorry for the mail-flood.
> 
>  arch/powerpc/boot/dts/canyonlands.dts |  393 +++++++++++++++++++++++++++++++++
>  1 files changed, 393 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/canyonlands.dts
> 
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> new file mode 100644
> index 0000000..2aee74c
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/canyonlands.dts

[snip]

> +		MAL0: mcmal {
> +			compatible = "ibm,mcmal-460ex", "ibm,mcmal2";
> +			dcr-reg = <180 62>;
> +			num-tx-chans = <2>;
> +			num-rx-chans = <10>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&UIC2>;
> +			interrupts = <	/*TXEOB*/ 6 4
> +					/*RXEOB*/ 7 4
> +					/*SERR*/  3 4

This is odd.  I have MAL SERR listed twice in the spec I have.  This
assignment is there, and there's also one to UIC1 IRQ 0.  Error in my
spec, or are both actually tied to the same interrupt line?

> +					/*TXDE*/  4 4
> +					/*RXDE*/  5 4>;
> +		};

> +			UART0: serial@ef600300 {
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <ef600300 8>;
> +				virtual-reg = <ef600300>;
> +				clock-frequency = <0>; /* Filled in by U-Boot */
> +				current-speed = <0>; /* Filled in by U-Boot */
> +				interrupt-parent = <&UIC1>;
> +				interrupts = <1 4>;

Should this be <2 4> or is the spec I have wrong?

josh
