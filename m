Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A8C81A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:16:30 +1100 (AEDT)
Message-ID: <1452219390.18702.2.camel@ellerman.id.au>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian Norris <computersforpeace@gmail.com>, Ian Munsie
 <imunsie@au1.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Neuling
 <mikey@neuling.org>, Anton Blanchard <anton@au1.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.com>
Date: Fri, 08 Jan 2016 13:16:30 +1100
In-Reply-To: <20160108020743.GA118336@google.com>
References: <20160107185406.GA65420@google.com>
 <10821353.mAlCTdTQBC@wuerfel> <87oacx6m14.fsf@gamma.ozlabs.ibm.com>
 <20160107230225.GA126548@google.com>
 <1452216163-sup-7558@delenn.ozlabs.ibm.com>
 <20160108020743.GA118336@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-07 at 18:07 -0800, Brian Norris wrote:
> On Fri, Jan 08, 2016 at 12:31:54PM +1100, Ian Munsie wrote:
> > Excerpts from Brian Norris's message of 2016-01-08 10:02:25 +1100:
> > > >  - It forces cxl developers to a higher standard. cxl has already had
> > > >    more than it's fair share of incredibly difficult to debug issues,
> > > >    so any way we can reduce the risk of errors going in makes our lives
> > > >    (and our end-users lives) better.
> > > 
> > > One problem with this point: not all warnings are under the purview of
> > > cxl developers. For instance, if I turn up warning verbosity (W=1), then
> 
> (BTW, I think most of these files are currently clean with W=1, but not W=2)

> > > the *header* files start producing plenty of warnings. Should this break
> > > the build? Your code didn't change, and you can't fix those errors.
> > 
> > That's a good point, but the specific warnings that we suppressed in the
> > new compiler are in drivers/misc/cxl/cxl.h, which is an internal header
> > that should only ever be included by the cxl driver. We do have some
> > headers elsewhere which are included by other drivers, the generic ppc
> > architecture code and userspace, but these are all warning free and
> > won't be affected by the -Werror when included from elsewhere.
> 
> I was referring to when extra warnings are turned on, not just the
> default. So this fails spectacularly:
> 
>   $ export ARCH=powerpc
>   $ make ppc64_defconfig
>   $ make drivers/misc/cxl/api.o W=2
>     CC [M]  drivers/misc/cxl/api.o
>   In file included from include/linux/bitops.h:36:0,
>                    from include/linux/kernel.h:10,
>                    from include/linux/list.h:8,
>                    from include/linux/pci.h:25,
>                    from drivers/misc/cxl/api.c:10:
>   ./arch/powerpc/include/asm/bitops.h:226:94: error: declaration of 'ffs' shadows a built-in function [-Werror=shadow]

>
> I doubt you plan to fix all those. So making -Werror configurable seems like
> the only way forward, then. (Glad you agreed!)

Yep, I'm happy to make Werror configurable.

cxl can probably just use the existing PPC_WERROR.

cheers
