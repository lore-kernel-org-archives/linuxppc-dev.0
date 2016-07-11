Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kt4lPtzDqxn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:30 +1000 (AEST)
In-Reply-To: <20160703203153.6155-1-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 <linux-kernel@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: make base more explicitly non-modular
Message-Id: <3rp1Kt2dPMz9t10@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-03-07 at 20:31:53 UTC, Paul Gortmaker wrote:
> The Kconfig/Makefile currently controlling compilation of this code is:
> 
> drivers/misc/cxl/Kconfig:config CXL_BASE
> drivers/misc/cxl/Kconfig:       bool
> 
> drivers/misc/cxl/Makefile:obj-$(CONFIG_CXL_BASE)          += base.o
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets convert the one module_init into device_initcall so that
> when reading the driver it more clear that it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We don't replace module.h with init.h since the file is doing
> other modular stuff (module_get/put) even though it is built-in.
> 
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e00878be3f414a99234b3c9613

cheers
