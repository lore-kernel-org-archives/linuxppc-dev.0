Return-Path: <bhelgaas@google.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcp1m2YfrzF17L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 06:20:27 +1100 (AEDT)
Received: by mail-yw0-x244.google.com with SMTP id u17so3411512ywg.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 11:20:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208053354.41725-1-aik@ozlabs.ru>
References: <20180208053354.41725-1-aik@ozlabs.ru>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 8 Feb 2018 13:20:04 -0600
Message-ID: <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>,
 Alistair Popple <alistair@popple.id.au>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc linux-pci]

The original commit was merged via PCI, and I think it's a good idea
to merge fixes to it the same way.  I'll try to merge this in time for
v4.16-rc1.

On Wed, Feb 7, 2018 at 11:33 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> correctly states that of_irq_parse_and_map_pci() does the same thing as
> of_irq_parse_pci() does as it simply calls
> of_irq_parse_pci() and irq_create_of_mapping().
>
> However of_irq_parse_and_map_pci() not only returns 0 for success and
> negative value for an error but also a positive virq value from
> irq_create_of_mapping() which the mentioned commit ignores and
> INTx config fails.
>
> This fixes the of_irq_parse_and_map_pci() return value handling.
>
> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Found it on POWER9 + powernv system - almost all devices suddenly lost
> INTx support.
> ---
>  arch/powerpc/kernel/pci-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index ae2ede4..acbb44f2 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>         memset(&oirq, 0xff, sizeof(oirq));
>  #endif
>         /* Try to get a mapping from the device-tree */
> -       if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
> +       virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> +       if (virq <= 0) {
>                 u8 line, pin;
>
>                 /* If that fails, lets fallback to what is in the config
> --
> 2.11.0
>
