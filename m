Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id C4CD3B6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 05:11:36 +1100 (EST)
Received: by yxe9 with SMTP id 9so5611228yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:11:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <0016e646923c937a80047904c936@google.com>
References: <001636832accdcc8a40479024c96@google.com>
	<0016e646923c937a80047904c936@google.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Nov 2009 11:11:14 -0700
Message-ID: <fa686aa40911231011wc51f942xde7e06d33d755b12@mail.gmail.com>
Subject: Re: Fwd: Re: DTS for PowerPC 440 based board
To: vinayak.kale@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 23, 2009 at 12:29 AM,  <vinayak.kale@gmail.com> wrote:
> Hi,
>
> David, Grant thank you for providing the info.
> From your reply and the other sources what I gather is as below. Please
> confirm whether I am on the right track.
>
> 1) Bootloader passing BDInfo:
> Here, I have to create a .dts file inside /arch/powerpc/boot/dts directory.
> dtc compiles the .dts file and creates a dtb. The kernel, dtb and
> boot-wrapper are then embedded in a cuImage.* file after make. We need to
> write the platform-specific fix-ups in the cuboot-*.c file. The bootloader
> will pass BDInfo struct to kernel.

The bootloader will pass bdinfo to the bootwrapper (the cuImage)

> The kernel will also receive the dtb.

The bootwrapper will pass the dtb to the kernel proper.  bootloader
knows nothing about the dtb, and the kernel knows nothing about
bdinfo.

> The only kernel changes we need to do here are fixups in cuboot-*.c and
> creation of .dts file.

Correct.  But if you're doing a new board and have control over your
bootloader, then don't choose this option.  bdinfo structures

> 2) Bootloader passing DT:
> Here, the booloader will directly pass the DT instead of BDInfo. The
> platform-specific code in simpleboot.c will get excuted. We don't have to do
> any fixups inside kernel here.

simpleboot.c doesn't get run at all.  In fact, the bootwrapper doesn't
get used at all in this case.  The uImage is just the raw compressed
kernel image (vmlinux) with a uImage header on it.

> I have queries with this approach -
> a) In this case, who creates DT? Do we need to use any tools to create a DT?

The .dts file still lives in the kernel tree, and the kernel build
process still compiles it into a .dtb

> or it can be created the same way by compiling the .dts file using dtc?

yes

> b) From previous implementaions of other boards, I didn't see any platform
> specific fix-ups inside kernel being done? Why is so that in case of BDInfo
> we need fix-ups and here we don't?

because bdinfo is a horribly method of passing data to the kernel.  So
the bdinfo data needs to be translated into a form the kernel can use
(the device tree).  Fixups aren't needed with this approach because
the device tree passed by the bootloader already has all the correct
data in it.  U-Boot has the ability to modify the .dtb blob at boot
time to update things like the kernel parameters line and the memory
size if it needs to.

> Please confirm my understanding of above to approaches. Also please suggest
> which way is better.

Pass the device tree from the bootloader.  the bootwrapper method is
only to support firmware that cannot pass a device tree image, and
passing bdinfo is non-portable and can cause problems.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
