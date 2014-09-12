Return-Path: <umgwanakikbuti@gmail.com>
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com
 [IPv6:2a00:1450:4010:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3EA11A009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 20:59:03 +1000 (EST)
Received: by mail-la0-f42.google.com with SMTP id hz20so694589lab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 03:58:58 -0700 (PDT)
Message-ID: <1410519533.5547.49.camel@marge.simpson.net>
Subject: Re: [PATCH v3 3/3] sched: BUG when stack end location is over written
From: Mike Galbraith <umgwanakikbuti@gmail.com>
To: Aaron Tomlin <atomlin@redhat.com>
Date: Fri, 12 Sep 2014 12:58:53 +0200
In-Reply-To: <20140912094419.GD1873@atomlin.usersys.redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-4-git-send-email-atomlin@redhat.com>
 <1410494817.17540.4.camel@concordia>
 <20140912094419.GD1873@atomlin.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 prarit@redhat.com, pzijlstr@redhat.com, peterz@infradead.org, bmr@redhat.com,
 x86@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, minchan@kernel.org, mingo@redhat.com,
 tglx@linutronix.de, aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, jgh@redhat.com,
 akpm@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-12 at 10:44 +0100, Aaron Tomlin wrote: 
> On Fri, Sep 12, 2014 at 02:06:57PM +1000, Michael Ellerman wrote:
> > On Thu, 2014-09-11 at 16:41 +0100, Aaron Tomlin wrote:
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index a285900..2a8280a 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -824,6 +824,18 @@ config SCHEDSTATS
> > >  	  application, you can say N to avoid the very slight overhead
> > >  	  this adds.
> > >  
> > > +config SCHED_STACK_END_CHECK
> > > +	bool "Detect stack corruption on calls to schedule()"
> > > +	depends on DEBUG_KERNEL
> > > +	default y
> > 
> > Did you really mean default y?
> > 
> > Doing so means it will be turned on more or less everywhere, which defeats the
> > purpose of having a config option in the first place.
> 
> Only if Kconfig CONFIG_DEBUG_KERNEL is enabled in the first place.

Which is likely enabled just about everywhere on the planet.

-Mike
