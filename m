Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AFCC76196
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 18:29:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Psqlz121mz3fW6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Apr 2023 04:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HYwyP555;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HYwyP555;
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Psqky3nTnz3fSm
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2023 04:28:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=krRR1rbNljM3A0v7Or9ollBea6RqbuAL/TrS9ntMbko=; b=HYwyP5557eX2aBI0hUlezid1GH
	5hoyG1Aj5dHjNeznaZOFr7Cy51rbii3Y5i3cE2woInFfeI8EAPtppz3o99BPe2GIduN6vXv6uyaw7
	R9cuTob59q/BPrQnGdBywtK77Stl8OJJpBnvpSy/YFDL7vPiYkNIMiGQPDEidGAvoA4jROBnBdVah
	jOoSwHyGjI0QMaTrXlud204St1NXsF+ujX5WasSumcwLZCeKMORJsJy5xkcpHYXjSOgsSKV186/O/
	cA0kt/u7rjhL3oPljvBtkfjk5sjNe9coia8oht3RGaO73x29c2Bi67dc2zk8arCu3QV+LNr4pLHNl
	VKwPG5qQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pkUKx-00Ad17-2X;
	Thu, 06 Apr 2023 18:27:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDA6530008D;
	Thu,  6 Apr 2023 20:27:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5453212E36AA; Thu,  6 Apr 2023 20:27:49 +0200 (CEST)
Date: Thu, 6 Apr 2023 20:27:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230406182749.GA405948@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
 <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
 <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
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
Cc: geert+renesas@glider.be, tony@atomide.com, linus.walleij@linaro.org, dave.hansen@linux.intel.com, Yair Podemsky <ypodemsk@redhat.com>, sebastian.reichel@collabora.com, linux-mm@kvack.org, hpa@zytor.com, sparclinux@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, ardb@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, vschneid@redhat.com, arnd@arndb.de, paulmck@kernel.org, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, samitolvanen@google.com, borntraeger@linux.ibm.com, hca@linux.ibm.com, keescook@chromium.org, gor@linux.ibm.com, jannh@google.com, Frederic Weisbecker <frederic@kernel.org>, npiggin@gmail.com, rmk+kernel@armlinux.org.uk, Yang Shi <shy828301@gmail.com>, bp@alien8.de, nick.hawkins@hpe.com, tglx@linutronix.de, jpoimboe@kernel.org, linux-arm-kernel@lists.infradead.org, alougovs@redhat.com, Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org, juerg.haefliger@canonical.com, svens@linux.ibm.com, aneesh.kumar@linux.ibm.com
 , dhildenb@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 06, 2023 at 05:51:52PM +0200, David Hildenbrand wrote:
> On 06.04.23 17:02, Peter Zijlstra wrote:

> > DavidH, what do you thikn about reviving Jann's patches here:
> > 
> >    https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1
> > 
> > Those are far more invasive, but afaict they seem to do the right thing.
> > 
> 
> I recall seeing those while discussed on security@kernel.org. What we
> currently have was (IMHO for good reasons) deemed better to fix the issue,
> especially when caring about backports and getting it right.

Yes, and I think that was the right call. However, we can now revisit
without having the pressure of a known defect and backport
considerations.

> The alternative that was discussed in that context IIRC was to simply
> allocate a fresh page table, place the fresh page table into the list
> instead, and simply free the old page table (then using common machinery).
> 
> TBH, I'd wish (and recently raised) that we could just stop wasting memory
> on page tables for THPs that are maybe never going to get PTE-mapped ... and
> eventually just allocate on demand (with some caching?) and handle the
> places where we're OOM and cannot PTE-map a THP in some descend way.
> 
> ... instead of trying to figure out how to deal with these page tables we
> cannot free but have to special-case simply because of GUP-fast.

Not keeping them around sounds good to me, but I'm not *that* familiar
with the THP code, most of that happened after I stopped tracking mm. So
I'm not sure how feasible is it.

But it does look entirely feasible to rework this page-table freeing
along the lines Jann did.
