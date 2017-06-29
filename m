Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyh971PnBzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 10:58:03 +1000 (AEST)
Date: Thu, 29 Jun 2017 09:57:57 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Update multiple kprobes test for
 powerpc
Message-Id: <20170629095757.2f1fea73ad2e61ad08618e15@kernel.org>
In-Reply-To: <20170628184324.zpfe6f54jbhzxq5g@naverao1-tp.localdomain>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <f49dbddfbc7dee2f68a610bba468c39a4d017feb.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622180738.e97092d4fa6458b9199a03d7@kernel.org>
 <20170622170325.qznheui7eydkdnmv@naverao1-tp.localdomain>
 <20170624023021.92f2f90f0e09314ac9bdb87a@kernel.org>
 <20170624200610.f3aee818b8f6ff2631e0d56a@kernel.org>
 <20170628092846.uwc55zuq7dsbrzho@naverao1-tp.localdomain>
 <20170628231650.6fb5d14fb00923d29bd313d7@kernel.org>
 <20170628184324.zpfe6f54jbhzxq5g@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 00:13:24 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/06/28 11:16PM, Masami Hiramatsu wrote:
> > > > diff --git 
> > > > a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc 
> > > > b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > > new file mode 100644
> > > > index 0000000..d259031
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > > @@ -0,0 +1,28 @@
> > > > +#!/bin/sh
> > > > +# description: Kprobe event auto/manual naming
> > > > +
> > > > +disable_events
> > > > +echo > kprobe_events
> > > > +
> > > > +:;: "Add an event on function without name" ;:
> > > > +
> > > > +FUNC=`grep -m 10 " [tT] [^.]*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> > > 
> > > On powerpc, this always ends up using a blacklisted function. So, I 
> > > think we need a way to find a function that is not black listed.  
> > 
> > Hmm, if we increase the -m argument, like -m 100, is that still
> > in a blacklisted function?
> 
> Yes, most of the initial symbols are exception vectors which are 
> blacklisted.

Hmm, then how about this? :)

grep _stext -A 1000 | grep -m 10 " [tT] [^.]*$" /proc/kallsyms

> 
> > 
> > > However, one of the issues is that debugfs does not show all the address 
> > > ranges that are blacklisted. I am coming up with a way to address that 
> > > and will post patches once I have it working.
> > 
> > Would you find that is only on powerpc or generic issue?
> 
> I meant the address _ranges_ that are blacklisted such as the ones with 
> __kprobes annotation and __entry_text and so on.

I see, but we can also check the address by comparing the address
of symbols, which also can be retrieved from kallsyms.
Since the test case is also applied to stable kernel, I don't want
to make it depending on some special kernel tweaks.

> > 
> > > 
> > > With those patches, we should be able to select symbols that are not 
> > > blacklisted.
> > 
> > Or, maybe we can use generic function, like "schedule" or "vfs_read"
> > etc.
> 
> Yes, I think this will be good for the generic test, but may not help 
> selecting a dot symbol on powerpc.

Right, and it depends on what gcc version and option is specified.
So, maybe we can skip the test if there is no such symbols.

I intended to test the symbols with some dot-suffix, but it seems
ppc64 has dot-started symbols, right? If there is no dot-suffixed
symbols, I think this test should skip the test case.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
