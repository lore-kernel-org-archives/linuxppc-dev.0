Return-Path: <stripathi@apm.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8819F1A0F01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 22:28:05 +1000 (AEST)
Received: by wicgi11 with SMTP id gi11so17175778wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 05:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434715227-27399-3-git-send-email-stripathi@apm.com>
References: <1434715227-27399-1-git-send-email-stripathi@apm.com>
 <1434715227-27399-3-git-send-email-stripathi@apm.com>
Date: Fri, 19 Jun 2015 17:58:02 +0530
Message-ID: <CAOHikRBkDinUfcOR3Dg12e2Xy_P5TABOpHSnkSpZhRyhLRWGFA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] mmc: host: sdhci: Disable 1.8V signaling for
 arasan 4.9a version of SDHCI controller.
From: Suman Tripathi <stripathi@apm.com>
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 khilman@deeprootsystems.com, Olof Johansson <olof@lixom.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, arm@kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Don Dutile <ddutile@redhat.com>,
 Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>,
 patches <patches@apm.com>, Suman Tripathi <stripathi@apm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi ,

On Fri, Jun 19, 2015 at 5:30 PM, Suman Tripathi <stripathi@apm.com> wrote:
> This patch disables the 1.8V signaling for arasan 4.9a version
> of SDHCI controller with the help SDHCI_QUIRK2_NO_1_8_V quirk.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 21c0c08..4c99ea4 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -171,7 +171,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>                 host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> -               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23 |
> +                                SDHCI_QUIRK2_NO_1_8_V;
>         }


I think I am  wrong here. No-1.8v is something related to board
regulator circuitry not related to IP version. So it should be dts
driven.

>
>         sdhci_get_of_property(pdev);
> --
> 1.8.2.1
>



-- 
Thanks,
with regards,
Suman Tripathi
