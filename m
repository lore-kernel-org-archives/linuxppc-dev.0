Date: Tue, 15 Jul 2003 09:17:32 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Message-ID: <20030715091731.C6208@home.com>
References: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>; from ebs@ebshome.net on Mon, Jul 14, 2003 at 09:32:07PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 14, 2003 at 09:32:07PM -0700, Eugene Surovegin wrote:
>
> Hi!
>
> I think this is a known problem.
>
> There are drivers or even subsystems which use stack allocated DMA buffers.
> To make things worse, those buffers usually non L1 cache line aligned
> (start and/or end).
>
> When they use pci_map_* with PCI_DMA_FROMDEVICE, consistent_sync calls
> invalidate_dcache_range for the buffer.
>
> invalidate_dcache_range works in L1_CACHE_LINE chunks, so if start and/or
> end of the buffer are not aligned we may corrupt data located in the same
> cache line (usually stack variable(s) declared before or after buffer
> declaration).
>
> According to MV kernel, there are USB devices that use such buffers.

Well, the USB subsystem itself in 2.4 has stack DMA buffers completely
intertwined, yes.  Fixing it in the USB stack was nontrivial enough
to force it to their 2.5/2.6 code.

> After spending last weekend with RISCWatch :) I can say that SCSI subsystem
> is also guilty of this behavior (drivers/scsi/scsi_scan.c::scan_scsis,
> scsi_result0).

I went through the SCSI subsystem a while back and found a few including
that one too. :)  These should be passed up since they are clear
violations of the DMA API.  I dropped that task since (as you know)
there are other issues with using SCSI drivers on "non-coherents" at
the moment.

> Unfortunately, I don't know how many similar places of code are still
> waiting to be found :(.

<snip>

> Comments/suggestions are welcome!

I'll agree that it's a better hack, but since the offending areas in
the SCSI subsystem are easily located, it seems wiser to fix upstream.
Just my US 2 cents.

We still need someone with interest AND time to properly fix the
consistent alloc from irq issue. :)  All of the patches post to date
are incomplete bandaids.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
