Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8E7B5B6EEF
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 21:10:51 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [PATCH v2 3/3] powerpc: Add support for ram filesystems
	in FIT uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa41001022108i92596d6qdf2da0e24c34767e@mail.gmail.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
	<1262221856.29396.104.camel@localhost.localdomain>
	<fa686aa41001022108i92596d6qdf2da0e24c34767e@mail.gmail.com>
Date: Sun, 03 Jan 2010 11:10:48 +0100
Message-Id: <20100103101048.AF4B7E34A26@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Peter Tyser <ptyser@xes-inc.com>,
	linux-kbuild@vger.kernel.org, u-boot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa41001022108i92596d6qdf2da0e24c34767e@mail.gmail.com> you wrote:
> 
> > Currently they have to make a "legacy" uImage, manually run the device
> > tree compiler with the proper flags to generate a board-specific .dtb
> > file,
> 
> ... or put the .dts files into arch/powerpc/boot/dts and use 'make <board>.=
> dtb'
> 
> multiple <board>.dtb targets can also be added to CONFIG_EXTRA_TARGETS
> so that a plain 'make' will build all needed files.

Note that the FIT image can also be made to contain a number of DT
blobs, and selection of a "board profile" then can be used to boot the
very sane FIT image file on any of the supported boards - so FIT
images inherently support multibooting.

> > I see your point.  The main goal of the patch was to introduce FIT image
> > support as its the new, more flexible, "better", standard image format
> > for U-Boot going forward.  Also, lots people aren't aware of FIT images
> > and the cool stuff they can do with them, so what better way to get the
> > word out than getting support for FIT images included in the kernel
> > proper:)
>
> Define 'better'.  :-)

FIT images are better than the old uImage format because they:

- allow for strong checksum algorithms like MD5, SHA1, ... (the plain
  CRC32 method is not good enough if you for example want to run
  software in a slot machine in Las Vegas).

- can combine multiple kernel images, device tree blobs and root file
  system images in arbitrary combinations; this allows for example
  for multibooting the same image on different boards by selecting
  the right DTB, for software updates with automatic fall-back, etc.

- can be extended to add new features, images types or whatever in a
  standard way, using a standard technology (device tree support)
  which is already present anyway, i. e. without additional code
  overhead.

> I do understand your use-case and what problem fit images solve for
> you.  However, from a "long term strategy" point of view it is a use
> case that I'm not interested in actively supporting for two reasons.
> The first is that I think it is in our best interest to encourage the
> mind set that the hardware description is separate from the operating
> system image, and so they should be stored and updated separately.  I

How do you boot systems over network, then? Normally you always
download only a single image file.

How do you explain this to system vendors? They have a very reasonable
request to offer only one image file to their customers.

> look at the unexpected ecosystem of distributions that has sprung up
> around wireless routers (ie OpenWRT and the like) and Linux cell
> phones (ie. Cyanogen Mod) where there is a huge range of hardware.
> The userspace can pretty much run on any of them excepting minor
> configuration changes.  The embedded space is becoming more PCs in

Right. So let's be able to provide kernel images that fit intot he
same pattern - that can be used on a range of platforms, for example
by embedding multiple DTBs.

Requesting that we manage a kernel mage plus a collection of DTBs and
that eveybody has to install the only working correctly combination
seems to be a bad idea to me.

> this regard, and I know that multiplatform is a big deal for some of
> the users.  I'm not interested in encouraging any behaviour that will
> scuttle deployment of multiplatform kernels.  (That being said, I'm

You misunderstand. FIT images do not scuttle multiplatform kernels.
Instead they support this much better, as they allow to bundle the
repsective DTBs into one image file.

> not going to actively sabotage people who want to put dtb sections
> into the kernel images either.  I understand that at times it is
> necessary, and there are numerous examples of this already in the
> kernel tree; specifically to support firmware that doesn't implement
> arch/powerpc's boot interface)

Even if the boot loader supports it, it is usually pretty benefical
(especially during development) if you can do this.

> I'd be okay (perhaps not happy, but okay) with merging fitImage and
> fitImage.initrd targets (no dtb).  I will resist merging fitImage.%
> and fitImage.initrd.% targets because I see that very much as a
> project specific deployment target and I'm not convinced yet that it
> the pattern is right or that it is even needed in the kernel at all.

Is this just your personal opinion, or do you think that this is
really what a majority of kernel developers and users are wanting?

Speaking for myself, I have to admit that I don't understand and don't
share this attitude.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The optimum committee has no members.
                                                   - Norman Augustine
