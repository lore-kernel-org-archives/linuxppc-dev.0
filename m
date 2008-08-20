Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id CDBA4DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 23:12:56 +1000 (EST)
Date: Wed, 20 Aug 2008 09:12:54 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Eran Liberty <liberty@extricom.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <48ABFD77.6030701@extricom.com>
Message-ID: <alpine.DEB.1.10.0808200911100.13132@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <48A9BEA3.10906@extricom.com>
	<alpine.DEB.1.10.0808181439480.796@gandalf.stny.rr.com>
	<48AAB7FF.4070502@extricom.com>
	<alpine.DEB.1.10.0808191614380.4957@gandalf.stny.rr.com>
	<48ABFD77.6030701@extricom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 20 Aug 2008, Eran Liberty wrote:

> Steven Rostedt wrote:
> > On Tue, 19 Aug 2008, Eran Liberty wrote:
> > 
> >   
> > > Steven Rostedt wrote:
> > >     
> > > >         
> > > > > Testing tracer sched_switch: PASSED
> > > > > Testing tracer ftrace: PASSED
> > > > > Testing dynamic ftrace: PASSED
> > > > >         
> > 
> > Do you have PREEMPT_TRACER enabled, or any other tracer for that matter?
> > 
> > -- Steve
> >   
> I can see stack trace & context trace, but they are derived from other choices
> (I can not un select them)

Yeah, those are not bad.

> 
> cat .config | grep TRACE
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> # CONFIG_BLK_DEV_IO_TRACE is not set
> CONFIG_STACKTRACE=y
> # CONFIG_BACKTRACE_SELF_TEST is not set
> CONFIG_HAVE_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_FTRACE=y
> # CONFIG_SCHED_TRACER is not set
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_FTRACE_SELFTEST=y
> CONFIG_FTRACE_STARTUP_TEST=y

You must not have PREEMPT on, so the PREEMPT_TRACER will not show up.

The reason I asked, is that my PowerBook runs fine without PREEMPT_TRACER 
but is very unstable when I have PREEMPT_TRACER enabled.

-- Steve


> >   
> > > > > Oops: Exception in kernel mode, sig: 11 [#1]
> > > > > Exsw1600
> > > > > Modules linked in:
> > > > > NIP: c00bbb20 LR: c00bbb20 CTR: 00000000
> > > > >             
> > 
> > 
> >   
> 
> 
