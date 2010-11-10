Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2162AB70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 01:50:57 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ppc44x:PHY fixup for USB on canyonlands board
Date: Wed, 10 Nov 2010 15:50:15 +0100
References: <201011101137.oAABbFoc015547@amcc.com>
In-Reply-To: <201011101137.oAABbFoc015547@amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011101550.16093.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 10 November 2010 12:37:15 Rupjyoti Sarmah wrote:
> This fix is a reset for USB PHY that requires some amount of time for power
> to be stable on Canyonlands.
> 
> Signed-off-by: Rupjyoti Sarmah <rsarmah@apm.com>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts     |   11 ++++
>  arch/powerpc/platforms/44x/44x.h          |    5 ++
>  arch/powerpc/platforms/44x/Kconfig        |    7 ++
>  arch/powerpc/platforms/44x/Makefile       |    1 +
>  arch/powerpc/platforms/44x/ppc44x_fixup.c |   90
> +++++++++++++++++++++++++++++ 5 files changed, 114 insertions(+), 0
> deletions(-)
>  create mode 100644 arch/powerpc/platforms/44x/ppc44x_fixup.c
> 
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts
> b/arch/powerpc/boot/dts/canyonlands.dts index a303703..d6e9ba2 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -171,6 +171,11 @@
>  				      0x5 0x4>;     /* AHBDMA */
>  		};
> 
> +		CPLD: cpld@e1000000 {
> +			compatible = "apm, ppc460ex-bcsr";
> +			reg = <4 0xe1000000 0x9>;
> +		};

This node should be moved to the EBC section. It would look something like 
this then (note the reg property change here):

				CPLD: cpld@2,0 {
					...
					reg = <2 0x0 0x9>;
				};

Cheers,
Stefan
