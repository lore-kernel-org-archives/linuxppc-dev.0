Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0823A2C0304
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 09:16:17 +1100 (EST)
Date: Fri, 3 Jan 2014 16:16:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [11/12,v3] pci: fsl: update PCI EDAC driver
Message-ID: <20140103221603.GA22546@home.buserror.net>
References: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 06:41:33PM +0800, Minghuan Lian wrote:
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 40d2e1d..4a03e1a 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -236,6 +236,7 @@ void fsl_arch_pci_sys_remove(struct fsl_pci *pci)
>  	if (!hose)
>  		return;
>  
> +	mpc85xx_pci_err_remove(to_platform_device(pci->dev));
>  	pcibios_free_controller(hose);

This causes a linker error if the EDAC driver is enabled, due to commit
0f1741c74aa6794b1c7fbdd19f26a4f2377a11c6 ("edac/85xx: Remove
mpc85xx_pci_err_remove").

-Scott
