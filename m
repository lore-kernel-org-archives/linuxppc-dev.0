Message-Id: <199912282228.RAA25934@mal-ach.watson.ibm.com>
To: Daniel Jacobowitz <drow@false.org>
Cc: linuxppc-dev@lists.linuxppc.org, libc-alpha@sourceware.cygnus.com
Subject: Re: DB_THREAD support in Berkeley DB/glibc 
In-Reply-To: Message from Daniel Jacobowitz <drow@false.org>
   of "Tue, 28 Dec 1999 17:05:39 EST." <19991228170539.A18218@drow.res.cmu.edu>
Date: Tue, 28 Dec 1999 17:28:23 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The TSL_UNSET still does not look sufficient to me.  It needs to
use lwarx/stwcx as well:

#define TSL_UNSET(tsl) ({
	register tsl_t *__l = (tsl);
	register tsl_t __r1;
	__asm__ __volatile__ ("
	       sync
           10: lwarx   %0,0,%1
	       stwcx.  %2,0,%1
               bne-    10b
	       isync"
         : "=&r" (__r1) : "r" (__l), "r" (0));
        })

As I mentioned privately to David Huggins-Daines, the order I normally use
is: 1) sync, 2) perform the atomic update, 3) isync.  This ensures that
the cached copy of the memory location is consistent, performs the update,
and the ensures that no later instructions which depend on the atomicity
are moved ahead of the atomic operation.  I am not sure how that maps to
the Alpha "memory barrier" instruction as I have seen some discussion
about it on the Linux/PPC mailinglists in the past.  As long as all
threads using the macro sync first, there is should be no need to sync
after.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
