Message-Id: <199912290101.UAA23618@mal-ach.watson.ibm.com>
To: Geoff Keating <geoffk@cygnus.com>
cc: eek@escape.ca, drow@false.org, linuxppc-dev@lists.linuxppc.org,
        libc-alpha@sourceware.cygnus.com
Subject: Re: DB_THREAD support in Berkeley DB/glibc 
In-Reply-To: Message from Geoff Keating <geoffk@cygnus.com>
   of "Tue, 28 Dec 1999 16:54:38 PST." <199912290054.QAA13250@localhost.cygnus.com>
Date: Tue, 28 Dec 1999 20:01:40 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Geoff Keating writes:

>> If you only are using the TSL_UNSET in the context that one
>> already has the lock, then the lwarx/stwcx are unnecessary.  What you have
>> written, however, is not a general atomic clear macro.

Geoff> How is it not atomic?

	If this thread is the only one that can clear the cell, I think
that it is okay.  The store to acquire the lock also is atomic, but one
cannot simply store the value.  If the programming model allows contention
when clearing the word, one needs to use the lwarx/stwcx instructions.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
