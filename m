Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 490AB2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 10:09:45 +1000 (EST)
Received: from mail145-va3 (localhost [127.0.0.1])	by
 mail145-va3-R.bigfish.com (Postfix) with ESMTP id 1DA071A01A0	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 00:09:40 +0000 (UTC)
Received: from VA3EHSMHS042.bigfish.com (unknown [10.7.14.225])	by
 mail145-va3.bigfish.com (Postfix) with ESMTP id 1D31B3E0041	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 00:09:38 +0000 (UTC)
Date: Fri, 23 Aug 2013 19:09:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [v2] powerpc/85xx: Add P1023RDB board support
Message-ID: <20130824000930.GA29088@home.buserror.net>
References: <1375184429-22145-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1375184429-22145-1-git-send-email-Chunhe.Lan@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 30, 2013 at 07:40:29PM +0800, Chunhe Lan wrote:
> P1023RDB Specification:
> -----------------------
> Memory subsystem:
>    512MB DDR3 (Fixed DDR on board)
>    64MB NOR flash
>    128MB NAND flash
> 
> Ethernet:
>    eTSEC1: Connected to Atheros AR8035 GETH PHY
>    eTSEC2: Connected to Atheros AR8035 GETH PHY
> 
> PCIe:
>    Three mini-PCIe slots
> 
> USB:
>    Two USB2.0 Type A ports
> 
> I2C:
>    AT24C08 8K Board EEPROM (8 bit address)
> 
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> 
> ---

No changelog since v1...

> +		nor@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <0x0 0x0 0x04000000>;
> +			bank-width = <2>;
> +			device-width = <1>;
> +
> +			partition@0 {
> +				/* 48MB for JFFS2 based Root file System */
> +				reg = <0x00000000 0x03000000>;
> +				label = "NOR JFFS2 Root File System";
> +			};

Don't specify JFFS2.

> +			partition@1000000 {
> +				/* 32MB for Compressed Root file System Image */
> +				reg = <0x01000000 0x02000000>;
> +				label = "NAND Compressed RFS Image";
> +			};
> +
> +			partition@3000000 {
> +				/* 64MB for JFFS2 based Root file System */
> +				reg = <0x03000000 0x04000000>;
> +				label = "NAND JFFS2 Root File System";
> +			};
> +
> +			partition@7000000 {
> +				/* 16MB for User Writable Area */
> +				reg = <0x07000000 0x01000000>;
> +				label = "NAND Writable User area";
> +			};

Don't specify JFFS2.

Why three separate partitions instead of one?  At least the two RFS
partitions should be merged.

> +	board_pci1: pci1: pcie@ff609000 {

You don't need more than one label on a node.

> diff --git a/arch/powerpc/configs/85xx/p1023_defconfig b/arch/powerpc/configs/85xx/p1023_defconfig
> new file mode 100644
> index 0000000..ac29fb8
> --- /dev/null
> +++ b/arch/powerpc/configs/85xx/p1023_defconfig

While I can understand p1023 wanting a separate defconfig once we get
datapath support (it's the only e500v2 chip with datapath, so we probably
don't want to burden mpc85xx_smp_defconfig with it), but I don't see why
we need a separate config right now.

> +# CONFIG_DEBUG_BUGVERBOSE is not set

Please don't disable this.  It's very useful for interpreting bug reports
and has minimal cost.

> diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
> deleted file mode 100644
> index b80bcc6..0000000
> --- a/arch/powerpc/configs/85xx/p1023rds_defconfig
> +++ /dev/null
> @@ -1,169 +0,0 @@
> -CONFIG_PPC_85xx=y
> -CONFIG_SMP=y
> -CONFIG_NR_CPUS=2

Oh, you were just moving this.  Please use "-M -C" with git format-patch
so such things are more obvious.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index efdd37c..d6424e9 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -112,10 +112,10 @@ config P1022_RDK
>  	  reference board.
>  
>  config P1023_RDS
> -	bool "Freescale P1023 RDS"
> +	bool "Freescale P1023 RDS (P1023 RDB)"
>  	select DEFAULT_UIMAGE
>  	help
> -	  This option enables support for the P1023 RDS board
> +	  This option enables support for the P1023 RDS (P1023 RDB) board
>  
>  config SOCRATES
>  	bool "Socrates"

I'd just say "P1023 RDS/RDB".

> +static int __init p1023_rdb_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "fsl,P1023RDB");
> +
> +}

Remove the blank line at the end of the function.

-Scott
