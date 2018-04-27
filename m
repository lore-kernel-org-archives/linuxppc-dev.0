Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XgYp2sTNzF24D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 03:15:41 +1000 (AEST)
Received: by mail-ot0-f193.google.com with SMTP id l12-v6so2835897oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 10:15:41 -0700 (PDT)
Date: Fri, 27 Apr 2018 12:15:37 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, hch@lst.de, gregkh@linuxfoundation.org,
 joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com
Subject: Re: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
Message-ID: <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2018 at 03:57:02PM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c   |   6 +--
>  drivers/of/address.c       | 102 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c           |   7 ++--
>  drivers/pci/of.c           | 101 --------------------------------------------
>  include/linux/of_address.h |  11 +++++
>  include/linux/of_pci.h     |  10 -----
>  6 files changed, 120 insertions(+), 117 deletions(-)

of/address.c isn't really the best fit either, though I don't have a 
better suggestion. 

I'm guessing this breaks on Sparc which doesn't build of/address.c. 
I guess move it to base.c and of.h if that is the case.

Rob
