Date: Tue, 28 Dec 1999 15:52:47 -0800
From: Geoff Keating <geoffk@cygnus.com>
Message-Id: <199912282352.PAA11865@localhost.cygnus.com>
To: dje@watson.ibm.com
CC: drow@false.org, linuxppc-dev@lists.linuxppc.org,
        libc-alpha@sourceware.cygnus.com
In-reply-to: <199912282228.RAA25934@mal-ach.watson.ibm.com> (message from
	David Edelsohn on Tue, 28 Dec 1999 17:28:23 -0500)
Subject: Re: DB_THREAD support in Berkeley DB/glibc
References: <199912282228.RAA25934@mal-ach.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: Tue, 28 Dec 1999 17:28:23 -0500
> From: David Edelsohn <dje@watson.ibm.com>
> 
> 	The TSL_UNSET still does not look sufficient to me.  It needs to
> use lwarx/stwcx as well:
> 
> #define TSL_UNSET(tsl) ({
> 	register tsl_t *__l = (tsl);
> 	register tsl_t __r1;
> 	__asm__ __volatile__ ("
> 	       sync
>            10: lwarx   %0,0,%1
> 	       stwcx.  %2,0,%1
>                bne-    10b
> 	       isync"
>          : "=&r" (__r1) : "r" (__l), "r" (0));
>         })
> 
> As I mentioned privately to David Huggins-Daines, the order I normally use
> is: 1) sync, 2) perform the atomic update, 3) isync.  This ensures that
> the cached copy of the memory location is consistent, performs the update,
> and the ensures that no later instructions which depend on the atomicity
> are moved ahead of the atomic operation.  I am not sure how that maps to
> the Alpha "memory barrier" instruction as I have seen some discussion
> about it on the Linux/PPC mailinglists in the past.  As long as all
> threads using the macro sync first, there is should be no need to sync
> after.

Hmmm.

I'm pretty sure the loop and lwarx/stwcx pair are unnecessary.  Stores
on ppc are atomic, and we're not taking any action based on the
previous value, so we can just use a normal store.  The store will
clear any reservations, although in the context of this code it
doesn't matter (because presumably only one thread will be unsetting
the lock).

Again, '__volatile__' does not imply a memory clobber, so we want to
do that instead.

We don't need 'isync', 'sync' will do just fine, and is faster.  We
are only concerned here with memory coherency.  In fact, 'isync' does
not imply 'sync' in a multiprocessor implementation; 'sync' does an
extra broadcast on the bus.  The PowerPC User's Manual says

  The sync instruction can be used to ensure that the result of all
  stores into a data structure, performed in a "critical section" of a
  program, are seen by other processors before the data structure is
  seen as unlocked.

We probably want 'sync' before and after, although it's probable the
'after' is unnecessary.

-- 
- Geoffrey Keating <geoffk@cygnus.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
