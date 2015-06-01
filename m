Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 756E81A0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 08:33:04 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0117.outbound.protection.outlook.com [207.46.100.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 976D41412E2
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2015 08:33:03 +1000 (AEST)
Message-ID: <1433195931.4089.181.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc/defconfig: new way of writing defconfig
From: Scott Wood <scottwood@freescale.com>
To: Pan Lijun-B44306 <Lijun.Pan@freescale.com>
CC: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Mon, 1 Jun 2015 16:58:51 -0500
In-Reply-To: <BY1PR03MB14528717D06152F7AB7023A5FCB60@BY1PR03MB1452.namprd03.prod.outlook.com>
References: <1431405562-25449-1-git-send-email-Lijun.Pan@freescale.com>
 <1431555481.3868.95.camel@freescale.com>
 <BY1PR03MB14528717D06152F7AB7023A5FCB60@BY1PR03MB1452.namprd03.prod.outlook.com>
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

On Mon, 2015-06-01 at 00:04 -0500, Pan Lijun-B44306 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, May 13, 2015 5:18 PM
> > To: Pan Lijun-B44306
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH v3] powerpc/defconfig: new way of writing 
> > defconfig
> > 
> > On Mon, 2015-05-11 at 23:39 -0500, Lijun Pan wrote:
> > > It is always a headache dealing with different defconfigs though 
> > > they
> > > only differ in a few places. Hence we are proposing a new way of
> > > writing the defconfig:
> > > 1. Define a basic defconfig say mpc85xx_basic_defconfig 2. Spin 
> > > off as
> > > much features as possible from the current mpc85xx_defconfig
> > >   and create a separate config file, say, smp.config, 
> > > kvm_500.config
> > > Every time we add a new feature, we don't need to change several
> > > defconfigs, we just add a new *.config And you could merge any
> > > fragments you want into .config with the current kconfig in 
> > > Kernel.
> > > 
> > > Say you want to build mpc85xx_smp_defconfig, you do 7 steps:
> > > make mpc85xx_basic_defconfig
> > > make 32bit.config
> > > make smp.config
> > > make cpu8.config
> > > make kvm_e500.config
> > > make uart2.config
> > > make i2c.config
> > > 
> > > With the new rules added into arch/powerpc/Makefile, you can do 
> > > it in
> > > one step:
> > > make mpc85xx_smp_defconfig
> > 
> > We currently do it in one step.  The 7 step version exists only in 
> > previous
> > versions of this patch, and won't be in the git history, so such 
> > comments should
> > go beneath the --- line.
> 
> Sure, I will put them beneath --- line in the next patch.
> 
> > 
> > > directory "scottwood" has my patch,
> > > directory "scottwood" does not have my patch
> > 
> > You shouldn't be working off of my repository unless it has 
> > patches (that you
> > need or that would conflict) that haven't yet been merged upstream.
> 
> I am working off an old commit. See the result from $"git log"
> 17a0f33 powerpc/defconfig: new way of writing defconfig
> d41444d powerpc/corenet: enable CONFIG_I2C_MUX and 
> CONFIG_I2C_MUX_PCA954x
> 7f9af0a powerpc/t2080qds: fix rtc interrupt
> 56302c5 powerpc/mpic: Remove WHOAMI readback after EOI

Don't do that.

[ b44306@b44306-12scottwood]$ ./scripts/diffconfig
> > > ../scottwood2/.config .config  EPAPR_PARAVIRT n -> y  KVM_GUEST n
> > > -> y
> > >  PPC_QEMU_E500 n -> y
> > > // these changes are expected since mpc85xx_smp_defconfig has 
> > > enabled
> > kvm_e500.config in freescale's internal git repo.   >
> > 
> > What does our internal git repo have to do with anything?
> 
> I will take off kvm_e500.config if upstream defconfig does have 
> these.
> I will add kvm_e500.config later.

You didn't answer my question.

> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile index
> > > fc502e0..7c80298 100644
> > > --- a/arch/powerpc/Makefile
> > > +++ b/arch/powerpc/Makefile
> > > @@ -269,6 +269,52 @@ bootwrapper_install:
> > >  %.dtb: scripts
> > >   $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot)
> > $(patsubst %,$(boot)/%,$@)
> > > 
> > > +configfiles=$(wildcard $(srctree)/kernel/configs/$(1).config
> > > +$(srctree)/arch/$(SRCARCH)/configs/$(1).config)
> > > +
> > > +define mergeconfig
> > > +$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -
> > > m -O
> > > +$(objtree)/arch/$(SRCARCH)/configs
> > > +$(objtree)/arch/$(SRCARCH)/configs/.config $(call 
> > > configfiles,$(1))
> > > +endef
> > 
> > Why not invoke make with the <whatever>.config target instead?
> 
> I first merge (no any make) all the config fragments into one, then 
> make it.

Do you mean for the reason described in 
http://patchwork.ozlabs.org/patch/476345/
?

You should probably base these changes on top of that patch.

> This is a way to make sure the .config after this patch the same as 
> .config before this patch.

In the general case that's not a reasonable goal, unless you remove 
the gratuitous inconsistencies from the configs first (which would be a
good thing).

> > > +mpc85xx_defconfig:
> > > + $(Q)cp 
> > > $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig
> > > +$(srctree)/arch/$(SRCARCH)/configs/.config
> > 
> > Don't modify $(srctree), ever.  Why not just depend on the
> > mpc85xx_basic_defconfig target?
> > 
> > > + $(call mergeconfig,32-bit)
> > > + $(call mergeconfig,uart6)
> > > + $(call mergeconfig,mpc85xx_misc)
> > > + $(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config
> > $(objtree)/arch/$(SRCARCH)/configs/mpc85xx_tmp_defconfig
> > > + $(Q)$(MAKE) -f $(srctree)/Makefile mpc85xx_tmp_defconfig
> > > +
> > > +mpc85xx_smp_defconfig:
> > > + $(Q)cp 
> > > $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig
> > $(srctree)/arch/$(SRCARCH)/configs/.config
> > > + $(call mergeconfig,32-bit)
> > > + $(call mergeconfig,smp)
> > > + $(call mergeconfig,cpu8)
> > > + $(call mergeconfig,kvm_e500)
> > > + $(call mergeconfig,uart2)
> > > + $(call mergeconfig,i2c)
> > > + $(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config
> > $(objtree)/arch/$(SRCARCH)/configs/mpc85xx_smp_tmp_defconfig
> > > + $(Q)$(MAKE) -f $(srctree)/Makefile mpc85xx_smp_tmp_defconfig
> > 
> > There shouldn't be any difference besides "SMP" for 
> > mpc85xx_defconfig
> > versus mpc85xx_smp_defconfig.  I know someone previously asked you 
> > to
> > ensure this didn't change the results, but I think this is a good 
> > opportunity to
> > get rid of gratuitous differences, as long as you show what the 
> > diff is between
> > old and new so we can verify that the changes are beneficial.
> > 
> 
> There are quite a lot difference between mcp85xx_defconfig and 
> mpc85xx_smp_config.
> Can you tell me which configs could be removed or neglected?

Again, there shouldn't be any difference besides CONFIG_SMP and things 
directly related to SMP.  If a non-SMP-related option is set in one 
but not the other, set it in both before refactoring.  Likewise for 
anything else that you find yourself putting in a fragment that isn't 
related to the topic of that fragment.

> > > +corenet32_smp_defconfig:
> > > + $(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_defconfig
> > $(srctree)/arch/$(SRCARCH)/configs/.config
> > > + $(call mergeconfig,32-bit)
> > 
> > Isn't the basic config already 32-bit?
> 
> Basic does not contain bit info.
> Mpc85xx_ is 32-bit.
> Mpc85xx_smp_ is 64-bit.

What do you mean by "Mpc85xx_smp_ is 64-bit"?  mpc85xx_smp_defconfig 
is *not* 64-bit.

> > > + $(call mergeconfig,smp)
> > > + $(call mergeconfig,cpu8)
> > > + $(call mergeconfig,corenet32_misc)
> > > + $(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config
> > $(objtree)/arch/$(SRCARCH)/configs/corenet32_smp_tmp_defconfig
> > > + $(Q)$(MAKE) -f $(srctree)/Makefile corenet32_smp_tmp_defconfig
> > > +
> > > +corenet64_smp_defconfig:
> > > + $(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_defconfig
> > $(srctree)/arch/$(SRCARCH)/configs/.config
> > > + $(call mergeconfig,64-bit)
> > > + $(call mergeconfig,smp)
> > > + $(call mergeconfig,cpu24)
> > > + $(call mergeconfig,dma)
> > > + $(call mergeconfig,math_emulation)
> > > + $(call mergeconfig,cgroup)
> > > + $(call mergeconfig,corenet64_misc)
> > > + $(Q)mv $(objtree)/arch/$(SRCARCH)/configs/.config
> > $(objtree)/arch/$(SRCARCH)/configs/corenet64_smp_tmp_defconfig
> > > + $(Q)$(MAKE) -f $(srctree)/Makefile corenet64_smp_tmp_defconfig
> > 
> > math emulation?
> 
> Only mpc85xx_smp_ has these configs.
> Hence I extracted them and name them math_emulation.
> Any suggestion on where I put these configs?

Never mind, we do want math emulation on corenet64 because of the 
missing fsqrt instruction on e5500/e6500.

> > >  define archhelp
> > >    @echo '* zImage          - Build default images selected by 
> > > kernel config'
> > >    @echo '  zImage.*        - Compressed kernel image
> > (arch/$(ARCH)/boot/zImage.*)'
> > > diff --git a/arch/powerpc/configs/32-bit.config
> > > b/arch/powerpc/configs/32-bit.config
> > > new file mode 100644
> > > index 0000000..3b8b43b
> > > --- /dev/null
> > > +++ b/arch/powerpc/configs/32-bit.config
> > > @@ -0,0 +1 @@
> > > +CONFIG_PPC_85xx=y
> > 
> > Not all 32-bit platforms are 85xx.
> 
> How about name it ppc_85.config

How about mpc85xx_basic_defconfig as per previous discussion?

Or if it's to be a fragment, mpc85xx.config.

> > > diff --git a/arch/powerpc/configs/64-bit.config
> > > b/arch/powerpc/configs/64-bit.config
> > > new file mode 100644
> > > index 0000000..b53af55
> > > --- /dev/null
> > > +++ b/arch/powerpc/configs/64-bit.config
> > > @@ -0,0 +1,3 @@
> > > +CONFIG_PPC64=y
> > > +CONFIG_PPC_BOOK3E_64=y
> > > +CONFIG_ALTIVEC=y
> > 
> > Not all 64-bit platforms are book3e, and Altivec should probably 
> > be separate,
> > especially given the impact it has on -mcpu.
> 
> How about have three configs:
> ppc64.config (CONFIG_PPC64=Y)
> booke3e.config (CONFIG_PPC_BOOK3E_64=y)
> altivec.config (CONFIG_ALTIVEC=y)

s/booke3e/book3e-64/ and get rid of ppc64.config since the book3e 
fragment is already 64-bit-specific.

> > > diff --git a/arch/powerpc/configs/cgroup.config
> > > b/arch/powerpc/configs/cgroup.config
> > > new file mode 100644
> > > index 0000000..a6012a3
> > > --- /dev/null
> > > +++ b/arch/powerpc/configs/cgroup.config
> > > @@ -0,0 +1,4 @@
> > > +CONFIG_CGROUPS=y
> > > +CONFIG_CPUSETS=y
> > > +CONFIG_CGROUP_CPUACCT=y
> > > +CONFIG_CGROUP_SCHED=y
> > 
> > Is there any significant downside to enabling this?  As I think I 
> > said before, I was
> > hoping for one largeish fragment for all non-hardware-specific 
> > stuff that we
> > want to enable by default on all of our configs.
> 
> I extracted these cgroups stuff out of mpc85xx_smp_.
> What config fragment do you suggest putting these CONFIG_CGROUPS 
> stuff to?

One largeish fragment for all non-hardware-specific stuff. :-P


> > 
> > I don't want it to be super-fine-grained, and I especially don't 
> > want some
> > eclectic mix of fine-grained and course-grained.
> > 
> > > diff --git a/arch/powerpc/configs/corenet32_misc.config
> > > b/arch/powerpc/configs/corenet32_misc.config
> > > new file mode 100644
> > > index 0000000..4ad0ea1
> > > --- /dev/null
> > > +++ b/arch/powerpc/configs/corenet32_misc.config
> > > @@ -0,0 +1,36 @@
> > > +CONFIG_AT803X_PHY=y
> > > +CONFIG_AUDIT=y
> > > +CONFIG_CHR_DEV_ST=y
> > > +CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=n
> > > +CONFIG_CRAMFS=y
> > > +CONFIG_E1000=y
> > > +CONFIG_EDAC_MPC85XX=y
> > > +CONFIG_EMBEDDED=y
> > > +CONFIG_EXT3_DEFAULTS_TO_ORDERED=n
> > > +CONFIG_FORCE_MAX_ZONEORDER=13
> > > +CONFIG_HIGHMEM=y
> > > +CONFIG_INET_AH=y
> > > +CONFIG_INET_IPCOMP=y
> > > +CONFIG_KEXEC=y
> > > +CONFIG_LEGACY_PTYS=n
> > > +CONFIG_NET_KEY_MIGRATE=y
> > > +CONFIG_NVRAM=y
> > > +CONFIG_PATA_SIL680=y
> > > +CONFIG_PCI=y
> > > +CONFIG_PCIEASPM=n
> > > +CONFIG_PERF_EVENTS=y
> > > +CONFIG_POSIX_MQUEUE=y
> > > +CONFIG_PPC_85xx=y
> > > +CONFIG_RCU_TRACE=y
> > > +CONFIG_SATA_AHCI=y
> > > +CONFIG_SATA_SIL=y
> > > +CONFIG_SCSI_LOGGING=y
> > > +CONFIG_SCSI_SYM53C8XX_2=y
> > > +CONFIG_SLAB=y
> > > +CONFIG_STAGING=y
> > > +CONFIG_UIO=y
> > > +CONFIG_USB_OHCI_HCD=y
> > > +CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
> > > +CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
> > > +CONFIG_XFRM_STATISTICS=y
> > > +CONFIG_XFRM_SUB_POLICY=y
> > 
> > None of this is 32-bit specific.
> 
> Above are the stuff mpc85xx_ has but mpc85xx_smp_ does not.
> How do we handle these CONFIGs? Any idea?



> 
> > 
> > > diff --git a/arch/powerpc/configs/cpu8.config
> > > b/arch/powerpc/configs/cpu8.config
> > > new file mode 100644
> > > index 0000000..8832f89
> > > --- /dev/null
> > > +++ b/arch/powerpc/configs/cpu8.config
> > > @@ -0,0 +1 @@
> > > +CONFIG_NR_CPUS=8
> > 
> > Move this to the basic config file for the CPU family.
>  
> But corenet32_smp_ has 8 cores while corenet64_smp_ has 24 cores.
> What do we do?

Set it to 24.


> diff --git a/arch/powerpc/configs/kvm_e500.config
> > > b/arch/powerpc/configs/kvm_e500.config
> > > new file mode 100644
> > > index 0000000..615b0a0
> > > --- /dev/null
> > > +++ b/arch/powerpc/configs/kvm_e500.config
> > > @@ -0,0 +1,2 @@
> > > +CONFIG_KVM_GUEST=y
> > > +CONFIG_PPC_QEMU_E500=y
> > 
> > CONFIG_PPC_QEMU_E500 should be always enabled like any other 
> > target.
> > 
> > As for KVM guest support, the standard name for this is 
> > kvm_guest.config
> > based on the rule in scripts/kconfig/Makefile, and it should also 
> > include
> > common virtio drivers.
> 
> How about kvm_guest.config (
> CONFIG_KVM_GUEST=y
> CONFIG_PPC_QEMU_E500=y
> CONFIG_VIRT_DRIVERS=y)?
> Anything else need to be added into kvm_guest.config?

CONFIG_PPC_QEMU_E500 would only work with e500 builds, so doesn't 
belong here.  Just enable it with all the other 85xx platforms.

I'd enable block and net virtio drivers in kvm_guest.config.

> 
> > 
> > > index b6c7111..8cb47f4 100644
> > > --- a/arch/powerpc/configs/mpc85xx_smp_defconfig
> > > +++ b/arch/powerpc/configs/mpc85xx_basic_defconfig
> > > @@ -1,7 +1,4 @@
> > > -CONFIG_PPC_85xx=y
> > >  CONFIG_PHYS_64BIT=y
> > > -CONFIG_SMP=y
> > > -CONFIG_NR_CPUS=8
> > >  CONFIG_SYSVIPC=y
> > >  CONFIG_POSIX_MQUEUE=y
> > >  CONFIG_AUDIT=y
> > > @@ -128,14 +125,11 @@ CONFIG_INPUT_FF_MEMLESS=m
> > CONFIG_SERIO_LIBPS2=y
> > > CONFIG_SERIAL_8250=y  CONFIG_SERIAL_8250_CONSOLE=y
> > > -CONFIG_SERIAL_8250_NR_UARTS=2
> > > -CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> > >  CONFIG_SERIAL_8250_MANY_PORTS=y
> > >  CONFIG_SERIAL_8250_DETECT_IRQ=y
> > >  CONFIG_SERIAL_8250_RSA=y
> > >  CONFIG_SERIAL_QE=m
> > >  CONFIG_NVRAM=y
> > > -CONFIG_I2C=y
> > >  CONFIG_I2C_CHARDEV=y
> > >  CONFIG_I2C_CPM=m
> > >  CONFIG_I2C_MPC=y
> > 
> > Why no i2c?
> 
> Mpc85xx_smp_ has i2c while mpc85xx_ does not.
> Shall I add i2c to mpc85xx_basic_defconfig such that both mpc85xx 
> and mpc85xx_smp_ have i2c? 

Yes.

-Scott
