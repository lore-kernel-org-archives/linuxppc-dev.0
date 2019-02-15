Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A329C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:42:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56C82082F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56C82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441MZS43XyzDqgs
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 05:42:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 441MXd4fqVzDqPk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 05:41:04 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F399A78;
 Fri, 15 Feb 2019 10:41:03 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937D53F589;
 Fri, 15 Feb 2019 10:40:58 -0800 (PST)
Date: Fri, 15 Feb 2019 18:40:56 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Message-ID: <20190215184056.GC15084@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <20190214103715.GI32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 11:37:15AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> > v4:
> >  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> > 
> > v3:
> >  - Optimize __down_read_trylock() for the uncontended case as suggested
> >    by Linus.
> > 
> > v2:
> >  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
> >  - Update performance test data in patch 1.
> > 
> > The goal of this patchset is to remove the architecture specific files
> > for rwsem-xadd to make it easer to add enhancements in the later rwsem
> > patches. It also removes the legacy rwsem-spinlock.c file and make all
> > the architectures use one single implementation of rwsem - rwsem-xadd.c.
> > 
> > Waiman Long (3):
> >   locking/rwsem: Remove arch specific rwsem files
> >   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
> >     archs
> >   locking/rwsem: Optimize down_read_trylock()
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> with the caveat that I'm happy to exchange patch 3 back to my earlier
> suggestion in case Will expesses concerns wrt the ARM64 performance of
> Linus' suggestion.

Right, the current proposal doesn't work well for us, unfortunately. Which
was your earlier suggestion?

Will
