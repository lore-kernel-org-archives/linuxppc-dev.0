Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 81A5B1007D2
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 21:44:53 +1100 (EST)
To: Peter Tyser <ptyser@xes-inc.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1262301038.29396.137.camel@localhost.localdomain>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
	<1262301038.29396.137.camel@localhost.localdomain>
Date: Fri, 01 Jan 2010 11:44:49 +0100
Message-Id: <20100101104449.6DAC63F6FF@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Peter,

In message <1262301038.29396.137.camel@localhost.localdomain> you wrote:
> 
> > Why chose a different name at all? We could still call it "uImage",
> > meaning "U-Boot image" - U-Boot is clever enought o detect
> > automatically if we pass it an old style or a fit image.
> 
> I agree with your point to an extent, but having 2 types of uImages is
> somewhat confusing to a user, even if U-Boot can differentiate between
> them.  And if the legacy image and FIT image had the same Make target,
> how does a user specify which type they want to build?  The fact that
> both "legacy" and FIT images would reside at arch/powerpc/boot/uImage
> doesn't make things any less confusing to Joe User.

Agreed.

> Currently U-Boot supports booting:
> 1 "legacy" uImages
> 2 "new" Flattened Image Tree (FIT) uImages

The "legacy" uImage format has a number of restrictions not unsimilar
to the restrictions we had in the bootloader / kernel interface when
using the old binary bd_info data structur. For the kernel interface
this has been replaced by using the device tree, and I would like to
see the same happen in U-Boot.

The "new" FIT image type should become the default, and old "legacy"
images should only be generated upon special request (i. e. if some-
one needs these for compatibility with an old, not yet FIT-aware
version of the boot loader).

> What do you think about changing the U-Boot documentation to rename
> those 2 image types to:
> 1 uImages
> 2 FIT Images

Let's make this "uImage.old" (or "uImage.legacy" similar) and
"uImage", then.

> The FIT image is a relatively generic image type - its just a blob that
> dtc created from a device tree and some input binaries.  In my mind its
> not intimately tied to U-Boot, at least not conceptually.  The "legacy"

Correct. The intention was to provide an open and somewhat
"standardized" format that can be easily extended for new
requirements, whatever these may be.

> uImages have to agree with U-Boot's header format defined in the U-Boot
> source code, so the uImage name does make sense with respect to the
> "legacy" uImages.

Well, you can read "uImage" as "universal Image", which kind of fits
the FIT approach :-)

> My vote would be to make the Linux FIT target rule "fitImage" and then
> update the U-Boot documentation to make obvious the differences between
> uImages and FIT images.

I think we should not try to support both legacy and FIT images on the
same level - the idea is clearly that legacy images is the old, to be
replaced format, while FIT images is the new, to be used as standard
format. In this sense I vote for using plain and simple "uImage" for
the (new) standard format, and marking the old format by some ".old"
or ".legacy" suffix.

BTW: note that (IIRC) we don't even have a formal definition of the
"FIT" abbreviation yet ;-)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The more data I punch in this card,  the lighter it becomes, and the
lower the mailing cost."
                     - Stan Kelly-Bootle, "The Devil's DP Dictionary"
