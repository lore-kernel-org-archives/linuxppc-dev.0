Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTfV70tVxzDr2S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 08:16:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7BMDcxo003694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 18:16:12 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c9drv38tw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 18:16:12 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 11 Aug 2017 18:16:11 -0400
Subject: Re: [bug report] powerpc/mm/radix: Avoid flushing the PWC on every
 flush_tlb_range
To: Dan Carpenter <dan.carpenter@oracle.com>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170811201544.jybwkrtd2oebtlld@mwanda>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 15:16:08 -0700
MIME-Version: 1.0
In-Reply-To: <20170811201544.jybwkrtd2oebtlld@mwanda>
Content-Type: text/plain; charset=utf-8
Message-Id: <e7eca4cb-23c1-f8c7-4c03-276b8f55b820@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2017 01:15 PM, Dan Carpenter wrote:
> Hello Benjamin Herrenschmidt,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 424de9c6e3f8: "powerpc/mm/radix: Avoid flushing the PWC on 
> every flush_tlb_range" from Jul 19, 2017, leads to the following 
> Smatch complaint:
> 
> arch/powerpc/mm/tlb-radix.c:368 radix__flush_tlb_collapsed_pmd()
> 	 error: we previously assumed 'mm' could be null (see line 362)
> 
> arch/powerpc/mm/tlb-radix.c
>    361	
>    362		pid = mm ? mm->context.id : 0;
>                       ^^
> Check for NULL.
> 
>    363		if (unlikely(pid == MMU_NO_CONTEXT))
>    364			goto no_context;
>    365	
>    366		/* 4k page size, just blow the world */
>    367		if (PAGE_SIZE == 0x1000) {
>    368			radix__flush_all_mm(mm);
>                                             ^^
> Unchecked dereference.

Appears to be a false positive. MMU_NO_CONTEXT I believe is defined as "0". So, maybe it
would be clearer that we take the goto branch if this line read:

362		pid = mm ? mm->context.id : MMU_NO_CONTEXT;

-Tyrel

> 
>    369			return;
>    370		}
> 
> regards,
> dan carpenter
> 
