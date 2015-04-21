Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 352F31A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 16:15:40 +1000 (AEST)
In-Reply-To: <1429332441-18647-1-git-send-email-Lijun.Pan@freescale.com>
To: Lijun Pan <LIJUN.PAN@FREESCALE.COM>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/defconfig: new way of writing defconfig
Message-Id: <20150421061539.78B071401F6@ozlabs.org>
Date: Tue, 21 Apr 2015 16:15:39 +1000 (AEST)
Cc: Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-18-04 at 04:47:21 UTC, Lijun Pan wrote:
> It is always a headache dealing with different defconfigs
> though they only differ in few places. Hence we are proposing a new
> way of writing defconfig:

So on the whole this is looking promising, some comments ...

> 1. Define a basic defconfig say mpc85xx_basic_defconfig

Why can't we just use mpc85xx_defconfig ?

> 2. Spin off as much features as possible from mpc85xx_defconfig
> 	and create a separate config file, say, kvm_guest.config

> Every time we add a new feature, we don't need to change several
> defconfigs, we just add a new *.config
> And you could merge any fragments you want into .config with the
> current kconfig in Kernel.
> 
> Say you want to build mpc85xx_smp_defconfig, you do 3 steps
> make mpc85xx_basic_defconfig
> make smp.config
> make kvm_guest.config

I'm not a big fan of that approach, but I guess it's fine for the more esoteric
combinations.


> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> ---
>  arch/powerpc/Makefile                              |  17 ++
>  ...t32_smp_defconfig => corenet32_basic_defconfig} |   0
>  ...t64_smp_defconfig => corenet64_basic_defconfig} |   0
>  arch/powerpc/configs/kvm_guest.config              |   2 +
>  .../{mpc85xx_defconfig => mpc85xx_basic_defconfig} |   0
>  arch/powerpc/configs/mpc85xx_smp_defconfig         | 244 ---------------------
>  arch/powerpc/configs/smp.config                    |   1 +
>  7 files changed, 20 insertions(+), 244 deletions(-)
>  rename arch/powerpc/configs/{corenet32_smp_defconfig => corenet32_basic_defconfig} (100%)
>  rename arch/powerpc/configs/{corenet64_smp_defconfig => corenet64_basic_defconfig} (100%)
>  create mode 100644 arch/powerpc/configs/kvm_guest.config
>  rename arch/powerpc/configs/{mpc85xx_defconfig => mpc85xx_basic_defconfig} (100%)
>  delete mode 100644 arch/powerpc/configs/mpc85xx_smp_defconfig
>  create mode 100644 arch/powerpc/configs/smp.config
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index fc502e0..590b441 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -269,6 +269,23 @@ bootwrapper_install:
>  %.dtb: scripts
>  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
> +define domerge
> +       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh $(srctree)/.config $(srctree)/arch/powerpc/configs/$(1).config
> +endef

Please look at mergeconfig in scripts/kconfig/Makefile. This needs to:
 - deal with objtree/srctree
 - run oldconfig
 - can you call it mergeconfig

> +mpc85xx_defconfig: mpc85xx_basic_defconfig
> +	@:
> +
> +mpc85xx_smp_defconfig: mpc85xx_basic_defconfig
> +	$(call domerge,smp)
> +	$(call domerge,kvm_guest)
> +
> +corenet32_smp_defconfig: corenet32_basic_defconfig
> +	$(call domerge,smp)
> +
> +corenet64_smp_defconfig: corenet64_basic_defconfig
> +	$(call domerge,smp)

Can these be further consolidated into a corenet_defconfig and then a 32-bit
and 64-bit config?


> diff --git a/arch/powerpc/configs/kvm_guest.config b/arch/powerpc/configs/kvm_guest.config
> new file mode 100644
> index 0000000..615b0a0
> --- /dev/null
> +++ b/arch/powerpc/configs/kvm_guest.config
> @@ -0,0 +1,2 @@
> +CONFIG_KVM_GUEST=y
> +CONFIG_PPC_QEMU_E500=y

This isn't a general "kvm_guest" config, ie. we don't want that enabled on
64-bit guest kernels. So can you call it kvm_e500.config or something.


Finally can you do some tests to show that the resulting .config is identical
before and after your patch, and demonstrate that in your changelog.

cheers
