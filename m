Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703EC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:50:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCB52183E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCB52183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8XQ6SLczDqbY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:50:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7Rn4LK3zDqS3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 04:01:41 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3OHrmqK075606
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 14:01:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s2u36vq30-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 14:01:38 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Wed, 24 Apr 2019 19:01:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Apr 2019 19:01:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3OI1OxR42663952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2019 18:01:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 527D2AE057;
 Wed, 24 Apr 2019 18:01:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 688DDAE05F;
 Wed, 24 Apr 2019 18:01:21 +0000 (GMT)
Received: from [9.145.176.48] (unknown [9.145.176.48])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2019 18:01:21 +0000 (GMT)
Subject: Re: [PATCH v12 00/31] Speculative page faults
To: Michel Lespinasse <walken@google.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
Date: Wed, 24 Apr 2019 20:01:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042418-0016-0000-0000-00000273657C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042418-0017-0000-0000-000032CFD8D0
Message-Id: <aadc7b03-9121-6800-341b-6f2849088a09@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-24_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240131
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, sergey.senozhatsky.work@gmail.com,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Punit Agrawal <punitagrawal@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Haiyan Song <haiyanx.song@intel.com>, Nick Piggin <npiggin@gmail.com>,
 sj38.park@gmail.com, Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net,
 kemi.wang@intel.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 22/04/2019 à 23:29, Michel Lespinasse a écrit :
> Hi Laurent,
> 
> Thanks a lot for copying me on this patchset. It took me a few days to
> go through it - I had not been following the previous iterations of
> this series so I had to catch up. I will be sending comments for
> individual commits, but before tat I would like to discuss the series
> as a whole.

Hi Michel,

Thanks for reviewing this series.

> I think these changes are a big step in the right direction. My main
> reservation about them is that they are additive - adding some complexity
> for speculative page faults - and I wonder if it'd be possible, over the
> long term, to replace the existing complexity we have in mmap_sem retry
> mechanisms instead of adding to it. This is not something that should
> block your progress, but I think it would be good, as we introduce spf,
> to evaluate whether we could eventually get all the way to removing the
> mmap_sem retry mechanism, or if we will actually have to keep both.

Until we get rid of the mmap_sem which seems to be a very long story, I 
can't see how we could get rid of the retry mechanism.

> The proposed spf mechanism only handles anon vmas. Is there a
> fundamental reason why it couldn't handle mapped files too ?
> My understanding is that the mechanism of verifying the vma after
> taking back the ptl at the end of the fault would work there too ?
> The file has to stay referenced during the fault, but holding the vma's
> refcount could be made to cover that ? the vm_file refcount would have
> to be released in __free_vma() instead of remove_vma; I'm not quite sure
> if that has more implications than I realize ?

The only concern is the flow of operation  done in the vm_ops->fault() 
processing. Most of the file system relie on the generic filemap_fault() 
which should be safe to use. But we need a clever way to identify fault 
processing which are compatible with the SPF handler. This could be done 
using a tag/flag in the vm_ops structure or in the vma's flags.

This would be the next step.


> The proposed spf mechanism only works at the pte level after the page
> tables have already been created. The non-spf page fault path takes the
> mm->page_table_lock to protect against concurrent page table allocation
> by multiple page faults; I think unmapping/freeing page tables could
> be done under mm->page_table_lock too so that spf could implement
> allocating new page tables by verifying the vma after taking the
> mm->page_table_lock ?

I've to admit that I didn't dig further here.
Do you have a patch? ;)

> 
> The proposed spf mechanism depends on ARCH_HAS_PTE_SPECIAL.
> I am not sure what is the issue there - is this due to the vma->vm_start
> and vma->vm_pgoff reads in *__vm_normal_page() ?

Yes that's the reason, no way to guarantee the value of these fields in 
the SPF path.

> 
> My last potential concern is about performance. The numbers you have
> look great, but I worry about potential regressions in PF performance
> for threaded processes that don't currently encounter contention
> (i.e. there may be just one thread actually doing all the work while
> the others are blocked). I think one good proxy for measuring that
> would be to measure a single threaded workload - kernbench would be
> fine - without the special-case optimization in patch 22 where
> handle_speculative_fault() immediately aborts in the single-threaded case.

I'll have to give it a try.

> Reviewed-by: Michel Lespinasse <walken@google.com>
> This is for the series as a whole; I expect to do another review pass on
> individual commits in the series when we have agreement on the toplevel
> stuff (I noticed a few things like out-of-date commit messages but that's
> really minor stuff).

Thanks a lot for reviewing this long series.

> 
> I want to add a note about mmap_sem. In the past there has been
> discussions about replacing it with an interval lock, but these never
> went anywhere because, mostly, of the fact that such mechanisms were
> too expensive to use in the page fault path. I think adding the spf
> mechanism would invite us to revisit this issue - interval locks may
> be a great way to avoid blocking between unrelated mmap_sem writers
> (for example, do not delay stack creation for new threads while a
> large mmap or munmap may be going on), and probably also to handle
> mmap_sem readers that can't easily use the spf mechanism (for example,
> gup callers which make use of the returned vmas). But again that is a
> separate topic to explore which doesn't have to get resolved before
> spf goes in.
> 

