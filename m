Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1626D1A0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:44:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 11 Aug 2015 10:44:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F8CE3578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:44:30 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7B0iG3465470506
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:44:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7B0huhl031394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:43:57 +1000
Date: Tue, 11 Aug 2015 10:43:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 18/42] powerpc/powernv: Allocate PE# in deasending order
Message-ID: <20150811004339.GC18981@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-19-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C8B786.1050702@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C8B786.1050702@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2015 at 12:39:02AM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>The available PE#, represented by a bitmap in the PHB, is allocated
>>in ascending order.
>
>Available PE# is available exactly because it is not allocated ;)
>

Yeah, will correct it.

>>It conflicts with the fact that M64 segments are
>>assigned in same order. In order to avoid the conflict, the patch
>>allocates PE# in descending order.
>
>What kind of conflict?
>

On PHB3, the M64 segment is assigned to one PE whose PE number is
determined. M64 segment are allocated in ascending order. It's why
I would like to allocate PE# in deascending order.

>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 56b058c..1c950e8 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -161,13 +161,18 @@ static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>  static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>  {
>>  	unsigned long pe;
>>+	unsigned long limit = phb->ioda.total_pe_num - 1;
>>
>>  	do {
>>  		pe = find_next_zero_bit(phb->ioda.pe_alloc,
>>-					phb->ioda.total_pe_num, 0);
>>-		if (pe >= phb->ioda.total_pe_num)
>>+					phb->ioda.total_pe_num, limit);
>>+		if (pe < phb->ioda.total_pe_num &&
>>+		    !test_and_set_bit(pe, phb->ioda.pe_alloc))
>>+			break;
>>+
>>+		if (--limit >= phb->ioda.total_pe_num)
>>  			return NULL;
>>-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>>+	} while (1);
>
>
>Usually, if it is "while(1)", then it is "while(1){}" rather than
>"do{}while(1)" :)

Agree, will change it.

>
>
>>
>>  	return pnv_ioda_init_pe(phb, pe);
>>  }
>>

Thanks,
Gavin
