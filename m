Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6A2E61007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 08:19:57 +1100 (EST)
Subject: Re: [PATCH 1/3 v2] mmc: Move mmc_delay() to include/linux/mmc/core.h
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1314345150-1803-1-git-send-email-Chunhe.Lan@freescale.com>
Date: Thu, 27 Oct 2011 16:19:45 -0500
Message-ID: <EC466705-A720-4083-A41E-C57065381C47@freescale.com>
References: <1314345150-1803-1-git-send-email-Chunhe.Lan@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Chris Ball <cjb@laptop.org>,
 linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 26, 2011, at 2:52 AM, Chunhe Lan wrote:

> Move mmc_delay() from drivers/mmc/core/core.h to
> include/linux/mmc/core.h. So when other functions
> call it with include syntax using <linux/mmc/core.h>
> of absolute path rather than "../core/core.h" of
> relative path.
>=20
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> drivers/mmc/core/core.h  |   12 ------------
> include/linux/mmc/core.h |   11 +++++++++++
> 2 files changed, 11 insertions(+), 12 deletions(-)

Chris,

Any comments on these patches or acceptance?

- k

>=20
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index d9411ed..58c3f10 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -11,8 +11,6 @@
> #ifndef _MMC_CORE_CORE_H
> #define _MMC_CORE_CORE_H
>=20
> -#include <linux/delay.h>
> -
> #define MMC_CMD_RETRIES        3
>=20
> struct mmc_bus_ops {
> @@ -44,16 +42,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, =
int signal_voltage,
> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> void mmc_set_driver_type(struct mmc_host *host, unsigned int =
drv_type);
>=20
> -static inline void mmc_delay(unsigned int ms)
> -{
> -	if (ms < 1000 / HZ) {
> -		cond_resched();
> -		mdelay(ms);
> -	} else {
> -		msleep(ms);
> -	}
> -}
> -
> void mmc_rescan(struct work_struct *work);
> void mmc_start_host(struct mmc_host *host);
> void mmc_stop_host(struct mmc_host *host);
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b8b1b7a..7bc2798 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -10,6 +10,7 @@
>=20
> #include <linux/interrupt.h>
> #include <linux/device.h>
> +#include <linux/delay.h>
>=20
> struct request;
> struct mmc_data;
> @@ -182,6 +183,16 @@ static inline void mmc_claim_host(struct mmc_host =
*host)
> 	__mmc_claim_host(host, NULL);
> }
>=20
> +static inline void mmc_delay(unsigned int ms)
> +{
> +	if (ms < 1000 / HZ) {
> +		cond_resched();
> +		mdelay(ms);
> +	} else {
> +		msleep(ms);
> +	}
> +}
> +
> extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>=20
> #endif /* LINUX_MMC_CORE_H */
> --=20
> 1.7.5.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
