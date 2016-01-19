Return-Path: <joel.stan@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A77FE1A0FCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 09:41:28 +1100 (AEDT)
Received: by mail-ob0-x22c.google.com with SMTP id ba1so611788190obb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 14:41:28 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Jan 2016 09:11:06 +1030
Message-ID: <CACPK8XcSxy8Ux1BgV8YcHoKSJ+3_+erT9J-h9zDpnYbVAAnvwA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/eeh: Fix PE location code
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Gavin,

On Wed, Dec 2, 2015 at 3:55 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> In eeh_pe_loc_get(), the PE location code is retrieved from the
> "ibm,loc-code" property of the device node for the bridge of the
> PE's primary bus. It's not correct because the property indicates
> the parent PE's location code.
>
> This reads the correct PE location code from "ibm,io-base-loc-code"
> or "ibm,slot-location-code" property of PE parent bus's device node.

I think we want this fix included in stable releases. Is that correct?

Cheers,

Joel

> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_pe.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 8654cb1..ca9e537 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -883,32 +883,29 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>  const char *eeh_pe_loc_get(struct eeh_pe *pe)
>  {
>         struct pci_bus *bus = eeh_pe_bus_get(pe);
> -       struct device_node *dn = pci_bus_to_OF_node(bus);
> +       struct device_node *dn;
>         const char *loc = NULL;
>
> -       if (!dn)
> -               goto out;
> +       while (bus) {
> +               dn = pci_bus_to_OF_node(bus);
> +               if (!dn) {
> +                       bus = bus->parent;
> +                       continue;
> +               }
>
> -       /* PHB PE or root PE ? */
> -       if (pci_is_root_bus(bus)) {
> -               loc = of_get_property(dn, "ibm,loc-code", NULL);
> -               if (!loc)
> +               if (pci_is_root_bus(bus))
>                         loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
> +               else
> +                       loc = of_get_property(dn, "ibm,slot-location-code",
> +                                             NULL);
> +
>                 if (loc)
> -                       goto out;
> +                       return loc;
>
> -               /* Check the root port */
> -               dn = dn->child;
> -               if (!dn)
> -                       goto out;
> +               bus = bus->parent;
>         }
>
> -       loc = of_get_property(dn, "ibm,loc-code", NULL);
> -       if (!loc)
> -               loc = of_get_property(dn, "ibm,slot-location-code", NULL);
> -
> -out:
> -       return loc ? loc : "N/A";
> +       return "N/A";
>  }
>
>  /**
> --
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
