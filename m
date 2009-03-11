Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 274BCDE158
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 20:31:30 +1100 (EST)
Date: Wed, 11 Mar 2009 10:31:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [RESEND GIT PATCH tj-percpu] percpu: fix spurious alignment
	WARN in legacy SMP percpu allocator
Message-ID: <20090311093110.GA11637@elte.hu>
References: <20090310195534.8f8f3c7a.sfr@canb.auug.org.au>
	<49B67552.5070307@in.ibm.com> <49B73B15.3040101@in.ibm.com>
	<49B75215.5010707@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B75215.5010707@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Tejun Heo <tj@kernel.org> wrote:

> Impact: remove spurious WARN on legacy SMP percpu allocator
> 
> Commit f2a8205c4ef1af917d175c36a4097ae5587791c8 incorrectly added too
> tight WARN_ON_ONCE() on alignments for UP and legacy SMP percpu
> allocator.  Commit e317603694bfd17b28a40de9d65e1a4ec12f816e fixed it
> for UP but legacy SMP allocator was forgotten.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Sachin P. Sant <sachinp@in.ibm.com>
> ---
> (RESEND: cc'ing Ingo. :-)
> 
> Oops, that was a stupid omission.  This patch should fix it.  Ingo,
> please pull from the following git vector to receive the first first
> four patches from the use-dynamic-percpu-allocator-by-default patchset
> (without the actual conversion which can disrupt archs) + this patch.
> I moved the actual conversion patch into #tj-percpu-exp branch, so the
> pull should be safe.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git tj-percpu
> 
> Thanks.

Pulled into tip:core/percpu, thanks a lot Tejun!

	Ingo
