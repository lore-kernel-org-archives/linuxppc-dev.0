Date: Mon, 22 Sep 2003 09:59:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
Message-ID: <20030922095952.A31727@home.com>
References: <Pine.LNX.4.44.0309221006580.30267-100000@spider.ancor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0309221006580.30267-100000@spider.ancor.com>; from Bret.Indrelee@qlogic.com on Mon, Sep 22, 2003 at 10:13:26AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 22, 2003 at 10:13:26AM -0500, Bret Indrelee wrote:
>
> Are there alignment restrictions on the address boundry your can
> start a DMA with when using the pci_map_single() / pci_unmap_single()
> calls?
>
> For some reason, I thought they had to be cache line aligned, but when
> I went back through the documentation I couldn't find any such
> restriction.

cache line alignment is an unwritten requirement that hasn't yet been
addressed in DMA-mapping.txt.  Unfortunately, kmalloc() doesn't
guarantee this so it's necessary to overallocate and align.
You can use L1_CACHE_BYTES for this.

Roland Dreier had a patch which added a little helper for this
stuff as well as docs.  Unfortunately, it's been dropped on the
floor until somebody with interest and time in non-coherent
platforms picks it up. http://lwn.net/Articles/2482/

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
