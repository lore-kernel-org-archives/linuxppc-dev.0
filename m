Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A356B70BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2011 03:12:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [RFC PATCH 1/2] RapidIO: Add DMA Engine support for RIO data
 transfers
Date: Fri, 7 Oct 2011 09:12:11 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552022D6BC1@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <CABE8wwuB2HxpjWiOjASizL5L6LU2_AHhLZnAJyey__hh1jfX8Q@mail.gmail.com>
References: <1317418715-9666-1-git-send-email-alexandre.bounine@idt.com><1317492077.1573.1839.camel@vkoul-udesk3><0CE8B6BE3C4AD74AB97D9D29BD24E55202291E40@CORPEXCH1.na.ads.idt.com>
 <CABE8wwuB2HxpjWiOjASizL5L6LU2_AHhLZnAJyey__hh1jfX8Q@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan J Williams wrote:
>=20
> On Mon, Oct 3, 2011 at 9:52 AM, Bounine, Alexandre
> <Alexandre.Bounine@idt.com> wrote:
> >
> > My concern here is that other subsystems may use/request DMA_SLAVE
channel(s) as well
> > and wrongfully acquire one that belongs to RapidIO. In this case
separation with another
> > flag may have a sense - it is possible to have a system that uses
RapidIO
> > and other "traditional" DMA slave channel.
> >
> > This is why I put that proposed interface for discussion instead of
keeping everything
> > inside of RapidIO.
> > If you think that situation above will not happen I will be happy to
remove
> > that subsystem knowledge from dmaengine files.
>=20
> I don't think that situation will happen, even on the same arch I
> don't think DMA_SLAVE is ready to be enabled generically.  So you're
> probably safe here.

Thank you for confirmation. I will rely on DMA_SLAVE only as in my most
recent
version.=20
=20
> >
> > I agree, this is not a case of "pure" slave transfers but existing
DMA_SLAVE
> > interface fits well into the RapidIO operations.
> >
> > First, we have only one memory mapped location on the host side. We
transfer
> > data to/from location that is not mapped into memory on the same
side.
> >
> > Second, having ability to pass private target information allows me
to pass
> > information about remote target device on per-transfer basis.
>=20
> ...but there is no expectation that these engines will be generically
> useful to other subsytems.  To be clear you are just using dmaengine
> as a match making service for your dma providers to clients, right?

Not only that. As an example I am offering other defined DMA slave mode
callbacks
in tsi721_dma driver. I think that RapidIO specific DMA channels should
follow
unified DMA engine interface. I am expecting that other DMA defined
functions
to be used directly without RapidIO specifics. E.g. tx_submit, tx_status
and
issue_pending are implemented in tsi721_dma driver. Similar approach may
be
applied to fsl_dma driver which is capable to RapidIO data transfers on
platforms
with RapidIO interface.=20

> > ... skip ...
> > RapidIO network usually has more than one device attached to it and
> > single DMA channel may service data transfers to/from several
devices.
> > In this case device information should be passed on per-transfer
basis.
> >
>=20
> You could maybe do what async_tx does and just apply the extra context
> after the ->prep(), but before ->submit(), but it looks like that
> context is critical to setting up the operation.

Yes, it is possible to do but does not look as quite safe and effective
as passing all related parameters during single call. This would require
RIO DMA drivers to hold a "half cooked" descriptor chain until next
portion
of information arrives. This requires to have prep and post-configure
calls
coupled together by locks. In this situation prep with private data
looks
safer and more effective.   =20

> This looks pretty dangerous without knowing the other details.  What
> prevents another thread from changing dchan->private before the the
> prep routine reads it?

Yes, locking is needed in rio_dma_prep_slave_sg() around a call for prep
routine. After all internal descriptors are set dchan can be submitted
with new private content. =20

>=20
> DMA_SLAVE assumes a static relationship between dma device and
> slave-device, instead this rapid-io case is a per-operation slave
> context.  It sounds like you really do want a new dma operation type
> that is just an extra-parameter version of the current
> ->device_prep_slave_sg.  But now we're getting into to
> dma_transaction_type proliferation again.  This is probably more fuel
> for the fire of creating a structure transfer template that defines
> multiple possible operation types and clients just fill in the fields
> that they need, rather than adding new operation types for every
> possible permutation of copy operation (DMA_SLAVE, DMA_MEMCPY,
> DMA_CYCLIC, DMA_SG, DMA_INTERLEAVE, DMA_RAPIDIO), it's getting to be a
> bit much.

Exactly. I need an ability of passing private parameter to prep
function.
I chose to adopt DMA engine interface instead of adding one completely
internal to RapidIO because having one common API has much more sense.
Passing user defined data structure when building individual request
would
make not only my life easier but probably will help some other drivers
as well.  =20
=20
> As a starting point, since this the first driver proposal to have
> per-operation slave context and there are other rapid-io specific
> considerations, maybe it's ok to have a rio_dma_prep_slave_sg() that
> does something like:
>=20
> struct tsi721_bdma_chan *bdma_chan =3D to_tsi721_chan(dchan);
>=20
> bdma_chan->prep_sg(rext, sgl, sg_len, direction, flags);
>=20
> Thoughts?

This brings HW dependence into generic RapidIO layer.
I would like to see it as a generic interface that is available
to other RIO-capable devices (e.g Freescale's 85xx and QorIQ).

I would probably make  ->prep_sg callback part of rio_mport structure
(which holds dma_device). In this case HW will be well abstracted.
The only problem will be with registering with DMA engine but this can
be solved by providing a pointer to a stub routine.

Second option may be keeping rio_dma_prep_slave_sg() "as is" but with an
appropriate
locking as I mentioned above (maybe remove "slave" from its name to
reduce confusion).

Thank you,

Alex.
