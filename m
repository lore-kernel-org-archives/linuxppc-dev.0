Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM9dS631FzDqD6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 02:15:40 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0HFC53X147390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 10:15:36 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fj5ektq3b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 10:15:36 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 15:15:33 -0000
Subject: Re: [PATCH v6 00/24] Speculative page faults
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
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
 <20180116151145.74odvlj6mjuwq3rr@node.shutemov.name>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 17 Jan 2018 16:15:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180116151145.74odvlj6mjuwq3rr@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Message-Id: <8dd74917-2f61-cf49-a350-73e4d54c72c1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kirill,

Thanks for reviewing this series.

On 16/01/2018 16:11, Kirill A. Shutemov wrote:
> On Fri, Jan 12, 2018 at 06:25:44PM +0100, Laurent Dufour wrote:
>> ------------------
>> Benchmarks results
>>
>> Base kernel is 4.15-rc6-mmotm-2018-01-04-16-19
>> SPF is BASE + this series
> 
> Do you have THP=always here? Lack of THP support worries me.

Yes my kernel is built with THP=always.

For the record, I wrote all the code to support THP, but when I was about
to plug it into the speculative page fault handler, I was wondering about
the pmd_none() check and this raises the issue with khugepaged and the way
it is invalidating the pmd before collapsing the underlying pages.
Currently, there is no easy way to detect when such a collapsing operation
is occurring.

> What is performance in the worst case scenario? Like when we go far enough into
> speculative code path on every page fault and then fallback to normal page
> fault?

I did further tests focusing on the THP with a patched ebizzy (to use
posix_memalign() and MADV_HUGEPAGE) to force the use of the transparent
huge pages. I double checked that use through /proc/#/smaps.

Here is the result I got on a 16 CPUs x86 VM (higher the best):
	BASE	SPF
mean	276.83	276.93	record/s
max	280	280	record/s

The run was done 100 times using a large enough size records (128 MB).

Here is also the event I recorded when running ebizzy during 60s:

275 records/s
 Performance counter stats for './ebizzy -HT -s 134217728':

           182,470      faults

             5,085      spf

           176,634      pagefault:spf_vma_notsup


      10.518504612 seconds time elapsed

Most of the speculative page fault events were aborted because the VMA was
not supported, which is matching the huge pages (pagefault:spf_vma_notsup).
Only 5,000 were managed fully without holding the mmap_sem, I guess for
other part of the memory's process.

Running the same command on the Base kernel gave:

293 records/s
 Performance counter stats for './ebizzy -HT -s 134217728':

           183,170      faults


      10.660787623 seconds time elapsed

So I'd say that aborting the speculative page fault handler when a THP is
detected, has no visible impact.

Cheers,
Laurent.
