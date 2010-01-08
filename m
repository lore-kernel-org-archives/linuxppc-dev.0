Return-Path: <Hollis_Blanchard@mentor.com>
Subject: Re: "status" property checks
From: Hollis Blanchard <hollis_blanchard@mentor.com>
To: Hunter Cobbs <hunter.cobbs@gmail.com>
In-Reply-To: <1262918143.2716.8.camel@ccs-laptop>
References: <1262905673.11702.16.camel@localhost.localdomain>
	<1262918143.2716.8.camel@ccs-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 10:34:15 -0800
Message-ID: <1262975655.31871.67.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-07 at 20:35 -0600, Hunter Cobbs wrote:
> I think that is definitely a solution.  It does centralize the testing
> for this particular issue.  The only thing question I have is if its
> really better to have the upper level do the check.  Shouldn't the
> driver itself handle the hardware and device node status?

Practically speaking, all drivers doing the checks today just return
-ENODEV. They don't try to do anything to "handle" the situation.

The definition of the status property implies it's outside of software's
control, for example:
        "disabled"
        "Indicates that the device is not presently operational, but it
        might become operational in the future (for example, something
        is not plugged in, or switched off)."

If a device is "not operational" in this sense, I don't think there's
anything for a device driver to do.

--=20
Hollis Blanchard
Mentor Graphics, Embedded Systems Division




> On Thu, 2010-01-07 at 15:07 -0800, Hollis Blanchard wrote:
> > Right now, a number of drivers honor the "status" property on device
> > nodes (via of_device_is_available() checks), but it's open-coded in eac=
h
> > driver. I'm thinking of "hiding" arbitrary devices from the kernel, and
> > setting this property seems like the best approach, but at the moment
> > that would require modifying all OF drivers to check for it.
> >=20
> > Wouldn't the better approach be to have of_platform_device_probe()
> > itself do the check, and not call the driver's probe() routine if the
> > device isn't available?
> >=20
>=20
>=20
