Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxgbR30j7zDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 19:28:51 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5R9NaVT047263
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 05:28:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bbf6f5bwq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 05:28:47 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 27 Jun 2017 19:28:44 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5R9Sfcc8061296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 19:28:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5R9Sd7U024649
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 19:28:40 +1000
Date: Tue, 27 Jun 2017 14:58:40 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
 linuxppc-dev@lists.ozlabs.org, Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH] kallsyms: optimize kallsyms_lookup_name() for a few cases
References: <87lgqn1m8k.fsf@concordia.ellerman.id.au>
 <20170426200810.2126-1-naveen.n.rao@linux.vnet.ibm.com>
 <20170427112122.b82014b321d387219bdbd7e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427112122.b82014b321d387219bdbd7e4@kernel.org>
Message-Id: <20170627092840.ly2ltf4paxgksvu2@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/27 11:21AM, Masami Hiramatsu wrote:
> On Thu, 27 Apr 2017 01:38:10 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Michael Ellerman wrote:
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > >> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > >> index 6a3b249a2ae1..d134b060564f 100644
> > >> --- a/kernel/kallsyms.c
> > >> +++ b/kernel/kallsyms.c
> > >> @@ -205,6 +205,12 @@ unsigned long kallsyms_lookup_name(const char *name)
> > >>  	unsigned long i;
> > >>  	unsigned int off;
> > >>  
> > >> +	if (!name || *name == '\0')
> > >> +		return false;
> > >> +
> > >> +	if (strnchr(name, MODULE_NAME_LEN, ':'))
> > >> +		return module_kallsyms_lookup_name(name);
> > >> +
> > >>  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
> > >>  		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
> > > 	...				
> > > 	}
> > >        	return module_kallsyms_lookup_name(name);
> > > 
> > > Is the rest of the context.
> > > 
> > > Which looks a bit odd, we already did module lookup previously?
> > > 
> > > But it's correct, because you can lookup a symbol in a module without a
> > > module prefix, it just looks in every module.
> > 
> > Yes.
> > 
> > > 
> > > You could invert the logic, ie. check that there isn't a ":" in the name
> > > and only in that case do the for loop, always falling back to module
> > > lookup.
> > > 
> > > Or just add a comment explaining why we call module lookup in two places.
> > 
> > Good point. Here's a v2 - I'm using a goto so as to not indent the code too much.
> > 
> > Thanks for the review!
> > - Naveen
> > 
> > --
> > [PATCH v2] kallsyms: optimize kallsyms_lookup_name() for a few cases
> > 
> > 1. Fail early for invalid/zero length symbols.
> > 2. Detect names of the form <mod:name> and skip checking for kernel
> > symbols in that case.
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, Masami!

I am not quite sure who maintains kallsyms...

Ingo,
Can you please help with merging this patch?

Thanks,
Naveen

> 
> Thanks,
> 
> 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  kernel/kallsyms.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 6a3b249a2ae1..f7558dc5c6ac 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -205,12 +205,20 @@ unsigned long kallsyms_lookup_name(const char *name)
> >  	unsigned long i;
> >  	unsigned int off;
> >  
> > +	if (!name || *name == '\0')
> > +		return 0;
> > +
> > +	/* For symbols of the form <mod>:<sym>, only check the modules */
> > +	if (strnchr(name, MODULE_NAME_LEN, ':'))
> > +		goto mod;
> > +
> >  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
> >  		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
> >  
> >  		if (strcmp(namebuf, name) == 0)
> >  			return kallsyms_sym_address(i);
> >  	}
> > +mod:
> >  	return module_kallsyms_lookup_name(name);
> >  }
> >  EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
> > -- 
> > 2.12.2
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 
