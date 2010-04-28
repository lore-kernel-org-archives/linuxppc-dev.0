Return-Path: <timur.tabi@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 5A764B7D17
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 23:36:03 +1000 (EST)
Received: by pvc22 with SMTP id 22so52283pvc.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:36:02 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 28 Apr 2010 08:35:30 -0500
Message-ID: <u2xed82fe3e1004280635vaeb792d2xf86996cac299ba2b@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 12:37 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:

> Why not? =A0Just have the ssi driver probe routine register the fabric
> device based on the existence of the codec-handle property. =A0It is the
> best way to go about things with the data that you've got available,
> and it is no big deal. =A0The relevant fabric driver can then bind
> against that. =A0You should probably also stuff the ssi device node
> pointer into the fabric device of_node pointer.

And then where do I put the board-specific initialization code that's
currently in the fabric driver?  The programming information for that
initialization is not in the device tree.

It sounds to me like you're saying I should take all the code from the
fabric driver and shove it into the SSI driver, just so that I can
avoid instantiating a platform driver.

Keep in mind that asoc likes to have a different struct device for the
fabric driver and the SSI nodes, so I would need to manually create a
struct device for the fabric device anyway.

>> I don't know when I would ever do this. =A0The two SSI devices are compl=
etely independent. =A0Why would I bind them together into one "device"?
>
> If there is no use case for binding them together, then you're right.
> The current binding is probably just fine. =A0I cannot comment on
> whether or not it will be used that way by platform designers.

Although the 8610 has two SSI devices, the reference board we ship
only has one wired up.  I have a prototype board in the lab that has
both wired up, but even then, I don't think I can get the two SSIs
synchronized in any meaningful fashion.  Mark suggested a technique,
but even if I could get that to work, the driver code would need to be
rewritten to handle two SSI devices in concert.  In short, it might be
theoretically possible, but I'm not going to try to make it work.

> Linux struct device registrations are cheap, and every struct device
> has a device_node pointer available. =A0It is totally fine to have both
> the ssi device and the fabric device point to the same device node if
> that helps solve your problem of finding references to the right
> things in each driver. =A0(Just as long as only one of them is an
> of_platform driver).

But I already have it set up like that.  The SSI driver is an OF
driver, and the fabric driver is a platform driver.  I might be able
to move some code from the fabric driver into the SSI driver to make
it the fabric driver less obnoxious about scanning the device tree.

--=20
Timur Tabi
Linux kernel developer at Freescale
