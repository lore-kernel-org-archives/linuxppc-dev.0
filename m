Return-Path: <computersforpeace@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D64D1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:07:48 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id e65so2194858pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 18:07:47 -0800 (PST)
Date: Thu, 7 Jan 2016 18:07:43 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
Message-ID: <20160108020743.GA118336@google.com>
References: <20160107185406.GA65420@google.com> <10821353.mAlCTdTQBC@wuerfel>
 <87oacx6m14.fsf@gamma.ozlabs.ibm.com>
 <20160107230225.GA126548@google.com>
 <1452216163-sup-7558@delenn.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452216163-sup-7558@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 08, 2016 at 12:31:54PM +1100, Ian Munsie wrote:
> Excerpts from Brian Norris's message of 2016-01-08 10:02:25 +1100:
> > >  - It forces cxl developers to a higher standard. cxl has already had
> > >    more than it's fair share of incredibly difficult to debug issues,
> > >    so any way we can reduce the risk of errors going in makes our lives
> > >    (and our end-users lives) better.
> > 
> > One problem with this point: not all warnings are under the purview of
> > cxl developers. For instance, if I turn up warning verbosity (W=1), then

(BTW, I think most of these files are currently clean with W=1, but not
W=2)

> > the *header* files start producing plenty of warnings. Should this break
> > the build? Your code didn't change, and you can't fix those errors.
> 
> That's a good point, but the specific warnings that we suppressed in the
> new compiler are in drivers/misc/cxl/cxl.h, which is an internal header
> that should only ever be included by the cxl driver. We do have some
> headers elsewhere which are included by other drivers, the generic ppc
> architecture code and userspace, but these are all warning free and
> won't be affected by the -Werror when included from elsewhere.

I was referring to when extra warnings are turned on, not just the
default. So this fails spectacularly:

  $ export ARCH=powerpc
  $ make ppc64_defconfig
  $ make drivers/misc/cxl/api.o W=2
    CC [M]  drivers/misc/cxl/api.o
  In file included from include/linux/bitops.h:36:0,
                   from include/linux/kernel.h:10,
                   from include/linux/list.h:8,
                   from include/linux/pci.h:25,
                   from drivers/misc/cxl/api.c:10:
  ./arch/powerpc/include/asm/bitops.h:226:94: error: declaration of 'ffs' shadows a built-in function [-Werror=shadow]
  In file included from include/linux/atomic.h:562:0,
                   from include/linux/mutex.h:18,
                   from include/linux/kernfs.h:13,
                   from include/linux/sysfs.h:15,
                   from include/linux/kobject.h:21,
                   from include/linux/pci.h:28,
                   from drivers/misc/cxl/api.c:10:
  include/asm-generic/atomic-long.h: In function 'atomic_long_read_acquire':
  include/asm-generic/atomic-long.h:45:231: error: nested extern declaration of '__compiletime_assert_45' [-Werror=nested-externs]
  In file included from include/linux/atomic.h:562:0,
                   from include/linux/mutex.h:18,
                   from include/linux/kernfs.h:13,
                   from include/linux/sysfs.h:15,
                   from include/linux/kobject.h:21,
                   from include/linux/pci.h:28,
                   from drivers/misc/cxl/api.c:10:
  include/asm-generic/atomic-long.h: In function 'atomic_long_set_release':
  include/asm-generic/atomic-long.h:57:1: error: nested extern declaration of '__compiletime_assert_57' [-Werror=nested-externs]
  In file included from include/linux/ktime.h:25:0,
                   from include/linux/rcupdate.h:47,
                   from include/linux/idr.h:18,
                   from include/linux/kernfs.h:14,
                   from include/linux/sysfs.h:15,
                   from include/linux/kobject.h:21,
                   from include/linux/pci.h:28,
                   from drivers/misc/cxl/api.c:10:
  include/linux/jiffies.h: In function 'jiffies_to_timespec':
  include/linux/jiffies.h:422:131: error: declaration of 'jiffies' shadows a global declaration [-Werror=shadow]
  include/linux/jiffies.h:78:65: error: shadowed declaration is here [-Werror=shadow]
  In file included from include/linux/kernfs.h:16:0,
                   from include/linux/sysfs.h:15,
                   from include/linux/kobject.h:21,
                   from include/linux/pci.h:28,
                   from drivers/misc/cxl/api.c:10:
  [...many more failures...]
  cc1: all warnings being treated as errors
  make[1]: *** [drivers/misc/cxl/api.o] Error 1
  make: *** [drivers/misc/cxl/api.o] Error 2


I doubt you plan to fix all those. So making -Werror configurable seems like
the only way forward, then. (Glad you agreed!)

Regards,
Brian
