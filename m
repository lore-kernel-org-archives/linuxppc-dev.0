Return-Path: <stripathi@apm.com>
Received: from mail-wg0-f53.google.com (exprod5og117.obsmtp.com [64.18.0.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96B481A0BE8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 17:06:10 +1000 (AEST)
Received: by wguv19 with SMTP id v19so115419397wgu.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 00:06:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431517912-10322-3-git-send-email-stripathi@apm.com>
References: <1431517912-10322-1-git-send-email-stripathi@apm.com>
 <1431517912-10322-3-git-send-email-stripathi@apm.com>
Date: Mon, 18 May 2015 12:36:07 +0530
Message-ID: <CAOHikRBU9yrGQU3BbTqs4sWZN5osqEYKzD3VjXPar180aQj67Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
From: Suman Tripathi <stripathi@apm.com>
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>,
 Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>,
 Jon Masters <jcm@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 13, 2015 at 5:21 PM, Suman Tripathi <stripathi@apm.com> wrote:
> The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
> This patch adds the support to disable SDR104/SDR50/DDR50 based on
> reading the capability register 0.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 58c1770..a3d9b8a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)
>                 }
>         }
>
> -       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> +       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
> +           !(caps[0] & SDHCI_CAN_VDD_180))
>                 caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>                        SDHCI_SUPPORT_DDR50);
>
> --
> 1.8.2.1
>

I didn't get any comments on this patch . Can anyone review it
(Michal , Ulf , Arnd etc ...)?


-- 
Thanks,
with regards,
Suman Tripathi
