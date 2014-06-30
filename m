Return-Path: <jwboyer@gmail.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20BD71A0017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 22:21:26 +1000 (EST)
Received: by mail-ob0-f173.google.com with SMTP id va2so8773184obc.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 05:21:24 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1404100934-7490-1-git-send-email-xerofoify@gmail.com>
References: <1404100934-7490-1-git-send-email-xerofoify@gmail.com>
Date: Mon, 30 Jun 2014 08:21:24 -0400
Message-ID: <CA+5PVA7WOiSBSzZZ=H19X7KdUAZJWhe8Fm=sHzsXOgeVz7Po=g@mail.gmail.com>
Subject: Re: [PATCH] Fixes return issues in uic_init_one
From: Josh Boyer <jwboyer@fedoraproject.org>
To: Nicholas Krause <xerofoify@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, paulus <paulus@samba.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2014 at 12:02 AM, Nicholas Krause <xerofoify@gmail.com> wrote:
> This patch fixes the FIXME messages for returning a ENOMEM error
> if uic is not allocated and if uic->irqhost is not allocated a
> IRQ domain that is linear returns EIO.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

NAK.

You didn't actually fix anything here.  In fact, you changed the
semantics of what uic_init_one returns and the function that calls
doesn't change for negative return codes.  You also didn't do similar
changes for the rest of the error conditions in within the same
function, making it inconsistent with itself.

NULL is the appropriate return for errors in this function.  The FIXME
about panicing is because without a UIC, the boards can't service
interrupts at all.  A board that doesn't work might as well panic, but
that panic is actually done in uic_init_tree appropriately.  If you're
going to change anything, just remove the comment.

josh

> ---
>  arch/powerpc/sysdev/uic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
> index 9203393..f95010a 100644
> --- a/arch/powerpc/sysdev/uic.c
> +++ b/arch/powerpc/sysdev/uic.c
> @@ -239,7 +239,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
>
>         uic = kzalloc(sizeof(*uic), GFP_KERNEL);
>         if (! uic)
> -               return NULL; /* FIXME: panic? */
> +               return -ENOMEM;
>
>         raw_spin_lock_init(&uic->lock);
>         indexp = of_get_property(node, "cell-index", &len);
> @@ -261,7 +261,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
>         uic->irqhost = irq_domain_add_linear(node, NR_UIC_INTS, &uic_host_ops,
>                                              uic);
>         if (! uic->irqhost)
> -               return NULL; /* FIXME: panic? */
> +               return -EIO;
>
>         /* Start with all interrupts disabled, level and non-critical */
>         mtdcr(uic->dcrbase + UIC_ER, 0);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
