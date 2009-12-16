Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Dec 2009 11:02:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [POWERPC] add U-Boot bootcount driver.
Message-ID: <20091216000250.GK9463@yookeroo>
References: <20091216024730.455b90fd@vitb-lp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091216024730.455b90fd@vitb-lp>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 16, 2009 at 02:47:30AM +0300, Vitaly Bordug wrote:
> 
> From: Heiko Schocher <hs@denx.de>
> 
> This driver provides (read/write) access to the
> U-Boot bootcounter via PROC FS or sysFS.
> 
> in u-boot, it uses a 8 byte mem area (it must hold the value over a
> soft reset of course), for storing a bootcounter (it counts many soft
> resets are done, on hard reset it starts with 0). If the bootcountvalue
> exceeds the value in the env variable "bootlimit", and alternative
> bootcmd stored in the env variable "altbootcmd" is run.
> 
> The bootcountregister gets configured via DTS.
> for example on the mgsuvd board:
> 
> bootcount@0x3eb0 {
>                   device_type = "bootcount";

No device_type.

>                   compatible = "uboot,bootcount";
>                   reg = <0x3eb0 0x08>;
>                  };

This area should also be in the flattened tree's reserved map.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
