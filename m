From: tom_gall@vnet.ibm.com
Message-ID: <399ABFBE.7278954E@vnet.ibm.com>
Date: Wed, 16 Aug 2000 16:22:22 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: dan@netx4.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with string.S
References: <399A4220.23A3B0F5@research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Graham Stoney wrote:
>
> Casting our minds back to July, Dan Malek wrote:
> > OK, I think I am bailing out here.  For some reason, if I remove
> > the 'dcbz' instructions on the MPC8xx processor the world is just
> > a better place.  I don't know why, maybe because of some of the
> > TLB mapping, but I can't find a reason.
>
> What was the eventual outcome of this?  I've been doing some 2.2.13
> kernel profiling on the 860, and __copy_tofrom_user is coming up as a
> hotspot.
> I tried dropping in the new improved version from
> linux-2.4.0-test7-pre4, and none of the 8xx mods are in there: it'l only
> work for 32 byte cache lines.

Graham,

  That's not right. Which version of linux-2.4.0-x do you have? I'm sure Paul's,
Cort's and and I know for sure mine work for more than 32 byte cache lines
because 2 of my boxes have 128 byte cache lines and there's support in there for
it. (Paul wrote it... awesome stuff)

> I hacked it around and found the same as you: it won't work with the
> dcbz in there, and of course it doesn't run any faster than the old
> version without it.  It's certainly getting more complex in there, and I
> see your point about whether the extra code will actually make it run
> any faster, especially on 8xx CPUs with small I-caches. I'd be keen to
> test whatever you've come up with to see if it's actually better than
> the old 2.2 code on 8xx CPUs.

This isn't the only spot too by the way ... glibc has the some problem.

> It sounds like a few people have at least had a shot at adding support
> for other than 32 byte cache lines, but none have propagated into the
> official kernels; how does that happen anyway?

By official are you meaning Linus' ?

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
