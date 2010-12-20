Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (unknown [71.74.56.125])
	by ozlabs.org (Postfix) with ESMTP id 218B8B70A4
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Dec 2010 07:43:39 +1100 (EST)
Subject: Re: Oops in trace_hardirqs_on (powerpc)
From: Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <20101219132705.GE6615@alea.gnuu.de>
References: <20100806233157.GA7117@alea.gnuu.de>
	<1285184671.26872.127.camel@gandalf.stny.rr.com>
	<20100927125037.GA4497@alea.gnuu.de> <1285639094.2989.1.camel@frodo>
	<20101219132705.GE6615@alea.gnuu.de>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 20 Dec 2010 15:43:26 -0500
Message-ID: <1292877806.22905.62.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-12-19 at 14:27 +0100, Jörg Sommer wrote:
> Hi Steven,
> 
> Steven Rostedt hat am Mon 27. Sep, 21:58 (-0400) geschrieben:
> > On Mon, 2010-09-27 at 14:50 +0200, Jörg Sommer wrote:
> > > Hello Steven,
> > > 
> > > Steven Rostedt hat am Wed 22. Sep, 15:44 (-0400) geschrieben:
> > > > Sorry for the late reply, but I was on vacation when you sent this, and
> > > > I missed it while going through email.
> > > > 
> > > > Do you still have this issue?
> > > 
> > > No. I've rebuild my kernel without TRACE_IRQFLAGS and the problem
> > > vanished, as expected. The problem is, that in some cases the stack is
> > > only two frames deep, which causes the macro CALLER_ADDR1 makes an
> > > invalid access. Someone told me, there a workaround for the problem on
> > > i386, too.
> > > 
> > > % sed -n 2p arch/x86/lib/thunk_32.S
> > >  * Trampoline to trace irqs off. (otherwise CALLER_ADDR1 might crash)
> > 
> > Yes, I remember that problem. When I get back from Tokyo, I'll tried to
> > remember to fix it.
> 
> Did you've fixed this problem? The bug report is still marked as open.
> https://bugzilla.kernel.org/show_bug.cgi?id=16573
> 

Ah, this email got lost in the hundreds I had when I got back from
Tokyo, sorry about that again :-(

Anyway, it looks like this only affects 32 bit PPC as I can't reproduce
it with my 64 bit one. And also, unfortunately, my 32bit ppc got taken
from me by my kids, so I can't test it on that either.

I'll look to see if I can write up a patch. Perhaps you could test it
for me.

Thanks,

-- Steve
