Message-Id: <200004111720.NAA03621@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'Marcus Sundberg'" <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>,
        "Royal, Bill"
	 <bill_royal@gilbarco.com>,
        "Banks, Kelly" <kelly_banks@gilbarco.com>
Subject: RE: Low Memory / Software Emulation Exception / Performance
Date: Tue, 11 Apr 2000 13:20:40 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus,

We are mapping memory that is above RAM, it has worked without any problems
until I applied the dirty page fix.  After that doing a memset on 96k of
/dev/mem mapped memory takes several minutes.  I will do some more
experiments and get back to you.

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Marcus
Sundberg
Sent: Tuesday, April 11, 2000 12:41 PM
To: Wohlgemuth, Jason
Cc: 'linuxppc-embedded@lists.linuxppc.org'; Royal, Bill
Subject: Re: Low Memory / Software Emulation Exception / Performance



"Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com> writes:

> Just a few more questions.  After applying the head.S patch our software
> emulation exceptions have gone away, although, I intend to go back and
trip
> the exception with a logic analyzer attached to verify everything with our
> hardware engineer.  However, this patch seems to induce ultra-slow
> performance in areas where we map physical memory down to the user-level
> with /dev/mem, my guess is that it has something to do with this:

Tring to map in RAM via /dev/mem is equivalent to mapping /dev/zero -
you'll get anonymous private pages (which are cached). Don't ask me
why it is done like that... Trying to map in memory above RAM via
/dev/mem will work as intended, and will always give you caching
inhibited pages.

The dirty page fix should not alter this behaviour afaikt.

Which is it that you are doing?

> Specifically, the part regarding _PAGE_WRITETHRU being redefined to
> _PAGE_NO_CACHE, is this a correct assumption?

Yes, but _PAGE_WRITETHRU is not used by anything in the standard
kernel so it shouldn't make any difference.

>  Is anyone else running into performance related issues with this
> patch applied?

I haven't noted anything like that, but on the other hand we have
no apps mapping /dev/mem.

//Marcus
--
Signature under construction, please come back later.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
