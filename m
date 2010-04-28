Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id C2C36B7D52
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 15:37:46 +1000 (EST)
Received: by gwj17 with SMTP id 17so3523921gwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 22:37:44 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BD74D0C.40303@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 23:37:23 -0600
Message-ID: <q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
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

On Tue, Apr 27, 2010 at 2:46 PM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>> So, the current 86xx device tree binding assumes a simple layout with
>> a node describing an DAI controller, and another node describing the
>> codec with a single phandle (pointer) from the DAI to the codec. =A0In
>> this configuration, it is completely reasonable for the DAI node to
>> trigger both the instantiation of the ASoC DAI controller device and
>> the sound card device. =A0Linux can treat them as separate even though
>> the current device tree has a simplistic representation.
>
> The only problem with this is that there is board-specific programming th=
at needs to be done (look at mpc8610_hpcd_machine_probe), so we still need =
to have a fabric driver that is independent of the SSI, codec, or DMA drive=
rs. =A0The P1022 also has an SSI, and I'm hoping that all I need to do is c=
reate a new fabric driver, not hack up the SSI driver to support board prog=
ramming.
>
> So if the fabric driver still needs to exist, then it still needs a struc=
t device, and it still needs to register with asoc. =A0I don't see how I ca=
n register the sound card itself in the SSI driver, because it won't know a=
nything about the board-specific code in the fabric driver.

Why not?  Just have the ssi driver probe routine register the fabric
device based on the existence of the codec-handle property.  It is the
best way to go about things with the data that you've got available,
and it is no big deal.  The relevant fabric driver can then bind
against that.  You should probably also stuff the ssi device node
pointer into the fabric device of_node pointer.

>> I've tried very hard to maintain a distinction between device tree
>> binding (representation) and Linux kernel internal implementation
>> details. =A0The real question is whether or not the binding provides
>> sufficient detail for the operating system to figure out what to do.
>
> I think it does, because it's working today.
>
>> In the extreme minimalist case, the audio driver could decide how to
>> configure itself solely on the board name property of the root node.
>> There is nothing wrong with that, but it also means that no data is
>> available to dynamically select common modules or modify connections;
>> it all has to be hard coded.
>
> Well, asoc already has several hard-coded requirements:
>
> =A0 =A0 =A0 =A0machine_data->dai.cpu_dai_drv =3D &fsl_ssi_dai;
> =A0 =A0 =A0 =A0machine_data->dai.codec_dai_drv =3D &cs4270_dai;
> =A0 =A0 =A0 =A0machine_data->dai.codec_drv =3D &soc_codec_device_cs4270;
> =A0 =A0 =A0 =A0machine_data->dai.ops =3D &mpc8610_hpcd_ops;
> =A0 =A0 =A0 =A0machine_data->dai.platform_drv =3D &fsl_soc_platform;
>
> So even though I probe for each device separately and register them separ=
ately, the fabric driver still needs to have hard-coded addresses
>
> Maybe the asoc guys can tell me why I need to register the cpu_dai_drv st=
ructure via platform_device_add(), when it's already being registered via s=
nd_soc_register_dai().
>
>> (I've omitted the DMA nodes and some irrelevant details) =A0This is
>> enough information for a simplistic driver registration that probably
>> makes a lot of assumptions. =A0Such as the ssi represents a single
>> logical sound device. =A0It won't handle complex representations, but in
>> a lot of cases that may be just fine.
>
> Why would I ever represent the SSI as anything but a single logical sound=
 device? =A0Let ALSA handle synchronizing multiple streams together if it w=
ants to.
>
>> =A0 =A0 =A0 sound {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8610-hpcd-sound";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* maybe something like (totally off the top=
 of my head) */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai-links =3D <&ssi1 0 &codec 0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ssi1 1 &codec 1>=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [...]
>> =A0 =A0 =A0 };
>
> I don't know when I would ever do this. =A0The two SSI devices are comple=
tely independent. =A0Why would I bind them together into one "device"?

If there is no use case for binding them together, then you're right.
The current binding is probably just fine.  I cannot comment on
whether or not it will be used that way by platform designers.

>> Where the 'sound' node is now the starting point for representing a
>> logical sound device instead of the ssi node. =A0This binding probably
>> makes more sense (but I'm not committing to anything like this until I
>> see a real proposal for a real device).
>
> The only issue I have with this is all it does is turn the fabric driver =
from a platform driver that scans the OF tree, into an OF driver that still=
 needs to query the device tree to get all the data it needs. =A0For exampl=
e, the fabric driver still needs to know the clock frequency and direction =
of the codec node, so that it can call snd_soc_dai_set_fmt() and snd_soc_da=
i_set_sysclk() properly. =A0To eliminate that, we could have the fabric dri=
ver never call these functions, and expect the SSI and codec drivers to gat=
her this information itself. =A0But the codec driver is not an OF driver, s=
o it has no expectation of being able to query the codec node.
>
>> I would solve the problem this way: In the ssi driver, if the
>> codec-node property is present, then call a function to instantiate a
>> simple or platform specific sound card instance that makes the
>> assumptions listed above. =A0If not, then just register the ssi and
>> exit, which leaves the ssi available for a separate driver to pick it
>> up. =A0I wouldn't do this for new platforms, but it gracefully makes use
>> of the data provided in the current 8610 device tree.
>
> Eh, I'll have to think about that. =A0The absence of a codec pointer in t=
he SSI node means that the SSI is not connected to a codec, so it should ju=
st be ignored altogether. =A0An SSI is useless if it's not connected to a c=
odec.

I'm suggesting the case where a third node describes the mappings
between codecs and SSIs.

>> BTW Timur, there is nothing wrong with registering multiple devices
>> that all have the of_node pointer set to the same node.
>
> Sorry, I don't understand what you're getting at.

Linux struct device registrations are cheap, and every struct device
has a device_node pointer available.  It is totally fine to have both
the ssi device and the fabric device point to the same device node if
that helps solve your problem of finding references to the right
things in each driver.  (Just as long as only one of them is an
of_platform driver).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
