Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZFbc38KMzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 16:50:36 +1000 (AEST)
Date: Wed, 22 Jun 2016 08:50:30 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] tools/perf: Fix the mask in regs_dump__printf and
 print_sample_iregs
Message-ID: <20160622065030.GA2042@krava>
References: <1466521000-11329-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160621153531.GA32361@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621153531.GA32361@yury-N73SV>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 06:35:31PM +0300, Yury Norov wrote:

SNIP

> > index 5214974e841a..1337b1c73f82 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -940,8 +940,22 @@ static void branch_stack__printf(struct perf_sample *sample)
> >  static void regs_dump__printf(u64 mask, u64 *regs)
> >  {
> >  	unsigned rid, i = 0;
> > +	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
> >  
> > -	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
> > +	/*
> > +	 * Since u64 is passed as 'unsigned long *', check
> > +	 * to see whether we need to swap words within u64.
> > +	 * Reason being, in 32 bit big endian userspace on a
> > +	 * 64bit kernel, 'unsigned long' is 32 bits.
> > +	 * When reading u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1],
> > +	 * we will get wrong value for the mask. This is what
> > +	 * find_first_bit() and find_next_bit() is doing.
> > +	 * Issue here is "(u32 *)(&val)[0]" gets upper 32 bits of u64,
> > +	 * but perf assumes it gets lower 32bits of u64. Hence the check
> > +	 * and swap.
> > +	 */
> 
> Identical comments... I'd prefer to see it in commit message, or
> better in function description. For me it's pretty straightforward in
> understanding what happens here in-place without comments.

yep, please use this just once as the fucntion description

thanks,
jirka
