Message-Id: <199912290021.TAA23598@mal-ach.watson.ibm.com>
To: Geoff Keating <geoffk@cygnus.com>
cc: drow@false.org, linuxppc-dev@lists.linuxppc.org,
        libc-alpha@sourceware.cygnus.com
Subject: Re: DB_THREAD support in Berkeley DB/glibc 
In-Reply-To: Message from Geoff Keating <geoffk@cygnus.com>
   of "Tue, 28 Dec 1999 15:52:47 PST." <199912282352.PAA11865@localhost.cygnus.com>
Date: Tue, 28 Dec 1999 19:21:36 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Geoff Keating writes:

Geoff> We don't need 'isync', 'sync' will do just fine, and is faster.  We
Geoff> are only concerned here with memory coherency.  In fact, 'isync' does
Geoff> not imply 'sync' in a multiprocessor implementation; 'sync' does an
Geoff> extra broadcast on the bus.  The PowerPC User's Manual says

Geoff> The sync instruction can be used to ensure that the result of all
Geoff> stores into a data structure, performed in a "critical section" of a
Geoff> program, are seen by other processors before the data structure is
Geoff> seen as unlocked.

Geoff> We probably want 'sync' before and after, although it's probable the
Geoff> 'after' is unnecessary.

	"sync" is not faster; sync is a full context synchronization
instruction.  As I had mentioned to David, the necessity of a sync *after*
the store depends on the semantics of this programming model.  Maybe in
this context one should sync before acquiring the lock and then sync after
releasing the lock.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
