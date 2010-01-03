Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196]) by ozlabs.org (Postfix) with ESMTP id 60744B6EEE
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 16:19:12 +1100 (EST)
Received: by yxe34 with SMTP id 34so12687173yxe.16
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Jan 2010 21:19:10 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100101141205.6F0B13F6FF@gemini.denx.de>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
	<20100101141205.6F0B13F6FF@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 Jan 2010 22:18:50 -0700
Message-ID: <fa686aa41001022118w6b41765ld145c646bfca9423@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Jan 1, 2010 at 7:12 AM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant,
>
> In message <fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com> y=
ou wrote:
>>
>> Thinking further, I do actually have another concern, at least with
>> regard to the way the current patch set implements things. =A0Is it
>> expected or even "recommended" that fit images will *always* contain a
>> .dtb image? =A0The current patch only handles the case of a .dtb
>> embedded inside the fit image.
>
> I think this can be expected.
>
> Historically, the need to pass the dtb image to the Linux kernel,
> too, was what actually triggered the development of the FIT image
> format, as it turned out that the old image format with it's fixed
> binary header was too inflexible. So bundling the kernel image and
> the device tree blob into one image file is the specific use case
> this image format was created for (which does not mean that other
> usage would be impossible).
>
>> Personally, I don't get any benefit out of the new image format, so I
>> haven't spent any time looking at it. =A0However, I'm concerned about
>
> Assume you want to boot over DHCP or similar, where you can provide
> just a single image file for download. Here it is definitely nice if
> you can bundle the kernel image and the DTB into one image file. We
> were able to extend the old so-called "multi-file" uImage format to
> handle this situation, too, but it was clear that further extensions
> were not really possible.
>
> We consider the old legace uImage format as something we want to move
> away from, and the new FIT image format shall be the new default.
>
>> the drift back towards a different image per target when the move over
>> the last 4 years has been towards multiplatform kernel images. =A0I
>> certainly don't want to encourage embedding the device tree blob into
>> the kernel image, and I'm not very interested in merging code to do
>> that into the kernel tree. =A0If someone really needs to do that for
>> their particular target, it is certainly easy enough for them to weld
>> in the .dtb after the fact before transferring the image to the
>> target, but I want that mode to be the exception, not the rule.
>
> This is specific for particular targets, but for =A0specific =A0modes =A0=
of
> operation, =A0like =A0booting =A0over =A0the network or other szenarios w=
here
> transferring a single image file is essential - another example where
> we often see this request is upgrade procedures for devics, where the
> vendor wants to be able to distribute a single file =A0for =A0his =A0targ=
et
> systems =A0 to =A0avoid =A0customers =A0bricking =A0their =A0devices =A0b=
y =A0chosing
> incompatible combinations.

As I said in a previous email; I understand the need for certain
scenarios, but in the general case it is not the mode that I think
should be encouraged.  I don't want to merge additional targets for
.dtb embedded in the kernel image unless absolutely necessary, and I
want developers to have the mindset that .dtbs should be separate from
the kernel; and should be quasi-stable (or at least more stable than
the kernel itself) because I think that multiplatform is important,
and is going to become more important in the future.

So I don't want to support it by default; but OTOH, I'm not going to
actively prevent embedded .dtb blobs either.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
