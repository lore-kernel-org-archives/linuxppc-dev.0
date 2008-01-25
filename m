Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 7B4B7DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:51:11 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so130322anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 21:51:10 -0800 (PST)
Message-ID: <fa686aa40801242151g303ab96dhbcb295ed14e13f52@mail.gmail.com>
Date: Thu, 24 Jan 2008 22:51:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, paulus@samba.org, scottwood@freescale.com,
	david@gibson.dropbear.id.au, "Kumar Gala" <galak@kernel.crashing.org>,
	"Jon Loeliger" <jdl@jdl.com>
Subject: Re: [PATCH/RFC] [POWERPC] Allow multiple images to be built when
	CONFIG_DEFAULT_UIMAGE set
In-Reply-To: <20080119035528.4286.67752.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080119035528.4286.67752.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anybody have comments/concerns on this one?

Cheers,
g.

On 1/18/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Most of the embedded board ports select CONFIG_DEFAULT_UIMAGE so that
> uImage files get built by default.  However, the current code casues
> the arch/powerpc/boot/Makefile to be called with the 'uImage' target
> and adds 'uImage' to the 'image-y' make variable.  If CONFIG_DEFAULT_UIMAGE
> is not set, then the boot makefile is called with target 'zImage'.
>
> However, the zImage target already automatically causes all targets
> listed in 'image-y' to be built, which includes uImage.
>
> This patch makes the default build target alwasy call the boot makefile
> using the 'zImage' target, regardless of if CONFIG_DEFAULT_UIMAGE is set.
> Making this change allows multiple boot images to be built from a single
> kernel compile.  An example of where this is useful is with the Efika
> and lite5200 boards.  Both boards can use the same kernel image (vmlinux),
> but they use different boot image files (zImage.chrp vs. uImage).  By
> making this change, the boot makefile now builds both by default so a
> single defconfig can be used for testing both platforms.
>
> This patch also eliminates the BOOTIMAGE variable because it doesn't
> appear to be used anywhere.  (Someone please correct me if I'm wrong)
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/Makefile |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index f70df9b..6451c2f 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -151,10 +151,7 @@ core-$(CONFIG_XMON)                += arch/powerpc/xmon/
>  drivers-$(CONFIG_OPROFILE)     += arch/powerpc/oprofile/
>
>  # Default to zImage, override when needed
> -defaultimage-y                 := zImage
> -defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
> -KBUILD_IMAGE := $(defaultimage-y)
> -all: $(KBUILD_IMAGE)
> +all: zImage
>
>  CPPFLAGS_vmlinux.lds   := -Upowerpc
>
> @@ -180,7 +177,7 @@ define archhelp
>  endef
>
>  install: vdso_install
> -       $(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
> +       $(Q)$(MAKE) $(build)=$(boot) install
>
>  vdso_install:
>  ifeq ($(CONFIG_PPC64),y)
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
