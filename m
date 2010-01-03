Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 6D6CCB6EEB
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 16:09:05 +1100 (EST)
Received: by gxk28 with SMTP id 28so7786329gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Jan 2010 21:09:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1262221856.29396.104.camel@localhost.localdomain>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
	<1262221856.29396.104.camel@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 Jan 2010 22:08:43 -0700
Message-ID: <fa686aa41001022108i92596d6qdf2da0e24c34767e@mail.gmail.com>
Subject: Re: [U-Boot] [PATCH v2 3/3] powerpc: Add support for ram filesystems
	in FIT uImages
To: Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: u-boot <u-boot@lists.denx.de>, linux-kbuild@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On Wed, Dec 30, 2009 at 6:10 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> On Wed, 2009-12-30 at 17:01 -0700, Grant Likely wrote:
>> On Wed, Dec 30, 2009 at 4:39 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
>> > Hi Grant,
>> > I put U-Boot ML on CC.
>>
>> Thinking further, I do actually have another concern, at least with
>> regard to the way the current patch set implements things. =A0Is it
>> expected or even "recommended" that fit images will *always* contain a
>> .dtb image? =A0The current patch only handles the case of a .dtb
>> embedded inside the fit image.
>
> I'm not aware of any recommendations as far as what FIT images should
> contain and there isn't a requirement that it should contain a .dtb
> image - its just a flexible image format.
>
> I believe in the most common FIT usage scenario the image would contain
> both a kernel image and .dtb file though. =A0For example, most people I
> deal with just have boardX and boardY that they want to boot Linux on.
>
> Currently they have to make a "legacy" uImage, manually run the device
> tree compiler with the proper flags to generate a board-specific .dtb
> file,

... or put the .dts files into arch/powerpc/boot/dts and use 'make <board>.=
dtb'

multiple <board>.dtb targets can also be added to CONFIG_EXTRA_TARGETS
so that a plain 'make' will build all needed files.

> transfer the uImage to to boardX, transfer the .dtb file to
> boardX, set some U-Boot variables, then boot to Linux. =A0For boardY they
> would have to redo the steps with the exception of recreating the legacy
> uImage. =A0(To add to the confusion, the format of device trees is a
> somewhat moving target, so .dtb files aren't always compatible with
> different kernel versions.)

The are no guarantees that new dtb files will work with old kernels,
but old dtb files should continue to work with new kernels.  There
have been growing pains in this regard, and there are a number of
examples where this hasn't been the case especially as we were
learning how best to use the device tree.  It is a lot more stable now
than it had been and new cases can be considered a kernel bug.

>> Personally, I don't get any benefit out of the new image format, so I
>> haven't spent any time looking at it. =A0However, I'm concerned about
>> the drift back towards a different image per target when the move over
>> the last 4 years has been towards multiplatform kernel images. =A0I
>> certainly don't want to encourage embedding the device tree blob into
>> the kernel image, and I'm not very interested in merging code to do
>> that into the kernel tree. =A0If someone really needs to do that for
>> their particular target, it is certainly easy enough for them to weld
>> in the .dtb after the fact before transferring the image to the
>> target, but I want that mode to be the exception, not the rule.
>
> I see your point. =A0The main goal of the patch was to introduce FIT imag=
e
> support as its the new, more flexible, "better", standard image format
> for U-Boot going forward. =A0Also, lots people aren't aware of FIT images
> and the cool stuff they can do with them, so what better way to get the
> word out than getting support for FIT images included in the kernel
> proper:)

Define 'better'.  :-)

I do understand your use-case and what problem fit images solve for
you.  However, from a "long term strategy" point of view it is a use
case that I'm not interested in actively supporting for two reasons.
The first is that I think it is in our best interest to encourage the
mind set that the hardware description is separate from the operating
system image, and so they should be stored and updated separately.  I
look at the unexpected ecosystem of distributions that has sprung up
around wireless routers (ie OpenWRT and the like) and Linux cell
phones (ie. Cyanogen Mod) where there is a huge range of hardware.
The userspace can pretty much run on any of them excepting minor
configuration changes.  The embedded space is becoming more PCs in
this regard, and I know that multiplatform is a big deal for some of
the users.  I'm not interested in encouraging any behaviour that will
scuttle deployment of multiplatform kernels.  (That being said, I'm
not going to actively sabotage people who want to put dtb sections
into the kernel images either.  I understand that at times it is
necessary, and there are numerous examples of this already in the
kernel tree; specifically to support firmware that doesn't implement
arch/powerpc's boot interface)

The second is that I no longer think it is a good idea to be building
bootloader specific image fomats if we can help it.  U-Boot is not the
only game bootloaders, especially when talking about ARM or MIPS, and
some folks are even using kexec to go from one kernel to the next.
Having the same image format for all firmware and also kexec is far
more interesting to me than the a new u-boot format.  Some form of
zImage seems to be a more likely format to standardize around than the
FIT format, mostly because kexec and a lot of firmware already
understand zImages, and it doesn't require firmware to link in libfdt.

> I think it would be nice to generate a FIT image that contained the
> kernel + .dtb as it significantly simplifies the process of booting
> Linux for the common case for lots of U-Boot users and showcases one of
> the benefits of the FIT format. =A0If you'd prefer not to have this
> portion of the patch included, I can respin so that the FIT image
> created only contains a kernel image, not a .dtb or initramfs. =A0Or I
> could make targets of fitImage (no dtb included), fitImage.<board> (dtb
> included), and fitImage.initrd.<board> (dtb and initramfs included).
> Either way is fine with me, it'd just be nice to see FIT support get in
> in some form.

I'd be okay (perhaps not happy, but okay) with merging fitImage and
fitImage.initrd targets (no dtb).  I will resist merging fitImage.%
and fitImage.initrd.% targets because I see that very much as a
project specific deployment target and I'm not convinced yet that it
the pattern is right or that it is even needed in the kernel at all.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
