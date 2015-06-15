Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AD851A0252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 09:31:35 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 138AB140273
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2015 09:31:33 +1000 (AEST)
Message-ID: <1434411058.2353.13.camel@freescale.com>
Subject: Re: [PATCH v4] powerpc/defconfig: new way of writing defconfig
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
CC: <linuxppc-dev@ozlabs.org>
Date: Mon, 15 Jun 2015 18:30:58 -0500
In-Reply-To: <1434163932-32741-1-git-send-email-Lijun.Pan@freescale.com>
References: <1434163932-32741-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-12 at 21:52 -0500, Lijun Pan wrote:
> It is always a headache dealing with different defconfigs
> though they only differ in a few places. Hence we are proposing a new
> way of writing the defconfig:
> 1. Define a basic defconfig say mpc85xx_basic_defconfig
> 2. Spin off as much features as possible from the current 
> mpc85xx_defconfig
>       and create a separate config file, say, smp.config, kvm_500.config
> Every time we add a new feature, we don't need to change several
> defconfigs, we just add a new *.config
> And you could merge any fragments you want into .config with the
> current kconfig in Kernel.
> 
> With the new rules added into arch/powerpc/Makefile,
> you can make it like before, e.g.
> make mpc85xx_smp_defconfig
> 
> In order to keep the final .config the same as before,
> we must first merge all the fragments (without make) repeatedly,
> and at last do "make" only once.
> 
> The make steps below will generate a different .config as above.
> We should not take the following steps.
> e.g.
> make mpc85xx_basic_defconfig
> make smp.config
> make kvm_guest.config
> 
> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> ---
> v4 changes:
>  1. removed many fragments according to the review feedback in v3
>  2. I cannot reuse the code in 
> http://patchwork.ozlabs.org/patch/476345/ 
>     since I have multiple fragments to merge while the that patch 
> only
>     has one fragment.

merge_into_defconfig works with multiple fragments, like this:

        $(call merge_into_defconfig,base_defconfig,frag1 frag2 frag3)

Even if it were true, the answer would be to fix it rather than to add 
a second mechanism.

When a change is requested and you don't think that change will work, 
respond to it rather than just proceeding with a new version that 
ignores the request.


>  arch/powerpc/Makefile                              |  34 +++
>  arch/powerpc/configs/altivec.config                |   1 +
>  arch/powerpc/configs/book3e-64.config              |   2 +
>  arch/powerpc/configs/corenet32_misc.config         |  35 +++
>  arch/powerpc/configs/corenet32_smp_defconfig       | 185 -----------
> ----
>  arch/powerpc/configs/corenet64_misc.config         |  16 ++
>  ...net64_smp_defconfig => corenet_basic_defconfig} |  29 +--
>  arch/powerpc/configs/dma.config                    |   2 +
>  arch/powerpc/configs/kvm_guest.config              |   2 +
>  arch/powerpc/configs/math_emulation.config         |   2 +
>  arch/powerpc/configs/mpc85xx.config                |   1 +
>  ...c85xx_smp_defconfig => mpc85xx_basic_defconfig} |   8 +-
>  arch/powerpc/configs/mpc85xx_defconfig             | 252 -----------
> ----------
>  arch/powerpc/configs/mpc85xx_misc.config           |  11 +
>  arch/powerpc/configs/non-hardware.config           |   4 +
>  arch/powerpc/configs/smp.config                    |   1 +
>  16 files changed, 116 insertions(+), 469 deletions(-)
>  create mode 100644 arch/powerpc/configs/altivec.config
>  create mode 100644 arch/powerpc/configs/book3e-64.config
>  create mode 100644 arch/powerpc/configs/corenet32_misc.config
>  delete mode 100644 arch/powerpc/configs/corenet32_smp_defconfig
>  create mode 100644 arch/powerpc/configs/corenet64_misc.config
>  rename arch/powerpc/configs/{corenet64_smp_defconfig => 
> corenet_basic_defconfig} (84%)
>  create mode 100644 arch/powerpc/configs/dma.config
>  create mode 100644 arch/powerpc/configs/kvm_guest.config
>  create mode 100644 arch/powerpc/configs/math_emulation.config
>  create mode 100644 arch/powerpc/configs/mpc85xx.config
>  rename arch/powerpc/configs/{mpc85xx_smp_defconfig => 
> mpc85xx_basic_defconfig} (98%)
>  delete mode 100644 arch/powerpc/configs/mpc85xx_defconfig
>  create mode 100644 arch/powerpc/configs/mpc85xx_misc.config
>  create mode 100644 arch/powerpc/configs/non-hardware.config
>  create mode 100644 arch/powerpc/configs/smp.config
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index fc502e0..40b6a81 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -269,6 +269,40 @@ bootwrapper_install:
>  %.dtb: scripts
>       $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
> +configfiles=$(wildcard $(srctree)/kernel/configs/$(1).config 
> $(srctree)/arch/$(SRCARCH)/configs/$(1).config)
> +
> +define mergeconfig
> +$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m -O
> $(objtree) $(srctree)/.config $(call configfiles,$(1))
> +endef
> +
> +PHONY += mpc85xx_defconfig mpc85xx_smp_defconfig 
> corenet32_smp_defconfig corenet64_smp_defconfig
> +mpc85xx_defconfig:
> +     $(Q)cp $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig 
> $(srctree)/.config
> +     $(call mergeconfig,mpc85xx_misc)
> +     $(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> +
> +mpc85xx_smp_defconfig:
> +     $(Q)cp $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig 
> $(srctree)/.config
> +     $(call mergeconfig,smp)
> +     $(call mergeconfig,kvm_guest)
> +     $(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> +
> +corenet32_smp_defconfig:
> +     $(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_basic_defconfig 
> $(srctree)/.config
> +     $(call mergeconfig,mpc85xx)
> +     $(call mergeconfig,corenet32_misc)
> +     $(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> +
> +corenet64_smp_defconfig:
> +     $(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_basic_defconfig 
> $(srctree)/.config
> +     $(call mergeconfig,book3e-64)
> +     $(call mergeconfig,altivec)
> +     $(call mergeconfig,dma)
> +     $(call mergeconfig,math_emulation)
> +     $(call mergeconfig,non-hardware)
> +     $(call mergeconfig,corenet64_misc)
> +     $(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> +
>  define archhelp
>    @echo '* zImage          - Build default images selected by 
> kernel config'
>    @echo '  zImage.*        - Compressed kernel image 
> (arch/$(ARCH)/boot/zImage.*)'
> diff --git a/arch/powerpc/configs/altivec.config 
> b/arch/powerpc/configs/altivec.config
> new file mode 100644
> index 0000000..58a697c
> --- /dev/null
> +++ b/arch/powerpc/configs/altivec.config
> @@ -0,0 +1 @@
> +CONFIG_ALTIVEC=y
> diff --git a/arch/powerpc/configs/book3e-64.config 
> b/arch/powerpc/configs/book3e-64.config
> new file mode 100644
> index 0000000..85f4cf2
> --- /dev/null
> +++ b/arch/powerpc/configs/book3e-64.config
> @@ -0,0 +1,2 @@
> +CONFIG_PPC64=y
> +CONFIG_PPC_BOOK3E_64=y
> diff --git a/arch/powerpc/configs/corenet32_misc.config 
> b/arch/powerpc/configs/corenet32_misc.config
> new file mode 100644
> index 0000000..0b32130
> --- /dev/null
> +++ b/arch/powerpc/configs/corenet32_misc.config
> @@ -0,0 +1,35 @@
> +CONFIG_AT803X_PHY=y
> +CONFIG_AUDIT=y
> +CONFIG_CHR_DEV_ST=y
> +CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=n
> +CONFIG_CRAMFS=y
> +CONFIG_E1000=y
> +CONFIG_EDAC_MPC85XX=y
> +CONFIG_EMBEDDED=y
> +CONFIG_EXT3_DEFAULTS_TO_ORDERED=n
> +CONFIG_FORCE_MAX_ZONEORDER=13
> +CONFIG_HIGHMEM=y
> +CONFIG_INET_AH=y
> +CONFIG_INET_IPCOMP=y
> +CONFIG_KEXEC=y
> +CONFIG_LEGACY_PTYS=n
> +CONFIG_NET_KEY_MIGRATE=y
> +CONFIG_NVRAM=y
> +CONFIG_PATA_SIL680=y
> +CONFIG_PCI=y
> +CONFIG_PCIEASPM=n
> +CONFIG_PERF_EVENTS=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_RCU_TRACE=y
> +CONFIG_SATA_AHCI=y
> +CONFIG_SATA_SIL=y
> +CONFIG_SCSI_LOGGING=y
> +CONFIG_SCSI_SYM53C8XX_2=y
> +CONFIG_SLAB=y
> +CONFIG_STAGING=y
> +CONFIG_UIO=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
> +CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
> +CONFIG_XFRM_STATISTICS=y
> +CONFIG_XFRM_SUB_POLICY=y

What does all of this have to do with corenet32?

Where are the preliminary patches I asked for eliminating 
inconsistencies?

> diff --git a/arch/powerpc/configs/corenet64_misc.config 
> b/arch/powerpc/configs/corenet64_misc.config
> new file mode 100644
> index 0000000..c079055
> --- /dev/null
> +++ b/arch/powerpc/configs/corenet64_misc.config
> @@ -0,0 +1,16 @@
> +CONFIG_BLK_DEV_SR_VENDOR=y
> +CONFIG_CRC_T10DIF=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_DUMMY=y
> +CONFIG_EEPROM_LEGACY=y
> +CONFIG_EXPERT=y
> +CONFIG_FHANDLE=y
> +CONFIG_FRAME_WARN=1024
> +CONFIG_FTL=y
> +CONFIG_INET_XFRM_MODE_BEET=n
> +CONFIG_INPUT_FF_MEMLESS=m
> +CONFIG_IRQ_DOMAIN_DEBUG=y
> +CONFIG_JFFS2_FS_DEBUG=1
> +CONFIG_MTD_UBI=y
> +CONFIG_PPC_OF_BOOT_TRAMPOLINE=n
> +CONFIG_UBIFS_FS=y

What does this stuff have to do with corenet64?  Why wouldn't we want 
ubifs on 32-bit?

> diff --git a/arch/powerpc/configs/dma.config 
> b/arch/powerpc/configs/dma.config
> new file mode 100644
> index 0000000..f0e66b5
> --- /dev/null
> +++ b/arch/powerpc/configs/dma.config
> @@ -0,0 +1,2 @@
> +CONFIG_DMADEVICES=y
> +CONFIG_FSL_DMA=y

Why is this a fragment?  We want this on all FSL PPC configs.

> diff --git a/arch/powerpc/configs/kvm_guest.config 
> b/arch/powerpc/configs/kvm_guest.config
> new file mode 100644
> index 0000000..9e7eef9
> --- /dev/null
> +++ b/arch/powerpc/configs/kvm_guest.config
> @@ -0,0 +1,2 @@
> +CONFIG_KVM_GUEST=y
> +CONFIG_VIRT_DRIVERS=y

Where are the virtio drivers I mentioned?


> diff --git a/arch/powerpc/configs/math_emulation.config 
> b/arch/powerpc/configs/math_emulation.config
> new file mode 100644
> index 0000000..fa2fb66
> --- /dev/null
> +++ b/arch/powerpc/configs/math_emulation.config
> @@ -0,0 +1,2 @@
> +CONFIG_MATH_EMULATION=y
> +CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y

This is not appropriate for all cores that need math emu -- only cores 
like e5500/e6500 that implement most of the FPU but are missing some 
instructions that the toolchain uses.

-Scott
