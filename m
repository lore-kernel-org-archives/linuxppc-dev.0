Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED831A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 19:47:12 +1000 (EST)
Date: Fri, 12 Sep 2014 10:44:19 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/3] sched: BUG when stack end location is over written
Message-ID: <20140912094419.GD1873@atomlin.usersys.redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-4-git-send-email-atomlin@redhat.com>
 <1410494817.17540.4.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1410494817.17540.4.camel@concordia>
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

On Fri, Sep 12, 2014 at 02:06:57PM +1000, Michael Ellerman wrote:
> On Thu, 2014-09-11 at 16:41 +0100, Aaron Tomlin wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index a285900..2a8280a 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -824,6 +824,18 @@ config SCHEDSTATS
> >  	  application, you can say N to avoid the very slight overhead
> >  	  this adds.
> >  
> > +config SCHED_STACK_END_CHECK
> > +	bool "Detect stack corruption on calls to schedule()"
> > +	depends on DEBUG_KERNEL
> > +	default y
> 
> Did you really mean default y?
> 
> Doing so means it will be turned on more or less everywhere, which defeats the
> purpose of having a config option in the first place.

Only if Kconfig CONFIG_DEBUG_KERNEL is enabled in the first place.

-- 
Aaron Tomlin
