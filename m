Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 493FDDDF24
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 05:19:22 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l58JJJm9011750
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 15:19:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l58JJIdn238840
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 13:19:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l58JJI7j005843
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 13:19:18 -0600
Subject: Re: [PATCH 1/3] [PATCH i386] during VM oom condition, kill all
	threads in process group
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070607171018.d51fc5da.akpm@linux-foundation.org>
References: <20070605174831.21740.33119.stgit@farscape.rchland.ibm.com>
	<20070607153459.2a1b3230.akpm@linux-foundation.org>
	<20070607231621.GB32549@kryten>
	<20070607171018.d51fc5da.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 14:19:18 -0500
Message-Id: <1181330358.21409.31.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 17:10 -0700, Andrew Morton wrote:
> On Thu, 7 Jun 2007 18:16:21 -0500
> Anton Blanchard <anton@samba.org> wrote:
> 
> >  
> > Hi,
> > 
> > > zap_other_threads() requires tasklist_lock.

Yup, I missed that.   Thanks for pointing it out.

> > > 
> > > If we're going to do this then we should probably create some new function
> > > (with a better name) which takes tasklsit_lock and then calls
> > > zap_other_threads().

I expect this will be a write_lock_irq() since zap_other_threads will be
doing a bit more than just reading the task info.

This will be down in a do-page-fault failure path (see
arch/*/mm/fault.c).  I wonder if calling write_lock is going to be safe,
or if its possible to get into a deadlock?  i.e. should I branch back up
to the survive: label if I can't take the lock?  Would that even be
sufficient? or is it not an issue here? 

> > > 
> > > Does this patch fix any observed-in-the-real-world problem?  If so, please
> > > describe it.
> > 
> > Yeah we have had complaints where threaded apps have only one thread
> > shot down instead of the entire process. This leaves the application in
> > a bad state, whereas if it had been killed cleanly the application could
> > have restarted.
> > 
> > My understanding is that fatal signals should kill all threads in the
> > group.
> > 
> 
> OK, well could we please get all that info appropriatelt captured in #2's
> changelog?
Yup, next spin I'll add more to the changelog. 

> 
> Other architectures will probably need to implement this.

-Will
