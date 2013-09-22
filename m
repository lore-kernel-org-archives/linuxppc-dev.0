Return-Path: <robherring2@gmail.com>
Received: from mail-qa0-x229.google.com (mail-qa0-x229.google.com
 [IPv6:2607:f8b0:400d:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 087B72C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 07:08:31 +1000 (EST)
Received: by mail-qa0-f41.google.com with SMTP id ii20so998972qab.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 14:08:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379510692-32435-8-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-8-git-send-email-treding@nvidia.com>
Date: Sun, 22 Sep 2013 16:08:26 -0500
Message-ID: <CAL_JsqJ+4P26hRrJcrbBmwfNPDAS+1GhXj12B+UvqmZZGjqT0g@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] of/irq: Propagate errors in
 of_irq_to_resource_table()
From: Rob Herring <robherring2@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>, linux-mips@linux-mips.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Now that all helpers return precise error codes, this function can
> propagate these errors to the caller properly.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - return 0 on success or a negative error code on failure
> - convert callers to new calling convention

[snip]

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e4f38c0..6d7f824 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -397,18 +397,20 @@ int of_irq_count(struct device_node *dev)
>   * @res: array of resources to fill in
>   * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)

You are effectively changing this to require an exact match rather
than an upper bound. That seems to be okay since that is what all the
callers want, but the documentation should be updated.

>   *
> - * Returns the size of the filled in table (up to @nr_irqs).
> + * Returns 0 on success or a negative error code on failure.
>   */
>  int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
>                 int nr_irqs)
>  {
> -       int i;
> +       int i, ret;
>
> -       for (i = 0; i < nr_irqs; i++, res++)
> -               if (!of_irq_to_resource(dev, i, res))

The error handling here needs to be updated in the previous patch.

> -                       break;
> +       for (i = 0; i < nr_irqs; i++, res++) {
> +               ret = of_irq_to_resource(dev, i, res);
> +               if (ret < 0)
> +                       return ret;
> +       }
>
> -       return i;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_to_resource_table);
>
