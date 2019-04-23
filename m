Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B6C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:51:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBFF206A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msYnu0kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBFF206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pNcQ4grZzDqM7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:51:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="msYnu0kx"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pNZ55s8JzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 22:49:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=35dsPaMjiCJMbp0smPFnBa37kyiFHneebblaSoEgPnQ=; b=msYnu0kx2JON/wV/5dmMl8vxA
 dNCkZAqilQAWKgXdb+pllDgIM1dvdIRn2PTFPCpPa2rT6jXvYFDwgwJ3h3lZoIhmej0toM48+/ppr
 RohELwfLN2xCfUtByxgahp0hU50CmU7ZInrqna7acSRDLG6c3QibbucubGNFtCp9B+Y0ozgd2WT4o
 YmvDH3/dt8VwyJiZCrP/zGJP5MwJsY7HaKgut9UodsIMQT0oida9zEnUjEPcD1ArwgTEhu1ogh2g7
 uhCboq8dRcEn79wKSzqUJPyUl3ZBauPLrK9e+FM9A3107dB1aRvokG5XAdcEqf5koNpX4UdSCUGyU
 i6pxQQxMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIuqu-0004F8-De; Tue, 23 Apr 2019 12:48:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A6FE829B8FE27; Tue, 23 Apr 2019 14:48:45 +0200 (CEST)
Date: Tue, 23 Apr 2019 14:48:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v12 00/31] Speculative page faults
Message-ID: <20190423124845.GS4038@hirez.programming.kicks-ass.net>
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
 Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>,
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

On Tue, Apr 23, 2019 at 05:41:48AM -0700, Matthew Wilcox wrote:
> On Tue, Apr 23, 2019 at 12:47:07PM +0200, Michal Hocko wrote:
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
> 
> I think scaling the lock needs to be tied to the actual data structure
> and not have a second tree on-the-side to fake-scale the locking.

Right, which is how I ended up using the split PT locks. They already
provide fine(r) grained locking.

