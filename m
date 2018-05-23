Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rmQT3XlrzF1Gj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 07:50:09 +1000 (AEST)
Date: Wed, 23 May 2018 16:50:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] pci/hotplug/pnv-php: add missing of_node_put
Message-ID: <20180523215006.GF150632@bhelgaas-glaptop.roam.corp.google.com>
References: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
 <1527102436-13447-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527102436-13447-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2018 at 09:07:15PM +0200, Julia Lawall wrote:
> The device node iterators perform an of_node_get on each iteration, so a
> jump out of the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator name for_each_child_of_node;
> @@
> 
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> +  of_node_put(child);
> ?  break;
>    ...
> }
> ... when != child
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to pci/hotplug for v4.18, thanks!

> ---
>  drivers/pci/hotplug/pnv_php.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index d441006..6c2e8d7 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -220,12 +220,16 @@ static int pnv_php_populate_changeset(struct of_changeset *ocs,
>  
>  	for_each_child_of_node(dn, child) {
>  		ret = of_changeset_attach_node(ocs, child);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(child);
>  			break;
> +		}
>  
>  		ret = pnv_php_populate_changeset(ocs, child);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(child);
>  			break;
> +		}
>  	}
>  
>  	return ret;
> 
