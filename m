Subject: Re: Possible bug in flush_dcache_all on 440GP
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFF6BB8794.C62B49D5-ON87256CDB.0052212D@us.ibm.com>
From: Ralph Blach <rcblach@us.ibm.com>
Date: Fri, 28 Feb 2003 10:00:54 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This comment is from Thomas Sartorius,


Eugene is correct about the "generic" way requiring that you load twice as
many memory locations as would fit in the cache, in order to guarantee that
any previous "dirty" contents get written to memory and removed from the
cache.

Note that his second suggestion regarding dccci requires that the processor
be in supervisor mode, and assumes that there is no dirty data left in the
cache at the time of the dccci (or else one doesn't care about causing such
dirty data to be written back to memory).

An alternative (and likely faster) method is to use a series of dcbz
instructions (as many as there are lines in the cache) to a series of
"safe" addresses for which it is known that the cache does not currently
contain dirty data, and then use dccci at the end to eliminate this dirty
data without causing any of it to be written back to memory.  This
technique should be much faster as it avoids having to actually read any
memory locations into the cache.

Another alternative is to use a loop that does a series of dcread/dcbf
instructions, where the information that is read into the GPR by the dcread
is then used by the dcbf to cause that line to be cast-out and invalidated.
Depending on the possible state of the cache, it might be necessary to test
the valid bit read by the dcread before trying to use the value for the
dcbf, to avoid any MMU exceptions.

One thing to note with regards to any of the techniques:  you probably need
to guarantee that interrupts do not occur during the sequence to make sure
that the cache is cleanly flushed when the routine is finished.

One more thing to note with regards to any of the techniques:  you need to
concern yourself with possible MMU exceptions during the sequence.

One last thing to note:  if you're using any of the techniques other than
the dcread/dcbf sequence, then you need to concern yourself with the
"victim limit" values, and whether or not the cache has been partitioned
into "normal". "transient", and "locked" regions.  The techniques described
all presume that "normal" storage access operations will cause the "victim
index" value to walk through all the values from 0 to 63, but if the cache
has been partitioned, this will not be the case.

In the end, I would suggest that the "safest", most robust technique is to
use the dcread/dcbf sequence loop, with proper testing of the dcread result
(e.g., for a valid bit) before executing the dcbf, and with proper MMU
setup ahead of time to make sure you don't get MMU exceptions during the
sequence.

One last thing:  Eugene suggests that "40x" processors have 32-byte cache
lines, but that is not the case for the 403 and 401 (they have 16-byte
cache lines).


Segher Boessenkool <segher@koffie.nl>@lists.linuxppc.org on 02/26/2003
10:39:05 AM

Sent by:    owner-linuxppc-embedded@lists.linuxppc.org


To:    Eugene Surovegin <ebs@ebshome.net>
cc:    linuxppc-embedded@lists.linuxppc.org
Subject:    Re: Possible bug in flush_dcache_all on 440GP




Eugene Surovegin wrote:

> I believe there is a bug in flush_dcache_all implementation for not cache
> coherent processors.
>
> This function uses simple algorithm to force dcache flush by reading
> "enough" data to completely reload the cache:


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
