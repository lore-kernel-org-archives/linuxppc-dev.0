Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjtdc66C6zDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 06:05:08 +1000 (AEST)
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com
 [209.85.216.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A807621AC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:05:06 +0000 (UTC)
Received: by mail-qt0-f180.google.com with SMTP id x36so3177901qtx.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 13:05:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5fc6930c9645c934de2586179ca3f80a055689cb.1504175330.git.robin.murphy@arm.com>
References: <5fc6930c9645c934de2586179ca3f80a055689cb.1504175330.git.robin.murphy@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 31 Aug 2017 15:04:45 -0500
Message-ID: <CAL_JsqKC6w_RH6bu3=he28NJn74JO_XLxQPfRLg15k9eSWsiuQ@mail.gmail.com>
Subject: Re: [PATCH v2] of: Restrict DMA configuration
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 31, 2017 at 5:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Moving DMA configuration to happen later at driver probe time had the
> unnoticed side-effect that we now perform DMA configuration for *every*
> device represented in DT, rather than only those explicitly created by
> the of_platform and PCI code.
>
> As Christoph points out, this is not really the best thing to do. Whilst
> there may well be other DMA-capable buses that can benefit from having
> their children automatically configured after the bridge has probed,
> there are also plenty of others like USB, MDIO, etc. that definitely do
> not support DMA and should not be indiscriminately processed.
>
> The good news is that in most cases the DT "dma-ranges" property serves
> as an appropriate indicator - per a strict interpretation of the spec,
> anything lacking a "dma-ranges" property should be considered not to
> have a mapping of DMA address space from its children to its parent,
> thus anything for which of_dma_get_range() does not succeed does not
> need DMA configuration. Certain bus types have a general expectation of
> DMA capability and carry a well-established precedent that an absent
> "dma-ranges" implies the same as the empty property, so we automatically
> opt those in to DMA configuration regardless, to avoid regressing most
> existing platforms.
>
> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v2: Updated commit message to be more reasonable
>
>  drivers/of/device.c | 48 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
