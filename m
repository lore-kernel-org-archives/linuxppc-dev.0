Message-ID: <3764E007.E09568FA@switchboard.ericsson.se>
Date: Mon, 14 Jun 1999 12:57:11 +0200
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Heinz Blaettner <heinz@bintec.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help booting MBX through bootd
References: <XFMail.990611232427.heinz@bintec.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Heinz Blaettner wrote:
> 
> On 11-Jun-99 Wolfgang Denk wrote:
> >> The fact that the cache magic in sysdeps/powerpc/memset.S in glibc
> >> will make the dynamic linker crash in it's early startup phase is
> >> quite a big problem... ;)
> >> Also sysdeps/powerpc/dl-machine.c makes an assumption about the cache
> >> line size, but that seems to be less fatal.
> >
> > Grrrghh... I see.
> 
> Maybe a thumb question ?

Not a dumb question at all, what's dumb is the person who hardcoded
cache line sizes into userland code without even a comment...

> How does the wrong cache line size makes that the code corrupts ???
> I will belive that the execution speed might not be optimal ?

Glibc optimizes memset-to-zero using the dcbz instruction. Now when
you shrink the cache line size to half (as is the case with MPC860)
every other cache line will not be cleared, resulting in bad things
happening.

As for the dl-machine.c the dcbst instruction is used in a loop to
ensure consistency after relocating (==copying) code. Here however
the dependency on cache line size == 32 was at least documented...

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
