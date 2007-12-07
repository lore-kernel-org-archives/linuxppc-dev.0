Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36543DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 14:30:44 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB73UfGk020636
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:30:41 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB73UfHD091570
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 20:30:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB73UfUO031612
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 20:30:41 -0700
Date: Thu, 6 Dec 2007 21:27:44 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 23/25] powerpc: Rework 4xx clock probing in boot wrapper
Message-ID: <20071206212744.7257f1a2@zod.rchland.ibm.com>
In-Reply-To: <20071206080133.D24A9DE136@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080133.D24A9DE136@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 19:00:22 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Index: linux-work/arch/powerpc/boot/reg.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/boot/reg.h	2007-12-03 14:26:09.000000000 +1100
> +++ linux-work/arch/powerpc/boot/reg.h	2007-12-03 14:26:09.000000000 +1100
> @@ -24,6 +24,14 @@ static inline u32 mfpvr(void)
>  				: "=r" (rval)); rval; })
>  #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
> 
> +#define __stringify_1(x)	#x
> +#define __stringify(x)		__stringify_1(x)
> +
> +#define mfspr(rn)	({unsigned long rval; \
> +			asm volatile("mfspr %0," __stringify(rn) \
> +				: "=r" (rval)); rval; })
> +#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
> +

You felt like duplicating this?  It was added in the previous patch. :)

josh
