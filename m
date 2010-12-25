Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id A6BE1B70CF
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2010 08:04:07 +1100 (EST)
Subject: Re: [PATCH][GIT PULL] powerpc64/tracing: Add frame buffer to calls
	of trace_hardirqs_on/off
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1293225065.16694.796.camel@pasglop>
References: <1293169566.22802.420.camel@gandalf.stny.rr.com>
	<1293225065.16694.796.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Sat, 25 Dec 2010 16:04:03 -0500
Message-ID: <1293311043.22802.434.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Sommer <joerg@alea.gnuu.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-12-25 at 08:11 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2010-12-24 at 00:46 -0500, Steven Rostedt wrote:
> 
> >  arch/powerpc/include/asm/irqflags.h |   40 ++++++++++++++++++++++++++--------
> >  1 files changed, 30 insertions(+), 10 deletions(-)
> > ---------------------------
> > commit 5025019505da6731f8be13940bb978617599c935
> > Author: Steven Rostedt <srostedt@redhat.com>
> > Date:   Thu Dec 23 21:07:39 2010 -0800
> > 
> >     powerpc64/tracing: Add frame buffer to calls of trace_hardirqs_on/off
> >     
> >     When an interrupt occurs in userspace, we can call trace_hardirqs_on/off()
> >     With one level stack. But if we have irqsoff tracing enabled,
> >     it checks both CALLER_ADDR0 and CALLER_ADDR1. The second call
> >     goes two stack frames up. If this is from user space, then there may
> >     not exist a second stack.
> >     
> >     Add a second stack when calling trace_hardirqs_on/off() otherwise
> >     the following oops might occur:
> 
> Hrm... this is really gross :-) So we add gratuituous overhead because
> the code below is dumb :-) What about making the code less stupid
> instead when poking at the stack and detect it's coming from userspace
> instead ?

Note, when CONFIG_IRQSOFF_TRACE is set, there's already a bit of
overhead :-)

Anyway, I'll have to take a look at how the frame pointer is set up. Or
we could also set up all stacks coming into the kernel to have a "dummy"
frame pointer that wont hurt anything if we index into it.

Anyway, I'm off till the new year, so I'll worry about it then ;-)

-- Steve
