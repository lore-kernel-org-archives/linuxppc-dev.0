Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id 05C25DDF3B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 07:09:54 +1100 (EST)
Date: Thu, 21 Feb 2008 12:03:09 -0800
Subject: Re: [PATCH] [POWERPC] add target for building .dtb files
From: Grant Erickson <gerickson@nuovations.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <C3E318FD.D883%gerickson@nuovations.com>
In-Reply-To: <20080221191955.10139.10496.stgit@trillian.secretlab.ca>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/21/08 11:19 AM, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> ---
> 
> Josh, is this what your were looking for?
> 
> Cheers,
> g.
> ---
> 
>  arch/powerpc/Makefile      |    2 +-
>  arch/powerpc/boot/Makefile |    4 ++++
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index ab5cfe8..dd80825 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -164,7 +164,7 @@ boot := arch/$(ARCH)/boot
>  $(BOOT_TARGETS): vmlinux
> $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
> -bootwrapper_install:
> +bootwrapper_install %.dtb:
> $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
>  define archhelp
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index d57a67d..fb29f10 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -311,6 +311,10 @@ $(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts
> $(wrapperbits)
>  $(obj)/treeImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
> $(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts)
>  
> +# Rule to build device tree blobs
> +$(obj)/%.dtb: $(dtstree)/%.dts $(obj)/dtc
> + $(obj)/dtc -O dtb -o $(obj)/$*.dtb -b 0 $(dtstree)/$*.dts
> +

Grant,

Would it be beneficial to provide a way to have environment- or
command-line-provided DTC arguments/flags such that the oft-required '-S
<size>' and '-R <reserved>' flags can be specified? Or, are there reasonable
size and reserved defaults appropriate for all platforms that can be
specified?

FWIW, generating a blob for Haleakala/Kilauea on the PPC405EX[r] using the
above command in the patch results in complaints about lack of space for the
"CHOSEN" node in u-boot.

Regards,

Grant
