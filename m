Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0158.outbound.protection.outlook.com [207.46.163.158])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 67FEB2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 12:12:40 +1100 (EST)
Date: Tue, 7 Jan 2014 19:12:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [v2] powerpc 8xx: defconfig: slice by 4 is more efficient than
 the default slice by 8 on Powerpc 8xx.
Message-ID: <20140108011224.GA18429@home.buserror.net>
References: <20131122172829.CC8EE1A4DE7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131122172829.CC8EE1A4DE7@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 22, 2013 at 06:28:29PM +0100, LEROY Christophe wrote:
> On PPC_8xx, CRC32_SLICEBY4 is more efficient (almost twice) than CRC32_SLICEBY8,
> as shown below:
> 
> With CRC32_SLICEBY8:
> [    1.109204] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
> [    1.114401] crc32: self tests passed, processed 225944 bytes in 15118910 nsec
> [    1.130655] crc32c: CRC_LE_BITS = 64
> [    1.134235] crc32c: self tests passed, processed 225944 bytes in 4479879 nsec
> 
> With CRC32_SLICEBY4:
> [    1.097129] crc32: CRC_LE_BITS = 32, CRC_BE BITS = 32
> [    1.101878] crc32: self tests passed, processed 225944 bytes in 8616242 nsec
> [    1.116298] crc32c: CRC_LE_BITS = 32
> [    1.119607] crc32c: self tests passed, processed 225944 bytes in 3289576 nsec
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> 
> diff -ur a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs.new/adder875_defconfig
> --- a/arch/powerpc/configs/adder875_defconfig	2013-11-22 18:20:10.342968268 +0100
> +++ b/arch/powerpc/configs.new/adder875_defconfig	2013-11-22 18:17:46.499686457 +0100
> @@ -70,3 +70,4 @@
>  CONFIG_DETECT_HUNG_TASK=y
>  CONFIG_DEBUG_INFO=y
>  # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> +CONFIG_CRC32_SLICEBY4=y

When applying I got this:
error: arch/powerpc/configs.new/adder875_defconfig: does not exist in index
error: arch/powerpc/configs.new/ep88xc_defconfig: does not exist in index
error: arch/powerpc/configs.new/mpc866_ads_defconfig: does not exist in index
error: arch/powerpc/configs.new/mpc885_ads_defconfig: does not exist in index
error: arch/powerpc/configs.new/tqm8xx_defconfig: does not exist in index

I've fixed it, but please ensure that patches can be applied using "git
am".  I recommend using git to generate patches, but if you don't want to
do so be sure that it's the "b" filename, not the "a" filename, that
matches the tree.

-Scott
