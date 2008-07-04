Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.244])
	by ozlabs.org (Postfix) with ESMTP id 00ECCDDDEA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 16:51:45 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so6590791agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 23:51:44 -0700 (PDT)
Message-ID: <fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
Date: Fri, 4 Jul 2008 00:51:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify additional
	default targets
In-Reply-To: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone had a chance to look at this?  I think this could be used to
eliminate a lot of the platform specific default targets in
arch/powerpc/boot/Makefile by moving them into the defconfigs.  Josh,
Kumar, what are your thoughts?

g.

On Tue, Jul 1, 2008 at 11:59 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> It is inconvenient to add additional default targets to the bootwrapper
> Makefile for each new board supported which just needs a different dts
> file.  This change allows the defconfig to specify additional build
> targets.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/Kconfig       |   13 +++++++++++++
>  arch/powerpc/boot/Makefile |    3 +++
>  2 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..f09f617 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -458,6 +458,19 @@ config CMDLINE
>          some command-line options at build time by entering them here.  In
>          most cases you will need to specify the root device here.
>
> +config EXTRA_TARGETS
> +       string "Additional default image types"
> +       help
> +         List additional targets to be built by the bootwrapper here (separated
> +         by spaces).  This is useful for targets that depend of device tree
> +         files in the .dts directory.
> +
> +         Targets in this list will be build as part of the default build
> +         target, or when the user does a 'make zImage' or a
> +         'make zImage.initrd'.
> +
> +         If unsure, leave blank
> +
>  if !44x || BROKEN
>  config ARCH_WANTS_FREEZER_CONTROL
>        def_bool y
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 1cee2f9..1e38237 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -270,6 +270,9 @@ ifeq ($(CONFIG_PPC32),y)
>  image-$(CONFIG_PPC_PMAC)       += zImage.coff zImage.miboot
>  endif
>
> +# Allow extra targets to be added to the defconfig
> +image-y        += $(subst ",,$(CONFIG_EXTRA_TARGETS))
> +
>  initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
>  initrd-y := $(patsubst zImage%, zImage.initrd%, \
>                $(patsubst dtbImage%, dtbImage.initrd%, \
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
