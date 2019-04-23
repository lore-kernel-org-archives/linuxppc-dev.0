Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A63C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 13:46:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33C221773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33C221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pPqT5xcJzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 23:46:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pPlB3qcPzDq7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 23:42:29 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6E9C4ACAC;
 Tue, 23 Apr 2019 13:42:25 +0000 (UTC)
Date: Tue, 23 Apr 2019 15:42:22 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v12 00/31] Speculative page faults
Message-ID: <20190423134222.GL25106@dhcp22.suse.cz>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
 <20190423104707.GK25106@dhcp22.suse.cz>
 <20190423124148.GA19031@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423124148.GA19031@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue 23-04-19 05:41:48, Matthew Wilcox wrote:
> On Tue, Apr 23, 2019 at 12:47:07PM +0200, Michal Hocko wrote:
> > On Mon 22-04-19 14:29:16, Michel Lespinasse wrote:
> > [...]
> > > I want to add a note about mmap_sem. In the past there has been
> > > discussions about replacing it with an interval lock, but these never
> > > went anywhere because, mostly, of the fact that such mechanisms were
> > > too expensive to use in the page fault path. I think adding the spf
> > > mechanism would invite us to revisit this issue - interval locks may
> > > be a great way to avoid blocking between unrelated mmap_sem writers
> > > (for example, do not delay stack creation for new threads while a
> > > large mmap or munmap may be going on), and probably also to handle
> > > mmap_sem readers that can't easily use the spf mechanism (for example,
> > > gup callers which make use of the returned vmas). But again that is a
> > > separate topic to explore which doesn't have to get resolved before
> > > spf goes in.
> > 
> > Well, I believe we should _really_ re-evaluate the range locking sooner
> > rather than later. Why? Because it looks like the most straightforward
> > approach to the mmap_sem contention for most usecases I have heard of
> > (mostly a mm{unm}ap, mremap standing in the way of page faults).
> > On a plus side it also makes us think about the current mmap (ab)users
> > which should lead to an overall code improvements and maintainability.
> 
> Dave Chinner recently did evaluate the range lock for solving a problem
> in XFS and didn't like what he saw:
> 
> https://lore.kernel.org/linux-fsdevel/20190418031013.GX29573@dread.disaster.area/T/#md981b32c12a2557a2dd0f79ad41d6c8df1f6f27c

Thank you, will have a look.

> I think scaling the lock needs to be tied to the actual data structure
> and not have a second tree on-the-side to fake-scale the locking.  Anyway,
> we're going to have a session on this at LSFMM, right?

I thought we had something for the mmap_sem scaling but I do not see
this in a list of proposed topics. But we can certainly add it there.

> > SPF sounds like a good idea but it is a really big and intrusive surgery
> > to the #PF path. And more importantly without any real world usecase
> > numbers which would justify this. That being said I am not opposed to
> > this change I just think it is a large hammer while we haven't seen
> > attempts to tackle problems in a simpler way.
> 
> I don't think the "no real world usecase numbers" is fair.  Laurent quoted:
> 
> > Ebizzy:
> > -------
> > The test is counting the number of records per second it can manage, the
> > higher is the best. I run it like this 'ebizzy -mTt <nrcpus>'. To get
> > consistent result I repeated the test 100 times and measure the average
> > result. The number is the record processes per second, the higher is the best.
> > 
> >   		BASE		SPF		delta	
> > 24 CPUs x86	5492.69		9383.07		70.83%
> > 1024 CPUS P8 VM 8476.74		17144.38	102%
> 
> and cited 30% improvement for you-know-what product from an earlier
> version of the patch.

Well, we are talking about
45 files changed, 1277 insertions(+), 196 deletions(-)

which is a _major_ surgery in my book. Having a real life workloads numbers
is nothing unfair to ask for IMHO.

And let me remind you that I am not really opposing SPF in general. I
would just like to see a simpler approach before we go such a large
change. If the range locking is not really a scalable approach then all
right but from why I've see it should help a lot of most bottle-necks I
have seen.
-- 
Michal Hocko
SUSE Labs
