Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdw0r518zzDrT4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 18:53:00 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7P8n8DM062567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:52:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cjesn66tq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:52:57 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 25 Aug 2017 09:52:56 +0100
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170820121155.GA624@tigerII.localdomain>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 10:52:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170820121155.GA624@tigerII.localdomain>
Content-Type: text/plain; charset=utf-8
Message-Id: <e91cd0ad-0b59-0d93-e8c8-8a82a26015ec@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/08/2017 14:11, Sergey Senozhatsky wrote:
> On (08/18/17 00:05), Laurent Dufour wrote:
> [..]
>> +	/*
>> +	 * MPOL_INTERLEAVE implies additional check in mpol_misplaced() which
>> +	 * are not compatible with the speculative page fault processing.
>> +	 */
>> +	pol = __get_vma_policy(vma, address);
>> +	if (!pol)
>> +		pol = get_task_policy(current);
>> +	if (pol && pol->mode == MPOL_INTERLEAVE)
>> +		goto unlock;
> 
> include/linux/mempolicy.h defines
> 
> struct mempolicy *get_task_policy(struct task_struct *p);
> struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
> 		unsigned long addr);
> 
> only for CONFIG_NUMA configs.

Thanks Sergey, I'll add #ifdef around this block.
