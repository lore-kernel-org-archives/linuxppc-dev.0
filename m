Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 183971007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 02:28:32 +1000 (EST)
Received: by gyf2 with SMTP id 2so2632198gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 09:28:31 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100614160201.GD9550@shareable.org>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Jun 2010 10:28:09 -0600
Message-ID: <AANLkTilZuMKzFN1hD1k4Q067jSkryPuWA2bhW0Y3GJTg@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Jamie Lokier <jamie@shareable.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 14, 2010 at 10:02 AM, Jamie Lokier <jamie@shareable.org> wrote:
> Nicolas Pitre wrote:
>> On Mon, 14 Jun 2010, David Gibson wrote:
>>
>> > On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
>> > [sni]
>> > > > That's sort of a self-fulfilling prophecy. =A0If the OS doesn't tr=
ust the
>> > > > firmware, there is no pressure for the firmware to "get it right".
>> > >
>> > > Firmware will not get it right. =A0Period. =A0There will always be
>> > > something wrong. =A0It is never right on PCs. =A0It will never be ri=
ght on
>> > > the other architectures.
>> >
>> > Yes, yes, yes. =A0And there is a great deal of empirical evidence to
>> > back that assertion.
>> >
>> > > =A0That goes for OSes too, but upgrading an OS
>> > > isn't as risky as upgrading firmware. =A0That isn't to say that it c=
an't
>> > > be close, but every firmware feature that the OS depends on is a
>> > > feature that could force a risky firmware upgrade when the bug in it
>> > > is discovered.
>> >
>> > Indeed. =A0In fact, the general rule of thumb is really "put as much a=
s
>> > possible into the most easily replaced layer of the stack". =A0This is=
,
>> > incidentally, why I've always been dubious about simple firmwares
>> > supplying a flattened device tree rather than including the device
>> > tree template in the kernel, cuboot style.
>>
>> The biggest advantage, IMHO, for adding DT to ARM, is actually to
>> decouple the hardware config information and the kernel. =A0If in the en=
d
>> the DT has to be shipped in the kernel then we're losing all this
>> advantage over the current state of things on ARM which still works
>> pretty well otherwise.
>>
>> In the best case, the simple firmware simply has to retrieve the
>> flattened device tree from flash, and pass it to the kernel just like
>> some anonymous blob. =A0And the simple firmware only needs to provide a
>> way for that DT blob to be updatable, like through an upload of a
>> replacement blob that was prepared offline. =A0Just like a ramdisk image
>> or the like.
>>
>> That doesn't need to be fancier than that, and the goal of having the DT
>> data tied to the hardware instead of the kernel is achieved.
>
> Imho that puts the DT in a similar category as initrd/initramfs, from
> the bootloader's point of view. =A0It's another blob whose address is
> passed to the kernel, just like initrd.
>
> Some bootloaders can't update blobs independently for technical
> reasons, or to be minimal.
>
> A device I'm using does kernel updates by updating the whole romfs
> boot image, which contains the kernel and other auxiliary blobs used
> for booting (splash screen, early irq handlers etc.) as well as the
> root filesystem.
>
> It is done that way to pack everything together in the small flash,
> and because the NOR flash eraseblocks are too large relative to the
> whole flash size to use separate partitions for kernel, boot
> filesystem and other blobs for booting.

This is totally fine.  I've got no problem with a specific firmware
requiring everything (kernel,dt,rootfs) packed into a single image
file.  Packing the image can be done at OS install time (instead of
prebuilding it) if the system builder want to retain the independent
hardware configuration aspects of using the device tree.

> Dedicating a 64kiB eraseblock out of 2MB just for a small DT would be
> quite wasteful. =A0Dedicating two to make it powerfail-safe would be
> even worse.
>
> So requiring that a bootloader can update the DT _independently_ of
> everything else is a bit much for some devices.

Independent update of the DT is a useful feature, but it is certainly
not a hard requirement.  It's a far more likely use-case if the kernel
and DT is stored on a filesystem instead of bare NOR flash.

> But requiring that it's generally treated like other separate blob,
> i.e. in a similar way to initrd, and the kernel image itself, seems
> not unreasonable.
>
> Like initrd, some people will find they need to compile it in to the
> kernel image to fit some bootloader they can't change, or daren't risk
> changing in already rolled out devices that they want to update to a
> DT-using kernel.

Yes, I fully expect that.  Fortunately the situation is better than it
was with powerpc.  Since the machine id is being retained, a
DT-enabled kernel can continue to support non-DT systems.  There will
not be a flag day to cut everything over to a new boot interface.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
