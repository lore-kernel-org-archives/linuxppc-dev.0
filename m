Return-Path: <avorontsov@mvista.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84149B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 20:18:10 +1000 (EST)
Received: by bwa18 with SMTP id 18so5228741bwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Jul 2011 03:18:05 -0700 (PDT)
Date: Tue, 5 Jul 2011 14:18:01 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 3/3] eSDHC: fix incorrect default value of the
	capabilities register on P4080
Message-ID: <20110705101801.GA13052@oksana.dev.rtsoft.ru>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-3-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1309839543-6031-3-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 05, 2011 at 12:19:03PM +0800, Roy Zang wrote:
> P4080 eSDHC errata 12 describes incorrect default value of the
> the host controller capabilities register.
> 
> The default value of the VS18 and VS30 fields in the host controller
> capabilities register (HOSTCAPBLT) are incorrect. The default of these bits
> should be zero instead of one in the eSDHC logic.
> 
> This patch adds the workaround for these errata.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>  drivers/mmc/host/sdhci-of-core.c |    3 +++
>  drivers/mmc/host/sdhci.c         |    6 ++++++
>  include/linux/mmc/sdhci.h        |    4 ++++
>  3 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
> index fede43d..9bdd30d 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -182,6 +182,9 @@ static int __devinit sdhci_of_probe(struct platform_device *ofdev)
>  	if (of_device_is_compatible(np, "fsl,esdhc"))
>  		host->quirks |= SDHCI_QUIRK_QORIQ_PROCTL_WEIRD;
>  
> +	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
> +		host->quirks |= SDHCI_QUIRK_QORIQ_HOSTCAPBLT_ONLY_VS33;

Should really use voltage-ranges, not quirks.

http://www.spinics.net/lists/linux-mmc/msg02785.html

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
