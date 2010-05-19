Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f224.google.com (mail-gx0-f224.google.com
	[209.85.217.224]) by ozlabs.org (Postfix) with ESMTP id 67C61B7D41
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 07:20:20 +1000 (EST)
Received: by gxk24 with SMTP id 24so1338547gxk.3
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 14:20:18 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100428154303.45d1ce87@wker>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
	<fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
	<4B8A2CD7.7070305@firmworks.com> <1267415120.23523.1898.camel@pasglop>
	<20100428154303.45d1ce87@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 May 2010 15:19:57 -0600
Message-ID: <AANLkTim4JddVZK99zb53iCKNLWSGLxfAX-d0yRS39yYc@mail.gmail.com>
Subject: Re: [PATCH 1/3] video: add support for getting video mode from device
	tree
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, Apr 28, 2010 at 7:43 AM, Anatolij Gustschin <agust@denx.de> wrote:
> On Mon, 01 Mar 2010 14:45:20 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Sat, 2010-02-27 at 22:44 -1000, Mitch Bradley wrote:
>>
>> > As it turns out, I'm doing exactly that - exporting verbatim EDID
>> > data
>> > as the value of the "edid" property - for the display node on the Via
>> > version of the OLPC machine. =A0The kernel driver uses it instead of
>> > trying to obtain the EDID data from the monitor, because the builtin
>> > OLPC display cannot supply EDID data through the usual hardware
>> > interfaces.
>>
>> This is actually a common practice (though EDID is most often in
>> uppercase) on Apple hardware too. It has issues though in the sense that
>> it doesn't carry proper connector information and falls over in many
>> multi-head cases.
>>
>> I think passing the EDID data, when available, is thus the right thing
>> to do indeed, however that doesn't solve two problems:
>>
>> =A0- Where to put that property ? This is a complicated problem and we
>> might argue on a binding for weeks because video cards typically support
>> multiple outputs, etc. etc... I think the best for now is to stick as
>> closely as possible to the existing OF fb binding, and have "display"
>> nodes for each output, which can eventually contain an EDID. We might
>> also want to add a string that indicate the connector type. Specific
>> drivers might want to define additional properties here where it makes
>> sense such as binding of those outputs to CRTCs or such, up to you.
>
> Putting EDID to display node would be really sufficient for LCDs in
> our case. Other systems might define this additional connector type
> property.
>
>>
>> =A0- We -also- want a way to specify the "default" mode as set by the
>> firmware, at least on some devices. The EDID gives capabilities, and
>> often for LCDs also the "preferred" mode which is almost always the
>> "default" mode ... but could be different. In order to avoid "flicking",
>> the driver might wants to know what is the currently programmed mode.
>> For that, having split out properties makes sense, though I would like
>> to either prefix them all with "mode," or stick them in a sub-node of
>> the display@.
>
> I would propose defining following properties in the case the
> programmed mode is different from "default" mode:
>
> display@...{
> =A0 =A0 =A0 =A0compatible =3D "<vendor>,<model>"
> =A0 =A0 =A0 =A0EDID =3D [edid-data];
>
> =A0 =A0 =A0 =A0current-mode {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pixel_clock =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0horizontal_active =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0horizontal_blank =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vertical_active =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vertical_blank =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0horizontal_active =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsync_offset =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsync_pulse_width =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vsync_offset =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vsync_pulse_width =3D <value>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsync_positive;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vsync_positive;
> =A0 =A0 =A0 =A0}
> };
>
> The firmware can set the "default" mode using the EDID's preferred
> Detailed Timing Descriptor data. If on some devices it sets another
> mode than the preferred mode, then the firmware can insert a
> "current-mode" sub-node with currently programmed mode. The driver
> can check for this sub-node and use it's data and if it isn't present,
> it can use the preferred timing data from EDID. The names of the
> properties here are actually what Detailed Timing Descriptor in EDID
> specifies. What do you think?

If you really want to do that, then I think it is okay.  I really
don't know enough about the problem space to say whether or not that
particular description is a good binding or not, but regardless it
should be a video-controller-specific binding.  The name of the node
should probably be prefixed with "<manufacturer>," and it should be
documented along with the display controller's device tree binding.
If another controller wants/needs a different binding format (for the
current mode), then that is fine too (unless you can make a really
good argument that this current-mode binding is perfect and no other
layout should ever be required).  :-)

Cheers,
g.

>
> Thanks,
> Anatolij
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
