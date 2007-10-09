Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C46DADDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 07:28:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l99LSBbs001272
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 17:28:11 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l99LSACo431896
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 15:28:10 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l99LSAsE018592
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 15:28:10 -0600
Date: Tue, 9 Oct 2007 16:28:10 -0500
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Hard hang in hypervisor!?
Message-ID: <20071009212810.GN4350@austin.ibm.com>
References: <20071009203724.GM4350@austin.ibm.com>
	<20071009211819.GR29559@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071009211819.GR29559@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 09, 2007 at 04:18:19PM -0500, Nathan Lynch wrote:
> Linas Vepstas wrote:
> > 
> > I was futzing with linux-2.6.23-rc8-mm1 in a power6 lpar when,
> > for whatever reason, a spinlock locked up. The bizarre thing 
> > was that the rest of system locked up as well: an ssh terminal,
> > and also an hvc console.
> > 
> > Breaking into the debugger showed 4 cpus, 1 of which was 
> > deadlocked in the spinlock, and the other 3 in 
> > .pseries_dedicated_idle_sleep
> > 
> > This was, ahhh, unexpected.  What's up with that? Can
> > anyone provide any insight?
> 
> Sounds consistent with a task trying to double-acquire the lock, or an
> interrupt handler attempting to acquire a lock that the current task
> holds.  Or maybe even an uninitialized spinlock.  Do you know which
> lock it was?

Not sure .. trying to find out now. But why would that kill the
ssh session, and the console? Sure, so maybe one cpu is spinning,
but the other three can still take interrupts, right?  The ssh session
should have been generating ethernet card interrupts, and the console
should have been generating hvc interrupts.  

Err ..  it was cpu 0 that was spinlocked.  Are interrupts not
distributed?

Perhaps I should IRC this ... 

--linas
