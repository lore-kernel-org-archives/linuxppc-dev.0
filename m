Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 3E4C1B7D24
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 23:58:09 +1000 (EST)
Received: by pwj6 with SMTP id 6so1874409pwj.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:58:08 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <u2xed82fe3e1004280635vaeb792d2xf86996cac299ba2b@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
	<u2xed82fe3e1004280635vaeb792d2xf86996cac299ba2b@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Apr 2010 07:57:47 -0600
Message-ID: <j2zfa686aa41004280657g49db18d9g563e643e16ca64e9@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Timur Tabi <timur@freescale.com>
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

On Wed, Apr 28, 2010 at 7:35 AM, Timur Tabi <timur@freescale.com> wrote:
> On Wed, Apr 28, 2010 at 12:37 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>
>> Why not? =A0Just have the ssi driver probe routine register the fabric
>> device based on the existence of the codec-handle property. =A0It is the
>> best way to go about things with the data that you've got available,
>> and it is no big deal. =A0The relevant fabric driver can then bind
>> against that. =A0You should probably also stuff the ssi device node
>> pointer into the fabric device of_node pointer.
>
> And then where do I put the board-specific initialization code that's
> currently in the fabric driver? =A0The programming information for that
> initialization is not in the device tree.

In the fabric driver; where it is right now.  I'm saying *instantiate*
the device when the ssi driver gets probed.  Use the top level board
name when assigning the name so that the correct asoc machine driver
gets bound to it.

> It sounds to me like you're saying I should take all the code from the
> fabric driver and shove it into the SSI driver, just so that I can
> avoid instantiating a platform driver.

Nope.

> Keep in mind that asoc likes to have a different struct device for the
> fabric driver and the SSI nodes, so I would need to manually create a
> struct device for the fabric device anyway.

You can do it this way too, but this is not what I'm saying.

>> Linux struct device registrations are cheap, and every struct device
>> has a device_node pointer available. =A0It is totally fine to have both
>> the ssi device and the fabric device point to the same device node if
>> that helps solve your problem of finding references to the right
>> things in each driver. =A0(Just as long as only one of them is an
>> of_platform driver).
>
> But I already have it set up like that. =A0The SSI driver is an OF
> driver, and the fabric driver is a platform driver. =A0I might be able
> to move some code from the fabric driver into the SSI driver to make
> it the fabric driver less obnoxious about scanning the device tree.

I'm just saying move the registration of the machine device out of
arch/powerpc platform code and into the ssi driver.  Then you've got a
reasonable place to pass shared data (either the ssi device node or
device instance or name.  Whatever you need) to the machine driver.

g.
