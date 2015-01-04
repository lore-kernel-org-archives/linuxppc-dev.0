Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C922F1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jan 2015 15:39:20 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 4 Jan 2015 21:39:18 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B2AA73E40044
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jan 2015 21:39:15 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t054dUeC23396408
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Jan 2015 21:39:30 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t054dDUh017952
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Jan 2015 21:39:15 -0700
Date: Sun, 4 Jan 2015 08:14:16 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] srcu: Isolate srcu sections using CONFIG_SRCU
Message-ID: <20150104161416.GA5280@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1419918382-4758-1-git-send-email-bobby.prani@gmail.com>
 <1419918382-4758-2-git-send-email-bobby.prani@gmail.com>
 <20141230185008.GA23965@worktop.programming.kicks-ass.net>
 <CAJhHMCDsxOsBKphPrH8N5ymPgdN_OVSujQWQt5CB52TK2PO9cA@mail.gmail.com>
 <1420364152.26772.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420364152.26772.0.camel@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Tiejun Chen <tiejun.chen@windriver.com>, Paul Mackerras <paulus@samba.org>,
 Daniel Walter <dwalter@google.com>, Ingo Molnar <mingo@kernel.org>,
 "open list:S390" <linux-s390@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Jens Freimann <jfrei@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>,
 Lai Jiangshan <laijs@cn.fujitsu.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "supporter:S390" <linux390@de.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 04, 2015 at 08:35:52PM +1100, Michael Ellerman wrote:
> On Tue, 2014-12-30 at 13:54 -0500, Pranith Kumar wrote:
> > On Tue, Dec 30, 2014 at 1:50 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Tue, Dec 30, 2014 at 12:46:22AM -0500, Pranith Kumar wrote:
> > >> Isolate the SRCU functions and data structures within CONFIG_SRCU so that there
> > >> is a compile time failure if srcu is used when not enabled. This was decided to
> > >> be better than waiting until link time for a failure to occur.
> > >
> > > Why?
> > 
> > This is part of the kernel tinification efforts. The first patch was
> > posted here: https://lkml.org/lkml/2014/12/4/848. This patch enables a
> > compile time failure instead of a link time failure.
> 
> The punch line was:
> 
>   "so the savings are about ~2000 bytes."
> 
> Which is utterly not worth the effort IMO. There have got to be more attractive
> targets for tinification than this.

There probably are.  But if the tinification effort is to come anywhere
near reaching its goals, it is going to need 2000-byte savings, especially
on the small systems that are this effort's main target.

That said, Peter's suggestion of falling back to the link-time diagnostic
does simplify things a bit, and might be a good approach.

							Thanx, Paul
