Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040224175409.GC1052@smtp.west.cox.net>
References: <1077074495.1082.94.camel@gaston>
	 <20040224175409.GC1052@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1077662351.965.21.camel@gaston>
Mime-Version: 1.0
Date: Wed, 25 Feb 2004 09:39:12 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Are you sure that you can get away with this, passed on how the manuals
> (745x) describe the sequence of flush/invalidating the L2 (and, L3) ?

Do they describe disabling the L1 at all ? I did that after looking at
Darwin place in the first place. But then, I discovered it broke the
wallstreet. I had people test the patch removing those L1 stuffs for
some time and it seems to work.

I think the proper sequence is still what Apple does, but that means
all caches are tied together. I don't have time to work on that, and
there's the issue of possible snoops that Apple addresses by using the
ROM space for the displacement flush, we need something different of
course.

A resume of Apple sequence is that they always tear down and re-enable
all 3 caches in one operation. Using the HW assist when available.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
