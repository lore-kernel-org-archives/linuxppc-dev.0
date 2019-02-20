Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A14C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:49:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CD82146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CD82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444L8m340ZzDqH6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 01:49:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 444L6n0YXszDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 01:47:27 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B34615AB;
 Wed, 20 Feb 2019 06:47:25 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EF1B3F5C1;
 Wed, 20 Feb 2019 06:47:20 -0800 (PST)
Date: Wed, 20 Feb 2019 14:47:17 +0000
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/3] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190220144717.GI7523@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550095217-12047-2-git-send-email-longman@redhat.com>
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
 Peter Zijlstra <peterz@infradead.org>, linux-mips@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
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

On Wed, Feb 13, 2019 at 05:00:15PM -0500, Waiman Long wrote:
> As the generic rwsem-xadd code is using the appropriate acquire and
> release versions of the atomic operations, the arch specific rwsem.h
> files will not be that much faster than the generic code as long as the
> atomic functions are properly implemented. So we can remove those arch
> specific rwsem.h and stop building asm/rwsem.h to reduce maintenance
> effort.
> 
> Currently, only x86, alpha and ia64 have implemented architecture
> specific fast paths. I don't have access to alpha and ia64 systems for
> testing, but they are legacy systems that are not likely to be updated
> to the latest kernel anyway.
> 
> By using a rwsem microbenchmark, the total locking rates on a 4-socket
> 56-core 112-thread x86-64 system before and after the patch were as
> follows (mixed means equal # of read and write locks):
> 
>                       Before Patch              After Patch
>    # of Threads  wlock   rlock   mixed     wlock   rlock   mixed
>    ------------  -----   -----   -----     -----   -----   -----
>         1        29,201  30,143  29,458    28,615  30,172  29,201
>         2         6,807  13,299   1,171     7,725  15,025   1,804
>         4         6,504  12,755   1,520     7,127  14,286   1,345
>         8         6,762  13,412     764     6,826  13,652     726
>        16         6,693  15,408     662     6,599  15,938     626
>        32         6,145  15,286     496     5,549  15,487     511
>        64         5,812  15,495      60     5,858  15,572      60
> 
> There were some run-to-run variations for the multi-thread tests. For
> x86-64, using the generic C code fast path seems to be a little bit
> faster than the assembly version with low lock contention.  Looking at
> the assembly version of the fast paths, there are assembly to/from C
> code wrappers that save and restore all the callee-clobbered registers
> (7 registers on x86-64). The assembly generated from the generic C
> code doesn't need to do that. That may explain the slight performance
> gain here.
> 
> The generic asm rwsem.h can also be merged into kernel/locking/rwsem.h
> with no code change as no other code other than those under
> kernel/locking needs to access the internal rwsem macros and functions.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  MAINTAINERS                     |   1 -
>  arch/alpha/include/asm/rwsem.h  | 211 -----------------------------------
>  arch/arm/include/asm/Kbuild     |   1 -
>  arch/arm64/include/asm/Kbuild   |   1 -
>  arch/hexagon/include/asm/Kbuild |   1 -
>  arch/ia64/include/asm/rwsem.h   | 172 -----------------------------
>  arch/powerpc/include/asm/Kbuild |   1 -
>  arch/s390/include/asm/Kbuild    |   1 -
>  arch/sh/include/asm/Kbuild      |   1 -
>  arch/sparc/include/asm/Kbuild   |   1 -
>  arch/x86/include/asm/rwsem.h    | 237 ----------------------------------------
>  arch/x86/lib/Makefile           |   1 -
>  arch/x86/lib/rwsem.S            | 156 --------------------------
>  arch/x86/um/Makefile            |   1 -
>  arch/xtensa/include/asm/Kbuild  |   1 -
>  include/asm-generic/rwsem.h     | 140 ------------------------
>  include/linux/rwsem.h           |   4 +-
>  kernel/locking/percpu-rwsem.c   |   2 +
>  kernel/locking/rwsem.h          | 130 ++++++++++++++++++++++
>  19 files changed, 133 insertions(+), 930 deletions(-)
>  delete mode 100644 arch/alpha/include/asm/rwsem.h
>  delete mode 100644 arch/ia64/include/asm/rwsem.h
>  delete mode 100644 arch/x86/include/asm/rwsem.h
>  delete mode 100644 arch/x86/lib/rwsem.S
>  delete mode 100644 include/asm-generic/rwsem.h

Looks like a nice cleanup, thanks:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
