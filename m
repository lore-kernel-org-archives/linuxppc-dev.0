Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL0zm5BzXzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 04:42:28 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0FHgO8H045113
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 12:42:24 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fgwn6hj86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 12:42:24 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 15 Jan 2018 17:42:21 -0000
Subject: Re: [PATCH v6 16/24] mm: Protect mm_rb tree with a rwlock
To: Matthew Wilcox <willy@infradead.org>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1515777968-867-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1515777968-867-17-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180112184821.GB7590@bombadil.infradead.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 18:42:11 +0100
MIME-Version: 1.0
In-Reply-To: <20180112184821.GB7590@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <9c21cf88-84bd-c951-59eb-c0a5b31dadb3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matthew,

Thanks for reviewing this series.

On 12/01/2018 19:48, Matthew Wilcox wrote:
> On Fri, Jan 12, 2018 at 06:26:00PM +0100, Laurent Dufour wrote:
>> -static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
>> +static void __vma_rb_erase(struct vm_area_struct *vma, struct mm_struct *mm)
>>  {
>> +	struct rb_root *root = &mm->mm_rb;
>>  	/*
>>  	 * Note rb_erase_augmented is a fairly large inline function,
>>  	 * so make sure we instantiate it only once with our desired
>>  	 * augmented rbtree callbacks.
>>  	 */
>> +#ifdef CONFIG_SPF
>> +	write_lock(&mm->mm_rb_lock);
>> +#endif
>>  	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
>> +#ifdef CONFIG_SPF
>> +	write_unlock(&mm->mm_rb_lock); /* wmb */
>> +#endif
> 
> I can't say I love this.  Have you considered:
> 
> #ifdef CONFIG_SPF
> #define vma_rb_write_lock(mm)	write_lock(&mm->mm_rb_lock)
> #define vma_rb_write_unlock(mm)	write_unlock(&mm->mm_rb_lock)
> #else
> #define vma_rb_write_lock(mm)	do { } while (0)
> #define vma_rb_write_unlock(mm)	do { } while (0)
> #endif

I haven't consider this, but this sounds to be smarter. I'll do that.

> Also, SPF is kind of uninformative.  CONFIG_MM_SPF might be better?
> Or perhaps even CONFIG_SPECULATIVE_PAGE_FAULT, just to make it really
> painful to do these one-liner ifdefs that make the code so hard to read.

Thomas also complained about that, and I agree, SPF is quite cryptic. This
being said, I don't think that CONFIG_MM_SPF will be far better, so I'll
change this define to CONFIG_SPECULATIVE_PAGE_FAULT, even if it's longer,
it should not be too much present in the code.

Thanks,
Laurent.
