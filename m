Message-ID: <003c01c29def$9b3d5df0$0300a8c0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Paul Mackerras" <paulus@au1.ibm.com>
Cc: "Matt Porter" <porter@cox.net>,
	"Pantelis Antoniou" <panto@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20021206085909.B17918@home.com><IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se> <15857.15826.513311.884408@argo.ozlabs.ibm.com>
Subject: Re: Regarding consistent_alloc
Date: Sat, 7 Dec 2002 13:53:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > m8xx_cpm_hostalloc() does not keep the DMA handle and __pa() does not work
> > on addresses returned by m8xx_cpm_hostalloc(). I just found that out the
> > hard way when upgrading from MV 2.4.2 to linuxppc_2_4_devel 2.4.20. My SPI driver
> > hung as soon you tried to read something.
>
> Then m8xx_cpm_hostalloc should be changed so it returns the DMA
> address along with the virtual address (of the uncached mapping).
>
> An alternative which will work, at least at present, is to use iopa()
> on the virtual address.  However, that assumes that DMA bus addresses
> are identical to CPU physical addresses.  That is true at the moment
> on all embedded PPC platforms that I know of currently, but there is
> no guarantee that it will always be true.  That is why I think it is
> better to make a practice of saving the DMA address that you get back
> from consistent_alloc and using that.

Is consistent_alloc really needed? All uses I have seen in the kernel for the 8xx CPU can be solved with
a kmalloc(or a static char buffer) and a invalidate_dcache_range call(flush_dcache_range if the buffer isn't cache line aligned).
This usally eliminates a memcpy() from uncached memory. See the 8xx_io/enet.c patch I sent to
this list a few weeks ago. One guy converted that patch to the 8260 FEC and had a 20% increase in performace
for big packets in his router.

    Jocke

PS.
     I still think the 'sync' instruction in invalidate_dcache_range is unneed. I have been running my system
     without it for a few weeks now and it still works as it should.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
