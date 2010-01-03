Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 595EEB6EFE
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2010 11:54:21 +1100 (EST)
Message-ID: <4B412DCE.4030509@xes-inc.com>
Date: Sun, 03 Jan 2010 17:52:46 -0600
From: Peter Tyser <ptyser@xes-inc.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
	<1262301038.29396.137.camel@localhost.localdomain>
	<20100101104449.6DAC63F6FF@gemini.denx.de>
In-Reply-To: <20100101104449.6DAC63F6FF@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

> The "new" FIT image type should become the default, and old "legacy"
> images should only be generated upon special request (i. e. if some-
> one needs these for compatibility with an old, not yet FIT-aware
> version of the boot loader).

Agreed.

>> What do you think about changing the U-Boot documentation to rename
>> those 2 image types to:
>> 1 uImages
>> 2 FIT Images
>
> Let's make this "uImage.old" (or "uImage.legacy" similar) and
> "uImage", then.

I'm in favor of keeping the old uImage format/naming the same, and 
calling the new image format a FIT Image.  ie no mention of uImage for 
FIT images.

<snip>

>> uImages have to agree with U-Boot's header format defined in the U-Boot
>> source code, so the uImage name does make sense with respect to the
>> "legacy" uImages.
>
> Well, you can read "uImage" as "universal Image", which kind of fits
> the FIT approach :-)

I agree that the FIT image is a type of "universal Image", but I think 
"FIT image" is much more descriptive and accurate than "universal 
Image".  The FIT naming convention is designed to match device tree 
naming, which has lots of meaning.  eg:
   Flattened Device Tree (FDT) -> Flattened Image Tree (FIT)
   device tree source (.dts) -> image tree source (.its)
   device tree blob (.dtb) -> image tree blob (.itb)

>> My vote would be to make the Linux FIT target rule "fitImage" and then
>> update the U-Boot documentation to make obvious the differences between
>> uImages and FIT images.
>
> I think we should not try to support both legacy and FIT images on the
> same level - the idea is clearly that legacy images is the old, to be
> replaced format, while FIT images is the new, to be used as standard
> format.

Agreed.

In this sense I vote for using plain and simple "uImage" for
> the (new) standard format, and marking the old format by some ".old"
> or ".legacy" suffix.

I disagree here.  I don't think calling FIT images "FIT uImages" adds 
much value and it would add confusion as there are now multiple uImage 
formats that a user needs to keep straight.  Keeping the legacy uImage 
naming/format the same, and calling the new FIT images "fitImage" (or 
possibly itbImage to line up with the dtbImage target) would make more 
sense to me.  Is there a compelling reason to keep the uImage word 
connected to FIT images?

Best,
Peter
