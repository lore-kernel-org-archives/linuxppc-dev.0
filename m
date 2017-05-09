Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMXXS6svtzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:26:48 +1000 (AEST)
Date: Tue, 9 May 2017 10:26:44 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 2/7] perf/x86/intel: Record branch type
Message-ID: <20170509082644.GB22125@krava>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-3-git-send-email-yao.jin@linux.intel.com>
 <20170423135559.GA23073@krava>
 <f6ede1eb-e015-5821-f00d-bbbc3ff3f317@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6ede1eb-e015-5821-f00d-bbbc3ff3f317@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 24, 2017 at 08:47:14AM +0800, Jin, Yao wrote:
> 
> 
> On 4/23/2017 9:55 PM, Jiri Olsa wrote:
> > On Thu, Apr 20, 2017 at 08:07:50PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +#define X86_BR_TYPE_MAP_MAX	16
> > > +
> > > +static int
> > > +common_branch_type(int type)
> > > +{
> > > +	int i, mask;
> > > +	const int branch_map[X86_BR_TYPE_MAP_MAX] = {
> > > +		PERF_BR_CALL,		/* X86_BR_CALL */
> > > +		PERF_BR_RET,		/* X86_BR_RET */
> > > +		PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
> > > +		PERF_BR_SYSRET,		/* X86_BR_SYSRET */
> > > +		PERF_BR_INT,		/* X86_BR_INT */
> > > +		PERF_BR_IRET,		/* X86_BR_IRET */
> > > +		PERF_BR_JCC,		/* X86_BR_JCC */
> > > +		PERF_BR_JMP,		/* X86_BR_JMP */
> > > +		PERF_BR_IRQ,		/* X86_BR_IRQ */
> > > +		PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
> > > +		PERF_BR_NONE,		/* X86_BR_ABORT */
> > > +		PERF_BR_NONE,		/* X86_BR_IN_TX */
> > > +		PERF_BR_NONE,		/* X86_BR_NO_TX */
> > > +		PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
> > > +		PERF_BR_NONE,		/* X86_BR_CALL_STACK */
> > > +		PERF_BR_IND_JMP,	/* X86_BR_IND_JMP */
> > > +	};
> > > +
> > > +	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
> > > +	mask = ~(~0 << 1);
> > is that a fancy way to get 1 into the mask? what do I miss?

you did not comment on this one

> > 
> > > +
> > > +	for (i = 0; i < X86_BR_TYPE_MAP_MAX; i++) {
> > > +		if (type & mask)
> > > +			return branch_map[i];
> > I wonder some bit search would be faster in here, but maybe not big deal
> > 
> > jirka
> 
> I just think the branch_map[] doesn't contain many entries (16 entries
> here), so maybe checking 1 bit one time should be acceptable. I just want to
> keep the code simple.
> 
> But if the number of entries is more (e.g. 64), maybe it'd better check 2 or
> 4 bits one time.

ook

jirka
