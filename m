Return-Path: <SRS0=vw+r=X4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 11:54:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8A4215EA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 11:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="poByP+b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8A4215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46kWdP2LJ8zDqZT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 21:54:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="poByP+b3"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46kWbC5jvhzDq61
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2019 21:52:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2RsgaW4dRBY/+tPdpgEQuWJrn0m0JZs7JZKItphvsrQ=; b=poByP+b3n6HNOdDnf/qGJvHAS
 pRXqXpuNZ5w4zB1+HX+MqRhfIs4qQZ01AcR9SEjX50dtaei+hC1Zaj3CiApO0agSJncV9ovMLgDUw
 9/uEPRGsGKaokZWwQISYwto97A6/ZRQyCqhOpAspu0qBX5fhYnphFLXbGxE6KrWlZMHmwAp6z3B4B
 5IDz5zPe7k8WbDoNC6I9oDE70/AnswPYgYH2TfiNQyBjzAnQunl4O//21nwspoAuQlYWRw134hOZZ
 +LCm7w5mWztLLvOsBIjYGDagQrOBPTbgN7YbGIxWo6778ed9wR/5evpPxlYBSacHl6Dds3Fr+ZCe8
 jqnFb5bog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFze6-0006QH-Dw; Thu, 03 Oct 2019 11:51:46 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 393FE301B59;
 Thu,  3 Oct 2019 13:50:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6CEBE20D8F669; Thu,  3 Oct 2019 13:51:41 +0200 (CEST)
Date: Thu, 3 Oct 2019 13:51:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Message-ID: <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-2-leonardo@linux.ibm.com>
 <20191003071145.GM4536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003071145.GM4536@hirez.programming.kicks-ass.net>
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
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>,
 "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org,
 Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Jesper Dangaard Brouer <brouer@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Reza Arbab <arbab@linux.ibm.com>,
 Allison Randal <allison@lohutok.net>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Souptick Joarder <jrdr.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Roman Gushchin <guro@fb.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 03, 2019 at 09:11:45AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 02, 2019 at 10:33:15PM -0300, Leonardo Bras wrote:
> > diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> > index 818691846c90..3043ea9812d5 100644
> > --- a/include/asm-generic/pgtable.h
> > +++ b/include/asm-generic/pgtable.h
> > @@ -1171,6 +1171,64 @@ static inline bool arch_has_pfn_modify_check(void)
> >  #endif
> >  #endif
> >  
> > +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> > +static inline unsigned long begin_lockless_pgtbl_walk(struct mm_struct *mm)
> > +{
> > +	unsigned long irq_mask;
> > +
> > +	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
> > +		atomic_inc(&mm->lockless_pgtbl_walkers);
> 
> This will not work for file backed THP. Also, this is a fairly serious
> contention point all on its own.

Kiryl says we have tmpfs-thp, this would be broken vs that, as would
your (PowerPC) use of mm_cpumask() for that IPI.

> > +	/*
> > +	 * Interrupts must be disabled during the lockless page table walk.
> > +	 * That's because the deleting or splitting involves flushing TLBs,
> > +	 * which in turn issues interrupts, that will block when disabled.
> > +	 */
> > +	local_irq_save(irq_mask);
> > +
> > +	/*
> > +	 * This memory barrier pairs with any code that is either trying to
> > +	 * delete page tables, or split huge pages. Without this barrier,
> > +	 * the page tables could be read speculatively outside of interrupt
> > +	 * disabling.
> > +	 */
> > +	smp_mb();
> 
> I don't think this is something smp_mb() can guarantee. smp_mb() is
> defined to order memory accesses, in this case the store of the old
> flags vs whatever comes after this.
> 
> It cannot (in generic) order against completion of prior instructions,
> like clearing the interrupt enabled flags.
> 
> Possibly you want barrier_nospec().

I'm still really confused about this barrier. It just doesn't make
sense.

If an interrupt happens before the local_irq_disable()/save(), then it
will discard any and all speculation that would be in progress to handle
the exception.

If there isn't an interrupt (or it happens after disable) it is
irrelevant.

Specifically, that serialize-IPI thing wants to ensure in-progress
lookups are complete, and I can't find a scenario where
local_irq_disable/enable() needs additional help vs IPIs. The moment an
interrupt lands it kills speculation and forces things into
program-order.

Did you perhaps want something like:

	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING)) {
		atomic_inc(&foo);
		smp_mb__after_atomic();
	}

	...

	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING)) {
		smp_mb__before_atomic();
		atomic_dec(&foo);
	}

To ensure everything happens inside of the increment?

And I still think all that wrong, you really shouldn't need to wait on
munmap().
