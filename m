Message-Id: <v04003a01b48ef374578e@[216.81.17.184]>
In-Reply-To: <199912282228.RAA25934@mal-ach.watson.ibm.com>
References: Message from Daniel Jacobowitz <drow@false.org>    of "Tue, 28
 Dec 1999 17:05:39 EST." <19991228170539.A18218@drow.res.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 28 Dec 1999 17:21:36 -0600
To: David Edelsohn <dje@watson.ibm.com>, Daniel Jacobowitz <drow@false.org>
From: Tony Mantler <eek@escape.ca>
Subject: Re: DB_THREAD support in Berkeley DB/glibc
Cc: linuxppc-dev@lists.linuxppc.org, libc-alpha@sourceware.cygnus.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:28 PM -0600 12/28/99, David Edelsohn wrote:
>	The TSL_UNSET still does not look sufficient to me.  It needs to
>use lwarx/stwcx as well:
>
>#define TSL_UNSET(tsl) ({
>	register tsl_t *__l = (tsl);
>	register tsl_t __r1;
>	__asm__ __volatile__ ("
>	       sync
>           10: lwarx   %0,0,%1
>	       stwcx.  %2,0,%1
>               bne-    10b
>	       isync"
>         : "=&r" (__r1) : "r" (__l), "r" (0));
>        })

Why? It would seem to me that the only time that atomic code would be
tripped is if the calling thread didn't have the lock when it tried to
clear it (umm, biiiig no-no), and a different thread tried to set the lock
at the same time.

I would agree with Daniel Jacobowitz's code, all that should be needed is a
sync and write for the unset.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
