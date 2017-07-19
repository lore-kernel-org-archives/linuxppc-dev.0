Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xC8wj14yGzDrT4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:15:31 +1000 (AEST)
Date: Wed, 19 Jul 2017 09:01:50 +0100
From: Will Deacon <will.deacon@arm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 catalin.marinas@arm.com, gabriele.paoloni@huawei.com,
 bhelgaas@google.com, airlied@linux.ie, daniel.vetter@intel.com,
 alex.williamson@redhat.com
Subject: Re: [PATCH v2 4/4] arm64: allow non-legacy VGA devices to be default
Message-ID: <20170719080150.GB13642@arm.com>
References: <20170719021516.24718-1-dja@axtens.net>
 <20170719021516.24718-5-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719021516.24718-5-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2017 at 12:15:16PM +1000, Daniel Axtens wrote:
> The VGA arbiter only marks a device as default if it can decode
> legacy I/O and memory ranges. This is often not the case on arm64,
> which doesn't use the legacy ranges.
> 
> Enable the VGA arbiter to mark the first enabled VGA card as
> default.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> ---
> 
> Tested on a D05 using the hibmc card.
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index dfd908630631..cefcbd442e4f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -28,6 +28,7 @@ config ARM64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> +	select ARCH_WANT_VGA_ARB_FALLBACK
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> -- 
> 2.11.0
> 
