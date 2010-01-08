Return-Path: <Hollis_Blanchard@mentor.com>
Subject: Re: "status" property checks
From: Hollis Blanchard <hollis_blanchard@mentor.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20100108234614.GB2661@yookeroo>
References: <1262905673.11702.16.camel@localhost.localdomain>
	<1262918143.2716.8.camel@ccs-laptop>
	<1262975655.31871.67.camel@localhost.localdomain>
	<4B478747.8070009@freescale.com>
	<1262979928.31871.81.camel@localhost.localdomain>
	<20100108234614.GB2661@yookeroo>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 15:58:40 -0800
Message-ID: <1262995120.31871.105.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Hunter Cobbs <hunter.cobbs@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-01-09 at 10:46 +1100, David Gibson wrote:
> On Fri, Jan 08, 2010 at 11:45:28AM -0800, Hollis Blanchard wrote:
> > On Fri, 2010-01-08 at 13:28 -0600, Scott Wood wrote:
> > > Hollis Blanchard wrote:
> > > > On Thu, 2010-01-07 at 20:35 -0600, Hunter Cobbs wrote:
> > > >> I think that is definitely a solution.  It does centralize the tes=
ting
> > > >> for this particular issue.  The only thing question I have is if i=
ts
> > > >> really better to have the upper level do the check.  Shouldn't the
> > > >> driver itself handle the hardware and device node status?
> > > >=20
> > > > Practically speaking, all drivers doing the checks today just retur=
n
> > > > -ENODEV. They don't try to do anything to "handle" the situation.
> > > >=20
> > > > The definition of the status property implies it's outside of softw=
are's
> > > > control, for example:
> > > >         "disabled"
> > > >         "Indicates that the device is not presently operational, bu=
t it
> > > >         might become operational in the future (for example, someth=
ing
> > > >         is not plugged in, or switched off)."
> > > >=20
> > > > If a device is "not operational" in this sense, I don't think there=
's
> > > > anything for a device driver to do.
> > >=20
> > > I could see situations where there is some software action that could=
=20
> > > enable the device (e.g. multiple devices sharing pins, where only one=
=20
> > > can be active at a time) -- but it's likely to not be the driver itse=
lf=20
> > > that knows how to do that.
> > >=20
> > > If the need arises, there could be a mechanism where the enabling ent=
ity=20
> > > can tell the platform bus that it has enabled a previously-disabled=20
> > > device, overriding the status in the device tree (and likewise if it=20
> > > wants take down a device that was previously enabled).
> >=20
> > OK, that makes sense to me. I'll put together a patch for the original
> > idea, and the enable/disable part can come later as needed.
>=20
> Sounds good to me to.  Only thing I'd add, is that I'd also suggest a
> helper function to do an explicit check on the status property (or do
> we have that already?).  This could be useful for drivers which are
> bound primarily to one device tree node, but also need to (possibly
> optionally) check/use some other node.

of_device_is_available() exists and is used already, so I think we're OK
there.

--=20
Hollis Blanchard
Mentor Graphics, Embedded Systems Division
