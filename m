From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <libc-alpha@sources.redhat.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, Dan Malek <dan@mvista.com>,
	<cort@fsmlabs.com>, <paulus@samba.org>
Subject: PPC sysdep additions & problem
Date: Fri, 6 Apr 2001 12:17:14 +0200
Message-Id: <20010406101714.12391@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

(Please CC me replies as I'm not subscribed to this list).

I'm in the process of cleaning up some of the PPC kernel code
related to identifying specific CPU features and to address a
longstanding issue we had which is to pass some CPU informations
to userland for glibc use.

For one thing (feature bits), I'll be using the ELF_HWCAP
mecanism. I'll post a complete definition of the bits there once
I'm final with it (things like altivec, fpu, mmu presence, things
like supported instruction sets, 4xx MAC, power instructions (601),
and whatever we may need there). If you have ideas about things
that should be there, please email me.

However, for something else, I need to extend the aux table passed
by the kernel ELF loader to glibc. I want that to pass the cache line
size for I, D and Unified cache.

While playing with that, I noticed that the AT_xxxx tags with the
current glibc should not be higher than 31. The reason is that
glibc dl-sysdep function _dl_sysdep_start() function will build
a bit mask of "seen" entries, and using higher than 31 values will
prevent that mecanism from working.

What do you sugggest ? I'd like to avoid "requesting" 3 AT_xxxx
constants if the total range is limited to 31. However, if we don't
care about the "seen" bits for those, we can define that additional
"platform" aux entries can have high numbers (let's say above 1000
for example).
Or I can use only one entry, and stuff the 2 (I & D) cache line
sizes (16 bits each), with one bit in HWCAP telling if the cache is
unified.

In anyway, I'll need at least one entry to be reserved for that
use, and I beleive some other CPUs may benefit from the cache line
size informations, so It would be great if AT_xxxx constants could
be defined & reserved for them right now. That would at least provide
binary compatiblity of my experimental kernels with future versions
of kernel & glibc that will implement this feature.

Note that so far, I had some problems loading binaries if I add
3 entries to the aux table from the kernel with numbers 1000,1001,1002.
I'm not sure what would have caused binaries not to load properly
(apparently, their command line gets screwed, I'm not too sure yet).
The glibc code that fills the "seen" mask definitely couldn't set
bits for those entries, but this shouldn't have caused any problem.

Waiting for any comments, clues, whatever...

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
