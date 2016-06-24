Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbT4Z3fGpzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:31:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5O6TewV040645
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 02:31:23 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23rj7hs6mb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 02:31:23 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 24 Jun 2016 16:31:20 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 33A6A3578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:31:17 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5O6VG6r3801408
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:31:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5O6VGwY029337
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:31:16 +1000
Date: Fri, 24 Jun 2016 16:31:15 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/pci: Reduce log level of PCI I/O space warning
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1466580187.4089.23.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466580187.4089.23.camel@kernel.crashing.org>
Message-Id: <20160624063115.GA13944@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2016 at 05:23:07PM +1000, Benjamin Herrenschmidt wrote:
>If a PHB has no I/O space, there's no need to make it look like
>something bad happened, a pr_debug() is plenty enough since this
>is the case of all our modern POWER chips.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/pci-common.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>index 2a67b16..3ab1f7b 100644
>--- a/arch/powerpc/kernel/pci-common.c
>+++ b/arch/powerpc/kernel/pci-common.c
>@@ -1487,9 +1487,9 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
> 	res = &hose->io_resource;
> 
> 	if (!res->flags) {
>-		pr_info("PCI: I/O resource not set for host"
>-		       " bridge %s (domain %d)\n",
>-		       hose->dn->full_name, hose->global_number);
>+		pr_debug("PCI: I/O resource not set for host"
>+			 " bridge %s (domain %d)\n",
>+			 hose->dn->full_name, hose->global_number);
> 	} else {
> 		offset = pcibios_io_space_offset(hose);
> 
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
