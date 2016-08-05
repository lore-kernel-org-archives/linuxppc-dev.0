Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5CMT2D6gzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 13:43:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: York Sun <york.sun@nxp.com>, linux-edac@vger.kernel.org
Cc: morbidrsa@gmail.com, oss@buserror.net, stuart.yoder@nxp.com, bp@alien8.de,
 York Sun <york.sun@nxp.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
In-Reply-To: <1470351518-22404-2-git-send-email-york.sun@nxp.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
Date: Fri, 05 Aug 2016 13:43:32 +1000
Message-ID: <877fbvkhi3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

York Sun <york.sun@nxp.com> writes:

> Two symbols are missing if mpc85xx_edac driver is compiled as module.
>
> Signed-off-by: York Sun <york.sun@nxp.com>
>
> ---
> Change log
>   v3: Change subject tag
>   v2: no change
>
>  arch/powerpc/kernel/pci-common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 0f7a60f..86bc484 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -226,6 +226,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
>  	}
>  	return NULL;
>  }
> +EXPORT_SYMBOL(pci_find_hose_for_OF_device);
>  
>  /*
>   * Reads the interrupt pin to determine if interrupt is use by card.
> @@ -1585,6 +1586,7 @@ int early_find_capability(struct pci_controller *hose, int bus, int devfn,
>  {
>  	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
>  }
> +EXPORT_SYMBOL(early_find_capability);

Does the driver really need to use these routines? They're meant for use
early in boot, before PCI is setup.

AFAICS this is just a regular driver, so when it's probed the PCI
devices should have already been scanned. In which case pci_get_device()
could work couldn't it? (I see other edac drivers doing that).

cheers
