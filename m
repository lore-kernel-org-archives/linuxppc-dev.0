Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4AA3B6EFE
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2010 13:09:01 +1100 (EST)
Message-ID: <4B413F3D.2000601@xes-inc.com>
Date: Sun, 03 Jan 2010 19:07:09 -0600
From: Peter Tyser <ptyser@xes-inc.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [PATCH v2 3/3] powerpc: Add support for ram filesystems
	in FIT uImages
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
	<1262221856.29396.104.camel@localhost.localdomain>
	<fa686aa41001022108i92596d6qdf2da0e24c34767e@mail.gmail.com>
	<20100103101048.AF4B7E34A26@gemini.denx.de>
In-Reply-To: <20100103101048.AF4B7E34A26@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

<snip>

> Note that the FIT image can also be made to contain a number of DT
> blobs, and selection of a "board profile" then can be used to boot the
> very sane FIT image file on any of the supported boards - so FIT
> images inherently support multibooting.

I agree with Wolfgang.  Additionally, if a FIT image does contain a .dtb 
file, firmware can ignore it and load a different .dtb file.  So for the 
fitImage.<boardname> target you could think of it as including a 
"default/fallback" .dtb file, not a mandatory one.  So the FIT image 
could still be used as a multiplatform image even if it contained dtbs.

>>> I see your point.  The main goal of the patch was to introduce FIT image
>>> support as its the new, more flexible, "better", standard image format
>>> for U-Boot going forward.  Also, lots people aren't aware of FIT images
>>> and the cool stuff they can do with them, so what better way to get the
>>> word out than getting support for FIT images included in the kernel
>>> proper:)
>>
>> Define 'better'.  :-)
>
> FIT images are better than the old uImage format because they:
>
> - allow for strong checksum algorithms like MD5, SHA1, ... (the plain
>    CRC32 method is not good enough if you for example want to run
>    software in a slot machine in Las Vegas).
>
> - can combine multiple kernel images, device tree blobs and root file
>    system images in arbitrary combinations; this allows for example
>    for multibooting the same image on different boards by selecting
>    the right DTB, for software updates with automatic fall-back, etc.
>
> - can be extended to add new features, images types or whatever in a
>    standard way, using a standard technology (device tree support)
>    which is already present anyway, i. e. without additional code
>    overhead.

Other advantages of FIT images that I see day-to-day include:
- Adding meta-data such as timestamps and version information for each 
component of the FIT image.  Its great to be able to easily display the 
contents of a FIT image to determine which kernel versions it contains, etc.

- Embed multiple OS/dtb images in one FIT image.  As a board vendor its 
nice to give a customer 1 image that has example dtb(s) and Linux, 
VxWorks, QNX, diagnostic, etc kernels.  They can boot a number of OSes 
on a number of different boards with 1 image.

- You can extract the images contained in a FIT image using 'dtc' to 
convert the FIT image to a ".dts" file that has the raw image contents. 
  Other image formats are more difficult to extract contents from.

<snip>

>> I'd be okay (perhaps not happy, but okay) with merging fitImage and
>> fitImage.initrd targets (no dtb).  I will resist merging fitImage.%
>> and fitImage.initrd.% targets because I see that very much as a
>> project specific deployment target and I'm not convinced yet that it
>> the pattern is right or that it is even needed in the kernel at all.
>
> Is this just your personal opinion, or do you think that this is
> really what a majority of kernel developers and users are wanting?
>
> Speaking for myself, I have to admit that I don't understand and don't
> share this attitude.

I agree with Wolfgang that many people would find the combined 
kernel/dtb/ramfs useful, but understand Grant's reservations.  Assuming 
I rework the patch to include a "fitImage" (no dtb) target, for the 
users that basic multiplatform images are important to, they could build 
this kernel-only FIT image.  For people such as Wolfgang, Peter, and 
myself who would like to bundle a kernel + dtb(s), we could use the 
fitImage.<boardname> target.  Wouldn't both parties be happy then?  I 
could make the FIT documentation explain the benefits of multiplatform 
images or warn about the combined kernel/dtb FIT images if that made a 
difference too.

Best,
Peter
