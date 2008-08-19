Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD4F8DDF38
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 11:57:01 +1000 (EST)
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <srostedt@redhat.com>
In-Reply-To: <48A9901B.1080900@redhat.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 11:51:32 +1000
Message-Id: <1219110692.8062.0.camel@pasglop>
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, Eran Liberty <liberty@extricom.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-18 at 11:07 -0400, Steven Rostedt wrote:
> Eran Liberty wrote:
> > After compiling a kernel with ftrace I started to experience all sorts 
> > of crashes.
> 
> Just to make sure...
> 
> ftrace enables markers too, and RCU has tracing with the markers. This 
> may not be the problem, but I just want to eliminate as many variables 
> as possible.
> Could you disable ftrace, but keep the markers on too.  Also, could you 
> enable ftrace again and turn on the FTRACE_STARTUP_TEST.

I spent some time last week tracking one of those crashes and it appears
that we are getting corruption of some of the non-volatile registers.

So far, I found out that it -seems- to be coming from stack frame
corruption during a timer interrupt.

I haven't had a chance to dig further yet.

Cheers,
Ben.
