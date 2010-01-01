Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D643E1007D1
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2010 01:12:09 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
Date: Fri, 01 Jan 2010 15:12:05 +0100
Message-Id: <20100101141205.6F0B13F6FF@gemini.denx.de>
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

Dear Grant,

In message <fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com> you wrote:
>
> Thinking further, I do actually have another concern, at least with
> regard to the way the current patch set implements things.  Is it
> expected or even "recommended" that fit images will *always* contain a
> .dtb image?  The current patch only handles the case of a .dtb
> embedded inside the fit image.

I think this can be expected.

Historically, the need to pass the dtb image to the Linux kernel,
too, was what actually triggered the development of the FIT image
format, as it turned out that the old image format with it's fixed
binary header was too inflexible. So bundling the kernel image and
the device tree blob into one image file is the specific use case
this image format was created for (which does not mean that other
usage would be impossible).

> Personally, I don't get any benefit out of the new image format, so I
> haven't spent any time looking at it.  However, I'm concerned about

Assume you want to boot over DHCP or similar, where you can provide
just a single image file for download. Here it is definitely nice if
you can bundle the kernel image and the DTB into one image file. We
were able to extend the old so-called "multi-file" uImage format to
handle this situation, too, but it was clear that further extensions
were not really possible.

We consider the old legace uImage format as something we want to move
away from, and the new FIT image format shall be the new default.

> the drift back towards a different image per target when the move over
> the last 4 years has been towards multiplatform kernel images.  I
> certainly don't want to encourage embedding the device tree blob into
> the kernel image, and I'm not very interested in merging code to do
> that into the kernel tree.  If someone really needs to do that for
> their particular target, it is certainly easy enough for them to weld
> in the .dtb after the fact before transferring the image to the
> target, but I want that mode to be the exception, not the rule.

This is specific for particular targets, but for  specific  modes  of
operation,  like  booting  over  the network or other szenarios where
transferring a single image file is essential - another example where
we often see this request is upgrade procedures for devics, where the
vendor wants to be able to distribute a single file  for  his  target
systems   to  avoid  customers  bricking  their  devices  by  chosing
incompatible combinations.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
                                           - Antoine de Saint-Exupery
