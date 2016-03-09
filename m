Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15B671A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 20:44:30 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7EF86140216
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 20:44:28 +1100 (AEDT)
Date: Wed, 9 Mar 2016 10:44:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309094423.GH10940@pathway.suse.cz>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309091904.GA23039@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2016-03-09 10:19:04, Torsten Duwe wrote:
> On Wed, Mar 09, 2016 at 05:59:40PM +1100, Balbir Singh wrote:
> > 
> > The previous revision was nacked by Torsten, but compared to the alternatives
> 
> I nacked it because I was confident it couldn't work. Same goes
> for this one, sorry. My good intention was to save us all some work.
> 
> > @@ -1265,6 +1271,51 @@ ftrace_call:
> >  	ld	r0, LRSAVE(r1)
> >  	mtlr	r0
> >  
> > +#ifdef CONFIG_LIVEPATCH
> > +	beq+	4f		/* likely(old_NIP == new_NIP) */
> > +	/*
> > +	 * For a local call, restore this TOC after calling the patch function.
> 
> This is the key issue.
> 
> Ftrace_caller can gather and save the current r2 contents, no problem;
> but the point is, it needs to be restored *after* the replacement function.
> I see 3 ways to accomplish this:
> 
> 1st: make _every_ replacement function aware of this, and make it restore
>      the TOC manually just before each return statement.
> 
> 2nd: provide a global hook to do the job, and use a stack frame to execute it.
> 
> 3rd: have a global hook like solution 2, but let it have its own data
>      structure, I'd call it a "shadow stack", for the real return addresses.
>      See struct fgraph_cpu_data in kernel/trace/trace_functions_graph.c
> 
> Using heuristics to determine whether the call was local or global
> makes me feel highly uncomfortable; one day it will break and
> nobody will remember why.
> 
> Balbir, the problem with your patch is that it goes only half the way from
> my solution 2 towards solution 1. When you call a helper function on return,
> you need a place to store the real return address.
> 
> I'll try to demonstrate a solution 1 as well, but you'll probably won't like
> that either...

To be honest, I still do not have a good picture about all the
problems in my head. Anyway, I would really appreciate if we could
find a solution that would work transparently. I mean that adding
an extra hacks into selected functions in the patch might be quite
error prone and problems hard to debug. I think that we all want this
but I wanted to be sure :-)

BTW: I am getting close to send a patch with some basic livepatch
documentation. It might be used to document "temporary" limitations.

Best Regards,
Petr
