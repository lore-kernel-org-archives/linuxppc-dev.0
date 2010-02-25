Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.mainstreet.net (mxout.mainstreet.net [207.5.0.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B828B7B98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 01:53:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/7] RapidIO: Add switch locking during discovery
Date: Thu, 25 Feb 2010 06:53:04 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552A54EA1@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4B857A53.30106@neli.hopto.org>
References: <20100224152050.GB13661@kaneng01.tundra.com>
	<4B857A53.30106@neli.hopto.org>
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
> > +				/* Attempt to acquire device lock */
> > +				rio_mport_write_config_32(port, destid,
> > +							  hopcount,
> > +
RIO_HOST_DID_LOCK_CSR,
> > +
port->host_deviceid);
> > +				rio_mport_read_config_32(port, destid,
hopcount,
> > +					RIO_HOST_DID_LOCK_CSR, &result);
> > +				while (result !=3D port->host_deviceid) {
>=20
> It's better to abstract the locking of a device into a new function,
> rio_lock_device / rio_unlock_device.
>=20
> Then you can use those in rio_get_route_entry and rio_add_route_entry.

Agree. Plus, adding a "lock" parameter to
rio_get_route_entry/rio_add_route_entry to avoid excessive locking
requests when scanning entire table. I will do it in next version or as
additional patch: I have to address locking anyway for future changes.
   =20
>=20
> > @@ -1027,6 +1090,13 @@ int __devinit rio_disc_mport(struct rio_
> > +
> > +		/* Read DestID assigned by enumerator */
> > +		rio_local_read_config_32(mport, RIO_DID_CSR,
> > +					 &mport->host_deviceid);
> > +		mport->host_deviceid =3D RIO_GET_DID(mport->sys_size,
> > +
mport->host_deviceid);
> > +
>=20
> This fixes something else, should be a separate patch.

This sets an ID used for locking during discovery. On a startup only
enumerator's ID is set to the specified value. All discovering agents
have this ID set to -1. After enumeration is completed it is safe to
initialize host_deviceid for agents as well.

Alex.
