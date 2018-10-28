Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789AC6786F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 18:27:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD482082B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 18:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD482082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jmR55GJPzDsM2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 05:26:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jmP66FZczDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 05:25:13 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9A699AE8A;
 Sun, 28 Oct 2018 18:25:10 +0000 (UTC)
Date: Sun, 28 Oct 2018 19:25:08 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: ethernet "bus" number in DTS ?
Message-ID: <20181028192508.6a1ace51@naga.suse.cz>
In-Reply-To: <27720d1a-a002-5090-d4fc-92ea59b5839a@gmail.com>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
 <20181024082239.5ee41017@naga.suse.cz>
 <27720d1a-a002-5090-d4fc-92ea59b5839a@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 robh@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Oct 2018 15:57:15 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 10/23/18 11:22 PM, Michal Such=C3=A1nek wrote:
> > On Tue, 23 Oct 2018 11:20:36 -0700
> > Florian Fainelli <f.fainelli@gmail.com> wrote:
> >  =20
> >> On 10/23/18 11:02 AM, Joakim Tjernlund wrote: =20
> >>> On Tue, 2018-10-23 at 10:03 -0700, Florian Fainelli wrote:   =20
> >  =20
> >>>
> >>> I also noted that using status =3D "disabled" didn't work either to
> >>> create a fix name scheme. Even worse, all the eth I/F after gets
> >>> renumbered. It seems to me there is value in having stability in
> >>> eth I/F naming at boot. Then userspace(udev) can rename if need
> >>> be.=20
> >>>
> >>> Sure would like to known more about why this feature is not
> >>> wanted ?
> >>>
> >>> I found
> >>>   https://patchwork.kernel.org/patch/4122441/
> >>> You quote policy as reason but surely it must be better to
> >>> have something stable, connected to the hardware name, than
> >>> semirandom naming?   =20
> >>
> >> If the Device Tree nodes are ordered by ascending base register
> >> address, my understanding is that you get the same order as far as
> >> platform_device creation goes, this may not be true in the future
> >> if Rob decides to randomize that, but AFAICT this is still true.
> >> This may not work well with status =3D disabled properties being
> >> inserted here and there, but we have used that here and it has
> >> worked for as far as I can remember doing it. =20
> >=20
> > So this is unstable in several respects. First is changing the
> > enabled/disabled status in the deivecetrees provided by the kernel.
> >=20
> > Second is if you have hardware hotplug mechanism either by firmware
> > or by loading device overlays.
> >=20
> > Third is the case when the devicetree is not built as part of the
> > kernel but is instead provided by firmware that initializes the
> > low-level hardware details. Then the ordering by address is not
> > guaranteed nor is that the same address will be used to access the
> > same interface every time. There might be multiple ways to
> > configure the hardware depending on firmware configuration and/or
> > version.
> >=20
> >   =20
> >> Second, you might want to name network devices ethX, but what if I
> >> want to name them ethernetX or fooX or barX? Should we be
> >> accepting a mechanism in the kernel that would allow someone to
> >> name the interfaces the way they want straight from a name being
> >> provided in Device Tree? =20
> >=20
> > Clearly if there is text Ethernet1 printed above the Ethernet port
> > we should provide a mechanism to name the port Ethernet1 by
> > default. =20
>=20
> Yes, but then have a specific property that is flexible enough to
> retrieve things like "vital product information". For DSA switches, we
> have an optional "label" property which names the network device
> directly like it would be found on the product's case. Ideally this
> should be much more flexible such that it can point to the appropriate
> node/firmware service/whatever to get that name, which is what some
> people have been working on lately, see [1].
>=20
> [1]: https://lkml.org/lkml/2018/8/14/1039

That's nice for something unique per-device like MAC address. However,
for something per-model like port labels DT properties should suffice.

>=20
> The point is don't re-purpose the aliases which is something that
> exists within Device Tree to basically provide a shorter path to a
> specific set of nodes for the boot program to mangle and muck with
> instead of having to resolve a full path to a node. At least that is
> how I conceive it.
>=20
> Now what complicates the matter is that some OSes like Linux tend to
> use it to also generate seemingly stable index for peripherals that
> are numbered by index such as SPI, I2C, etc buses, which is why we are
> having this conversation here, see below for more.
>=20
> >  =20
> >>
> >> Aliases are fine for providing relative stability within the Device
> >> Tree itself and boot programs that might need to modify the Device
> >> Tree (e.g: inserting MAC addresses) such that you don't have to
> >> encode logic to search for nodes by compatible strings etc. but
> >> outside of that use case, it seems to me that you can resolve every
> >> naming decision in user-space. =20
> >=20
> > However, this is pushing platform-specific knowledge to userspace.
> > The way the Ethernet interface is attached and hence the device
> > properties usable for identifying the device uniquely are
> > platform-specific. =20
>=20
> There is always going to be some amount of platform specific knowledge
> to user-space, what matters is the level of abstraction that is
> presented to you.
>=20
> >=20
> > On the other hand, aliases are universal when provided. If they are
> > good enough to assign a MAC address they are good enough to provide
> > a stable default name. =20
>=20
> We are not talking about the same aliases then. The special Device
> Tree node named "aliases" is a way to create shorted Device Tree node
> paths, it is not by any means an equivalent for what I would rather
> call a "label", or "port name" or silk screen annotation on a PCB for
> instance.

However, if the kernel ethN names are deterministic based on something
like aliases it is trivial to translate them to "port name". As it is
they are pretty much random which is the issue aliases *can* solve.

>=20
> >=20
> > I think this is indeed forcing the userspace to reinvent several
> > wheels for no good reason. =20
>=20
> udev or systemd will come up with some stable names for your network
> device right off the bat.

As has been already pointed out these names are not stable for various
reasons. *Making* them stable is the whole point of this discussion.
=20
> If you are deeply embedded maybe you don't
> want those, but then use something like the full path in /sys to get
> some stable names based on the SoC's topology.

However, it some devices might be disabled depending on the device
configuration generating stable names is not that easy. Also if bus
topology may differ depending on device/firmware configuration you
cannot assign stable names based just on /sys hierarchy. Also it is
said that /sys hierarchy is not an ABI in the kernel docs so you should
not base your stable device names which *are* an ABI on the
unstable /sys hierarchy.

>=20
> >=20
> > What is the problem with adding the aliases? =20
>=20
> aliases is IMHO the wrong tool for the job because it is too limiting,
> you want it to be used to have Ethernet controller instance N to be
> named "ethN", what if someone tomorrows says, no this is not good, I
> want the aliases to automatically name my network devices
> "ethernet-controllerN" or "blahblahN"? You see where I am getting
> with that?

Then you can write udev rule to translate ethN to blahlbahN and so long
as the ethN is stable the translation is stable as well. Alternatively
you might want to use a different devicetree property if one existed.

>=20
> And yes, I do realize that Linux has traditionally named Ethernet
> adapters ethN, but also allows people to name interfaces just the way
> they want even from within the drivers themselves.
>=20
> Now imagine your platform uses ACPI, and there are no aliases there to
> point a node with a shorter name, how we would go about naming your
> Ethernet controller unless there is a specific VPD/label/sticker
> property that can be somehow be retried?

There is biosdevname for that which uses proprietary BIOS extensions to
look up device names in BIOS.

Thanks

Michal
