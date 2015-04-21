Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4FD61A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 04:30:38 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0118.outbound.protection.outlook.com [157.56.111.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE6CF140133
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 04:30:37 +1000 (AEST)
Message-ID: <1429641018.4352.105.camel@freescale.com>
Subject: Re: powerpc/defconfig: new way of writing defconfig
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 21 Apr 2015 13:30:18 -0500
In-Reply-To: <20150421061539.78B071401F6@ozlabs.org>
References: <20150421061539.78B071401F6@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Lijun Pan <LIJUN.PAN@FREESCALE.COM>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-21 at 16:15 +1000, Michael Ellerman wrote:
> On Sat, 2015-18-04 at 04:47:21 UTC, Lijun Pan wrote:
> > It is always a headache dealing with different defconfigs
> > though they only differ in few places. Hence we are proposing a new
> > way of writing defconfig:
> 
> So on the whole this is looking promising, some comments ...
> 
> > 1. Define a basic defconfig say mpc85xx_basic_defconfig
> 
> Why can't we just use mpc85xx_defconfig ?

It seems like it would be good not to redefine the meaning of existing
names.

> > 2. Spin off as much features as possible from mpc85xx_defconfig
> > 	and create a separate config file, say, kvm_guest.config
> 
> > Every time we add a new feature, we don't need to change several
> > defconfigs, we just add a new *.config

We shouldn't do this for every new feature.  That would end up with way
too many config fragments.  There should only be a handful based on
logical groupings and/or things that are very commonly enabled/disabled.
If the user wants more fine-grained control that's what menuconfig is
for.

> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index fc502e0..590b441 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -269,6 +269,23 @@ bootwrapper_install:
> >  %.dtb: scripts
> >  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
> >  
> > +define domerge
> > +       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh $(srctree)/.config $(srctree)/arch/powerpc/configs/$(1).config
> > +endef
> 
> Please look at mergeconfig in scripts/kconfig/Makefile. This needs to:
>  - deal with objtree/srctree
>  - run oldconfig
>  - can you call it mergeconfig

oldconfig should be handled by the rules that call this depending on a
file-based defconfig.

I chose domerge to avoid conflicting with the later definition of
mergeconfig in scripts/kconfig/mergeconfig (might not be an actual
problem, but reusing names makes it harder to follow what's going on).

I do think we should be calling scripts/kconfig/mergeconfig, as I
previously suggested, instead of hardcoding this.  E.g. that would allow
non-arch-specific fragments in kernel/configs/ rather than only looking
in arch/powerpc/configs.

> 
> > +mpc85xx_defconfig: mpc85xx_basic_defconfig
> > +	@:
> > +
> > +mpc85xx_smp_defconfig: mpc85xx_basic_defconfig
> > +	$(call domerge,smp)
> > +	$(call domerge,kvm_guest)
> > +
> > +corenet32_smp_defconfig: corenet32_basic_defconfig
> > +	$(call domerge,smp)
> > +
> > +corenet64_smp_defconfig: corenet64_basic_defconfig
> > +	$(call domerge,smp)
> 
> Can these be further consolidated into a corenet_defconfig and then a 32-bit
> and 64-bit config?

A lot of things depend on 32 versus 64 bit so I was hesitant to set that
later (though in theory I guess it should be doable).  I was thinking
the "basic" defconfig would be truly basic, with a common
corenet .config that turns on drivers and such.

> > diff --git a/arch/powerpc/configs/kvm_guest.config b/arch/powerpc/configs/kvm_guest.config
> > new file mode 100644
> > index 0000000..615b0a0
> > --- /dev/null
> > +++ b/arch/powerpc/configs/kvm_guest.config
> > @@ -0,0 +1,2 @@
> > +CONFIG_KVM_GUEST=y
> > +CONFIG_PPC_QEMU_E500=y
> 
> This isn't a general "kvm_guest" config, ie. we don't want that enabled on
> 64-bit guest kernels. So can you call it kvm_e500.config or something.

s/64-bit/book3s/

I guess the issue here is that the symbol is defined inside an "if",
rather than with a depends, so kconfig will raise an error rather than
silently ignore it on book3s builds?

-Scott
