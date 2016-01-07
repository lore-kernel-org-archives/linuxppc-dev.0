Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EDC61A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 07:18:31 +1100 (AEDT)
Received: by mail-pa0-x235.google.com with SMTP id cy9so266794567pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 12:18:31 -0800 (PST)
Date: Thu, 7 Jan 2016 12:18:26 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Michal Marek <mmarek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
Message-ID: <20160107201826.GA120952@google.com>
References: <20160107185406.GA65420@google.com>
 <1452195444.4028.21.camel@perches.com> <568EC026.2020207@suse.com>
 <1452196651.4028.31.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1452196651.4028.31.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 07, 2016 at 11:57:31AM -0800, Joe Perches wrote:
> On Thu, 2016-01-07 at 20:44 +0100, Michal Marek wrote:
> > Dne 7.1.2016 v 20:37 Joe Perches napsal(a):
> > > On Thu, 2016-01-07 at 10:54 -0800, Brian Norris wrote:
> > > > I'm using a GCC 4.6.3 compiler for some compile tests, and I noticed
> > > > that commit 2cd55c68c0a4 ("cxl: Fix build failure due to -Wunused-variable
> > > > behaviour change") breaks my builds, because the
> > > > -Wno-unused-const-variable doesn't exist on GCC 4.6.3.
> > > >   drivers/misc/cxl/base.c: At top level:
> > > >   cc1: error: unrecognized command line option "-Wno-unused-const-variable" [-Werror]
> > > > Any thoughts on how to best fix this? I'd like not to have to scrounge
> > > > up a new cross compiler just for build tests.
> > > drivers/misc/cxl/Makefile:ccflags-y := -Werror -Wno-unused-const-variable
> > > You could take that -Wno-unused-const-variable out of the
> > > Makefile or maybe add something like:
> > > 
> > > $(call cc-ifversion, -ge, 0530, -Wno-unused-const-variable)
> > > 
> > > or whatever gcc version actually added that unused-const-variable check
> > 
> > We have cc-disable-warning for this.
> 
> Thanks Michal.

Cool, thanks! I'll send a patch to use that instead.

> Perhaps most uses of -Werror without some CONFIG_<FOO> guard
> should be removed or replaced by some other mechanism.

+1000. I'd personally like to see all one-off uses of -Werror removed.

> $ git grep -E "=\s*\-Werror" | grep -v CONFIG
> [...]
> arch/alpha/lib/Makefile:ccflags-y := -Werror
> arch/alpha/mm/Makefile:ccflags-y := -Werror
> arch/alpha/oprofile/Makefile:ccflags-y := -Werror -Wno-sign-compare
> arch/metag/oprofile/Makefile:ccflags-y	+= -Werror
> arch/mips/Kbuild:subdir-ccflags-y := -Werror

^^ I always patch this one out when build-testing MIPS, since I like to
turn up warning levels (e.g., W=1), but not kill the build entirely.

Regards,
Brian

> arch/sh/cchips/hd6446x/Makefile:ccflags-y := -Werror
> arch/sh/kernel/Makefile:ccflags-y := -Werror
> arch/sh/lib/Makefile:ccflags-y := -Werror
> arch/sh/mm/Makefile:ccflags-y := -Werror
> arch/sparc/kernel/Makefile:ccflags-y := -Werror
> arch/sparc/lib/Makefile:ccflags-y := -Werror
> arch/sparc/mm/Makefile:ccflags-y := -Werror
> arch/sparc/prom/Makefile:ccflags := -Werror
> drivers/gpu/drm/tilcdc/Makefile:	ccflags-y += -Werror
> drivers/misc/cxl/Makefile:ccflags-y := -Werror -Wno-unused-const-variable
> drivers/scsi/aic7xxx/Makefile:ccflags-y += -Werror
> drivers/scsi/lpfc/Makefile:ccflags-y += -Werror
> 
