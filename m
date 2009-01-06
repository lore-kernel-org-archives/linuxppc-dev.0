Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: The usage of compatible 'simple-bus'
Date: Tue, 6 Jan 2009 13:46:21 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED0B38C9@zch01exm26.fsl.freescale.net>
In-Reply-To: <20090106014323.GB29456@yookeroo.seuss>
References: <3A45394FD742FA419B760BB8D398F9ED0B37E7@zch01exm26.fsl.freescale.net><20090105192053.GB23766@ld0162-tx32.am.freescale.net>
	<20090106014323.GB29456@yookeroo.seuss>
From: "Li Yang" <LeoLi@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> devicetree-discuss-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:devicetree-discuss-bounces+leoli=3Dfreescale.com@ozlabs.
> org] On Behalf Of David Gibson
> Sent: Tuesday, January 06, 2009 9:43 AM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@ozlabs.org; Li Yang-R58472;=20
> devicetree-discuss@ozlabs.org
> Subject: Re: The usage of compatible 'simple-bus'
>=20
> On Mon, Jan 05, 2009 at 01:20:53PM -0600, Scott Wood wrote:
> > On Mon, Jan 05, 2009 at 06:27:39PM +0800, Li Yang wrote:
> > > I got an assumption from the existing device trees that having=20
> > > 'simple-bus' in the compatible property of a node means that all=20
> > > child nodes should be added as of_platform_device in platform=20
> > > initialization phase.  No matter it represents a bus in=20
> common sense=20
> > > or not.  Is this truly the case?
> >=20
> > Yes, simple-bus indicates that the children can be driven=20
> standalone=20
> > from any knowledge of the parent bus.
>=20
> Erm, well, sort of.  Strictly it indicates that the only way=20
> to locate the child devices of this bus is by using the=20
> address information in the device tree - there's no way to=20
> dynamically probe the bus.

So if I understand correctly, "simple-bus" is intended to be used for
true buses.

>=20
> The fact that this causes of_platform_devices to be=20
> instantiated is a Linux implementation specific detail (and=20
> one we might change in future).

Here we have a common case for SoC that part of a device has its
separate driver besides the driver for the main feature of the whole
device.  The resources used by the sub-device is usually part of the
resources of the parent device.  So it makes sense to put the node of
sub-device beneathe the node of main device.  Shall we have a convention
to mark such devices in device tree so that the sub-device can be
scanned and probed as a standalone of_platform_device?

If "simple-bus" may cause confusion to do this job as it's not a bus
actually, I propose to use "has-subdevice".

- Leo
