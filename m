To: Dan Malek <dan@netx4.com>
Cc: Pavel Roskin <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com> <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F200CF.B4A07187@embeddededge.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 11 Apr 2000 10:50:32 +0200
In-Reply-To: Dan Malek's message of "Mon, 10 Apr 2000 12:26:55 -0400"
Message-ID: <kfysnwtrpgn.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Marcus Sundberg wrote:
>
> > Well, it also happens to be typical to the MM problem solved by
> > the patches at http://www.zeta.org.au/~linsol/.....
>
> That's pretty interesting, since the Software Emulation trap is
> caused by fetching trash from memory, and the MMU changes are to
> properly track dirty data pages.  I don't buy it.  All you did
> by adding these changes was eliminate (or change) the data TLB
> miss timing.

Well, I've verified the problem on MBX, ADS, FADS, RPX Lite/Classic
and 3 different custom boards, with 823, 850, 860, 860T and 860P
CPUs. It has a 100% chance of crashing without the patch, and a 0%
chance of crashing with it. Especially Pavel's description sounded
very much like this problem.

All you have to do to experience the problem is allocate memory
until the RAM gets low (allocating buffer cache by copying files
around is enough.) If you are running a dynamicly linked glibc2
app what is most likely to happen is that the (dirty) jump table
is thrown out by the broken MM code. When the application tries
to call a function in a shared library the jump table will be
read in from disk again, but as it's not filled in properly the
app will crash, usually by jumping into some data area and getting
an illegal instruction.

What happens next is usually that the app's parent will run, and
crash for the same reason. This will go on until we get up to init,
which can not be killed, and get stuck in an endless loop of trying
to execute the same illegal instruction.

If you are running a staticly linked app, or using libc 1.99, it
is usually more common to get a segfault, but in the end it all
depends on what pages have been erroneously thrown out and which
are accessed first.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
