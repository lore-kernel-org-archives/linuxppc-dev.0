Date: Sun, 26 Aug 2001 21:24:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup
Message-ID: <20010826212415.G1481@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010826200404.E1481@cpe-24-221-152-185.az.sprintbbd.net> <22437.998883951@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22437.998883951@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 27, 2001 at 01:45:51PM +1000, Keith Owens wrote:

> Please check that this patch against modutils 2.4.7 works.  It puts the
> ftr fixup data in the archdata section of PPC modules.  Use
> "insmod -nm -o blob module_name" to get a map and check that the
> generated blob contains an archdata section containing the ftr fixup
> pointers.  Pick any module from 2.4.8-ac12 that contains ftr data,
> something using get_cycles will do.

Well, I attempted to anyhow.  The get_cycles calls are protected w/
a define that's usually off (and some quick trying couldn't find the
right combo of defines to turn on and have it compile), so I hacked
drivers/char/drm/drm_context.h (this is based on Linus' tree, which is all
I've got right now, sorry) to blindly call get_cycles.  Assuming that
r128_context_switch is the context_switch in drivers/char/drm/drm_context.h,
I had an __archdata section, but it was empty.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
