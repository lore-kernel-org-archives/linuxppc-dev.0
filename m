Subject: Re: switching linux kernels
To: jelbert@enerdyne.com (Julia Elbert)
Date: Wed, 27 Sep 2000 11:40:21 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <67505026E29DD311A9AA00508B7315F350A529@EXCHANGE> from "Julia Elbert" at Sep 26, 2000 03:34:49 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000927004021.ABEB8BF@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert writes:
> In 2.2.14, I need to have the Copy-Back Data Cache option off for my drivers
> to work with video, same as in 2.2.13, or I else I get corrupted video data.

Turning off copy-back has a global performance hit, so it's a pretty nasty
workaround for cache coherency bugs in a single driver.  It's OK when it gets
you going in a pinch, but as you've found, these bugs keep coming back to bite
every time you upgrade to a more aggressive caching regimen.  Also, perhaps
your driver isn't doing I/O barrier stuff properly; does it use insx/outsx &
friends from asm/io.h, or does it dereference pointers directly, forgetting
the eieio's?

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
