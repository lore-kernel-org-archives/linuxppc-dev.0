Message-ID: <399A4220.23A3B0F5@research.canon.com.au>
Date: Wed, 16 Aug 2000 17:26:24 +1000
From: Graham Stoney <greyham@research.canon.com.au>
MIME-Version: 1.0
To: dan@netx4.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with string.S
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Casting our minds back to July, Dan Malek wrote:
> OK, I think I am bailing out here.  For some reason, if I remove
> the 'dcbz' instructions on the MPC8xx processor the world is just
> a better place.  I don't know why, maybe because of some of the
> TLB mapping, but I can't find a reason.

What was the eventual outcome of this?  I've been doing some 2.2.13
kernel profiling on the 860, and __copy_tofrom_user is coming up as a
hotspot.
I tried dropping in the new improved version from
linux-2.4.0-test7-pre4, and none of the 8xx mods are in there: it'l only
work for 32 byte cache lines.

I hacked it around and found the same as you: it won't work with the
dcbz in there, and of course it doesn't run any faster than the old
version without it.  It's certainly getting more complex in there, and I
see your point about whether the extra code will actually make it run
any faster, especially on 8xx CPUs with small I-caches. I'd be keen to
test whatever you've come up with to see if it's actually better than
the old 2.2 code on 8xx CPUs.

It sounds like a few people have at least had a shot at adding support
for other than 32 byte cache lines, but none have propagated into the
official kernels; how does that happen anyway?

Thanks,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
