Return-Path: <haren@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6E4E2C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 15:38:10 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 01:38:07 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1BF5338C801A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 01:38:04 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G5c4dY327332
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 01:38:04 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G5c3AC000664
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 01:38:03 -0400
Message-ID: <516CE3B9.6030901@linux.vnet.ibm.com>
Date: Mon, 15 Apr 2013 22:38:01 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc: Fix audit crash due to save/restore PPR changes
References: <18949a6b246ced7268c2d2831f931f01.squirrel@mignight.com>
In-Reply-To: <18949a6b246ced7268c2d2831f931f01.squirrel@mignight.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/14/2013 06:44 PM, Alistair Popple wrote:
> The current mainline crashes when hitting userspace with the following:
> 
> kernel BUG at /home/alistair/Source/linux-stable/kernel/auditsc.c:1769!
> cpu 0x1: Vector: 700 (Program Check) at [c000000023883a60]
>     pc: c0000000001047a8: .__audit_syscall_entry+0x38/0x130
>     lr: c00000000000ed64: .do_syscall_trace_enter+0xc4/0x270
>     sp: c000000023883ce0
>    msr: 8000000000029032
>   current = 0xc000000023800000
>   paca    = 0xc00000000f080380   softe: 0        irq_happened: 0x01
>     pid   = 1629, comm = start_udev
> kernel BUG at /home/alistair/Source/linux-stable/kernel/auditsc.c:1769!
> enter ? for help
> [c000000023883d80] c00000000000ed64 .do_syscall_trace_enter+0xc4/0x270
> [c000000023883e30] c000000000009b08 syscall_dotrace+0xc/0x38
> --- Exception: c00 (System Call) at 0000008010ec50dc
> 
> Bisecting found the following patch caused it:
> 
> commit 44e9309f1f357794b7ae93d5f3e3e6f11d2b8a7f
> Author: Haren Myneni <haren@linux.vnet.ibm.com>
> powerpc: Implement PPR save/restore
> 
> It was found this patch corrupted r9 when calling
> SET_DEFAULT_THREAD_PPR()
> 
> Using r10 as a scratch register instead of r9 solved the problem.

Thanks for fixing. Sorry I missed it

Acked-by: Haren Myneni <haren@us.ibm.com>

> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Michael Neuling <mikey@neuling.org>
> ---
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 256c5bf..3acb1a0 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -304,7 +304,7 @@ syscall_exit_work:
>  	subi	r12,r12,TI_FLAGS
> 
>  4:	/* Anything else left to do? */
> -	SET_DEFAULT_THREAD_PPR(r3, r9)		/* Set thread.ppr = 3 */
> +	SET_DEFAULT_THREAD_PPR(r3, r10)		/* Set thread.ppr = 3 */
>  	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
>  	beq	.ret_from_except_lite
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
