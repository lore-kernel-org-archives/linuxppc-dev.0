Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhv9R1zpRzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 15:25:47 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7U5PPDM144787
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 01:25:45 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cnby41yn5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 01:25:44 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 15:25:42 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7U5Pd5940435796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 15:25:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7U5PTPC016996
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 15:25:30 +1000
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 10:55:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f6927138-5863-82f8-8c85-2ff96d5e9434@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/2017 05:48 AM, Kirill A. Shutemov wrote:
>> +	/* Transparent huge pages are not supported. */
>> +	if (unlikely(pmd_trans_huge(*pmd)))
>> +		goto out_walk;
> That's looks like a blocker to me.
> 
> Is there any problem with making it supported (besides plain coding)?

IIUC we would have to reattempt once for each PMD level fault because
of the lack of a page table entry there. Besides do we want to support
huge pages in general as part of speculative page fault path ? The
number of faults will be very less (256 times lower on POWER and 512
times lower on X86). So is it worth it ? BTW calling hugetlb_fault()
after figuring out the VMA, works correctly inside handle_speculative
_fault() last time I checked.
