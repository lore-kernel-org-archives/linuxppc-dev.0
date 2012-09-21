Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5A472C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 20:58:39 +1000 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 21 Sep 2012 06:58:34 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8LAwUMV37158926
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 06:58:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8LAwToU024462
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 07:58:30 -0300
Date: Fri, 21 Sep 2012 18:58:26 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc: Don't release eeh_mutex in eeh_phb_pe_get
Message-ID: <20120921105826.GA31029@shangw.(null)>
References: <1348219786-31221-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348219786-31221-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2012 at 02:59:46PM +0530, Aneesh Kumar K.V wrote:
>From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
>=====================================
>[ BUG: bad unlock balance detected! ]
>3.6.0-rc5-00338-gcaa1d63-dirty #6 Not tainted
>-------------------------------------
>swapper/0/1 is trying to release lock (eeh_mutex) at:
>[<c000000000058218>] .eeh_add_to_parent_pe+0x318/0x410
>but there are no more locks to release!
>
>other info that might help us debug this:
>no locks held by swapper/0/1.
>
>stack backtrace:
>Call Trace:
>[c00000003e483870] [c000000000013310] .show_stack+0x70/0x1c0 (unreliable)
>[c00000003e483920] [c0000000000d8310] .print_unlock_inbalance_bug+0x110/0x120
>[c00000003e4839b0] [c0000000000d9a50] .lock_release+0x1d0/0x240
>[c00000003e483a60] [c000000000778064] .__mutex_unlock_slowpath+0xb4/0x250
>[c00000003e483b10] [c000000000058218] .eeh_add_to_parent_pe+0x318/0x410
>[c00000003e483bc0] [c00000000005a118] .pseries_eeh_of_probe+0x258/0x2f0
>[c00000003e483cc0] [c000000000032528] .traverse_pci_devices+0xa8/0x150
>[c00000003e483d70] [c000000000aa7288] .eeh_init+0xd4/0x140
>[c00000003e483e00] [c00000000000abc4] .do_one_initcall+0x64/0x1e0
>[c00000003e483ec0] [c000000000a90418] .kernel_init+0x1e8/0x2bc
>[c00000003e483f90] [c00000000002048c] .kernel_thread+0x54/0x70
>EEH: PCI Enhanced I/O Error Handling Enabled
>
>Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/platforms/pseries/eeh_pe.c |    5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
>index 9d35543..797cd18 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pe.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
>@@ -105,11 +105,8 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
> 		 * the PE for PHB has been determined when that
> 		 * was created.
> 		 */
>-		if ((pe->type & EEH_PE_PHB) &&
>-		    pe->phb == phb) {
>-			eeh_unlock();
>+		if ((pe->type & EEH_PE_PHB) && pe->phb == phb)
> 			return pe;
>-		}
> 	}
>
> 	return NULL;
>-- 
>1.7.10
>
