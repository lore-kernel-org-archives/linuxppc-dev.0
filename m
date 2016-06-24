Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbSs13JSTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:21:24 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5O6J7p5117402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 02:21:22 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23rmrr2v4n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 02:21:21 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 24 Jun 2016 16:21:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D78452BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:21:16 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5O6LGOI7930206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:21:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5O6LGVd015865
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:21:16 +1000
Date: Fri, 24 Jun 2016 16:21:15 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: fix pr_debug()s in eeh_cache.c
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1466747662-9868-1-git-send-email-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466747662-9868-1-git-send-email-andrew.donnellan@au1.ibm.com>
Message-Id: <20160624062115.GA8107@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 24, 2016 at 03:54:22PM +1000, Andrew Donnellan wrote:
>eeh_cache.c doesn't build cleanly with -DDEBUG when
>CONFIG_PHYS_ADDR_T_64BIT is set, as a couple of pr_debug()s use "%lx" for
>resource_size_t parameters.
>
>Use "%pap" instead, as it's the correct format specifier for types deriving
>from phys_addr_t.
>
>Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>Cc: Russell Currey <ruscur@russell.cc>
>Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/eeh_cache.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
>index ddbcfab..ceb81a4 100644
>--- a/arch/powerpc/kernel/eeh_cache.c
>+++ b/arch/powerpc/kernel/eeh_cache.c
>@@ -114,9 +114,9 @@ static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
> 	while (n) {
> 		struct pci_io_addr_range *piar;
> 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
>-		pr_debug("PCI: %s addr range %d [%lx-%lx]: %s\n",
>+		pr_debug("PCI: %s addr range %d [%pap-%pap]: %s\n",
> 		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
>-		       piar->addr_lo, piar->addr_hi, pci_name(piar->pcidev));
>+		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
> 		cnt++;
> 		n = rb_next(n);
> 	}
>@@ -159,8 +159,8 @@ eeh_addr_cache_insert(struct pci_dev *dev, resource_size_t alo,
> 	piar->flags = flags;
>
> #ifdef DEBUG
>-	pr_debug("PIAR: insert range=[%lx:%lx] dev=%s\n",
>-	                  alo, ahi, pci_name(dev));
>+	pr_debug("PIAR: insert range=[%pap:%pap] dev=%s\n",
>+	                  &alo, &ahi, pci_name(dev));
> #endif
>
> 	rb_link_node(&piar->rb_node, parent, p);
>-- 
>Andrew Donnellan              OzLabs, ADL Canberra
>andrew.donnellan@au1.ibm.com  IBM Australia Limited
>
