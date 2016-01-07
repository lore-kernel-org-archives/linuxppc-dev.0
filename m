Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0057.hostedemail.com
 [216.40.44.57])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6551A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 06:57:40 +1100 (AEDT)
Message-ID: <1452196651.4028.31.camel@perches.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
From: Joe Perches <joe@perches.com>
To: Michal Marek <mmarek@suse.com>, Brian Norris
 <computersforpeace@gmail.com>,  Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Jan 2016 11:57:31 -0800
In-Reply-To: <568EC026.2020207@suse.com>
References: <20160107185406.GA65420@google.com>
 <1452195444.4028.21.camel@perches.com> <568EC026.2020207@suse.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-07 at 20:44 +0100, Michal Marek wrote:
> Dne 7.1.2016 v 20:37 Joe Perches napsal(a):
> > On Thu, 2016-01-07 at 10:54 -0800, Brian Norris wrote:
> > > I'm using a GCC 4.6.3 compiler for some compile tests, and I noticed
> > > that commit 2cd55c68c0a4 ("cxl: Fix build failure due to -Wunused-variable
> > > behaviour change") breaks my builds, because the
> > > -Wno-unused-const-variable doesn't exist on GCC 4.6.3.
> > >   drivers/misc/cxl/base.c: At top level:
> > >   cc1: error: unrecognized command line option "-Wno-unused-const-variable" [-Werror]
> > > Any thoughts on how to best fix this? I'd like not to have to scrounge
> > > up a new cross compiler just for build tests.
> > drivers/misc/cxl/Makefile:ccflags-y := -Werror -Wno-unused-const-variable
> > You could take that -Wno-unused-const-variable out of the
> > Makefile or maybe add something like:
> > 
> > $(call cc-ifversion, -ge, 0530, -Wno-unused-const-variable)
> > 
> > or whatever gcc version actually added that unused-const-variable check
> 
> We have cc-disable-warning for this.

Thanks Michal.

Perhaps most uses of -Werror without some CONFIG_<FOO> guard
should be removed or replaced by some other mechanism.

$ git grep -E "=\s*\-Werror" | grep -v CONFIG
[...]
arch/alpha/lib/Makefile:ccflags-y := -Werror
arch/alpha/mm/Makefile:ccflags-y := -Werror
arch/alpha/oprofile/Makefile:ccflags-y := -Werror -Wno-sign-compare
arch/metag/oprofile/Makefile:ccflags-y	+= -Werror
arch/mips/Kbuild:subdir-ccflags-y := -Werror
arch/sh/cchips/hd6446x/Makefile:ccflags-y := -Werror
arch/sh/kernel/Makefile:ccflags-y := -Werror
arch/sh/lib/Makefile:ccflags-y := -Werror
arch/sh/mm/Makefile:ccflags-y := -Werror
arch/sparc/kernel/Makefile:ccflags-y := -Werror
arch/sparc/lib/Makefile:ccflags-y := -Werror
arch/sparc/mm/Makefile:ccflags-y := -Werror
arch/sparc/prom/Makefile:ccflags := -Werror
drivers/gpu/drm/tilcdc/Makefile:	ccflags-y += -Werror
drivers/misc/cxl/Makefile:ccflags-y := -Werror -Wno-unused-const-variable
drivers/scsi/aic7xxx/Makefile:ccflags-y += -Werror
drivers/scsi/lpfc/Makefile:ccflags-y += -Werror
