Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41D00564.6010507@free.fr>
References: <41CEC6B0.5020106@free.fr> <1104137527.5615.20.camel@gaston>
	<41D00564.6010507@free.fr>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 14:32:00 +0100
Message-Id: <1104154320.23891.27.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PATCH uninorth3 (G5) agp support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-12-27 at 13:51 +0100, Jerome Glisse wrote:
> I changed the name to proper one :) And masked
> the rev version, Darwin do so to even if it is unlikely
> that such revision have been used for production.

Good !

> thanx for your comments, will you push it too the kernel.
> (after testing) or doI  i have to send it elsewhere ? :)

Nah, I'll take care of it when I'm back from vacation.

> Anyway this is not a critical issue but if we manage to
> make the r300 chipset working (even only for 2d accel)
> than this could be usefull for users :)

Sure. There is still a pending issue though with AGP on the G5. The
problem is that we create a non-cacheable mapping for the RAM pages of
the AGP aperture (both in-kernel and for userland) while they already
have a cacheable mapping via the normal kernel linear mapping of main
memory.

The result is that there is a potential cache aliasing issue, aggravated
by the fact that the G5 is quite aggressive on pre-fetching and thuis,
may end up prefetching some of the AGP cache lines (via the linear
mapping) even if no actual access is ever done to these pages.

Unfortunately, if a collision occurs (a non-cacheable access to some
space that do exist in the cache at the same time), the result is
undefined, and is likely to result in a checkstop (the CPU just stops).

I really don't know of a simple remedy at this point. The problem is
partially due to the fact that we do the linear mapping using large
pages, so we can't simply undo the cacheable mapping for the pages that
ended up beeing allocated for AGP... An option would be to eventually
reserve the AGP memory early during boot and not include it in the
linear mapping at all. Another thing to test is that maybe U3 is smart
enough to snoop AGP accesses, and thus we could have the AGP mappings be
cacheable as well (though that may require some stronger synchronisation
directives in the DRM code).

Ben.
