Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E7A62C0332
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Sep 2013 01:42:07 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 26 Sep 2013 11:42:04 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7B2A76E805C
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 11:41:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8QFfvwL63766560
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 15:41:57 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8QFfu5x015628
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 12:41:56 -0300
Date: Thu, 26 Sep 2013 23:41:54 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/powernv: Replace CONFIG_POWERNV_MSI with
 just CONFIG_PPC_POWERNV
Message-ID: <20130926154154.GB11159@shangw.(null)>
References: <1380181937-15156-1-git-send-email-michael@ellerman.id.au>
 <1380181937-15156-2-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380181937-15156-2-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 05:52:17PM +1000, Michael Ellerman wrote:
>We currently have a user visible CONFIG_POWERNV_MSI option, but it
>doesn't actually disable MSI for powernv. The MSI code is always built,
>what it does disable is the inclusion of the MSI bitmap code, which
>leads to a build error.
>
>eg, with PPC_POWERNV=y and POWERNV_MSI=n we get:
>
>  arch/powerpc/platforms/built-in.o: In function `.pnv_teardown_msi_irqs':
>  pci.c:(.text+0x3558): undefined reference to `.msi_bitmap_free_hwirqs'
>
>We don't really need a POWERNV_MSI symbol, just have the MSI bitmap code
>depend directly on PPC_POWERNV.
>
>Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/Kconfig | 5 -----
> arch/powerpc/sysdev/Kconfig            | 2 +-
> 2 files changed, 1 insertion(+), 6 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
>index 6fae5eb..09a5afd 100644
>--- a/arch/powerpc/platforms/powernv/Kconfig
>+++ b/arch/powerpc/platforms/powernv/Kconfig
>@@ -11,11 +11,6 @@ config PPC_POWERNV
> 	select PPC_UDBG_16550
> 	default y
>
>-config POWERNV_MSI
>-	bool "Support PCI MSI on PowerNV platform"
>-	depends on PCI_MSI
>-	default y
>-
> config PPC_POWERNV_RTAS
> 	depends on PPC_POWERNV
> 	bool "Support for RTAS based PowerNV platforms such as BML"
>diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
>index ab4cb54..8223f78 100644
>--- a/arch/powerpc/sysdev/Kconfig
>+++ b/arch/powerpc/sysdev/Kconfig
>@@ -19,7 +19,7 @@ config PPC_MSI_BITMAP
> 	default y if MPIC
> 	default y if FSL_PCI
> 	default y if PPC4xx_MSI
>-	default y if POWERNV_MSI
>+	default y if PPC_POWERNV
>
> source "arch/powerpc/sysdev/xics/Kconfig"
>

Thanks,
Gavin
