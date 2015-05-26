Return-Path: <stripathi@apm.com>
Received: from mail-wg0-f46.google.com (exprod5og104.obsmtp.com [64.18.0.178])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 583E21A0EAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 21:07:32 +1000 (AEST)
Received: by wgez8 with SMTP id z8so93750263wge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 04:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432197817-22110-3-git-send-email-stripathi@apm.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
 <1432197817-22110-3-git-send-email-stripathi@apm.com>
Date: Tue, 26 May 2015 16:37:22 +0530
Message-ID: <CAOHikRC7p+wzgHXbEYkK56dJucahf6rk=x0sphQedtSKV0N0xQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
From: Suman Tripathi <stripathi@apm.com>
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>,
 Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
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

On Thu, May 21, 2015 at 2:13 PM, Suman Tripathi <stripathi@apm.com> wrote:
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

Any comments on this patch ?


-- 
Thanks,
with regards,
Suman Tripathi
