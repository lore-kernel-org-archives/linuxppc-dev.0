Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgx6L4tktzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 22:48:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t190so10014469pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 05:48:26 -0700 (PDT)
Message-ID: <1467377311.12509.3.camel@gmail.com>
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
From: Balbir Singh <bsingharora@gmail.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, David.Laight@ACULAB.COM,
 naveen.n.rao@linux.vnet.ibm.com,  dja@axtens.net
Date: Fri, 01 Jul 2016 22:48:31 +1000
In-Reply-To: <57762D2A.9040103@linux.vnet.ibm.com>
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-01 at 14:13 +0530, Ravi Bangoria wrote:
> Thanks Michael for your suggestion.
> 
> On Thursday 30 June 2016 11:51 AM, Michael Ellerman wrote:
> > 
> > On Thu, 2016-06-30 at 11:44 +0530, Ravi Bangoria wrote:
> > > 
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index 36a5825..b87eac7 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -476,6 +481,125 @@ static int ins__cmp(const void *a, const void *b)
> > ...
> > > 
> > > +
> > > +static struct ins *ins__find_powerpc(const char *name)
> > > +{
> > > +	int i;
> > > +	struct ins *ins;
> > > +	struct ins_ops *ops;
> > > +	static struct instructions_powerpc head;
> > > +	static bool list_initialized;
> > > +
> > > +	/*
> > > +	 * - Interested only if instruction starts with 'b'.
> > > +	 * - Few start with 'b', but aren't branch instructions.
> > > +	 * - Let's also ignore instructions involving 'ctr' and
> > > +	 *   'tar' since target branch addresses for those can't
> > > +	 *   be determined statically.
> > > +	 */
> > > +	if (name[0] != 'b'             ||
> > > +	    !strncmp(name, "bcd", 3)   ||
> > > +	    !strncmp(name, "brinc", 5) ||
> > > +	    !strncmp(name, "bper", 4)  ||
> > > +	    strstr(name, "ctr")        ||
> > > +	    strstr(name, "tar"))
> > > +		return NULL;
> > It would be good if 'bctr' was at least recognised as a branch, even if we
> > can't determine the target. They are very common.
> We can not show arrow for this since we don't know the target location.
> can you please suggest how you intends perf to display bctr?
> 
> bctr can be classified into two variants -- 'bctr' and 'bctrl'.
> 
> 'bctr' will be considered as jump instruction but jump__parse() won't
> be able to find any target location and hence it will set target to
> UINT64_MAX which transform 'bctr' to 'bctr UINT64_MAX'. This
> looks misleading.
> 
> bctrl will be considered as call instruction but call_parse() won't
> be able to find any target function and hence it won't show any
> navigation arrow for this instruction. Which is same as filter it
> beforehand.
>

The target location and function are in the counter. Can't we add
this to instruction ops? Is it a major change to add it?
 
Balbir Singh. 
