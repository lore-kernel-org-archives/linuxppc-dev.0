Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Matt Porter" <porter@cox.net>
Cc: "Pantelis Antoniou" <panto@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
Date: Fri, 6 Dec 2002 17:08:22 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021206085909.B17918@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> On Fri, Dec 06, 2002 at 03:25:48PM +0100, Joakim Tjernlund wrote:
> > If you implement the performance improvement I suggested earlier, I don't think
> > you need them. Another thing with consistent_xxx() is that you can not use
> > __pa() and __va() on addresses returned by the consistent_alloc et. al.
>
> Um, well if you are doing a consistent_alloc() then surely you are
> keeping the dma_handle around which is your physical address.  If you
> want the kernel virtual address then you can apply __va to that.  So,
> you have the cache inhibited mapping in vmalloc space returned to you,
> the physical address provided in dma_handle, and a kernel virtual address
> that can be trivially generated.

m8xx_cpm_hostalloc() does not keep the DMA handle and __pa() does not work
on addresses returned by m8xx_cpm_hostalloc(). I just found that out the
hard way when upgrading from MV 2.4.2 to linuxppc_2_4_devel 2.4.20. My SPI driver
hung as soon you tried to read something.

Not sure about __va() but there is a comment in 8xx_io/enet.c that it does not work
anymore.

Perhaps this is so only for early calls to consistent_alloc(during the init phase)?

  Jocke

>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
