Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3683F1A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 12:03:21 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0C28140077
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 12:03:20 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 12:03:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFF102CE804E
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 12:03:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R2326f5374046
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 12:03:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R22b15020881
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 12:02:37 +1000
Date: Mon, 27 Apr 2015 12:02:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] powerpc/powernv: Fix early pci_controller_ops loading.
Message-ID: <20150427020213.GA9830@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430099666-9159-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430099666-9159-1-git-send-email-dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2015 at 11:54:26AM +1000, Daniel Axtens wrote:
>Load the PowerNV platform pci controller ops into pci controllers
>after all the operations are loaded into the platform ops struct, not
>before.
>
>Fixes: c88c2a188905cb3077c3c38dc498e7e9f8eebeee

I think it would fix commit 65ebf4b63 ("powerpc/powernv: Move controller ops from ppc_md to controller_ops")
If that's the case, the above line could be replaced with:

Fixes: 65ebf4b63 ("powerpc/powernv: Move controller ops from ppc_md to controller_ops")

>Reported-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Daniel Axtens <dja@axtens.net>

The changes look good to me.

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 920c252..f8bc950 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -2693,7 +2693,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> 		hose->last_busno = 0xff;
> 	}
> 	hose->private_data = phb;
>-	hose->controller_ops = pnv_pci_controller_ops;
> 	phb->hub_id = hub_id;
> 	phb->opal_id = phb_id;
> 	phb->type = ioda_type;
>@@ -2812,6 +2811,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> 	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
> 	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
> 	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
>+	hose->controller_ops = pnv_pci_controller_ops;
>
> #ifdef CONFIG_PCI_IOV
> 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
>-- 
>2.1.4
>
