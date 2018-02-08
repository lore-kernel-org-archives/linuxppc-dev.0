Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcpcV2kYnzF1B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 06:47:05 +1100 (AEDT)
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E703217B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 19:47:03 +0000 (UTC)
Received: by mail-qk0-f182.google.com with SMTP id d129so3856224qke.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 11:47:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208053354.41725-1-aik@ozlabs.ru>
References: <20180208053354.41725-1-aik@ozlabs.ru>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Feb 2018 13:46:41 -0600
Message-ID: <CAL_JsqKas_etnkOptNvWGDsnUSs_OYOdpW3D+6a7+4MtLeF45Q@mail.gmail.com>
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Thanks.

Acked-by: Rob Herring <robh@kernel.org>
