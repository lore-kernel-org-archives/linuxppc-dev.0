Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA4EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 06:16:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D402082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoftIaKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D402082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44D68c1mzszDqCx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 17:16:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XoftIaKF"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44D66j367BzDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 17:14:20 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id d125so1676398ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Mar 2019 22:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IojBl3jLz5IfvShs6QhkZ+GWUkLKuHgkE0WSF3TNLZU=;
 b=XoftIaKF0KHR2Dt2HKTe6sUTy/xqrVCyQsvJdp72DUGoMNy928CN0yxIshzzsfnYL+
 BIQIV5xc52rmoRYozuQJAJQjd4Dt/kgi/FBWPYGDziOWA6AvFzD/zvbRM/Lm1/nq2nCl
 eXIsAlP73IpIGIkVKsiAbphgy77m1BWkQf3QyJhadSD7fIJq+22/ZiCjK545TjhZhcc5
 IWlXR//dezV1wzE3HQCVkDWirNrsL5UXvqs4TXXJ1QXWKSuEsm7wIOkVZtDfp6cACxyD
 2EtuVDWAnADM7XPPZSAhyB6CAZJSVoZvuc7/0AOxHLe2EEYx8eUbjr7rjNLjG0HBjhCi
 0i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IojBl3jLz5IfvShs6QhkZ+GWUkLKuHgkE0WSF3TNLZU=;
 b=dGBVZ+B7DJDv/dVbUmDuXT2OW3nmdqVHYLtc7tucaoXUuTywMdaxC2hdgQ2eubauV+
 MZB9AdLGR5bQCIj+LVSMpPE0ZS2xOZFsF235vP+Z9W9TxX90pLwVYC7D7wQfM7XWdKyV
 iCgOA4NNMU6bzs+uBzUXZyJv1tN1urFmgv/Qc/ySuKwmQ5TZ8ooUTjudwDj59t/AszJ+
 s27k/yXXs9o1HkX1DdrZNRXC7HJEUtmOmHY6ZRxx8U+46U3bWKDFNJw0OK+L6G32X7wW
 cH8Ikr/GamNURDFsGIM0EPgnwW9znjbGlbFr8lIExyWXnw97lv+hOPqJymxV+AOeraUq
 Idpw==
X-Gm-Message-State: APjAAAUmTdaP1xzVuwMApu3j7Xoqnm8++gd1Utd8zzFPx1cWlViEnmOf
 YOzwUpn1AEcmjUpkH9HRmMaLajO8SiYsUzCxmN+oDQaj
X-Google-Smtp-Source: APXvYqyK94FI749S8RRw6P78DZthK6fiYukLeNxbLCQZKPP6jsf98FuRQt1IA5xb94Wx1EUu5MWj7Lp2a0trhA/9xqU=
X-Received: by 2002:a24:304a:: with SMTP id q71mr1697122itq.4.1551766457349;
 Mon, 04 Mar 2019 22:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
 <20190301160440.26262-3-s.miroshnichenko@yadro.com>
In-Reply-To: <20190301160440.26262-3-s.miroshnichenko@yadro.com>
From: Oliver <oohall@gmail.com>
Date: Tue, 5 Mar 2019 17:14:05 +1100
Message-ID: <CAOSf1CG0c_4jZQKanq7WHo-n9Urmx8NG8yVWbbx07ivZDu9e-A@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/9] powerpc/powernv/pci: Suppress an EEH error
 when reading an empty slot
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
> Reading an empty slot returns all ones, which triggers a false
> EEH error event on PowerNV. This patch unfreezes the bus where
> it has happened.
>
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/include/asm/ppc-pci.h   |  1 +
>  arch/powerpc/kernel/pci_dn.c         |  2 +-
>  arch/powerpc/platforms/powernv/pci.c | 34 ++++++++++++++++++++++++----
>  3 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
> index f67da277d652..737393c54f58 100644
> --- a/arch/powerpc/include/asm/ppc-pci.h
> +++ b/arch/powerpc/include/asm/ppc-pci.h
> @@ -40,6 +40,7 @@ void *traverse_pci_dn(struct pci_dn *root,
>                       void *(*fn)(struct pci_dn *, void *),
>                       void *data);
>  extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
> +struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus);
>
>  /* From rtas_pci.h */
>  extern void init_pci_config_tokens (void);
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index ab147a1909c8..341ed71250f1 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -40,7 +40,7 @@
>   * one of PF's bridge. For other devices, their firmware
>   * data is linked to that of their bridge.
>   */
> -static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
> +struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
>  {
>         struct pci_bus *pbus;
>         struct device_node *dn;
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 3260250d2029..73c2d0aed996 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -761,6 +761,21 @@ static inline pnv_pci_cfg_check(struct pci_dn *pdn)
>  }
>  #endif /* CONFIG_EEH */
>
> +static int get_bus_pe_number(struct pci_bus *bus)
> +{
> +       struct pci_dn *pdn = pci_bus_to_pdn(bus);
> +       struct pci_dn *child;
> +
> +       if (!pdn)
> +               return IODA_INVALID_PE;
> +
> +       list_for_each_entry(child, &pdn->child_list, list)
> +               if (child->pe_number != IODA_INVALID_PE)
> +                       return child->pe_number;
> +
> +       return IODA_INVALID_PE;
> +}
> +
>  static int pnv_pci_read_config(struct pci_bus *bus,
>                                unsigned int devfn,
>                                int where, int size, u32 *val)
> @@ -769,12 +784,23 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>         struct pci_controller *hose = pci_bus_to_host(bus);
>         struct pnv_phb *phb = hose->private_data;
>         int ret;
> +       u32 empty_val = 0xFFFFFFFF;
>
> -       *val = 0xFFFFFFFF;
> +       *val = empty_val;
>         pdn = pci_get_pdn_by_devfn(bus, devfn);
> -       if (!pdn)
> -               return pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
> -                                           where, size, val);
> +       if (!pdn) {
> +               int pe_number = get_bus_pe_number(bus);
> +
> +               ret = pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
> +                                          where, size, val);
> +
> +               if (!ret && (*val == empty_val) && phb->unfreeze_pe)

Do this empty val check work when using 1 or 2 byte cfg accesses?

> +                       phb->unfreeze_pe(phb, (pe_number == IODA_INVALID_PE) ?
> +                                        0xff : pe_number,

Use phb->ioda.reserved_pe_idx rather than guessing that 0xff is safe
to use. On P9 we have PHBs with 512 PEs and some older P8 firmware
releases used 0 as the reserved PE rather than 0xff.

> +                                        OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
> +
> +               return ret;
> +       }
>
>         if (!pnv_pci_cfg_check(pdn))
>                 return PCIBIOS_DEVICE_NOT_FOUND;
> --
> 2.20.1
>
