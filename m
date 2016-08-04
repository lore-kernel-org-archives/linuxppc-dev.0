Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s4lyH1rVrzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 20:08:39 +1000 (AEST)
Date: Thu, 4 Aug 2016 12:01:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: York Sun <york.sun@nxp.com>
Cc: linux-edac@vger.kernel.org, morbidrsa@gmail.com, oss@buserror.net,
 stuart.yoder@nxp.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 01/10] driver/edac/mpc85xx_edac: Fix compiling error
Message-ID: <20160804100117.GC8093@nazgul.tnic>
References: <1469745064-26597-1-git-send-email-york.sun@nxp.com>
 <1469745064-26597-2-git-send-email-york.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1469745064-26597-2-git-send-email-york.sun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 28, 2016 at 03:30:55PM -0700, York Sun wrote:
> Two symbols are missing if mpc85xx_edac driver is compiled as module.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> ---
> Change log
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

Please use get_maintainer.pl in order to CC the proper people when
preparing patches for the kernel.

I've CCed them now.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
