Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFFC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:44:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9DB206A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TrqTdEME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9DB206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pNRp3c3ZzDqNr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:44:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="TrqTdEME"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pNPq1Mw2zDq69
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 22:42:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IUSefa2fbNlZbOuHcNA5D0IJahGVYD6yfn/AbwElUsk=; b=TrqTdEMEKxvq5dvTMbRu3X0tE
 romqF91vKZ4XMJc1Xlx3PtB2OHqsgt/3rfTRWX7x8WIbvduWqPlKoJ3IyHWNSnirc3ACRqWnbqnmq
 d3b08dAk8iw4mnqQvD+KDObzUIzuCKGvICeu2joxGepVN0HN89+t+CyWajVOXVMf1CQQS06ng8CcL
 Sr9qpBjZCimuduEfA2sXO/VK5g35iFadxvny5Xm7sQmgipeK2zJVr4KX3OKf7C1gTZ2X0O/4D4Xkl
 hR8TS29/mwITh/+Kzpf+CjCCEtWL28fm/hd754vEImI1wUvIJPUteRypEOdCR/gLAqFdiT/FgsFkw
 ltvy2Y0cw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1hIuk9-0002FR-2A; Tue, 23 Apr 2019 12:41:49 +0000
Date: Tue, 23 Apr 2019 05:41:48 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v12 00/31] Speculative page faults
Message-ID: <20190423124148.GA19031@bombadil.infradead.org>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
 <20190423104707.GK25106@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423104707.GK25106@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Punit Agrawal <punitagrawal@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michel Lespinasse <walken@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Haiyan Song <haiyanx.song@intel.com>, Nick Piggin <npiggin@gmail.com>,
 sj38.park@gmail.com, Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net,
 kemi.wang@intel.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, Laurent Dufour <ldufour@linux.ibm.com>,
 zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 12:47:07PM +0200, Michal Hocko wrote:
> On Mon 22-04-19 14:29:16, Michel Lespinasse wrote:
> [...]
> > I want to add a note about mmap_sem. In the past there has been
> > discussions about replacing it with an interval lock, but these never
> > went anywhere because, mostly, of the fact that such mechanisms were
> > too expensive to use in the page fault path. I think adding the spf
> > mechanism would invite us to revisit this issue - interval locks may
> > be a great way to avoid blocking between unrelated mmap_sem writers
> > (for example, do not delay stack creation for new threads while a
> > large mmap or munmap may be going on), and probably also to handle
> > mmap_sem readers that can't easily use the spf mechanism (for example,
> > gup callers which make use of the returned vmas). But again that is a
> > separate topic to explore which doesn't have to get resolved before
> > spf goes in.
> 
> Well, I believe we should _really_ re-evaluate the range locking sooner
> rather than later. Why? Because it looks like the most straightforward
> approach to the mmap_sem contention for most usecases I have heard of
> (mostly a mm{unm}ap, mremap standing in the way of page faults).
> On a plus side it also makes us think about the current mmap (ab)users
> which should lead to an overall code improvements and maintainability.

Dave Chinner recently did evaluate the range lock for solving a problem
in XFS and didn't like what he saw:

https://lore.kernel.org/linux-fsdevel/20190418031013.GX29573@dread.disaster.area/T/#md981b32c12a2557a2dd0f79ad41d6c8df1f6f27c

I think scaling the lock needs to be tied to the actual data structure
and not have a second tree on-the-side to fake-scale the locking.  Anyway,
we're going to have a session on this at LSFMM, right?

> SPF sounds like a good idea but it is a really big and intrusive surgery
> to the #PF path. And more importantly without any real world usecase
> numbers which would justify this. That being said I am not opposed to
> this change I just think it is a large hammer while we haven't seen
> attempts to tackle problems in a simpler way.

I don't think the "no real world usecase numbers" is fair.  Laurent quoted:

> Ebizzy:
> -------
> The test is counting the number of records per second it can manage, the
> higher is the best. I run it like this 'ebizzy -mTt <nrcpus>'. To get
> consistent result I repeated the test 100 times and measure the average
> result. The number is the record processes per second, the higher is the best.
> 
>   		BASE		SPF		delta	
> 24 CPUs x86	5492.69		9383.07		70.83%
> 1024 CPUS P8 VM 8476.74		17144.38	102%

and cited 30% improvement for you-know-what product from an earlier
version of the patch.

