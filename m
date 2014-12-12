Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 308171A0806
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:28:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 12 Dec 2014 14:28:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BC56D2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:28:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBC4SWCF32833712
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:28:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBC4SV2g029583
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:28:31 +1100
Date: Fri, 12 Dec 2014 12:28:29 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Print the M64 range information
Message-ID: <20141212042829.GA1668@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1418221778-12458-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141210224030.GA13035@shangw> <20141211072901.GA9598@richard>
 <20141211215818.GA6584@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141211215818.GA6584@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 12, 2014 at 08:58:19AM +1100, Gavin Shan wrote:
>On Thu, Dec 11, 2014 at 03:29:01PM +0800, Wei Yang wrote:
>>On Thu, Dec 11, 2014 at 09:40:30AM +1100, Gavin Shan wrote:
>>>On Wed, Dec 10, 2014 at 10:29:37PM +0800, Wei Yang wrote:
>>>>The M64 range information is missed, which would be helpful in debug.
>>>>
>>>>This patch print the M64 range information in the same format as M32.
>
>s/print/prints
>
>>>>
>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>---
>>>> arch/powerpc/platforms/powernv/pci-ioda.c |    3 +++
>>>> 1 file changed, 3 insertions(+)
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 21c8b4d..34f1a27 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -369,6 +369,9 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>>> 	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
>>>> 	phb->ioda.m64_base = pci_addr;
>>>>
>>>>+	printk(KERN_INFO " MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
>>>>+			res->start, res->end, pci_addr);
>>>>+
>>>
>>>Please output segment size if you think it's helpful as well.
>>
>>The M64 segment size is printed in pnv_pci_init_ioda_phb() line 2620.
>>
>
>Yes, it has been printed separately. So the change looks good to me
>after you replace "printk(KERN_INFO ...)" with pr_info. Could you please
>send updated version and include following line if you want:

Sure, glad to.

>
>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me
