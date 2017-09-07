Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp4rd0rQFzDrTW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 01:59:12 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v87Fx7Ha130029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Sep 2017 11:59:10 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cu77cevf3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 11:59:10 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 7 Sep 2017 11:59:08 -0400
Date: Thu, 7 Sep 2017 10:59:02 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, mikey@neuling.org,
 npiggin@gmail.com, paulus@samba.org, bharata@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
References: <20170907050551.4632-1-anton@ozlabs.org>
 <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
 <20170907151741.41ee33a8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170907151741.41ee33a8@kryten>
Message-Id: <20170907155902.kpzhgqqsxbwxwce5@arbab-laptop.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2017 at 05:17:41AM +0000, Anton Blanchard wrote:
>But all of memory on PowerNV should be able to be hot unplugged, so
>there are two options as I see it - either increase the memory block
>size, or map everything with 2MB pages.

I may be misunderstanding this, but what if we did something like x86 
does? When trying to unplug a region smaller than the mapping, they fill 
that part of the pagetable with 0xFD instead of freeing the whole thing.  
Once the whole thing is 0xFD, free it.

See arch/x86/mm/init_64.c:remove_{pte,pmd,pud}_table()

---%<---
	memset((void *)addr, PAGE_INUSE, next - addr);

	page_addr = page_address(pte_page(*pte));
	if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
		...
		pte_clear(&init_mm, addr, pte);
		...
	}
---%<---

-- 
Reza Arbab
