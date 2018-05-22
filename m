Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qv2q0GKwzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 21:45:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MBdSEJ089498
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 07:45:03 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4gpkw2nf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 07:45:03 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 22 May 2018 12:45:00 +0100
Subject: Re: [PATCH v11 01/26] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
To: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
 kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
 jack@suse.cz, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 sergey.senozhatsky.work@gmail.com, Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Minchan Kim <minchan@kernel.org>, Punit Agrawal <punitagrawal@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1526555193-7242-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <2cb8256d-5822-d94d-b0e6-c46f21d84852@infradead.org>
 <20180517171951.GB26718@bombadil.infradead.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 13:44:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180517171951.GB26718@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <9a95bb6b-78cb-52a6-9c3a-4869f7cdb079@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/05/2018 19:19, Matthew Wilcox wrote:
> On Thu, May 17, 2018 at 09:36:00AM -0700, Randy Dunlap wrote:
>>> +	 If the speculative page fault fails because of a concurrency is
>>
>> 	                                     because a concurrency is
> 
> While one can use concurrency as a noun, it sounds archaic to me.  I'd
> rather:
> 
> 	If the speculative page fault fails because a concurrent modification
> 	is detected or because underlying PMD or PTE tables are not yet

Thanks Matthew, I'll do that.

> 
>>> +	 detected or because underlying PMD or PTE tables are not yet
>>> +	 allocating, it is failing its processing and a classic page fault
>>
>> 	 allocated, the speculative page fault fails and a classic page fault
>>
>>> +	 is then tried.
> 
