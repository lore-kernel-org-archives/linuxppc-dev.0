Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDYyC1VJpzDvLZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 05:05:54 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 6C71520364
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 18:05:47 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
 [209.85.161.176])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86BD120377
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 18:05:44 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id l124so212544163ywb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 10:05:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 9 Nov 2016 12:05:23 -0600
Message-ID: <CAL_JsqL13-e5RGfafsLfP7EoJWTkAsuRG4mAF-t52GoDXeQS-Q@mail.gmail.com>
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 9, 2016 at 8:05 AM, Guilherme G. Piccoli
<gpiccoli@linux.vnet.ibm.com> wrote:
> On PowerPC machines some PCI slots might not have Level-triggered
> interrupts capability (also know as Level Signaled Interrupts - LSI),
> leading of_irq_parse_pci() to complain by presenting error messages
> on the kernel log - in this case, the properties "interrupt-map" and
> "interrupt-map-mask" are not present on the device's node on device
> tree.
>
> This patch introduces a different message for this specific case,
> and it also reduces the level of the message from error to warning.
> Before this patch, when an adapter was plugged in a slot without Level
> interrupts capabilities, we saw generic error messages like this:
>
>     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-22
>
> Now, with this applied, we see the following specific message:
>
>     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot of this
>     device has no Level-triggered Interrupts capability.
>
> No functional changes were introduced.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  drivers/of/irq.c        | 5 ++++-
>  drivers/of/of_pci_irq.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 393fea8..1ad6882 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -275,7 +275,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>         of_node_put(ipar);
>         of_node_put(newpar);
>
> -       return -EINVAL;
> +       /* Positive non-zero return means no Level-triggered Interrupts
> +        * capability was found.
> +        */
> +       return ENOENT;

It's not really a normal pattern to return positive errno values. You
should return a negative value and check for that specific error value
or perhaps move the print statement into this function.

Rob
