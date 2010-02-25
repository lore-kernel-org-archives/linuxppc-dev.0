Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.mainstreet.net (mxout.mainstreet.net [207.5.0.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26F09B7CE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 07:30:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/7] RapidIO: Add Port-Write handling for EM
Date: Thu, 25 Feb 2010 12:30:21 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552A5508A@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4B85894A.6040406@neli.hopto.org>
References: <20100224152401.GC13661@kaneng01.tundra.com>
	<4B85894A.6040406@neli.hopto.org>
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
>=20
> Alexandre Bounine wrote:
> >  /**
> > + * rio_em_set_ops- Sets Error Managment operations for a particular
vendor switch
> > + * @rdev: RIO device
> > + *
> > + * Searches the RIO EM ops table for known switch types. If the vid
> > + * and did match a switch table entry, then set the em_init() and
> > + * em_handle() ops to the table entry values.
>=20
> Shouldn't any RIO device be able to support error management, not just
> switches?

Only if a device reports this capability by having Error Management
Extended Features block.
Ideally, we have to provide default handler for every such device (I am
planning it for some future updates). It should be the same as for
routing operations - if the standard feature exists, it has to be used
unless something else takes over.

For now I keep all port-write messages from end-points serviced by their
individual drivers. One of reasons for this: the EM PW message format
definitions lacks any hint that allows to identify type of the message.
In theory endpoints may send port-writes of any format (up to max size
of 64 bytes), what makes unifying handling of endpoints more difficult
(at least at this stage of SRIO evolution).    =20
=20
> > +/**
> > + * rio_pw_enable - Enables/disables port-write handling by a master
port
> > + * @port: Master port associated with port-write handling
> > + * @enable:  1=3Denable,  0=3Ddisable
> > + */
> > +static void rio_pw_enable(struct rio_mport *port, int enable)
> > +{
> > +	if (port->ops->pwenable)
> > +		port->ops->pwenable(port, enable);
> > +}
> > +
>=20
> Maybe this can be done by switch->init function?

This is not per-switch function. This function enables mport to receive
incoming PW messages. Per-switch PW enable is done in switch->init as
for Tsi57x.=20

>=20
> > +/**
> > + * rio_inb_pwrite_handler - process inbound port-write message
> > + * @pw_msg: pointer to inbound port-write message
> > + *
> > + * Processes an inbound port-write message. Returns 0 if the
request
> > + * has been satisfied.
> > + */
> > +int rio_inb_pwrite_handler(u32 *pw_msg)
> > +{
>=20
> Perhaps map this pw_msg to a struct? Or read it into named variables?

Agree - this is not nice. The best way may be defining it as a union
which combines different message formats (EM at this point) and raw
array. Will change for next update.

>=20
> > +	/* Clear Port Errors */
> > +	rio_mport_write_config_32(mport, destid, hopcount,
> > +			rdev->phys_efptr +
RIO_PORT_N_ERR_STS_CSR(portnum),
> > +			err_status & 0x07120204);
>=20
> Hardcoded value!

Agree. Tagged for next drop.

>=20
> > +
> > +	if (rdev->rswitch->port_ok & (1 << portnum)) {
> > +		if (err_status & RIO_PORT_N_ERR_STS_PORT_UNINIT) {
> > +			rdev->rswitch->port_ok &=3D ~(1 << portnum);
> > +			rio_mport_read_config_32(mport, destid,
hopcount,
> > +				rdev->phys_efptr +
RIO_PORT_N_CTL_CSR(portnum),
> > +				&regval);
> > +			rio_mport_write_config_32(mport, destid,
hopcount,
> > +				rdev->phys_efptr +
RIO_PORT_N_CTL_CSR(portnum),
> > +				regval | RIO_PORT_N_CTL_LOCKOUT);
>=20
> You have a function for this?

Yes, I do. Will be fixed for the next drop.

>=20
> > +			rio_mport_write_config_32(mport, destid,
hopcount,
> > +				rdev->phys_efptr +
> > +					RIO_PORT_N_ACK_STS_CSR(portnum),
> > +				RIO_PORT_N_ACK_CLEAR);
>=20
> This doesn't work for the 568; but the 568 has no special handling?

Tsi568 will not send EM PW message. Tsi568 PWs are disabled in its
em_init().

>=20
> > +	/* Clear Port-Write Pending bit */
> > +	rio_mport_write_config_32(mport, destid, hopcount,
> > +			rdev->phys_efptr +
RIO_PORT_N_ERR_STS_CSR(portnum),
> > +			RIO_PORT_N_ERR_STS_PW_PEND);
> > +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI572, tsi57x_em_init,
tsi57x_em_handler);
> > +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI574, tsi57x_em_init,
tsi57x_em_handler);
> > +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI577, tsi57x_em_init,
tsi57x_em_handler);
> > +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI578, tsi57x_em_init,
tsi57x_em_handler);
>=20
> Why not declare these along with the other ops?

Because the EM extensions is a separate capability. It is not guaranteed
to be in every switch.

Alex.
