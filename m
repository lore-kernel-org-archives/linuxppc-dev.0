Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B04F9DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Dec 2006 08:12:50 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBLLChtu032583
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 16:12:43 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBLLChIj194318
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 14:12:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBLLChOt014814
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 14:12:43 -0700
Date: Thu, 21 Dec 2006 15:12:42 -0600
To: Ingo Molnar <mingo@redhat.com>
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4
	crashes... and power5 too, actually
Message-ID: <20061221211242.GG16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta>
	<20061220211931.GB16860@austin.ibm.com>
	<1166650134.6673.9.camel@localhost.localdomain>
	<20061220230342.GC16860@austin.ibm.com>
	<1166656195.6673.23.camel@localhost.localdomain>
	<20061220234647.GD16860@austin.ibm.com>
	<20061221003658.GB3048@krispykreme>
	<20061221010319.GE16860@austin.ibm.com>
	<1166712099.8869.16.camel@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1166712099.8869.16.camel@earth>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 21, 2006 at 03:41:39PM +0100, Ingo Molnar wrote:
> On Wed, 2006-12-20 at 19:03 -0600, Linas Vepstas wrote:
> > Same kernel runs fine on power5. Although it does have patches
> > applied, those very same patches boot fine when applied to a slightly
> > older kernel (2.6.19-rc4).  I haven't been messing with buids or 
> > pci config space (at least not intentionaly).
> > 
> > I'll try again with an unpatched, unmodified kernel.
> 
> there have been a number of fixes to lockdep recently - could you try
> the kernel/lockdep.c file from latest -mm, does that fail too?
> 
> one possibility would be a chain-hash collision.

I see the same problem on linux-2.6.20-rc1-mm1 

The patch below fixes this, although I don't understand why 
this has become an issue just now:

Index: linux-2.6.20-rc1-mm1/kernel/mutex.c
===================================================================
--- linux-2.6.20-rc1-mm1.orig/kernel/mutex.c    2006-12-19
16:19:34.000000000 -0600
+++ linux-2.6.20-rc1-mm1/kernel/mutex.c 2006-12-21 14:31:33.000000000
-0600
@@ -249,7 +249,7 @@ __mutex_unlock_common_slowpath(atomic_t
                wake_up_process(waiter->task);
        }

-       debug_mutex_clear_owner(lock);
+       // debug_mutex_clear_owner(lock);

        spin_unlock_mutex(&lock->wait_lock, flags);
 }


It obvious that this is the proximal cause of the failure of 
the double_unlock_mutex() mutex self-test.  However, both
the double-unlock test, and this clear_owner() call, are 
in linux-2.6.19-git7, which doesn't fail this test. So I conclude
that __mutex_unlock_common_slowpath() is never taken in 2.6.19
but is always taken on 2.6.20-rc1 (in particular, is taken
during the double-unlock test).

I don't know why that would be. 

It might be wise to add a test to make sure the slowpath
is taken only when it should be taken? Its sort of scary 
to think that it might be always taken, and that no one 
notices the problem...

I'm gonna be out until after Christmas. -- and so, 

Merry Christmas! 
 
--linas
