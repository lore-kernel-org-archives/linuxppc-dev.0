Return-Path: <pku.leo@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421Tq747fYzF373
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 03:23:31 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so16862974ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 10:23:31 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com.
 [209.85.218.43])
 by smtp.gmail.com with ESMTPSA id o125-v6sm11927349oig.44.2018.08.30.10.23.28
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Aug 2018 10:23:28 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id b15-v6so16784342oib.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 10:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180829092746.30674-1-colin.king@canonical.com>
In-Reply-To: <20180829092746.30674-1-colin.king@canonical.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 30 Aug 2018 12:23:16 -0500
Message-ID: <CADRPPNQxAZi4HahERZZdKDKpauh+pbw+PmDOe_nUXZvJbvJRng@mail.gmail.com>
Subject: Re: [PATCH] fsl: remove redundant pointer 'priv'
To: colin.king@canonical.com
Cc: Roy Pledge <Roy.Pledge@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, kernel-janitors@vger.kernel.org,
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

On Wed, Aug 29, 2018 at 4:29 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer 'priv' is being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> variable 'priv' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Merged for next after updated the title prefix.

Thanks!
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index b60b77bfaffa..e58fcc9096e8 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -50,13 +50,10 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
>
>  static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
>  {
> -       struct dpio_priv *priv;
>         int error;
>         struct fsl_mc_device_irq *irq;
>         cpumask_t mask;
>
> -       priv = dev_get_drvdata(&dpio_dev->dev);
> -
>         irq = dpio_dev->irqs[0];
>         error = devm_request_irq(&dpio_dev->dev,
>                                  irq->msi_desc->irq,
> --
> 2.17.1
>
