To: Pavel Roskin <pavel_roskin@geocities.com>
Cc: kd@flaga.is, linuxppc-embedded@lists.linuxppc.org
Subject: Re: zeroing of bss segments
References: <Pine.LNX.4.21.0004241211280.30844-100000@sunapee.transcept.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Apr 2000 11:03:30 +0200
In-Reply-To: Pavel Roskin's message of "Mon, 24 Apr 2000 12:17:54 -0400 (EDT)"
Message-ID: <kfy3doao8m5.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin <pavel_roskin@geocities.com> writes:

> Hello!
>
> > I forgot to remove the memset.S file from sysdeps/powerpc....
>
> I believe we should rewrite memset.S in a 8xx-safe way rather than remove
> it. Patches are usually more visible than instructions to remove
> something.
>
> Besides, future versions of Glibc could apply that patch permanently.
> Portability is a strong argument for GNU developers.

The problem has been to find out the cache line size at runtime, as
the Mac users probably don't wan't memset() performance halfed.
Geoff Keating suggested the following simple way to check for cache
line size:

  and what we want to do is insert something like this in place of the
  first 'dcbz':

        stb	r7,31(r6)
        dcbz	0,r6
        lbz	r10,31(r6)
        cmplw	cr0,r10,r7
        bne	cr0,(somewhere)

I'll try to get time to look at this after this week.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
