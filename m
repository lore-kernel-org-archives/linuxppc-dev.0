Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 952FCB6FAC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2011 18:23:03 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 17015-02 for <linuxppc-dev@ozlabs.org>;
	Tue, 24 May 2011 09:16:14 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PCI DMA to user mem on mpc83xx
Date: Tue, 24 May 2011 09:15:03 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD4B@saturn3.aculab.com>
In-Reply-To: <4DDA2509.6070702@matrix-vision.de>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Andre Schwarz" <andre.schwarz@matrix-vision.de>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> we have a pretty old PCI device driver here that needs some
> basic rework running on 2.6.27 on several MPC83xx.
> It's a simple char-device with "give me some data" implemented
> using read() resulting in zero-copy DMA to user mem.
>=20
> There's get_user_pages() working under the hood along with=20
> SetPageDirty() and page_cache_release().

Does that dma use the userspace virtual address, or the
physical address - or are you remapping the user memory into
kernel address space.

If the memory is remapped into the kernel address space, the
cost of the mmu and tlb operations (especially on MP systems)
is such that a dma to kernel memory followed by copyout/copytouser
may well be faster!

That may even be the case even if the dma is writing to the
user virtual (or physical) addresses when it is only
necessary to ensure the memory page is resident and that
the caches are coherent.

In any case the second copy is probably far faster than the
PCI one!

I've recently written driver that supports a pread/pwrite interface
to the memory windows on a PCIe card. It was important to use
dma for the PCIe transfers (to get a sensible transfer size).
I overlapped the copyin/copyout with the next dma transfer.
The dma's are fast enough that it is worth spinning waiting
for completion - but slow enough to make the overlapped
operation worthwhile (same speed as a single word pio transfer).

	David
