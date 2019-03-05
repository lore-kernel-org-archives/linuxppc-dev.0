Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D4BC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 08:06:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F3620675
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 08:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDh8jnmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F3620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44D8bm1MnzzDqFG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 19:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDh8jnmb"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44D8Yt5tsyzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 19:04:34 +1100 (AEDT)
Received: by mail-it1-x141.google.com with SMTP id l139so3005793ita.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Mar 2019 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qDTU1/tgQbMZi5C7FD/YKJxVigtBTOw4VfnwQ0tSqq4=;
 b=aDh8jnmbISJnr/YQsUPI8t1mj4SAvowrR3EROC9kfMsvVNjJ4eVjgbc+lENpTlGSz8
 CjR1ihUxbhUIImrlGR9QNRcmAZu2btRW+yk28aND5Okf82MijxYcsjiTbyA8tq73f9iS
 iG/ERoiPRkPtbdOcORghhkJ2oT9tiO2Poy8ToQFuJQc3z9dIj69axxptF2/MQZiB0gag
 GS0GnVAw7W35zK6em2+zDr5kK3GNACS5xcQoEYgCvUU4+t1AGrWO8iviM6ujAUhiISfc
 h0fWyVXOtC1wail7ryQMMwsrFXC6VqQARoqE+qWQlWmLxNQ6GZnTeunLG8F+PgCrasf8
 Ka+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qDTU1/tgQbMZi5C7FD/YKJxVigtBTOw4VfnwQ0tSqq4=;
 b=RNbviqgMC8MaBw5jPybqV/l8jhG/2aBeidG+fWIlwn9C6jLZMt8m9nXGg3ZKsNiYpw
 XYnan2bwkl+0y4+B4cDLwMCK0TdJq/i3f34RMmPgwRpxe3suVMBIcC1vlZn3NtRct9mj
 /jKs2ZjT+fuDhWvebQR12J1RfvEN/h+8twYqZk8QK9ZCLLDKTp+ChdPnwCLW8PSDB3Jf
 /EUZAtCWVWy70LlCWBNjmXR79jdhJzYg900jZiuvbk6WpPVzrpZr1r44uMdSA9xrPoDt
 YE+2VD1ZiguRwpYyhLRS1UtLy7wf06kE/L6wyiMofoOkPbb95hooYJApLnLPJM6/GTyC
 myxA==
X-Gm-Message-State: APjAAAU1Fcsb+AOGGI6jMcBRfuUGmtnvKhe11dTq8EubzEBRjE4gNUhD
 u4lQpWbQmmu6pre+3lIvp0XEidtdgL+yIdyiP3k=
X-Google-Smtp-Source: APXvYqxL+uULLLrocoDELwc7RSB2Q82sg4TvglGN2snW/0qOxydiXPmjR6yaN3ZY0hfMfN8RP0887X+bSkNCKt4ZViQ=
X-Received: by 2002:a24:304a:: with SMTP id q71mr1863151itq.4.1551773070828;
 Tue, 05 Mar 2019 00:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
 <20190301160440.26262-4-s.miroshnichenko@yadro.com>
In-Reply-To: <20190301160440.26262-4-s.miroshnichenko@yadro.com>
From: Oliver <oohall@gmail.com>
Date: Tue, 5 Mar 2019 19:04:19 +1100
Message-ID: <CAOSf1CGZcy3N5-KztkakNSDD5w4kg5CL4ucMMbWyYxd=eEa5dw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 3/9] powerpc/pci: Create pci_dn on demand
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux@yadro.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 2, 2019 at 3:04 AM Sergey Miroshnichenko
<s.miroshnichenko@yadro.com> wrote:
>
> If a struct pci_dn hasn't yet been created for the PCIe device (there was
> no DT node for it), allocate this structure and fill with info read from
> the device directly.
>
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/kernel/pci_dn.c | 79 ++++++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index 341ed71250f1..67ccd7be8344 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -33,6 +33,8 @@
>  #include <asm/firmware.h>
>  #include <asm/eeh.h>
>
> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *parent);
> +
>  /*
>   * The function is used to find the firmware data of one
>   * specific PCI device, which is attached to the indicated
> @@ -65,6 +67,9 @@ struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
>         dn = pci_bus_to_OF_node(pbus);
>         pdn = dn ? PCI_DN(dn) : NULL;
>
> +       if (!pdn && pbus->self)
> +               pdn = pbus->self->dev.archdata.pci_data;
> +
>         return pdn;
>  }
>
> @@ -74,10 +79,13 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
>         struct device_node *dn = NULL;
>         struct pci_dn *parent, *pdn;
>         struct pci_dev *pdev = NULL;
> +       bool pdev_found = false;
>
>         /* Fast path: fetch from PCI device */
>         list_for_each_entry(pdev, &bus->devices, bus_list) {
>                 if (pdev->devfn == devfn) {
> +                       pdev_found = true;
> +
>                         if (pdev->dev.archdata.pci_data)
>                                 return pdev->dev.archdata.pci_data;
>
> @@ -86,6 +94,9 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
>                 }
>         }
>
> +       if (!pdev_found)
> +               pdev = NULL;
> +
>         /* Fast path: fetch from device node */
>         pdn = dn ? PCI_DN(dn) : NULL;
>         if (pdn)
> @@ -98,9 +109,12 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
>
>         list_for_each_entry(pdn, &parent->child_list, list) {
>                 if (pdn->busno == bus->number &&
> -                    pdn->devfn == devfn)
> -                        return pdn;
> -        }
> +                   pdn->devfn == devfn) {
> +                       if (pdev)
> +                               pdev->dev.archdata.pci_data = pdn;
> +                       return pdn;
> +               }
> +       }
>
>         return NULL;
>  }
> @@ -130,14 +144,15 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>
>         list_for_each_entry(pdn, &parent->child_list, list) {
>                 if (pdn->busno == pdev->bus->number &&
> -                   pdn->devfn == pdev->devfn)
> +                   pdn->devfn == pdev->devfn) {
> +                       pdev->dev.archdata.pci_data = pdn;
>                         return pdn;
> +               }
>         }
>
> -       return NULL;
> +       return create_pdn(pdev, parent);
>  }

Eh... If it works I guess it's fine? Killing pdn entirely (or at the
very least greatly restricting it's role) is something we should work
towards though since it doesn't make much sense on PNV.

> -#ifdef CONFIG_PCI_IOV
>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>                                            int vf_index,
>                                            int busno, int devfn)
> @@ -156,7 +171,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>         pdn->parent = parent;
>         pdn->busno = busno;
>         pdn->devfn = devfn;
> +       #ifdef CONFIG_PCI_IOV
>         pdn->vf_index = vf_index;
> +       #endif /* CONFIG_PCI_IOV */

This function is currently only used when adding VFs, so I'd move the
VF specific params from this and put them in the call site at
add_dev_pci_data(). Then you can drop the #ifdef hacks. It might be
worth renaming add_one_dev_pci_data() and add_one_dev_pci_data() since
their actual usage is limited to the VF init path, but their name seem
generic.

>         pdn->pe_number = IODA_INVALID_PE;
>         INIT_LIST_HEAD(&pdn->child_list);
>         INIT_LIST_HEAD(&pdn->list);
> @@ -164,7 +181,55 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>
>         return pdn;
>  }
> -#endif
> +
> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *parent)
> +{
> +       struct pci_dn *pdn = NULL;
> +
> +       if (!parent)
> +               return NULL;
> +
> +       pdn = add_one_dev_pci_data(parent, 0, pdev->bus->busn_res.start, pdev->devfn);
> +       dev_info(&pdev->dev, "Create a new pdn for devfn %2x\n", pdev->devfn / 8);
> +

> +       if (pdn) {

Check for !pdn and exit early. Stacking indentation levels just gets
kind of ugly.

> +               #ifdef CONFIG_EEH
> +               struct eeh_dev *edev;
> +               #endif /* CONFIG_EEH */
You don't use the variable for anything. You can either switch this to
a void pointer or just check the return value of eeh_dev_init()
directly and drop this.

> +               u32 class_code;
> +               u16 device_id;
> +               u16 vendor_id;
> +

> +               #ifdef CONFIG_EEH
> +               edev = eeh_dev_init(pdn);
> +               if (!edev) {
> +                       kfree(pdn);
> +                       dev_err(&pdev->dev, "%s: Failed to allocate edev\n", __func__);
> +                       return NULL;
> +               }
> +               #endif /* CONFIG_EEH */
> +
> +               pci_bus_read_config_word(pdev->bus, pdev->devfn,
> +                                        PCI_VENDOR_ID, &vendor_id);
> +               pdn->vendor_id = vendor_id;
> +
> +               pci_bus_read_config_word(pdev->bus, pdev->devfn,
> +                                        PCI_DEVICE_ID, &device_id);
> +               pdn->device_id = device_id;
> +
> +               pci_bus_read_config_dword(pdev->bus, pdev->devfn,
> +                                         PCI_CLASS_REVISION, &class_code);
> +               class_code >>= 8;
> +               pdn->class_code = class_code;
> +
> +               pdn->pci_ext_config_space = 0;
Does this need to be explicitly initialised or can we rely on it being
allocated with kzalloc() or similar?

> +               pdev->dev.archdata.pci_data = pdn;
> +       } else {
> +               dev_err(&pdev->dev, "%s: Failed to allocate pdn\n", __func__);
> +       }
> +
> +       return pdn;
> +}
>
>  struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>  {
> --
> 2.20.1
>
