Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17616.12251.339657.215571@cargo.ozlabs.ibm.com>
Date: Wed, 2 Aug 2006 14:53:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
In-Reply-To: <20060719230014.GB3887@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> Abstract the operations used in the bootwrapper.  The operations
> have been divided up into platform ops (platform_ops), firware ops
> (fw_ops), device tree ops (dt_ops), and console ops (console_ops).

Overall the approach looks good.

The ops structure seems like a reasonable concept, but I question
whether we need to have platform_ops separate from fw_ops, since the
firmware is essentially part of the implementation of the platform.
Also I don't see why we need to do a double indirection to get to each
ops function.

Also, we will probably want to create some directory structure under
arch/powerpc/boot in the longer term.

> +#ifdef __powerpc64__
> +typedef unsigned long		u64;
> +#else
> +typedef unsigned long long	u64;
> +#endif

This is potentially confusing, because the __powerpc64__ relates to
the boot wrapper not the kernel, and we don't build a 64-bit boot
wrapper on any platform (not yet anyway).  Maybe this needs a comment.

Paul.
