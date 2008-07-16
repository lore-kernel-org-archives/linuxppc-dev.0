Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 16 Jul 2008 07:39:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: fkan@amcc.com
Subject: Re: [PATCH] Add AMCC Arches DTS
Message-ID: <20080716073913.100d259a@zod.rchland.ibm.com>
In-Reply-To: <1216186476-28018-1-git-send-email-fkan@amcc.com>
References: <1216186476-28018-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2008 22:34:36 -0700
fkan@amcc.com wrote:

> From: Victor Gallardo <vgallard@amcc.com>
> 
> ppc4xx: Add AMCC Arches DTS
> 
> Signed-off-by: Victor Gallardo <vgallard@amcc.com>
> ---
>  arch/powerpc/boot/dts/arches.dts |  522 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 522 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/arches.dts
> 
> diff --git a/arch/powerpc/boot/dts/arches.dts b/arch/powerpc/boot/dts/arches.dts
> new file mode 100644
> index 0000000..459cec2
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/arches.dts
> @@ -0,0 +1,522 @@
> +/*
> + * Device Tree Source for AMCC Arches (dual 460GT board)
> + *
> + * (C) Copyright 2008
> + * Victor Gallardo, Applied Micro Circuits Corp., vgallardo@amcc.com.
> + * Adam Graham, Applied Micro Circuits Corp., agraham@amcc.com.
> + *
> + * Based on the glacier.dts file
> + * Stefan Roese <sr@denx.de>
> + * Copyright 2008 DENX Software Engineering
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +/ {

Could you convert this to a dts-v1 file please?  All the in-tree DTS
files are dts-v1 and I'd very much like to keep it that way.

> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "amcc,arches";
> +	compatible = "amcc,arches";
> +	dcr-parent = <&/cpus/cpu@0>;
> +
> +	aliases {
> +		ethernet0 = &EMAC0;
> +		ethernet1 = &EMAC1;
> +		serial0 = &UART0;
> +		serial1 = &UART1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			model = "PowerPC,460GT";
> +			reg = <0>;
> +			clock-frequency = <0>; /* Filled in by U-Boot */
> +			timebase-frequency = <0>; /* Filled in by U-Boot */
> +			i-cache-line-size = <20>;
> +			d-cache-line-size = <20>;
> +			i-cache-size = <8000>;
> +			d-cache-size = <8000>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};

If this is a dual-460GT, why is there only one CPU node listed?  Is it
simply because Linux will only see one CPU as it is an AMP
configuration?

josh
