Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.mainstreet.net (mxout.mainstreet.net [207.5.0.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD2E2B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 07:20:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/7] RapidIO: Add Port-Write handling for EM
Date: Fri, 26 Feb 2010 12:20:30 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552A553AA@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4B86E572.6090101@neli.hopto.org>
References: <20100224152401.GC13661@kaneng01.tundra.com>
	<4B85894A.6040406@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552A5508A@CORPEXCH1.na.ads.idt.com>
	<4B86E572.6090101@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: Alexandre Bounine <alexb@tundra.com>, linux-kernel@vger.kernel.org,
	thomas.moll@sysgo.com, linuxppc-dev@lists.ozlabs.org,
	thomas.moll.ext@nsn.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
> Bounine, Alexandre wrote:
> > Micha Nelissen wrote:
> >> Alexandre Bounine wrote:
> >>>  /**
> >>> + * rio_em_set_ops- Sets Error Managment operations for a
particular
> > vendor switch
> >>> + * @rdev: RIO device
> >>> + *
> >>> + * Searches the RIO EM ops table for known switch types. If the
vid
> >>> + * and did match a switch table entry, then set the em_init() and
> >>> + * em_handle() ops to the table entry values.
> >> Shouldn't any RIO device be able to support error management, not
just
> >> switches?
> >
> > Only if a device reports this capability by having Error Management
> > Extended Features block.
> > Ideally, we have to provide default handler for every such device (I
am
> > planning it for some future updates). It should be the same as for
> > routing operations - if the standard feature exists, it has to be
used
> > unless something else takes over.
>=20
> Yes, therefore I thought that: or the EM_OPS are per driver, or they
can
> be integrated in the switch hooks list.

Or combination of both methods as I implemented it. I want to have it
flexible enough to be adopted to further development of RapidIO
ecosystem.  =20
=20
> > For now I keep all port-write messages from end-points serviced by
their
> > individual drivers. One of reasons for this: the EM PW message
format
>=20
> Maybe have a generic rio function that can be called by any driver
that
> knows a particular port-write was due to error management causes? This
> function would read the standard defined EF block registers. Then the
> driver part can be quite small.

I think this echoes what I mentioned above as default handler.

>=20
> >>> +	if (port->ops->pwenable)
> >>> +		port->ops->pwenable(port, enable);
> >>> +}
> >>> +
> >> Maybe this can be done by switch->init function?
> >
> > This is not per-switch function. This function enables mport to
receive
> > incoming PW messages. Per-switch PW enable is done in switch->init
as
> > for Tsi57x.
>=20
> Oops, I meant this comment for the em_init function call.
>=20
> >>> +			rio_mport_write_config_32(mport, destid,
> > hopcount,
> >>> +				rdev->phys_efptr +
> >>> +					RIO_PORT_N_ACK_STS_CSR(portnum),
> >>> +				RIO_PORT_N_ACK_CLEAR);
> >> This doesn't work for the 568; but the 568 has no special handling?
> >
> > Tsi568 will not send EM PW message. Tsi568 PWs are disabled in its
> > em_init().
>=20
> Why?

Because Tsi568 requires special handling which is not implemented
(yet?).=20
 =20
>=20
> >>> +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI578,
tsi57x_em_init,
> > tsi57x_em_handler);
> >> Why not declare these along with the other ops?
> >
> > Because the EM extensions is a separate capability. It is not
guaranteed
> > to be in every switch.
>=20
> They might initialize them with NULL to indicate they don't support
it?

My preference is to keep unrelated capabilities separately. Otherwise,
these long ops lists may become unmanageable later when new extensions
will be added into RIO spec.

Cheers,

Alex.
