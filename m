Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 9423F1007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 10:02:53 +1100 (EST)
Received: by yxe8 with SMTP id 8so13090633yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 15:02:52 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 30 Dec 2009 16:02:32 -0700
Message-ID: <fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
To: Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 6:50 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> The PowerPC architecture has the ability to embed the ramdisk located
> at arch/powerpc/boot/ramdisk.image.gz into a bootable kernel image. =A0If
> the bootable kernel is in the Flattened Image Tree (FIT) format, the
> ramdisk should be a node in the tree instead of being embedded directly
> in the kernel executable.
>
> A FIT uImage with a ram filesystem can be generated using the command:
> "make uImage.fit.initrd.<boardname>" where <boardname> is one of
> arch/powerpc/boot/dts/<boardname>.dts. =A0The command will generate a FIT
> uImage at arch/powerpc/boot/uImage.fit.initrd.<boardname> that contains
> a kernel image, device tree blob, and a ram filesystem.
>
> The ramdisk at arch/powerpc/boot/ramdisk.image.gz can either be an older
> style "ramdisk" or a newer "ramfs" gzipped cpio archive.
>
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> ---
> Changes since v1:
> - Don't strip leading 0x from dts ramdisk address
>
> =A0arch/powerpc/boot/Makefile | =A0 =A03 +++
> =A0arch/powerpc/boot/wrapper =A0| =A0 20 ++++++++++++++++----
> =A0scripts/mkits.sh =A0 =A0 =A0 =A0 =A0 | =A0 34 ++++++++++++++++++++++++=
++++++++--
> =A03 files changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index e56ec21..c2a6591 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -313,6 +313,9 @@ $(obj)/uImage: vmlinux $(wrapperbits)
> =A0$(obj)/uImage.fit.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> =A0 =A0 =A0 =A0$(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb)
>
> +$(obj)/uImage.fit.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> + =A0 =A0 =A0 $(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb,$(obj)/ramd=
isk.image.gz)
> +

IIRC, uImage.fit.initrd.% should appear before uImage.fit.% in the
Makefile so that make behaves more consistently.  Speaking of which,
the number of '.' in the name is getting rather large.  Would you
consider using 'fitImage' instead of 'uImage.fit'?

g.
