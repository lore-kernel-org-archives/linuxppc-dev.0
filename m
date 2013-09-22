Return-Path: <robherring2@gmail.com>
Received: from mail-qc0-x22a.google.com (mail-qc0-x22a.google.com
 [IPv6:2607:f8b0:400d:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CD3D2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 07:19:30 +1000 (EST)
Received: by mail-qc0-f170.google.com with SMTP id m20so1571059qcx.15
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 14:19:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379510692-32435-2-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-2-git-send-email-treding@nvidia.com>
Date: Sun, 22 Sep 2013 16:19:27 -0500
Message-ID: <CAL_JsqLE8aj511oF-gK7Gu5QfmHsQO3+oJ0KFkv0wmuo7i6eiw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] of/irq: Rework of_irq_count()
From: Rob Herring <robherring2@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Grant Likely <grant.likely@linaro.org>,
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
> The of_irq_to_resource() helper that is used to implement of_irq_count()
> tries to resolve interrupts and in fact creates a mapping for resolved
> interrupts. That's pretty heavy lifting for something that claims to
> just return the number of interrupts requested by a given device node.
>
> Instead, use the more lightweight of_irq_map_one(), which, despite the
> name, doesn't create an actual mapping. Perhaps a better name would be
> of_irq_translate_one().
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/of/irq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 1752988..5f44388 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -368,9 +368,10 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
>   */
>  int of_irq_count(struct device_node *dev)
>  {
> +       struct of_irq irq;
>         int nr = 0;
>
> -       while (of_irq_to_resource(dev, nr, NULL))
> +       while (of_irq_map_one(dev, nr, &irq) == 0)
>                 nr++;
>
>         return nr;
> --
> 1.8.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
