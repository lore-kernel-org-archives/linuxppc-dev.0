Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 85D62DDF1D
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 22:48:25 +1100 (EST)
Date: Mon, 13 Oct 2008 14:26:31 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Brice Goglin <brice@myri.com>, Jeff Garzik <jgarzik@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on powerpc selects
	CONFIG_INTEL_IOATDMA=y
Message-ID: <20081013112631.GD29938@cs181140183.pp.htv.fi>
References: <20081013101559.GA14372@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20081013101559.GA14372@linux.vnet.ibm.com>
Cc: e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 13, 2008 at 03:45:59PM +0530, Kamalesh Babulal wrote:
> Hi,
> 
>    2.6.27-git2 kernel build fails, while building the kernel with
> allyesconfig option. The allyesconfig selects CONFIG_INTEL_IOATDMA=y
> 
> CC   drivers/dma/ioat_dca.o
> drivers/dma/ioat_dca.c: In function âdca_enabled_in_biosâ:
> drivers/dma/ioat_dca.c:81: error: implicit declaration of function âcpuid_eaxâ
> drivers/dma/ioat_dca.c: In function âsystem_has_dca_enabledâ:
> drivers/dma/ioat_dca.c:91: error: implicit declaration of function âboot_cpu_hasâ
> drivers/dma/ioat_dca.c:91: error: âX86_FEATURE_DCAâ undeclared (first use in this function)
> drivers/dma/ioat_dca.c:91: error: (Each undeclared identifier is reported only once
> drivers/dma/ioat_dca.c:91: error: for each function it appears in.)
> drivers/dma/ioat_dca.c: In function âioat_dca_get_tagâ:
> drivers/dma/ioat_dca.c:190: error: implicit declaration of function âcpu_physical_idâ
> make[2]: *** [drivers/dma/ioat_dca.o] Error 1
> make[1]: *** [drivers/dma] Error 2
> make: *** [drivers] Error 2
>...

Thanks for the report, the MYRI10GE and IXGBE commits that introduced 
the select's are really broken.

For fixing it I need to know the intended semantics.

Brian, Jesse, is it OK to limit the drivers to m with 
CONFIG_INTEL_IOATDMA=m ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
