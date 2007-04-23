Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44862DDEFB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:07:13 +1000 (EST)
Date: Mon, 23 Apr 2007 14:07:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: Fw: [PATCH][RFC] PCMCIA support for 8xx using platform devices
Message-ID: <20070423190700.GA9987@ld0162-tx32.am.freescale.net>
References: <20070422232658.5f427fd3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070422232658.5f427fd3@localhost.localdomain>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-pcmcia@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 22, 2007 at 11:26:58PM +0400, Vitaly Bordug wrote:
> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
> index 90e047a..330ac91 100644
> --- a/arch/powerpc/boot/dts/mpc885ads.dts
> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> @@ -112,6 +112,18 @@
>  			compatible = "CPM";
>  		};
>  
> +               pcmcia@0080 {
> +                       linux,phandle = <0080>;
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       compatible = "8xx";
> +                       device_type = "pcmcia";
> +                       reg = <80 80>;
> +                       clock-frequency = <2faf080>;
> +                       interrupt-parent = <ff000000>;
> +                       interrupts = <d 1>;
> +		};
> +

DTC supports labels now; we should be using those instead of hardcoded
phandles.  Also, please indent by tabs.

-Scott
