From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <dri-devel@lists.sourceforge.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: UniNorth AGP: Some success
Date: Tue, 14 Aug 2001 15:38:18 +0200
Message-Id: <20010814133818.31081@smtp.adsl.oleane.com>
In-Reply-To: <20010814090523.21635@smtp.adsl.oleane.com>
References: <20010814090523.21635@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I've made some progress. It sort of works, but dies after a few
seconds. Here are the details:

 - Machine is a PowerBook "Pismo" with a rev. of UniNorth that can do x2
AGP only and no fast write (it does SBA fortunately). I use the alpha
nopage() code for userland mappings and a home made ioremap_agp() for in-
kernel mappings. Everything is mapped uncached, which is a performance
hit on PPC, I'll have to see how I can make things cachable by adding the
proper flush routines all over the place. X is 4.1 from top of 4.1 branch
in XFree CVS, DRM is hacked from the 2.4.8 kernel version.

 - glxgears display is sorta broken (but that happened with PCI GART as
well, so I beleive it's a problem with the GL driver vs. the Rage M3
(r128 mobility).

 - It's a bit slower than PCI GART (about 430 fps in gears, but it's not
stable, while PCI GART gives me a stable 474 fps). This may be partially
do to the fact that we have all the AGP memory uncachable, I think that
will prevent the PPC from doing write-combining.

 - After running for a few seconds with any GL app (I tried glxgears and
tuxracer), X dies with the message "drmR128SwapBuffers: return = -16". In
dmesg, I also have a bunch of:
[drm:r128_cce_vertex] *ERROR* ring space check failed!
[drm:r128_cce_vertex] *ERROR* ring space check failed!
[drm:r128_cce_vertex] *ERROR* ring space check failed!
[drm:r128_cce_vertex] *ERROR* ring space check failed!
[drm:r128_cce_vertex] *ERROR* ring space check failed!
etc... and one
[drm:r128_cce_swap] *ERROR* ring space check failed!

It seems to stop at this point.

Any clue what's up here ? I beleive I will have better perfs with more
recent Apple machines that can do x4 AGP and support fast write. Also,
the rage M3 is not a very fast chip anyway...

For those interested, the hacked code is available in my rsync kernel
tree at penguinppc.org::linux-2.4-benh

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
