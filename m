Return-Path: <sshtylyov@mvista.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 84D1BB7E4A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 May 2010 03:45:09 +1000 (EST)
Received: by wyb32 with SMTP id 32so383777wyb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 10:45:07 -0700 (PDT)
Message-ID: <4BED8BF1.5080800@ru.mvista.com>
Date: Fri, 14 May 2010 21:44:17 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
References: <201005051757.o45HvPmY005954@amcc.com>
In-Reply-To: <201005051757.o45HvPmY005954@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, sr@denx.de, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Rupjyoti Sarmah wrote:

> This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
>
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com> 
> Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts |    8 +
>  drivers/ata/Kconfig                   |    9 +
>  drivers/ata/Makefile                  |    1 +
>  drivers/ata/sata_dwc.c                | 1827 +++++++++++++++++++++++++++++++++
>  4 files changed, 1845 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c
>
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> index cd56bb5..d3b2c99 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -163,6 +163,14 @@
>  			interrupts = <0x1e 4>;
>  		};
>  
> +		SATA0: sata@bffd1000 {
> +                        compatible = "amcc,sata-460ex";
> +			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
> +                        interrupt-parent = <&UIC3>;
> +                        interrupts = <0x0 0x4       /* SATA */
> +                                      0x5 0x4>;     /* AHBDMA */
> +                };
> +
>  		POB0: opb {
>  			compatible = "ibm,opb-460ex", "ibm,opb";
>  			#address-cells = <1>;
>   

   Please put the device tree update in a separate patch to go thru the 
PowerPC tree.

MBR, Sergei
