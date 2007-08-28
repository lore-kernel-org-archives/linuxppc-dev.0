Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 689FDDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 05:08:52 +1000 (EST)
Date: Tue, 28 Aug 2007 13:14:37 -0500
From: Olof Johansson <olof@lixom.net>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 3/4] PowerPC 440EPx: Sequoia board support
Message-ID: <20070828181437.GA14905@lixom.net>
References: <20070828170007.GA1605@ru.mvista.com>
	<20070828175022.GA7556@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828175022.GA7556@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Aug 28, 2007 at 09:50:22PM +0400, Valentine Barshak wrote:

> diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
> --- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-08-27 14:08:43.000000000 +0400
> +++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-08-28 17:04:51.000000000 +0400
> @@ -217,7 +217,7 @@
>  	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
>  	mtspr	SPRN_IVPR,r4
>  
> -#ifdef CONFIG_440EP
> +#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
>  	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
>  	mfspr	r2,SPRN_CCR0
>  	lis	r3,0xffef

This is obviously nothing urgent given that the ifdef already existed, but
this looks like it really should be a runtime check instead. Multiplatform
kernels will require it (if/whenever that becomes a priority for 44x).


-Olof
