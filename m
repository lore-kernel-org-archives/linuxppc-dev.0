Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23E661A0378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 08:18:16 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34F6F1401DA
 for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2015 08:18:14 +1000 (AEST)
Message-ID: <1431555481.3868.95.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc/defconfig: new way of writing defconfig
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
Date: Wed, 13 May 2015 17:18:01 -0500
In-Reply-To: <1431405562-25449-1-git-send-email-Lijun.Pan@freescale.com>
References: <1431405562-25449-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-05-11 at 23:39 -0500, Lijun Pan wrote:
> It is always a headache dealing with different defconfigs
> though they only differ in a few places. Hence we are proposing a new
> way of writing the defconfig:
> 1. Define a basic defconfig say mpc85xx_basic_defconfig
> 2. Spin off as much features as possible from the current mpc85xx_defconfig
> 	and create a separate config file, say, smp.config, kvm_500.config
> Every time we add a new feature, we don't need to change several
> defconfigs, we just add a new *.config
> And you could merge any fragments you want into .config with the
> current kconfig in Kernel.
> 
> Say you want to build mpc85xx_smp_defconfig, you do 7 steps:
> make mpc85xx_basic_defconfig
> make 32bit.config
> make smp.config
> make cpu8.config
> make kvm_e500.config
> make uart2.config
> make i2c.config
> 
> With the new rules added into arch/powerpc/Makefile,
> you can do it in one step:
> make mpc85xx_smp_defconfig

We currently do it in one step.  The 7 step version exists only in
previous versions of this patch, and won't be in the git history, so
such comments should go beneath the --- line.

> directory "scottwood" has my patch,
> directory "scottwood" does not have my patch

You shouldn't be working off of my repository unless it has patches
(that you need or that would conflict) that haven't yet been merged
upstream.

> [b44306@b44306-12 scottwood]$ ./scripts/diffconfig ../scottwood2/.config .config
>  EPAPR_PARAVIRT n -> y
>  KVM_GUEST n -> y
>  PPC_QEMU_E500 n -> y
> // these changes are expected since mpc85xx_smp_defconfig has enabled kvm_e500.config in freescale's internal git repo.	> 

What does our internal git repo have to do with anything?
 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index fc502e0..7c80298 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -269,6 +269,52 @@ bootwrapper_install:
>  %.dtb: scripts
>  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
> +configfiles=$(wildcard $(srctree)/kernel/configs/$(1).config $(srctree)/arch/$(SRCARCH)/configs/$(1).config)
> +
> +define mergeconfig
> +$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m -O $(objtree)/arch/$(SRCARCH)/configs $(objtree)/arch/$(SRCARCH)/configs/.config $(call configfiles,$(1))
> +endef

Why not invoke make with the <whatever>.config target instead?

> +
> +mpc85xx_defconfig:
> +	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig $(srctree)/arch/$(SRCARCH)/configs/.config

Don't modify $(srctree), ever.  Why not just depend on the mpc85xx_basic_defconfig target?

> +	$(call mergeconfig,32-bit)
> +	$(call mergeconfig,uart6)
> +	$(call mergeconfig,mpc85xx_misc)
> +	$(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config $(objtree)/arch/$(SRCARCH)/configs/mpc85xx_tmp_defconfig
> +	$(Q)$(MAKE) -f $(srctree)/Makefile mpc85xx_tmp_defconfig
> +
> +mpc85xx_smp_defconfig:
> +	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig $(srctree)/arch/$(SRCARCH)/configs/.config
> +	$(call mergeconfig,32-bit)
> +	$(call mergeconfig,smp)
> +	$(call mergeconfig,cpu8)
> +	$(call mergeconfig,kvm_e500)
> +	$(call mergeconfig,uart2)
> +	$(call mergeconfig,i2c)
> +	$(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config $(objtree)/arch/$(SRCARCH)/configs/mpc85xx_smp_tmp_defconfig
> +	$(Q)$(MAKE) -f $(srctree)/Makefile mpc85xx_smp_tmp_defconfig

There shouldn't be any difference besides "SMP" for mpc85xx_defconfig
versus mpc85xx_smp_defconfig.  I know someone previously asked you to
ensure this didn't change the results, but I think this is a good
opportunity to get rid of gratuitous differences, as long as you show
what the diff is between old and new so we can verify that the changes
are beneficial.

> +corenet32_smp_defconfig:
> +	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_defconfig $(srctree)/arch/$(SRCARCH)/configs/.config
> +	$(call mergeconfig,32-bit)

Isn't the basic config already 32-bit?

> +	$(call mergeconfig,smp)
> +	$(call mergeconfig,cpu8)
> +	$(call mergeconfig,corenet32_misc)
> +	$(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config $(objtree)/arch/$(SRCARCH)/configs/corenet32_smp_tmp_defconfig
> +	$(Q)$(MAKE) -f $(srctree)/Makefile corenet32_smp_tmp_defconfig
> +
> +corenet64_smp_defconfig:
> +	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_defconfig $(srctree)/arch/$(SRCARCH)/configs/.config
> +	$(call mergeconfig,64-bit)
> +	$(call mergeconfig,smp)
> +	$(call mergeconfig,cpu24)
> +	$(call mergeconfig,dma)
> +	$(call mergeconfig,math_emulation)
> +	$(call mergeconfig,cgroup)
> +	$(call mergeconfig,corenet64_misc)
> +	$(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config $(objtree)/arch/$(SRCARCH)/configs/corenet64_smp_tmp_defconfig
> +	$(Q)$(MAKE) -f $(srctree)/Makefile corenet64_smp_tmp_defconfig

math emulation?

>  define archhelp
>    @echo '* zImage          - Build default images selected by kernel config'
>    @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> diff --git a/arch/powerpc/configs/32-bit.config b/arch/powerpc/configs/32-bit.config
> new file mode 100644
> index 0000000..3b8b43b
> --- /dev/null
> +++ b/arch/powerpc/configs/32-bit.config
> @@ -0,0 +1 @@
> +CONFIG_PPC_85xx=y

Not all 32-bit platforms are 85xx.

> diff --git a/arch/powerpc/configs/64-bit.config b/arch/powerpc/configs/64-bit.config
> new file mode 100644
> index 0000000..b53af55
> --- /dev/null
> +++ b/arch/powerpc/configs/64-bit.config
> @@ -0,0 +1,3 @@
> +CONFIG_PPC64=y
> +CONFIG_PPC_BOOK3E_64=y
> +CONFIG_ALTIVEC=y

Not all 64-bit platforms are book3e, and Altivec should probably be
separate, especially given the impact it has on -mcpu.

> diff --git a/arch/powerpc/configs/cgroup.config b/arch/powerpc/configs/cgroup.config
> new file mode 100644
> index 0000000..a6012a3
> --- /dev/null
> +++ b/arch/powerpc/configs/cgroup.config
> @@ -0,0 +1,4 @@
> +CONFIG_CGROUPS=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_CGROUP_SCHED=y

Is there any significant downside to enabling this?  As I think I said
before, I was hoping for one largeish fragment for all
non-hardware-specific stuff that we want to enable by default on all
of our configs.

I don't want it to be super-fine-grained, and I especially don't want
some eclectic mix of fine-grained and course-grained.

> diff --git a/arch/powerpc/configs/corenet32_misc.config b/arch/powerpc/configs/corenet32_misc.config
> new file mode 100644
> index 0000000..4ad0ea1
> --- /dev/null
> +++ b/arch/powerpc/configs/corenet32_misc.config
> @@ -0,0 +1,36 @@
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
> +CONFIG_PPC_85xx=y
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

None of this is 32-bit specific.

> diff --git a/arch/powerpc/configs/corenet64_misc.config b/arch/powerpc/configs/corenet64_misc.config
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

None of this is 64-bit specific.

> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet_defconfig
> similarity index 83%
> rename from arch/powerpc/configs/corenet64_smp_defconfig
> rename to arch/powerpc/configs/corenet_defconfig
> index 33cd1df..89c43ee 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet_defconfig

Why is "corenet_defconfig" not "basic" like "mpc85xx_basic_defconfig"?

> diff --git a/arch/powerpc/configs/cpu24.config b/arch/powerpc/configs/cpu24.config
> new file mode 100644
> index 0000000..08d2f61
> --- /dev/null
> +++ b/arch/powerpc/configs/cpu24.config
> @@ -0,0 +1 @@
> +CONFIG_NR_CPUS=24
> diff --git a/arch/powerpc/configs/cpu8.config b/arch/powerpc/configs/cpu8.config
> new file mode 100644
> index 0000000..8832f89
> --- /dev/null
> +++ b/arch/powerpc/configs/cpu8.config
> @@ -0,0 +1 @@
> +CONFIG_NR_CPUS=8

Move this to the basic config file for the CPU family.

> diff --git a/arch/powerpc/configs/dma.config b/arch/powerpc/configs/dma.config
> new file mode 100644
> index 0000000..f0e66b5
> --- /dev/null
> +++ b/arch/powerpc/configs/dma.config
> @@ -0,0 +1,2 @@
> +CONFIG_DMADEVICES=y
> +CONFIG_FSL_DMA=y

Why does this need to be separate?

> diff --git a/arch/powerpc/configs/i2c.config b/arch/powerpc/configs/i2c.config
> new file mode 100644
> index 0000000..aafb657
> --- /dev/null
> +++ b/arch/powerpc/configs/i2c.config
> @@ -0,0 +1 @@
> +CONFIG_I2C=y
> diff --git a/arch/powerpc/configs/kvm_e500.config b/arch/powerpc/configs/kvm_e500.config
> new file mode 100644
> index 0000000..615b0a0
> --- /dev/null
> +++ b/arch/powerpc/configs/kvm_e500.config
> @@ -0,0 +1,2 @@
> +CONFIG_KVM_GUEST=y
> +CONFIG_PPC_QEMU_E500=y

CONFIG_PPC_QEMU_E500 should be always enabled like any other target.

As for KVM guest support, the standard name for this is
kvm_guest.config based on the rule in scripts/kconfig/Makefile, and it
should also include common virtio drivers.

> diff --git a/arch/powerpc/configs/math_emulation.config b/arch/powerpc/configs/math_emulation.config
> new file mode 100644
> index 0000000..fa2fb66
> --- /dev/null
> +++ b/arch/powerpc/configs/math_emulation.config
> @@ -0,0 +1,2 @@
> +CONFIG_MATH_EMULATION=y
> +CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
> diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_basic_defconfig
> similarity index 97%
> rename from arch/powerpc/configs/mpc85xx_smp_defconfig
> rename to arch/powerpc/configs/mpc85xx_basic_defconfig

mpc85xx_smp_defconfig contains a lot of things that I wouldn't consider
"basic" (obscure filesystems, HID drivers, etc), though I suppose
that could be a later cleanup.

> index b6c7111..8cb47f4 100644
> --- a/arch/powerpc/configs/mpc85xx_smp_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_basic_defconfig
> @@ -1,7 +1,4 @@
> -CONFIG_PPC_85xx=y
>  CONFIG_PHYS_64BIT=y
> -CONFIG_SMP=y
> -CONFIG_NR_CPUS=8
>  CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_AUDIT=y
> @@ -128,14 +125,11 @@ CONFIG_INPUT_FF_MEMLESS=m
>  CONFIG_SERIO_LIBPS2=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_8250_NR_UARTS=2
> -CONFIG_SERIAL_8250_RUNTIME_UARTS=2
>  CONFIG_SERIAL_8250_MANY_PORTS=y
>  CONFIG_SERIAL_8250_DETECT_IRQ=y
>  CONFIG_SERIAL_8250_RSA=y
>  CONFIG_SERIAL_QE=m
>  CONFIG_NVRAM=y
> -CONFIG_I2C=y
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_CPM=m
>  CONFIG_I2C_MPC=y

Why no i2c?

> --- /dev/null
> +++ b/arch/powerpc/configs/uart2.config
> @@ -0,0 +1,2 @@
> +CONFIG_SERIAL_8250_NR_UARTS=2
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> diff --git a/arch/powerpc/configs/uart6.config b/arch/powerpc/configs/uart6.config
> new file mode 100644
> index 0000000..c7150c9
> --- /dev/null
> +++ b/arch/powerpc/configs/uart6.config
> @@ -0,0 +1,2 @@
> +CONFIG_SERIAL_8250_NR_UARTS=6
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=6

What's the harm in always setting it to 6?

-Scott
