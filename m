Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42B8DDDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 09:18:09 +1000 (EST)
Subject: Re: [PATCH] powerpc: save trap number in bad_stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070416062347.GA20196@lixom.net>
References: <20070416062347.GA20196@lixom.net>
Content-Type: text/plain
Date: Fri, 20 Apr 2007 09:17:58 +1000
Message-Id: <1177024678.7286.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-16 at 01:23 -0500, Olof Johansson wrote:
> Save the trap number in the case of getting a bad stack in an exception
> handler. It is sometimes useful to know what exception it was that caused
> this to happen. Without this, no trap is reported.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Index: linux-2.6/arch/powerpc/kernel/asm-offsets.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/asm-offsets.c
> +++ linux-2.6/arch/powerpc/kernel/asm-offsets.c
> @@ -139,6 +139,7 @@ int main(void)
>  	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
>  	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
>  	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
> +	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
>  
>  	DEFINE(SLBSHADOW_STACKVSID,
>  	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
> Index: linux-2.6/include/asm-powerpc/paca.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/paca.h
> +++ linux-2.6/include/asm-powerpc/paca.h
> @@ -81,6 +81,8 @@ struct paca_struct {
>  	u64 exslb[10];		/* used for SLB/segment table misses
>   				 * on the linear mapping */
>  
> +	u64 trap_save;			/* Used when bad stack is encountered */

Can you put it elsewhere in the PACA (around less frequently used
bits) ? This is a pretty hot area of the PACA...

Ben.
