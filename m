Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93E131A0206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 17:28:10 +1100 (AEDT)
Message-ID: <1414736879.28356.51.camel@pasglop>
Subject: Re: [PATCH] powerpc/pseries: Quieten ibm,pcie-link-speed-stats warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Fri, 31 Oct 2014 17:27:59 +1100
In-Reply-To: <1414731901-2096-1-git-send-email-anton@samba.org>
References: <1414731901-2096-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-31 at 16:05 +1100, Anton Blanchard wrote:
> The ibm,pcie-link-speed-stats isn't mandatory, so we shouldn't print
> a high priority error message when missing. One example where we see
> this is QEMU.
> 
> Reduce it to pr_info.

I would reduce it even further to pr_dbg.

Cheers,
Ben.

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/platforms/pseries/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 67e4859..57dd7a0 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -134,7 +134,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
>  	of_node_put(pdn);
>  
>  	if (rc) {
> -		pr_err("no ibm,pcie-link-speed-stats property\n");
> +		pr_info("no ibm,pcie-link-speed-stats property\n");
>  		return 0;
>  	}
>  
