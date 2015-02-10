Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E50D31A0290
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:37:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Feb 2015 10:37:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A758A2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:37:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A0bDqZ17956916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:37:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A0amXX014110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:36:48 +1100
Message-ID: <1423528584.4924.70.camel@au1.ibm.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 11:36:24 +1100
In-Reply-To: <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
> If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
> resources will be cleaned out during device header fixup time and then get
> reassigned by PCI core. However, the VF resources won't be reassigned and
> thus, we shouldn't clean them out.
> 
> This patch adds a condition. If the pci_dev is a VF, skip the resource
> unset process.

I don't understand this, can you elaborate ? Why wouldn't we reassign
the IOV resource just like everything else ?

Ben.

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci-common.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 37d512d..889f743 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>  		       pci_name(dev));
>  		return;
>  	}
> +
> +	if (dev->is_virtfn)
> +		return;
> +
>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  		struct resource *res = dev->resource + i;
>  		struct pci_bus_region reg;
