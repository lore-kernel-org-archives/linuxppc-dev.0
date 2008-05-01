Return-Path: <kay.sievers@vrfy.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 3A986DDEC6
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 01:53:03 +1000 (EST)
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
From: Kay Sievers <kay.sievers@vrfy.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20080501100409.1b04fdb7@hyperion.delvare>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
	<1209395245.3666.9.camel@linux.site>
	<20080428174010.5a40c2c0@hyperion.delvare>
	<1209399377.3666.30.camel@linux.site>
	<20080501100409.1b04fdb7@hyperion.delvare>
Content-Type: text/plain; charset=utf-8
Date: Thu, 01 May 2008 17:51:29 +0200
Message-Id: <1209657089.20889.46.camel@linux.site>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-01 at 10:04 +0200, Jean Delvare wrote:
> On Mon, 28 Apr 2008 18:16:17 +0200, Kay Sievers wrote:
> > On Mon, 2008-04-28 at 17:40 +0200, Jean Delvare wrote:
> > > Why would i2c device modaliases ever contain multiple strings? A devi=
ce
> > > can't have multiple names, can it?
> >=20
> > Like ACPI/PNP devices, which can have several compat id's, which means
> > that a single device can have "multiple names":
> >   $ cat /sys/bus/pnp/devices/00:09/id
> >   IBM0057
> >   PNP0f13
>=20
> Ah, I didn't know about this. Now I'm curious how it can work. Does it
> mean that several drivers attempt to bind to this device?=20

=EF=BB=BFThey are usually all id's for the same type of device, and don't d=
escribe
multiple functions at the same time. In most cases the vendor id's, like
"IBM0057" here, do not match anything.

> > > Can't we just stop handle_moddevtable() from adding a tailing "*"
> > > automatically, and just let the device types which need it, add it on
> > > their own?
> >=20
> > For a lot subsystems it's fine to have it appended, as there is a
> > defined list of identifiers, which must appear in the same order, and
> > new identifiers are appended to the end. So the "*" still matches
> > modules with possibly extended modalias strings.
>=20
> I understand the logic, however I am skeptical how useful it is in
> practice. If we add an identifier to the device aliases, then we also
> update the corresponding modalias, so no in-tree driver can break. The
> only case where it makes a difference, as far as I can see, is for
> out-of-tree drivers. Am I correct?

=EF=BB=BFThat sounds correct, yes.

> On top of that, I doubt that we
> actually add new identifiers that frequently, do we?

Not that I know.

> > We would also need to review all buses which export modalias, if they
> > need the "*" or not, and add them by hand, if needed.
> >=20
> > I guess, it's easier to introduce an additional parameter to
> > file2alias::do_table() and suppress the trailing "*" for i2c?
>=20
> That's one possibility, but I had a slightly different approach, which
> is to just let the type-specific handlers add the trailing "*" by
> themselves if they need it. This allows for optimization in a few
> cases.
>=20
> Subject: modpost: i2c aliases need no trailing wildcard
>=20
> Not all device type aliases need a trailing wildcard, in particular
> the i2c aliases don't. Don't add a wildcard by default in do_table(),
> instead let each device type handler add it if needed.

...

> The patch only changes the i2c aliases, all the rest is the same as
> before (unless I messed up somewhere, that is.) Do you think this would
> be acceptable for upstream? If you think it's better to add a parameter
> to do_table() and let it add the "*" as it did so far, that's also fine
> with me, I can update the patch to do that.

Looks fine to me.

If the content of:
  /lib/modules/$(uname -r)/modules.alias
looks correct after the patch, this should go in, I think.

Thanks,
Kay
