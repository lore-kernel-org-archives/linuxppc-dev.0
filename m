Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21A3F1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 04:52:53 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 584471402E3
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2015 04:52:51 +1000 (AEST)
Message-ID: <1429296759.4352.8.camel@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Scott Wood <scottwood@freescale.com>
To: Pan Lijun-B44306 <Lijun.Pan@freescale.com>
Date: Fri, 17 Apr 2015 13:52:39 -0500
In-Reply-To: <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429232060.22546.7.camel@ellerman.id.au>
 <1429244000.32545.51.camel@freescale.com>
 <1429251526.22546.8.camel@ellerman.id.au>
 <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Schmitt Richard-B43082 <richard.schmitt@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-17 at 13:50 -0500, Pan Lijun-B44306 wrote:
> 
> 
> > -----Original Message-----
> > From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> > Sent: Friday, April 17, 2015 1:19 AM
> > To: Wood Scott-B07421
> > Cc: Pan Lijun-B44306; linuxppc-dev@ozlabs.org; Schmitt Richard-B43082
> > Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
> > 
> > On Thu, 2015-04-16 at 23:13 -0500, Scott Wood wrote:
> > > On Fri, 2015-04-17 at 10:54 +1000, Michael Ellerman wrote:
> > > > On Thu, 2015-04-09 at 21:52 +0000, Lijun Pan wrote:
> > > > > Hi Maintainers,
> > > > >
> > > > > We have a proposal for writing the defconfigs for freescale's powperpc
> > platforms in a new way.
> > > > > Can you take a look and provide some feedback?
> > > > >
> > > > > You know currently we have mpc85xx_defconfig, corenet32_defconfig,
> > bsc913x_defconfig, *fman*_defconfig, etc.
> > > > > We are going to extract some common parts from the existing defconfigs,
> > and name it, say, fsl_basic_defconfig.
> > > > > Then, we could create some defconfigs targeting specific features or
> > specific platforms.
> > > > > Say, features specific: kvm_defconfig, fman_defconfig, etc.
> > > > > Platforms specific: p1_defconfig, p2_defcongfig, p4_defconfig,
> > > > > t1_defconfig, t2_defconfig, t2_defconfig, b4_defconfig, etc When
> > > > > we want to make a kernel image for p1 platform, Using the following
> > steps:
> > > > >
> > > > > make ./scripts/kconfig/merge_config.sh
> > > > > arch/powerpc/configs/fsl_basic_config p1_defconfig make
> > > > >
> > > > > What do you think of this new approach?
> > > >
> > > > I don't like that the user has to manually run merge_config.sh.
> > > >
> > > > How does a user even know that it's an option?
> > > >
> > > > It also breaks scripts that auto build the kernel, which expect to be able to
> > do:
> > > >
> > > >   $ make foo_defconfig
> > > >   $ make
> > > >
> > > > Scripts like mine for example :)
> > > >
> > > >   http://kisskb.ellerman.id.au/kisskb/head/8734/
> > > >
> > > > What I'd be happy with is something that does merge_config under the
> > > > covers. So a user still runs 'make fsl_plat_foo_defconfig', but
> > > > under the covers it does a merge config.
> > > >
> > > > kvmconfig and tinyconfig are implemented that way already, so with a
> > > > bit more work hopefully you can do that for arch configs also.
> > >
> > > kvmconfig and tinyconfig are still separate user-visible steps to be
> > > applied after running a base defconfig.
> > 
> > Not as of recently:
> > 
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/scripts/kc
> > onfig/Makefile?id=63a91033d52e64a22e571fe84924c0b7f21c280d
> > 
> 
> Above patch is very generic.
> With this patch, we don't even need to modify arch/powerpc/Makefile.
> We can just add fragments (like smp.config, kvm_guest.config, etc) under
> arch/powerpc/configs/ or
> add platform independent config under kernel/configs/
> 
> example might be:
> make mpc85xx_defconfig
> make smp.config
> make kvm_guest.config

The point is that the user should not have to do that.  They can if they
want, but there should still be traditional named configs, which would
just work differently under the hood.

-Scott
