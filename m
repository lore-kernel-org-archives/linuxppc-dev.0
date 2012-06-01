Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D60AB6FFE
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2012 11:25:44 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 1 Jun 2012 06:55:42 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q511PHxF57999450
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2012 06:55:18 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q516ttRf011180
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2012 16:55:55 +1000
Date: Fri, 1 Jun 2012 09:25:15 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pci: cleanup on duplicate assignment
Message-ID: <20120601012515.GA7503@richard>
References: <1338445049-20520-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338445049-20520-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Agree, this is a duplication.

On Thu, May 31, 2012 at 02:17:29PM +0800, Gavin Shan wrote:
>While creating the PCI root bus through function pci_create_root_bus()
>of PCI core, it should have assigned the secondary bus number for the
>newly created PCI root bus. Thus we needn't do the explicit assignment
>for the secondary bus number again in pcibios_scan_phb().
>
>Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/pci-common.c |    1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>index 8e78e93..0f75bd5 100644
>--- a/arch/powerpc/kernel/pci-common.c
>+++ b/arch/powerpc/kernel/pci-common.c
>@@ -1646,7 +1646,6 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
> 		pci_free_resource_list(&resources);
> 		return;
> 	}
>-	bus->secondary = hose->first_busno;
> 	hose->bus = bus;
>
> 	/* Get probe mode and perform scan */
>-- 
>1.7.9.5
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Richard Yang
Help you, Help me
