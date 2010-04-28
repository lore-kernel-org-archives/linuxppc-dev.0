Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B2BE3B7D95
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 23:43:14 +1000 (EST)
Date: Wed, 28 Apr 2010 15:43:03 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] video: add support for getting video mode from
	device tree
Message-ID: <20100428154303.45d1ce87@wker>
In-Reply-To: <1267415120.23523.1898.camel@pasglop>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
	<fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
	<4B8A2CD7.7070305@firmworks.com>
	<1267415120.23523.1898.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev@ozlabs.org, Mitch Bradley <wmb@firmworks.com>,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 01 Mar 2010 14:45:20 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2010-02-27 at 22:44 -1000, Mitch Bradley wrote:
> 
> > As it turns out, I'm doing exactly that - exporting verbatim EDID
> > data 
> > as the value of the "edid" property - for the display node on the Via 
> > version of the OLPC machine.  The kernel driver uses it instead of 
> > trying to obtain the EDID data from the monitor, because the builtin 
> > OLPC display cannot supply EDID data through the usual hardware
> > interfaces.
> 
> This is actually a common practice (though EDID is most often in
> uppercase) on Apple hardware too. It has issues though in the sense that
> it doesn't carry proper connector information and falls over in many
> multi-head cases.
> 
> I think passing the EDID data, when available, is thus the right thing
> to do indeed, however that doesn't solve two problems:
> 
>  - Where to put that property ? This is a complicated problem and we
> might argue on a binding for weeks because video cards typically support
> multiple outputs, etc. etc... I think the best for now is to stick as
> closely as possible to the existing OF fb binding, and have "display"
> nodes for each output, which can eventually contain an EDID. We might
> also want to add a string that indicate the connector type. Specific
> drivers might want to define additional properties here where it makes
> sense such as binding of those outputs to CRTCs or such, up to you.

Putting EDID to display node would be really sufficient for LCDs in
our case. Other systems might define this additional connector type
property.

> 
>  - We -also- want a way to specify the "default" mode as set by the
> firmware, at least on some devices. The EDID gives capabilities, and
> often for LCDs also the "preferred" mode which is almost always the
> "default" mode ... but could be different. In order to avoid "flicking",
> the driver might wants to know what is the currently programmed mode.
> For that, having split out properties makes sense, though I would like
> to either prefix them all with "mode," or stick them in a sub-node of
> the display@.

I would propose defining following properties in the case the
programmed mode is different from "default" mode:

display@...{
	compatible = "<vendor>,<model>"
	EDID = [edid-data];

	current-mode {
		pixel_clock = <value>;
		horizontal_active = <value>;
		horizontal_blank = <value>;
		vertical_active = <value>;
		vertical_blank = <value>;
		horizontal_active = <value>;
		hsync_offset = <value>;
		hsync_pulse_width = <value>;
		vsync_offset = <value>;
		vsync_pulse_width = <value>;
		hsync_positive;
		vsync_positive;
	}
};

The firmware can set the "default" mode using the EDID's preferred
Detailed Timing Descriptor data. If on some devices it sets another
mode than the preferred mode, then the firmware can insert a
"current-mode" sub-node with currently programmed mode. The driver
can check for this sub-node and use it's data and if it isn't present,
it can use the preferred timing data from EDID. The names of the
properties here are actually what Detailed Timing Descriptor in EDID
specifies. What do you think?

Thanks,
Anatolij
