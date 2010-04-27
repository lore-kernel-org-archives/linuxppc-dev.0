Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 9644FB7D24
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:24:55 +1000 (EST)
Received: by pvg6 with SMTP id 6so1837761pvg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:24:54 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272355624.3204.52.camel@odin>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 14:24:34 -0600
Message-ID: <g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Liam Girdwood <lrg@slimlogic.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 2:07 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Tue, 2010-04-27 at 16:36 +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2010-04-26 at 15:49 -0500, Timur Tabi wrote:
>> > An upcoming change in the architecture of ALSA SoC (ASoC) will require the
>> > MPC8610 HPCD's ASoC fabric driver to register as a standard platform driver.
>> > Therefore, we need to call platform_device_register_simple() from the board's
>> > platform code.
>> >
>> > Signed-off-by: Timur Tabi <timur@freescale.com>
>> > ---
>>
>> Gross. Loses the linkage to device-tree etc... which is useful for audio
>> especially. You should at least make sure the device node follows for
>> the target driver to be able to use it :-) I'd like you to sync with
>> Grant work on that matter if you are going to convert of_devices into
>> platform_devices.
>
> Timur, please correct my device tree understanding form our IRC
> conversation if I'm wrong here.
>
> I think one of the difficulties encountered here is that the device tree
> root for sound in this case is the SSI (Digital Audio Interface)
> controller and not the sound card as in ASoC. So maybe the problem is
> how do we represent an ASoC sound card in the device tree ?

Most likely this is currently a problem, yes.  *however* the device
tree is just data.  It is convenient and useful to have a common
representation between similar kinds of devices, but it isn't
mandatory.  The device tree structure does *not* need to have a 1:1
correspondence to the ASoC device registrations.

So, the current 86xx device tree binding assumes a simple layout with
a node describing an DAI controller, and another node describing the
codec with a single phandle (pointer) from the DAI to the codec.  In
this configuration, it is completely reasonable for the DAI node to
trigger both the instantiation of the ASoC DAI controller device and
the sound card device.  Linux can treat them as separate even though
the current device tree has a simplistic representation.

> The sound card within ASoC is a compound device that is made up of the
> SSI, Codec and audio DMA engine components. The SSI/Codec/DMA components
> do not have to be the sound cards child devices wrt the driver model but
> do register with the ASoC core and are 'joined' with each other and the
> sound card driver to form a working audio device.

Right.  This makes sense to me.

> Now I don't know the mechanics of adding an ASoC sound card to the
> device tree, but the device tree should be able to define an ASoC sound
> card and also represent the relationships between the sound card and the
> SSI/Codec/DMA components. The components should also be represented in
> the device tree. Parsing the device tree should probe() all the ASoC
> components and sound card. The ASoC core would then instantiated them as
> a sound device.

I've tried very hard to maintain a distinction between device tree
binding (representation) and Linux kernel internal implementation
details.  The real question is whether or not the binding provides
sufficient detail for the operating system to figure out what to do.
In the extreme minimalist case, the audio driver could decide how to
configure itself solely on the board name property of the root node.
There is nothing wrong with that, but it also means that no data is
available to dynamically select common modules or modify connections;
it all has to be hard coded.

The 8610 device tree looks something like this right now:

	[...]
		cs4270:codec@4f {
			compatible = "cirrus,cs4270";
			reg = <0x4f>;
			/* MCLK source is a stand-alone oscillator */
			clock-frequency = <12288000>;
		};
	[...]
	ssi@16000 {
		compatible = "fsl,mpc8610-ssi";
		[...]
		fsl,mode = "i2s-slave";
		codec-handle = <&cs4270>;
		fsl,playback-dma = <&dma00>;
		fsl,capture-dma = <&dma01>;
		fsl,fifo-depth = <8>;
		sleep = <&pmc 0 0x08000000>;
	};
	[...]

(I've omitted the DMA nodes and some irrelevant details)  This is
enough information for a simplistic driver registration that probably
makes a lot of assumptions.  Such as the ssi represents a single
logical sound device.  It won't handle complex representations, but in
a lot of cases that may be just fine.

However, as you and Mark rightly point out, it completely fails to
represent complex sound devices with weird clocking and strange
routes.  Something like this is probably more appropriate:

	[...]
		codec1 :codec@4f {
			compatible = "cirrus,cs4270";
			reg = <0x4f>;
			/* MCLK source is a stand-alone oscillator */
			clock-frequency = <12288000>;
		};
	[...]
	ssi1: ssi@16000 {
		compatible = "fsl,mpc8610-ssi";
		[...]
		fsl,mode = "i2s-slave";
		fsl,playback-dma = <&dma00>;
		fsl,capture-dma = <&dma01>;
		fsl,fifo-depth = <8>;
		sleep = <&pmc 0 0x08000000>;
	};
	[...]
	sound {
		compatible = "fsl,mpc8610-hpcd-sound";
		/* maybe something like (totally off the top of my head) */
		dai-links = <&ssi1 0 &codec 0
		             &ssi1 1 &codec 1>;
		[...]
	};

Where the 'sound' node is now the starting point for representing a
logical sound device instead of the ssi node.  This binding probably
makes more sense (but I'm not committing to anything like this until I
see a real proposal for a real device).

The question for the drivers is more around how to deal with the data
provided.  I've got zero issues with platform specific code to handle
things that aren't easily described in a device tree.  The point is to
make the common cases data-driven so that common code will handle
them.  The complex corner cases are still complex corner cases that
need platform specific code.

Or, in other words, the device tree should *not* be used to describe
every possible detail and permutation.  It is best used to describe
the permutations that are common so that they don't need to be hard
coded for each and every board.

I would solve the problem this way: In the ssi driver, if the
codec-node property is present, then call a function to instantiate a
simple or platform specific sound card instance that makes the
assumptions listed above.  If not, then just register the ssi and
exit, which leaves the ssi available for a separate driver to pick it
up.  I wouldn't do this for new platforms, but it gracefully makes use
of the data provided in the current 8610 device tree.

BTW Timur, there is nothing wrong with registering multiple devices
that all have the of_node pointer set to the same node.

g.
