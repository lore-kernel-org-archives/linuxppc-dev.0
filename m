Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz0Pc6QSzzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:09:56 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TD9lwP055950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:09:54 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1npsfbn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:09:52 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 23:09:22 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TD9C4E8061210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:09:20 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TD8la6020169
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:08:47 +1000
Date: Thu, 29 Jun 2017 18:38:29 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Update multiple kprobes test for
 powerpc
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <f49dbddfbc7dee2f68a610bba468c39a4d017feb.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622180738.e97092d4fa6458b9199a03d7@kernel.org>
 <20170622170325.qznheui7eydkdnmv@naverao1-tp.localdomain>
 <20170624023021.92f2f90f0e09314ac9bdb87a@kernel.org>
 <20170624200610.f3aee818b8f6ff2631e0d56a@kernel.org>
 <20170628092846.uwc55zuq7dsbrzho@naverao1-tp.localdomain>
 <20170628231650.6fb5d14fb00923d29bd313d7@kernel.org>
 <20170628184324.zpfe6f54jbhzxq5g@naverao1-tp.localdomain>
 <20170629095757.2f1fea73ad2e61ad08618e15@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629095757.2f1fea73ad2e61ad08618e15@kernel.org>
Message-Id: <20170629130829.yo2zadusujji4koq@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/29 09:57AM, Masami Hiramatsu wrote:
> On Thu, 29 Jun 2017 00:13:24 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/06/28 11:16PM, Masami Hiramatsu wrote:
> > > > > diff --git 
> > > > > a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc 
> > > > > b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > > > new file mode 100644
> > > > > index 0000000..d259031
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > > > @@ -0,0 +1,28 @@
> > > > > +#!/bin/sh
> > > > > +# description: Kprobe event auto/manual naming
> > > > > +
> > > > > +disable_events
> > > > > +echo > kprobe_events
> > > > > +
> > > > > +:;: "Add an event on function without name" ;:
> > > > > +
> > > > > +FUNC=`grep -m 10 " [tT] [^.]*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> > > > 
> > > > On powerpc, this always ends up using a blacklisted function. So, I 
> > > > think we need a way to find a function that is not black listed.  
> > > 
> > > Hmm, if we increase the -m argument, like -m 100, is that still
> > > in a blacklisted function?
> > 
> > Yes, most of the initial symbols are exception vectors which are 
> > blacklisted.
> 
> Hmm, then how about this? :)
> 
> grep _stext -A 1000 | grep -m 10 " [tT] [^.]*$" /proc/kallsyms

That just happened to block the test ;)
I think your suggestion to use schedule/vfs_read is probably the best 
option. I will update your patch and post it.

> 
> > 
> > > 
> > > > However, one of the issues is that debugfs does not show all the address 
> > > > ranges that are blacklisted. I am coming up with a way to address that 
> > > > and will post patches once I have it working.
> > > 
> > > Would you find that is only on powerpc or generic issue?
> > 
> > I meant the address _ranges_ that are blacklisted such as the ones with 
> > __kprobes annotation and __entry_text and so on.
> 
> I see, but we can also check the address by comparing the address
> of symbols, which also can be retrieved from kallsyms.

Yes, but this is very platform specific and will result in a lot of 
checks, arm64 especially.

> Since the test case is also applied to stable kernel, I don't want
> to make it depending on some special kernel tweaks.

Sure, makes sense. For now, I think it's best to keep the test simple.  
But, we can enhance these later to consider the blacklist.

Thanks,
Naveen

> 
> > > 
> > > > 
> > > > With those patches, we should be able to select symbols that are not 
> > > > blacklisted.
> > > 
> > > Or, maybe we can use generic function, like "schedule" or "vfs_read"
> > > etc.
> > 
> > Yes, I think this will be good for the generic test, but may not help 
> > selecting a dot symbol on powerpc.
> 
> Right, and it depends on what gcc version and option is specified.
> So, maybe we can skip the test if there is no such symbols.
> 
> I intended to test the symbols with some dot-suffix, but it seems
> ppc64 has dot-started symbols, right? If there is no dot-suffixed
> symbols, I think this test should skip the test case.
> 
> Thank you,
> 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 
