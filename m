Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC9C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 21:31:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277562075A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 21:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Boh3XzRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277562075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p0Bj0SvgzDqMF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:31:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::a41; helo=mail-vk1-xa41.google.com;
 envelope-from=walken@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Boh3XzRN"; 
 dkim-atps=neutral
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com
 [IPv6:2607:f8b0:4864:20::a41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p08g01jnzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 07:29:32 +1000 (AEST)
Received: by mail-vk1-xa41.google.com with SMTP id d30so919599vkl.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j6ZNX8PzZTc2KzrAqgh1Ng4laLRheQ1IuJOBZqlb3Bs=;
 b=Boh3XzRNxD117G85f/L05gtwAnDAfHoPs9C1FhzigFYfOnfP0eH2Ibrg1KsROyHkXG
 E5FokjelGfi7bsSOKsnu/qDQybbKcNTShOUMhOPHQUSZLq3sTgesj44PcT+sLLvcP0u1
 0zprQt1JN4vP4+kxx0XnT7UE+8fflPPsY81LEbfMtNSQFyD/dmCc6KkcEq7RHfflccuJ
 k7oxWsl6T6plZHXzE7oObRUH+TJBP6n7E8Xh9mkAtD3F0D5QHEPkcEPDVzor0meP454r
 ivW5OATTTiYvx8CEC+AWPGD54CmOlxJRr3T9iS5AqO1cuZY4F8dg8Bfqa3XGFY4IJ/lb
 1TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j6ZNX8PzZTc2KzrAqgh1Ng4laLRheQ1IuJOBZqlb3Bs=;
 b=TW4AMdvK6C+TVNN8uvn8tXb+foCORmPDrPAeihiNRO+cT2isgmOObex1xEVsjq6zu2
 xxBVMgJXnQBMxkSr1IFP3oMwhp5IlrMNbbXWdAZvbh1ELc8yrT0oVUbn4uT4l8zWs5/T
 guyvMfEDHMwgxQNHwbuk6KCd+uHKXSBxNci8GMEOkzY6bK7cjfrSBxPYeQU2uBiBDtBb
 3hqjxKGUwrWUXYnohJR1dT6xTOyM8fREyfYuymqS5UFKk8K9jZIgihkL2RoV/6WkoDYo
 piWjhTklcoLIA0qq+JFxPnlWciub44FFWiscJO6lY/V9NwIgE9zQET9P90JGuHeDVrzw
 Ciaw==
X-Gm-Message-State: APjAAAUmZCdJLYLeKHd57rlC3hZn1xJ5XY1rlD32B7cTTw28Wpd/E844
 oire+4ezb8I1IWTjo+V7F6YHsIffeRkhFsbA3cPwFA==
X-Google-Smtp-Source: APXvYqyayLq7fveYwsVJYv2RL6WtmqgCh4VRowXNECgcbX8d5XclmkCqh6hazJDdUL3SB6G8DBLVF2TroVADzI3hjsU=
X-Received: by 2002:a1f:a0d2:: with SMTP id j201mr11280429vke.37.1555968568316; 
 Mon, 22 Apr 2019 14:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
From: Michel Lespinasse <walken@google.com>
Date: Mon, 22 Apr 2019 14:29:16 -0700
Message-ID: <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
Subject: Re: [PATCH v12 00/31] Speculative page faults
To: Laurent Dufour <ldufour@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Laurent,

Thanks a lot for copying me on this patchset. It took me a few days to
go through it - I had not been following the previous iterations of
this series so I had to catch up. I will be sending comments for
individual commits, but before tat I would like to discuss the series
as a whole.

I think these changes are a big step in the right direction. My main
reservation about them is that they are additive - adding some complexity
for speculative page faults - and I wonder if it'd be possible, over the
long term, to replace the existing complexity we have in mmap_sem retry
mechanisms instead of adding to it. This is not something that should
block your progress, but I think it would be good, as we introduce spf,
to evaluate whether we could eventually get all the way to removing the
mmap_sem retry mechanism, or if we will actually have to keep both.


The proposed spf mechanism only handles anon vmas. Is there a
fundamental reason why it couldn't handle mapped files too ?
My understanding is that the mechanism of verifying the vma after
taking back the ptl at the end of the fault would work there too ?
The file has to stay referenced during the fault, but holding the vma's
refcount could be made to cover that ? the vm_file refcount would have
to be released in __free_vma() instead of remove_vma; I'm not quite sure
if that has more implications than I realize ?

The proposed spf mechanism only works at the pte level after the page
tables have already been created. The non-spf page fault path takes the
mm->page_table_lock to protect against concurrent page table allocation
by multiple page faults; I think unmapping/freeing page tables could
be done under mm->page_table_lock too so that spf could implement
allocating new page tables by verifying the vma after taking the
mm->page_table_lock ?

The proposed spf mechanism depends on ARCH_HAS_PTE_SPECIAL.
I am not sure what is the issue there - is this due to the vma->vm_start
and vma->vm_pgoff reads in *__vm_normal_page() ?


My last potential concern is about performance. The numbers you have
look great, but I worry about potential regressions in PF performance
for threaded processes that don't currently encounter contention
(i.e. there may be just one thread actually doing all the work while
the others are blocked). I think one good proxy for measuring that
would be to measure a single threaded workload - kernbench would be
fine - without the special-case optimization in patch 22 where
handle_speculative_fault() immediately aborts in the single-threaded case.

Reviewed-by: Michel Lespinasse <walken@google.com>
This is for the series as a whole; I expect to do another review pass on
individual commits in the series when we have agreement on the toplevel
stuff (I noticed a few things like out-of-date commit messages but that's
really minor stuff).


I want to add a note about mmap_sem. In the past there has been
discussions about replacing it with an interval lock, but these never
went anywhere because, mostly, of the fact that such mechanisms were
too expensive to use in the page fault path. I think adding the spf
mechanism would invite us to revisit this issue - interval locks may
be a great way to avoid blocking between unrelated mmap_sem writers
(for example, do not delay stack creation for new threads while a
large mmap or munmap may be going on), and probably also to handle
mmap_sem readers that can't easily use the spf mechanism (for example,
gup callers which make use of the returned vmas). But again that is a
separate topic to explore which doesn't have to get resolved before
spf goes in.
