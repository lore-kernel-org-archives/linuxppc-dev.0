Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 66E6F67E35
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 08:23:55 +1100 (EST)
Date: Fri, 10 Nov 2006 15:23:10 -0600
From: Olof Johansson <olof@lixom.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061110152310.7419ef3e@pb15>
In-Reply-To: <4554DACB.8060809@am.sony.com>
References: <4554DACB.8060809@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Just a couple of small comments, I haven't had time to get deeper into
the patchset yet. :-)

On Fri, 10 Nov 2006 12:02:19 -0800 Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> This adds the core platform support for the PS3 game console and other
> platforms using the PS3 Platform hypervisor.
> 
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> ---
>  MAINTAINERS                             |    7 
>  arch/powerpc/Kconfig                    |   11 
>  arch/powerpc/platforms/Makefile         |    1 
>  arch/powerpc/platforms/ps3pf/Kconfig    |   32 +

Why are you naming the platform "platform" as in "this is the ps3pf
platform" which expands to "this is the ps3 platform platform"? ps3 is
quite adequate as the platform name. :-)

> +config PS3PF_HTAB_SIZE
> +	depends on PS3PF
> +	int "PS3 Platform pagetable size"
> +	range 18 20
> +	default 20
> +	help
> +	  This option is only for experts who may have the desire to fine
> +	  tune the pagetable size on their system.  The value here is
> +	  expressed as the log2 of the page table size.  Valid values are
> +	  18, 19, and 20, corresponding to 256KB, 512KB and 1MB respectively.
> +
> +	  If unsure, choose the default (20) with the confidence that your
> +	  system will have optimal runtime performance.

Wouldn't it be more understandable if you had a "small/medium/large"
memory config options (that in itself sets the values) instead of
having people pick numbers?

> +	result = dma_region_create(r);
> +
> +	if (result) {
> +		pr_debug("%s:%d: ps3pf_dma_region_create failed\n",
> +			__func__, __LINE__);
> +		BUG();
> +	}

You have lots of these. please do BUG_ON(result) instead. :-)


-Olof
