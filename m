Return-Path: <brice@myri.com>
Received: from myri.com (mailbox2.myri.com [64.172.73.26])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D81F3DE7B5
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 23:19:00 +1100 (EST)
Message-ID: <48F338D2.9080300@myri.com>
Date: Mon, 13 Oct 2008 14:02:26 +0200
From: Brice Goglin <brice@myri.com>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on powerpc selects
	CONFIG_INTEL_IOATDMA=y
References: <20081013101559.GA14372@linux.vnet.ibm.com>
	<20081013112631.GD29938@cs181140183.pp.htv.fi>
In-Reply-To: <20081013112631.GD29938@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8
Cc: e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, sam@ravnborg.org,
	Jeff Garzik <jgarzik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk wrote:
> On Mon, Oct 13, 2008 at 03:45:59PM +0530, Kamalesh Babulal wrote:
>   
>> Hi,
>>
>>    2.6.27-git2 kernel build fails, while building the kernel with
>> allyesconfig option. The allyesconfig selects CONFIG_INTEL_IOATDMA=y
>>
>> CC   drivers/dma/ioat_dca.o
>> drivers/dma/ioat_dca.c: In function âdca_enabled_in_biosâ:
>> drivers/dma/ioat_dca.c:81: error: implicit declaration of function âcpuid_eaxâ
>> drivers/dma/ioat_dca.c: In function âsystem_has_dca_enabledâ:
>> drivers/dma/ioat_dca.c:91: error: implicit declaration of function âboot_cpu_hasâ
>> drivers/dma/ioat_dca.c:91: error: âX86_FEATURE_DCAâ undeclared (first use in this function)
>> drivers/dma/ioat_dca.c:91: error: (Each undeclared identifier is reported only once
>> drivers/dma/ioat_dca.c:91: error: for each function it appears in.)
>> drivers/dma/ioat_dca.c: In function âioat_dca_get_tagâ:
>> drivers/dma/ioat_dca.c:190: error: implicit declaration of function âcpu_physical_idâ
>> make[2]: *** [drivers/dma/ioat_dca.o] Error 1
>> make[1]: *** [drivers/dma] Error 2
>> make: *** [drivers] Error 2
>> ...
>>     
>
> Thanks for the report, the MYRI10GE and IXGBE commits that introduced 
> the select's are really broken.
>
> For fixing it I need to know the intended semantics.
>
> Brian, Jesse, is it OK to limit the drivers to m with 
> CONFIG_INTEL_IOATDMA=m ?
>   

I think I would rather drop DCA from myri10ge if IOATDMA=m while
myri10ge=y. What's the simplest way to do so?

When Jesse told me to commit this in myri10ge, I thought it would be
nice to have DCA work the same than NETDMA/DMAengine does: you can have
NETDMA enabled without IOATDMA (either not built at all, or just not
loaded). You just don't get any DMA channel when you ask for one. Why
not do the same for DCA? There could be some generic DCA layer that can
be built all the time and returns DCA resources only if IOATDMA is
loaded/built ?

Brice
