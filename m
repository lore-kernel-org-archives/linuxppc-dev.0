Return-Path: <fengguang.wu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id C50962C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 13:03:29 +1000 (EST)
Date: Thu, 6 Sep 2012 11:03:26 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [powerpc:next 11/29]
 arch/powerpc/platforms/pseries/iommu.c:1064:2: error: implicit declaration
 of function 'memblock_end_of_DRAM'
Message-ID: <20120906030326.GA16800@localhost>
References: <20120906022003.GB16076@localhost>
 <1346899471.19098.14.camel@pasglop>
 <1346899754.19098.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346899754.19098.15.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2012 at 12:49:14PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2012-09-06 at 12:44 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2012-09-06 at 10:20 +0800, Fengguang Wu wrote:
> > > Hi Michael,
> > > 
> > > FYI, kernel build failed on
> > > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
> > > head:   8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad
> > > commit: 474e3d569b63f7275cfec072d7ef7b2ffb8904c8 [11/29] powerpc/pseries: Remove uses of abs_to_virt() and virt_to_abs()
> > > config: powerpc-allmodconfig (attached as .config)
> > > 
> > > All related error/warning messages:
> > > 
> > > arch/powerpc/platforms/pseries/iommu.c: In function 'enable_ddw':
> > > arch/powerpc/platforms/pseries/iommu.c:1064:2: error: implicit declaration of function 'memblock_end_of_DRAM' [-Werror=implicit-function-declaration]
> > > cc1: some warnings being treated as errors
> > 
> > Thanks. That seems to be building in my tree oddly, I didn't even have a
> > warning. Maybe some conditional inclusion ? I will add a commit that
> > adds an explicit #include of memblock.h
> 
> Ok, I see. It's a subtle bisection breakage, the next commit fixes it.

Yes, I'm doing bisectibility tests :)

> Oh well, I won't rebase for that, but thanks for the heads up.

No problem. Sorry I didn't know that. Will test HEAD commits only for
this branch in future.

Thanks,
Fengguang
