Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98B021A0030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 16:18:46 +1000 (AEST)
Message-ID: <1429251526.22546.8.camel@ellerman.id.au>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 17 Apr 2015 16:18:46 +1000
In-Reply-To: <1429244000.32545.51.camel@freescale.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429232060.22546.7.camel@ellerman.id.au>
 <1429244000.32545.51.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Lijun Pan <Lijun.Pan@freescale.com>,
 Richard Schmitt <richard.schmitt@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-16 at 23:13 -0500, Scott Wood wrote:
> On Fri, 2015-04-17 at 10:54 +1000, Michael Ellerman wrote:
> > On Thu, 2015-04-09 at 21:52 +0000, Lijun Pan wrote:
> > > Hi Maintainers,
> > > 
> > > We have a proposal for writing the defconfigs for freescale's powperpc platforms in a new way.
> > > Can you take a look and provide some feedback?
> > > 
> > > You know currently we have mpc85xx_defconfig, corenet32_defconfig, bsc913x_defconfig, *fman*_defconfig, etc.
> > > We are going to extract some common parts from the existing defconfigs, and name it, say, fsl_basic_defconfig.
> > > Then, we could create some defconfigs targeting specific features or specific platforms.
> > > Say, features specific: kvm_defconfig, fman_defconfig, etc.
> > > Platforms specific: p1_defconfig, p2_defcongfig, p4_defconfig, t1_defconfig, t2_defconfig, t2_defconfig, b4_defconfig, etc
> > > When we want to make a kernel image for p1 platform,
> > > Using the following steps:
> > > 
> > > make ./scripts/kconfig/merge_config.sh arch/powerpc/configs/fsl_basic_config p1_defconfig
> > > make
> > > 
> > > What do you think of this new approach?
> > 
> > I don't like that the user has to manually run merge_config.sh.
> > 
> > How does a user even know that it's an option?
> > 
> > It also breaks scripts that auto build the kernel, which expect to be able to do:
> > 
> >   $ make foo_defconfig
> >   $ make
> > 
> > Scripts like mine for example :)
> > 
> >   http://kisskb.ellerman.id.au/kisskb/head/8734/
> > 
> > What I'd be happy with is something that does merge_config under the covers. So
> > a user still runs 'make fsl_plat_foo_defconfig', but under the covers it does a
> > merge config.
> > 
> > kvmconfig and tinyconfig are implemented that way already, so with a bit more
> > work hopefully you can do that for arch configs also.
> 
> kvmconfig and tinyconfig are still separate user-visible steps to be
> applied after running a base defconfig.

Not as of recently:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/scripts/kconfig/Makefile?id=63a91033d52e64a22e571fe84924c0b7f21c280d
 

Which pretty much does what you describe below I think.

> For breaking a platform defconfig into components, we could do something
> like this in arch/powerpc/Makefile:
> 
> # Can't call mergeconfig directly as it isn't defined at this point
> define domerge
>        @$(MAKE) -f $(srctree)/scripts/kconfig/Makefile $(1).config
> endef
> 
> corenet64_smp_defconfig: corenet64_basic_defconfig
> 	$(call domerge,smp)
> 	$(call domerge,altivec)
> 	$(call domerge,corenet_drivers)
> 	$(call domerge,embedded_misc) # filesystems etc
> 
> And this in scripts/kconfig/Makefile:
> 
> %.config:
>        $(call mergeconfig,$*)
> 
> One issue with this is that we'd lose the ability to use savedefconfig
> (at least without manual manipulation of the results) to maintain the
> defconfigs/fragments.

That's probably OK, it's only maintainers who need to do that.

cheers
