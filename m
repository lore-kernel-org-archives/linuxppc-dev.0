Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMNhW261lzF0YT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 10:34:03 +1100 (AEDT)
Date: Wed, 17 Jan 2018 17:33:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Frank Rowand <frowand.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: move DT PCI functions to PCI core
Message-ID: <20180117233357.GB53542@bhelgaas-glaptop.roam.corp.google.com>
References: <20180104211215.11344-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180104211215.11344-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 04, 2018 at 03:12:12PM -0600, Rob Herring wrote:
> Most subsystem specific functions have been moved into the respective
> subsystems. Only PCI and networking remain. This series moves most of the
> PCI related code to drivers/pci/of.c. Some bus address functions for PCI
> remain in of/address.c because we don't have infrastructure to split up
> the per bus helper functions.
> 
> I expect Bjorn to take this series, so PPC maintainers please ack.

I plan to merge this for v4.16, so PPC maintainers, this is your
chance to speak up :)

> Rob Herring (3):
>   PCI: move OF related PCI functions into PCI core
>   powerpc/pci: use of_irq_parse_and_map_pci helper
>   PCI: make of_irq_parse_pci static
> 
>  arch/arm/mach-mvebu/Kconfig      |   1 -
>  arch/powerpc/kernel/pci-common.c |   8 +-
>  drivers/of/Kconfig               |  16 --
>  drivers/of/Makefile              |   2 -
>  drivers/of/address.c             |   8 +-
>  drivers/of/of_pci.c              | 384 -----------------------------
>  drivers/of/of_pci_irq.c          | 131 ----------
>  drivers/pci/of.c                 | 505 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h           |   8 +-
>  9 files changed, 510 insertions(+), 553 deletions(-)
>  delete mode 100644 drivers/of/of_pci.c
>  delete mode 100644 drivers/of/of_pci_irq.c
> 
> --
> 2.14.1
