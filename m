Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37A791A0030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 10:54:21 +1000 (AEST)
Message-ID: <1429232060.22546.7.camel@ellerman.id.au>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lijun Pan <Lijun.Pan@freescale.com>
Date: Fri, 17 Apr 2015 10:54:20 +1000
In-Reply-To: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Richard Schmitt <richard.schmitt@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 21:52 +0000, Lijun Pan wrote:
> Hi Maintainers,
> 
> We have a proposal for writing the defconfigs for freescale's powperpc platforms in a new way.
> Can you take a look and provide some feedback?
> 
> You know currently we have mpc85xx_defconfig, corenet32_defconfig, bsc913x_defconfig, *fman*_defconfig, etc.
> We are going to extract some common parts from the existing defconfigs, and name it, say, fsl_basic_defconfig.
> Then, we could create some defconfigs targeting specific features or specific platforms.
> Say, features specific: kvm_defconfig, fman_defconfig, etc.
> Platforms specific: p1_defconfig, p2_defcongfig, p4_defconfig, t1_defconfig, t2_defconfig, t2_defconfig, b4_defconfig, etc
> When we want to make a kernel image for p1 platform,
> Using the following steps:
> 
> make ./scripts/kconfig/merge_config.sh arch/powerpc/configs/fsl_basic_config p1_defconfig
> make
> 
> What do you think of this new approach?

I don't like that the user has to manually run merge_config.sh.

How does a user even know that it's an option?

It also breaks scripts that auto build the kernel, which expect to be able to do:

  $ make foo_defconfig
  $ make

Scripts like mine for example :)

  http://kisskb.ellerman.id.au/kisskb/head/8734/

What I'd be happy with is something that does merge_config under the covers. So
a user still runs 'make fsl_plat_foo_defconfig', but under the covers it does a
merge config.

kvmconfig and tinyconfig are implemented that way already, so with a bit more
work hopefully you can do that for arch configs also.

cheers
