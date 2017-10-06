Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7gK3021vzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 17:51:18 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v966ovNg018145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 02:51:16 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2de41cjp10-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 02:51:08 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 07:49:15 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v966nBWq15728794
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 06:49:13 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v966nBJh016894
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 17:49:12 +1100
Subject: Re: [PATCH] mm: deferred_init_memmap improvements
To: Pavel Tatashin <pasha.tatashin@oracle.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20171004152902.17300-1-pasha.tatashin@oracle.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 6 Oct 2017 12:18:31 +0530
MIME-Version: 1.0
In-Reply-To: <20171004152902.17300-1-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <071d574f-1d8c-5be9-ec92-6227db01bbd3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/2017 08:59 PM, Pavel Tatashin wrote:
> This patch fixes another existing issue on systems that have holes in
> zones i.e CONFIG_HOLES_IN_ZONE is defined.
> 
> In for_each_mem_pfn_range() we have code like this:
> 
> if (!pfn_valid_within(pfn)
> 	goto free_range;
> 
> Note: 'page' is not set to NULL and is not incremented but 'pfn' advances.

page is initialized to NULL at the beginning of the function.
PFN advances but we dont proceed unless pfn_valid_within(pfn)
holds true which basically should have checked with arch call
back if the PFN is valid in presence of memory holes as well.
Is not this correct ?

> Thus means if deferred struct pages are enabled on systems with these kind
> of holes, linux would get memory corruptions. I have fixed this issue by
> defining a new macro that performs all the necessary operations when we
> free the current set of pages.

If we bail out in case PFN is not valid, then how corruption
can happen ?
