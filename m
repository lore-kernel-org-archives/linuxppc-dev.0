Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 818062C0093
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 12:44:44 +1000 (EST)
Message-ID: <1346899471.19098.14.camel@pasglop>
Subject: Re: [powerpc:next 11/29]
 arch/powerpc/platforms/pseries/iommu.c:1064:2: error: implicit declaration
 of function 'memblock_end_of_DRAM'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 06 Sep 2012 12:44:31 +1000
In-Reply-To: <20120906022003.GB16076@localhost>
References: <20120906022003.GB16076@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-06 at 10:20 +0800, Fengguang Wu wrote:
> Hi Michael,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
> head:   8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad
> commit: 474e3d569b63f7275cfec072d7ef7b2ffb8904c8 [11/29] powerpc/pseries: Remove uses of abs_to_virt() and virt_to_abs()
> config: powerpc-allmodconfig (attached as .config)
> 
> All related error/warning messages:
> 
> arch/powerpc/platforms/pseries/iommu.c: In function 'enable_ddw':
> arch/powerpc/platforms/pseries/iommu.c:1064:2: error: implicit declaration of function 'memblock_end_of_DRAM' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors

Thanks. That seems to be building in my tree oddly, I didn't even have a
warning. Maybe some conditional inclusion ? I will add a commit that
adds an explicit #include of memblock.h

Cheers,
Ben.
