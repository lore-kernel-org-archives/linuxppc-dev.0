Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x401f1mJVzDr5l
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 02:09:58 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v67G9llM174771
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 12:09:55 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bj3v76j6r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 12:09:53 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 8 Jul 2017 02:09:19 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v67G9Gcc7995738
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Jul 2017 02:09:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v67G97km003786
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Jul 2017 02:09:08 +1000
Date: Fri, 7 Jul 2017 21:39:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests/ftrace: Add a test to probe module
 functions
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
 <04c3a67eb5fe13b12725f7198ef9904f992a512a.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170703122733.e0f7043415e495352c0a12a9@kernel.org>
 <20170703125109.191c52bdc0495cc41e742d84@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170703125109.191c52bdc0495cc41e742d84@kernel.org>
Message-Id: <20170707160914.plo3vpeafwmimpqm@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/07/03 12:51PM, Masami Hiramatsu wrote:
> On Mon, 3 Jul 2017 12:27:33 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 29 Jun 2017 19:05:37 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > Add a kprobes test to ensure that we are able to add a probe on a
> > > module function using 'p <mod>:<func>' format, without having to
> > > specify a probe name.
> > > 
> > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > >  .../testing/selftests/ftrace/test.d/kprobe/probe_module.tc | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
> > > new file mode 100644
> > > index 000000000000..ea7657041ba6
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
> > > @@ -0,0 +1,14 @@
> > > +#!/bin/sh
> > > +# description: Kprobe dynamic event - probing module
> > > +
> > > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > > +
> > > +echo 0 > events/enable
> > > +echo > kprobe_events
> > > +export MOD=`lsmod | head -n 2 | tail -n 1 | cut -f1 -d" "`
> > > +export FUNC=`grep -m 1 ".* t .*\\[$MOD\\]" /proc/kallsyms | xargs | cut -f3 -d" "`
> > > +[ "x" != "x$MOD" -a "y" != "y$FUNC" ] || exit_untested
> > 
> > Could you also add below case?
> > 
> > echo p:probe_$MOD/$FUNC $MOD/$FUNC > kprobe_events 
> 
> Oops, it should be something like
> 
> echo "p:test_${MOD}_${FUNC} $MOD/$FUNC" > kprobe_events
> 
> since we would like to avoid adding new group name for it.
> 
> (Adding new group name should be a separated one.)
> 
> Thank you,
> 
> > 
> > This is for "new event with name on module" case, your one is for "new event without name on module (automatic name generation)"
> > 
> > We should have different test case, because those kicks slightly different parts in kprobe tracer.

Sure. Will make changes to the two tests here and re-spin.

Thanks,
Naveen
