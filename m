Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26F1E1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 12:11:06 +1100 (EST)
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
From: Peter Tyser <ptyser@xes-inc.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Dec 2009 19:10:56 -0600
Message-ID: <1262221856.29396.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: u-boot <u-boot@lists.denx.de>, linuxppc-dev@ozlabs.org,
	linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-30 at 17:01 -0700, Grant Likely wrote:
> On Wed, Dec 30, 2009 at 4:39 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> > Hi Grant,
> > I put U-Boot ML on CC.
> 
> Thinking further, I do actually have another concern, at least with
> regard to the way the current patch set implements things.  Is it
> expected or even "recommended" that fit images will *always* contain a
> .dtb image?  The current patch only handles the case of a .dtb
> embedded inside the fit image.

I'm not aware of any recommendations as far as what FIT images should
contain and there isn't a requirement that it should contain a .dtb
image - its just a flexible image format.

I believe in the most common FIT usage scenario the image would contain
both a kernel image and .dtb file though.  For example, most people I
deal with just have boardX and boardY that they want to boot Linux on.

Currently they have to make a "legacy" uImage, manually run the device
tree compiler with the proper flags to generate a board-specific .dtb
file, transfer the uImage to to boardX, transfer the .dtb file to
boardX, set some U-Boot variables, then boot to Linux.  For boardY they
would have to redo the steps with the exception of recreating the legacy
uImage.  (To add to the confusion, the format of device trees is a
somewhat moving target, so .dtb files aren't always compatible with
different kernel versions.)

The FIT+.dtb patches I sent make it so the same process is shortened to:
make a FIT image for boardX which contains a .dtb, download it to
boardX, and boot it.  Then repeat the same steps for boardY.

> Personally, I don't get any benefit out of the new image format, so I
> haven't spent any time looking at it.  However, I'm concerned about
> the drift back towards a different image per target when the move over
> the last 4 years has been towards multiplatform kernel images.  I
> certainly don't want to encourage embedding the device tree blob into
> the kernel image, and I'm not very interested in merging code to do
> that into the kernel tree.  If someone really needs to do that for
> their particular target, it is certainly easy enough for them to weld
> in the .dtb after the fact before transferring the image to the
> target, but I want that mode to be the exception, not the rule.

I see your point.  The main goal of the patch was to introduce FIT image
support as its the new, more flexible, "better", standard image format
for U-Boot going forward.  Also, lots people aren't aware of FIT images
and the cool stuff they can do with them, so what better way to get the
word out than getting support for FIT images included in the kernel
proper:)

I think it would be nice to generate a FIT image that contained the
kernel + .dtb as it significantly simplifies the process of booting
Linux for the common case for lots of U-Boot users and showcases one of
the benefits of the FIT format.  If you'd prefer not to have this
portion of the patch included, I can respin so that the FIT image
created only contains a kernel image, not a .dtb or initramfs.  Or I
could make targets of fitImage (no dtb included), fitImage.<board> (dtb
included), and fitImage.initrd.<board> (dtb and initramfs included).
Either way is fine with me, it'd just be nice to see FIT support get in
in some form.

Thanks,
Peter
