From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15857.15826.513311.884408@argo.ozlabs.ibm.com>
Date: Sat, 7 Dec 2002 11:16:18 +1100
To: <joakim.tjernlund@lumentis.se>
Cc: "Matt Porter" <porter@cox.net>,
	"Pantelis Antoniou" <panto@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
In-Reply-To: <IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se>
References: <20021206085909.B17918@home.com>
	<IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> m8xx_cpm_hostalloc() does not keep the DMA handle and __pa() does not work
> on addresses returned by m8xx_cpm_hostalloc(). I just found that out the
> hard way when upgrading from MV 2.4.2 to linuxppc_2_4_devel 2.4.20. My SPI driver
> hung as soon you tried to read something.

Then m8xx_cpm_hostalloc should be changed so it returns the DMA
address along with the virtual address (of the uncached mapping).

An alternative which will work, at least at present, is to use iopa()
on the virtual address.  However, that assumes that DMA bus addresses
are identical to CPU physical addresses.  That is true at the moment
on all embedded PPC platforms that I know of currently, but there is
no guarantee that it will always be true.  That is why I think it is
better to make a practice of saving the DMA address that you get back
from consistent_alloc and using that.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
