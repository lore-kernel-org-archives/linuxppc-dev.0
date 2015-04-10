Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC3F1A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 13:18:34 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0141.outbound.protection.outlook.com [207.46.100.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B574140281
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 13:18:33 +1000 (AEST)
Message-ID: <1428635902.22867.574.camel@freescale.com>
Subject: Re: [PATCH v4 16/19] powerpc: fsl_pci, swiotlb: Move controller ops
 from ppc_md to controller_ops
From: Scott Wood <scottwood@freescale.com>
To: Daniel Axtens <dja@axtens.net>
Date: Thu, 9 Apr 2015 22:18:22 -0500
In-Reply-To: <1428635747-9754-1-git-send-email-dja@axtens.net>
References: <1428624718-13564-1-git-send-email-dja@axtens.net>
 <1428635747-9754-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 13:15 +1000, Daniel Axtens wrote:
> Move the installation of DMA operations out of swiotlb's subsys
> initcall, and into the generic PCI controller operations struct.
> 
> These ops are installed conditionally, based on the ppc_swiotlb_enable
> global. The global can be set in two places:
>  - swiotlb_detect_4g, which is always called at the arch initcall level
>  - setup_pci_atmu, which is called as part of the fsl_add_bridge and
> fsl_pci_syscore_do_resume.
> 
> fsl_pci_syscore_do_resume is called late enough that any changes as a
> result of that call will have no effect.
> 
> As such, if we test the global and set the operations as part of
> fsl_add_bridge, after the call to setup_pci_atmu, we can be confident
> that it will cover all the PCI implementations affected by the changes
> to dma-swiotlb.c.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> v1 --> v2:
>  - Move the setup call to after setup_pci_atmu().
> 
> v2 --> v3:
>  - Only set the affected op, not the entire structure. Thanks mpe.
> 
> v3 --> v4:
>  - Improved commit message, thanks Scott Wood.
> ---
>  arch/powerpc/kernel/dma-swiotlb.c | 11 ++++-------
>  arch/powerpc/sysdev/fsl_pci.c     | 15 +++++++++++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
