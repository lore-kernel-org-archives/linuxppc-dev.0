To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
        "Royal, Bill" <bill_royal@gilbarco.com>
Subject: Re: Low Memory / Software Emulation Exception / Performance
References: <200004111350.JAA25971@hoover.gilbarco.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 11 Apr 2000 18:40:46 +0200
In-Reply-To: "Wohlgemuth, Jason"'s message of "Tue, 11 Apr 2000 09:50:45 -0400"
Message-ID: <kfy1z4csi9d.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com> writes:

> Just a few more questions.  After applying the head.S patch our software
> emulation exceptions have gone away, although, I intend to go back and trip
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
