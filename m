Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Matt Porter" <porter@cox.net>
Cc: "Pantelis Antoniou" <panto@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
Date: Fri, 6 Dec 2002 19:15:15 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLOEJHFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021206113007.B18257@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> On Fri, Dec 06, 2002 at 05:08:22PM +0100, Joakim Tjernlund wrote:
> > >
> > > On Fri, Dec 06, 2002 at 03:25:48PM +0100, Joakim Tjernlund wrote:
> > > > If you implement the performance improvement I suggested earlier, I don't think
> > > > you need them. Another thing with consistent_xxx() is that you can not use
> > > > __pa() and __va() on addresses returned by the consistent_alloc et. al.
> > >
> > > Um, well if you are doing a consistent_alloc() then surely you are
> > > keeping the dma_handle around which is your physical address.  If you
> > > want the kernel virtual address then you can apply __va to that.  So,
> > > you have the cache inhibited mapping in vmalloc space returned to you,
> > > the physical address provided in dma_handle, and a kernel virtual address
> > > that can be trivially generated.
> >
> > m8xx_cpm_hostalloc() does not keep the DMA handle and __pa() does not work
> > on addresses returned by m8xx_cpm_hostalloc(). I just found that out the
> > hard way when upgrading from MV 2.4.2 to linuxppc_2_4_devel 2.4.20. My SPI driver
>
> that's a problem with m8xx_cpm_hostalloc() (or how you are using it) if
> it doesn't keep around the values you need.
>

Yes and no, someone changed the m8xx_cpm_hostalloc() implementation and now
it does not behave as it used to. Earlier both __pa(adr) and __va(__pa(adr))
worked on addresses returned by m8xx_cpm_hostalloc().

I think in it's current form it's useless and should either be changed back to what
it was or die.

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
