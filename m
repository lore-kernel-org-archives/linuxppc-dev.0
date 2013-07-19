Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 626132C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 12:22:07 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
 system transaction
Date: Fri, 19 Jul 2013 02:21:55 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13DF52C@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, all

Expect your advice and any comments.


Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Zhang Haijun-B42677
> Sent: Wednesday, July 17, 2013 6:11 PM
> To: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: cbouatmailru@gmail.com; cjb@laptop.org; Wood Scott-B07421; Fleming
> Andy-AFLEMING; Zhang Haijun-B42677; Zhang Haijun-B42677
> Subject: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
> system transaction
>=20
> A-004388: eSDHC DMA might not stop if error occurs on system transaction
>=20
> eSDHC DMA(SDMA/ADMA) might not stop if an error occurs in the last system
> transaction. It may continue initiating additional transactions until
> software reset for data/all is issued during error recovery. There is not
> any data corruption to the SD data. The IRQSTAT[DMAE] is set when the
> erratum occurs.
> The only conditions under which issues occur are the following:
> 1. SDMA - For SD Write , the error occurs in the last system transaction.
> No issue for SD read
> 2. ADMA
> a. Block count is enabled: For SD write, the error occurs in the last
> system transaction. There is no issue for SD read when block count is
> enabled.
> b. Block count is disabled: Block count is designated by the ADMA
> descriptor table, and the error occurs in the last system transaction
> when ADMA is executing last descriptor line of table.
>=20
> eSDHC may initiate additional system transactions. There is no data
> integrity issue for case 1 and 2a described below. For case 2b, system
> data might be corrupted.
>=20
> Workaround: Set eSDHC_SYSCTL[RSTD] when IRQSTAT[DMAE] is set. For cases
> 2a and 2b above, add an extra descriptor line with zero data next to the
> last descriptor line.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for V2:
> 	- Update the svr version list
>=20
>  drivers/mmc/host/sdhci-of-esdhc.c | 112
> ++++++++++++++++++++++++++++++++++----
>  1 file changed, 102 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index 15039e2..adfaadd 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -21,9 +21,13 @@
>  #include <linux/mmc/host.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> +#include <asm/mpc85xx.h>
>=20
>  #define VENDOR_V_22	0x12
>  #define VENDOR_V_23	0x13
> +
> +static u32 svr;
> +
>  static u32 esdhc_readl(struct sdhci_host *host, int reg)  {
>  	u32 ret;
> @@ -142,6 +146,26 @@ static void esdhc_writeb(struct sdhci_host *host, u8
> val, int reg)
>  	sdhci_be32bs_writeb(host, val, reg);
>  }
>=20
> +static void esdhc_reset(struct sdhci_host *host, u8 mask) {
> +	u32 ier;
> +	u32 uninitialized_var(isav);
> +
> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
> +		isav =3D esdhc_readl(host, SDHCI_INT_ENABLE);
> +
> +	esdhc_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +	mdelay(100);
> +
> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
> +		ier =3D esdhc_readl(host, SDHCI_INT_ENABLE);
> +		ier &=3D ~SDHCI_INT_ALL_MASK;
> +		ier |=3D isav;
> +		esdhc_writel(host, ier, SDHCI_INT_ENABLE);
> +		esdhc_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> +	}
> +}
> +
>  /*
>   * For Abort or Suspend after Stop at Block Gap, ignore the ADMA
>   * error(IRQSTAT[ADMAE]) if both Transfer Complete(IRQSTAT[TC]) @@ -
> 156,25 +180,92 @@ static void esdhci_of_adma_workaround(struct sdhci_host
> *host, u32 intmask)
>  	dma_addr_t dmastart;
>  	dma_addr_t dmanow;
>=20
> -	tmp =3D in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +	tmp =3D esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
>  	tmp =3D (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>=20
>  	applicable =3D (intmask & SDHCI_INT_DATA_END) &&
>  		(intmask & SDHCI_INT_BLK_GAP) &&
>  		(tmp =3D=3D VENDOR_V_23);
> -	if (!applicable)
> +	if (applicable) {
> +
> +		esdhc_reset(host, SDHCI_RESET_DATA);
> +		host->data->error =3D 0;
> +		dmastart =3D sg_dma_address(host->data->sg);
> +		dmanow =3D dmastart + host->data->bytes_xfered;
> +
> +		/* Force update to the next DMA block boundary. */
> +		dmanow =3D (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> +			SDHCI_DEFAULT_BOUNDARY_SIZE;
> +		host->data->bytes_xfered =3D dmanow - dmastart;
> +		esdhc_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +
>  		return;
> +	}
>=20
> -	host->data->error =3D 0;
> -	dmastart =3D sg_dma_address(host->data->sg);
> -	dmanow =3D dmastart + host->data->bytes_xfered;
>  	/*
> -	 * Force update to the next DMA block boundary.
> +	 * Check for A-004388: eSDHC DMA might not stop if error
> +	 * occurs on system transaction
> +	 * Impact list:
> +	 * T4240-R1.0 B4860-R1.0 P1010-R1.0
> +	 * P3041-R1.0-R2.0-R1.1 P2041-R1.0-R1.1-R2.0
> +	 * P5040-R2.0
>  	 */
> -	dmanow =3D (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> -		SDHCI_DEFAULT_BOUNDARY_SIZE;
> -	host->data->bytes_xfered =3D dmanow - dmastart;
> -	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +	if (!(((SVR_SOC_VER(svr) =3D=3D SVR_T4240) && (SVR_REV(svr) =3D=3D 0x10=
))
> ||
> +		((SVR_SOC_VER(svr) =3D=3D SVR_B4860) && (SVR_REV(svr) =3D=3D 0x10))
> ||
> +		((SVR_SOC_VER(svr) =3D=3D SVR_P1010) && (SVR_REV(svr) =3D=3D 0x10))
> ||
> +		((SVR_SOC_VER(svr) =3D=3D SVR_P3041) && (SVR_REV(svr) <=3D 0x20))
> ||
> +		((SVR_SOC_VER(svr) =3D=3D SVR_P2041) && (SVR_REV(svr) <=3D 0x20))
> ||
> +		((SVR_SOC_VER(svr) =3D=3D SVR_P5040) && SVR_REV(svr) =3D=3D 0x20)))
> +		return;
> +
> +	esdhc_reset(host, SDHCI_RESET_DATA);
> +
> +	if (host->flags & SDHCI_USE_ADMA) {
> +		u32 mod, i, offset;
> +		u8 *desc;
> +		dma_addr_t addr;
> +		struct scatterlist *sg;
> +		__le32 *dataddr;
> +		__le32 *cmdlen;
> +
> +		/*
> +		 * If block count was enabled, in case read transfer there
> +		 * is no data was corrupted
> +		 */
> +		mod =3D esdhc_readl(host, SDHCI_TRANSFER_MODE);
> +		if ((mod & SDHCI_TRNS_BLK_CNT_EN) &&
> +			(host->data->flags & MMC_DATA_READ))
> +			host->data->error =3D 0;
> +
> +		BUG_ON(!host->data);
> +		desc =3D host->adma_desc;
> +		for_each_sg(host->data->sg, sg, host->sg_count, i) {
> +			addr =3D sg_dma_address(sg);
> +			offset =3D (4 - (addr & 0x3)) & 0x3;
> +			if (offset)
> +				desc +=3D 8;
> +			desc +=3D 8;
> +		}
> +
> +		/*
> +		 * Add an extra zero descriptor next to the
> +		 * terminating descriptor.
> +		 */
> +		desc +=3D 8;
> +		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
> +
> +		dataddr =3D (__le32 __force *)(desc + 4);
> +		cmdlen =3D (__le32 __force *)desc;
> +
> +		cmdlen[0] =3D cpu_to_le32(0);
> +		dataddr[0] =3D cpu_to_le32(0);
> +	}
> +
> +	if ((host->flags & SDHCI_USE_SDMA) &&
> +		(host->data->flags & MMC_DATA_READ))
> +		host->data->error =3D 0;
> +
> +	return;
>  }
>=20
>  static int esdhc_of_enable_dma(struct sdhci_host *host) @@ -299,6 +390,7
> @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  	int ret;
>=20
> +	svr =3D mfspr(SPRN_SVR);
>  	host =3D sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
> --
> 1.8.0
