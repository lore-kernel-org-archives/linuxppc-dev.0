Date: Tue, 28 Dec 1999 16:54:38 -0800
From: Geoff Keating <geoffk@cygnus.com>
Message-Id: <199912290054.QAA13250@localhost.cygnus.com>
To: dje@watson.ibm.com
CC: eek@escape.ca, drow@false.org, linuxppc-dev@lists.linuxppc.org,
        libc-alpha@sourceware.cygnus.com
In-reply-to: <199912290015.TAA24316@mal-ach.watson.ibm.com> (message from
	David Edelsohn on Tue, 28 Dec 1999 19:15:59 -0500)
Subject: Re: DB_THREAD support in Berkeley DB/glibc
References: <199912290015.TAA24316@mal-ach.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: Tue, 28 Dec 1999 19:15:59 -0500
> From: David Edelsohn <dje@watson.ibm.com>

You were right about sync being slower than isync.  I expect
the difference is caused by sync needing to perform bus operations
where isync does not.

Anyway, they're not substitutes for each other; they do different
things, and in a given situation only one (or, possibly, both in
sequence) will be right.

> 	If you only are using the TSL_UNSET in the context that one
> already has the lock, then the lwarx/stwcx are unnecessary.  What you have
> written, however, is not a general atomic clear macro.

How is it not atomic?

The PUM says "With the exception of double-precision floating-point
accesses on 32-bit implementations, all aligned accesses are atomic."

-- 
- Geoffrey Keating <geoffk@cygnus.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
