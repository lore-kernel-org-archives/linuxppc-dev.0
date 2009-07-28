Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 028C3B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 15:55:08 +1000 (EST)
Date: Tue, 28 Jul 2009 14:54:58 +0900
To: beckyb@kernel.crashing.org, benh@kernel.crashing.org
Subject: Re: [PATCH 5/5] powerpc: use asm-generic/dma-mapping-common.h
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <B388F2F2-C68F-4464-A63A-4D541DF5E9C9@kernel.crashing.org>
References: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1248405855-15546-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<B388F2F2-C68F-4464-A63A-4D541DF5E9C9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090728145138Y.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Jul 2009 16:08:46 -0500
Becky Bruce <beckyb@kernel.crashing.org> wrote:

> 
> On Jul 23, 2009, at 10:24 PM, FUJITA Tomonori wrote:
> 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> 
> Fujita,
> 
> Since you're removing all the uses of it, you should probably remove  
> PPC_NEED_DMA_SYNC_OPS from arch/powerpc/Kconfig:
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 0603b6c..fb3f4ff 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -307,10 +307,6 @@ config SWIOTLB
>            platforms where the size of a physical address is larger
>            than the bus address.  Not all platforms support this.
> 
> -config PPC_NEED_DMA_SYNC_OPS
> -       def_bool y
> -       depends on (NOT_COHERENT_CACHE || SWIOTLB)
> -
>   config HOTPLUG_CPU
>          bool "Support for enabling/disabling CPUs"
>          depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES ||  
> PPC_PMAC)
> 
> Otherwise, this looks good to me.

Ah, thanks. I fold the above change. The updated patchset is available
at:

git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git powerpc


> I also think you want an ACK from Ben - making this switch does add  
> slight overhead to platforms that don't need sync ops, but I think  
> it's worth it.  IIRC, it was Ben who asked for the optimization of  
> NEED_DMA_SYNC_OPS, so I'd like him to weigh in here.

Yeah, of course. Ben?
