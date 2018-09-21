Return-Path: <pku.leo@gmail.com>
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H7Fr244RzF3Qc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 08:15:27 +1000 (AEST)
Received: by mail-ot1-f68.google.com with SMTP id n5-v6so14478619otl.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 15:15:27 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52])
 by smtp.gmail.com with ESMTPSA id m11-v6sm11138477oif.27.2018.09.21.15.15.25
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 15:15:25 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id n5-v6so14478591otl.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 15:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
 <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 21 Sep 2018 17:15:13 -0500
Message-ID: <CADRPPNQMK8sNYU23nvAdF3T_gx=VruM1ZKAcwNg6HuW6hz+Ezw@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when
 initializing portals
To: madalin.bucur@nxp.com
Cc: Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
 Catalin Marinas <catalin.marinas@arm.com>, Scott Wood <oss@buserror.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2018 at 10:09 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> If the affine portal for a specific CPU is offline at boot time
> affine its interrupt to CPU 0. If the CPU is later brought online
> the hotplug handler will correctly adjust the affinity.

Although this does provide better compatibility with cpu hotplug, we
still have a problem.  You are assuming the CPU0 is always online
which is not the case for arm64.  How about not setting the affinity
and let the system decide if the dedicated CPU is offline?

>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
>  drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
> index f9485cedc648..2e6e682bf16b 100644
> --- a/drivers/soc/fsl/qbman/bman.c
> +++ b/drivers/soc/fsl/qbman/bman.c
> @@ -562,10 +562,19 @@ static int bman_create_portal(struct bman_portal *portal,
>                 dev_err(c->dev, "request_irq() failed\n");
>                 goto fail_irq;
>         }
> -       if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
> -           irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> -               dev_err(c->dev, "irq_set_affinity() failed\n");
> -               goto fail_affinity;
> +       if (cpu_online(c->cpu) && c->cpu != -1 &&
> +           irq_can_set_affinity(c->irq)) {
> +               if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> +                       dev_err(c->dev, "irq_set_affinity() failed %d\n",
> +                               c->cpu);
> +                       goto fail_affinity;
> +               }
> +       } else {
> +               /* CPU is offline, direct IRQ to CPU 0 */
> +               if (irq_set_affinity(c->irq, cpumask_of(0))) {
> +                       dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
> +                       goto fail_affinity;
> +               }
>         }
>
>         /* Need RCR to be empty before continuing */
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index ecb22749df0b..7dbcb475a59c 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
>                         break;
>                 udelay(1);
>         } while (--timeout);
> -
>         return timeout;
>  }
>
> @@ -1210,10 +1209,19 @@ static int qman_create_portal(struct qman_portal *portal,
>                 dev_err(c->dev, "request_irq() failed\n");
>                 goto fail_irq;
>         }
> -       if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
> -           irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> -               dev_err(c->dev, "irq_set_affinity() failed\n");
> -               goto fail_affinity;
> +       if (cpu_online(c->cpu) && c->cpu != -1 &&
> +           irq_can_set_affinity(c->irq)) {
> +               if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> +                       dev_err(c->dev, "irq_set_affinity() failed %d\n",
> +                               c->cpu);
> +                       goto fail_affinity;
> +               }
> +       } else {
> +               /* CPU is offline, direct IRQ to CPU 0 */
> +               if (irq_set_affinity(c->irq, cpumask_of(0))) {
> +                       dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
> +                       goto fail_affinity;
> +               }
>         }
>
>         /* Need EQCR to be empty before continuing */
> --
> 2.1.0
>
