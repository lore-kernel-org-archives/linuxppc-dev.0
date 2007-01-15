Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 64022DDE3D
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 00:49:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1297746ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 05:48:59 -0800 (PST)
Message-ID: <528646bc0701150548q1f9eac36u248326276465090d@mail.gmail.com>
Date: Mon, 15 Jan 2007 06:48:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: Discussion on SOC device tree bindings
In-Reply-To: <20070115110509.GA25974@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<528646bc0701141429q577f87f1oe65aa7033c09b62b@mail.gmail.com>
	<20070115110509.GA25974@localhost.localdomain>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/15/07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi,
>
> On Sun, Jan 14, 2007 at 03:29:24PM -0700, Grant Likely wrote:
> > >
> > > So, the following changes are proposed:
> > > 1. "mpc52xx-*" items will be dropped from the compatible property
> > > because they are premature.  Unless the 5200B device is incompatible
> > > with the 5200, then the 5200B will specify "mpc5200b-*\0mpc5200-*".
> > > (strong recommendation, but not required; if a 5200b board just has
> > > "mpc5200-*", in most cases it won't cause breakage).
>
> How about always specifying the exact name and only the exact name
> in the device tree, i.e. mpc5200-fec on mpc5200, mpc5200b-fec on
> mpc5200b and so on. This way the driver can decide whether or not it's
> compatible to a device and we can be sure not to overlook any
> incompatibilities. We could even decide in later kernel versions that
> two devices are too incompatible and split the driver into two.

That's the point I started from, but if you go down that path it still
doesn't provide the right amount of information.  What if one silicon
version of the 5200b has a problem?  For that kind of stuff we need to
know the exact version of the chip.

The compatible property has a different purpose.  It's purpose is to
describe the interfaces; not the implementations of the interface.  It
is a list from most compatible to least compatible.  So, assuming no
silicon bugs, a chip down the road with the same device on it gets
it's devices supported 'for free' on systems that already support the
5200.  No code changes.  It also means the kernel doesn't have to
maintain the compatibility tables.

If there are too drivers (ie. mpc5200-psc-ac97 and mpc5200b-psc-ac97),
then the most compatible driver should match first.

If there *are* as-yet-unknown silicon bugs; it's a different matter,
but the addition of the model/revision properties on the soc node
gives the OS enough info to enable/disable workarounds.

>
> > > 2. known quirks/extra features will be reported with additional
> > > properties to the device.  ie. gpt0 will add a 'has-wdt' empty
> > > property
> > > 3. an /soc5200/model property will be added for last resort
> > > determination of chip version (The soc5200 node is called 'builtin' on
> > > the efika)
> > > 4. most of the 5200 drivers will be changed to bind on 5200-* instead
> > > of 52xx-*.  Drivers will not bind on 5200b-* unless truly incompatible
> > > with the 5200.
>
> There may be incompatibilities between 5200 and 5200b which we simply did
> not discover yet.

of course, but the driver should have enough info to make good
decisions about when to enable/disable them.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
