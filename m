Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFTwL017czDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 08:07:45 +1100 (AEDT)
Date: Fri, 3 Feb 2017 15:07:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Roy Zang <tie-fei.zang@freescale.com>, linux-renesas-soc@vger.kernel.org,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Shailendra Verma <shailendra.v@samsung.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Mingkai Hu <mingkai.hu@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1 0/4] PCI: Use of_device_get_match_data() to simplify
 probe
Message-ID: <20170203210740.GC24162@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 02:19:51PM -0600, Bjorn Helgaas wrote:
> This turned into much ado about nothing, but Shailendra's hisi patch
> prompted similar cleanups in other drivers.  It's a minor simplification,
> but I think worth doing consistently across drivers.
> 
> Basically this is Geert's observation that when the driver probe function
> is called only as a result of matching something in <match_table>, a
> subsequent of_match_device(<match_table>, dev) call should never fail.
> 
> Therefore, instead of this:
> 
>   struct of_device_id *match;
> 
>   match = of_match_device(<match_table>, dev);
>   ... = match->data;
> 
> we can do this:
> 
>   ... = of_device_get_match_data(dev);
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: iproc: Use of_device_get_match_data() to simplify probe
>       PCI: layerscape: Use of_device_get_match_data() to simplify probe
>       PCI: rcar: Use of_device_get_match_data() to simplify probe
> 
> Shailendra Verma (1):
>       PCI: hisi: Use of_device_get_match_data() to simplify probe
> 
> 
>  drivers/pci/host/pci-layerscape.c      |    7 +------
>  drivers/pci/host/pcie-hisi.c           |    8 +++-----
>  drivers/pci/host/pcie-iproc-platform.c |    7 +------
>  drivers/pci/host/pcie-rcar.c           |    7 +------
>  4 files changed, 6 insertions(+), 23 deletions(-)

I applied these to pci/host-layerscape, pci/host-hisi, pci/host-iproc,
pci/host-rcar for v4.11.
