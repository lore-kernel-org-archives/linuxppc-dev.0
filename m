Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11564B70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 13:23:22 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB4D4DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 13:23:21 +1000 (EST)
Date: Sat, 6 Jun 2009 10:44:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: leon.woestenberg@gmail.com
Subject: Re: [PATCH] Add MSI interrupts to DTS of MPC8315E-RDB
Message-ID: <20090606004410.GA10940@yookeroo.seuss>
References: <4a292f95.05a4100a.1a14.0a04@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4a292f95.05a4100a.1a14.0a04@mx.google.com>
Cc: linuxppc-dev@ozlabs.org, Leon Woestenberg <leon@sidebranch.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 05, 2009 at 07:45:41AM -0700, leon.woestenberg@gmail.com wrote:
> The PCIe MSI interrupts are missing from the device tree source, and
> thus were not enabled. This patch adds them.
> 
> Tested to work on MPC8315E-RDB with custom FPGA PCIe device.
> 
> Signed-off-by: Leon Woestenberg <leon@sidebranch.com>
> Tested-by: Leon Woestenberg <leon@sidebranch.com>
> 
> diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
> index 3f4c5fb..4f04667 100644
> --- a/arch/powerpc/boot/dts/mpc8315erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
> @@ -322,6 +322,21 @@
>  			reg = <0x700 0x100>;
>  			device_type = "ipic";
>  		};
> +
> +		ipic-msi@7c0 {
> +			compatible = "fsl,ipic-msi";
> +                        reg = <0x7c0 0x40>;
> +                        msi-available-ranges = <0 0x100>;

This patch appears not to use consistent whitespace formatting.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
