Return-Path: <robherring2@gmail.com>
Received: from mail-qe0-x22f.google.com (mail-qe0-x22f.google.com
 [IPv6:2607:f8b0:400d:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A99A92C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 07:14:46 +1000 (EST)
Received: by mail-qe0-f47.google.com with SMTP id b4so1600522qen.34
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 14:14:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379510692-32435-5-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-5-git-send-email-treding@nvidia.com>
Date: Sun, 22 Sep 2013 16:14:43 -0500
Message-ID: <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] irqdomain: Return errors from
 irq_create_of_mapping()
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
> Instead of returning 0 for all errors, allow the precise error code to
> be propagated. This will be used in subsequent patches to allow further
> propagation of error codes.
>
> The interrupt number corresponding to the new mapping is returned in an
> output parameter so that the return value is reserved to signal success
> (== 0) or failure (< 0).
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

One comment below, otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 905a24b..ae71b14 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -230,6 +230,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  {
>         struct of_irq oirq;
>         unsigned int virq;
> +       int ret;
>
>         pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
>
> @@ -266,8 +267,10 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>                          oirq.size, oirq.specifier[0], oirq.specifier[1],
>                          of_node_full_name(oirq.controller));
>
> -               virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
> -                                            oirq.size);
> +               ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
> +                                           oirq.size, &virq);
> +               if (ret)
> +                       virq = NO_IRQ;
>         }
>         if(virq == NO_IRQ) {
>                 pr_debug(" Failed to map !\n");

Can you get rid of NO_IRQ usage here instead of adding to it.

Rob
