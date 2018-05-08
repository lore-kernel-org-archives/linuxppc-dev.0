Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gHzT6ZGbzF24c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 21:57:25 +1000 (AEST)
Date: Tue, 8 May 2018 21:57:25 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: hcall_exit tracepoint retval should be
 signed
Message-ID: <20180508215725.7ec117c1@kryten>
In-Reply-To: <20180507130355.25115-1-mpe@ellerman.id.au>
References: <20180507130355.25115-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> The hcall_exit() tracepoint has retval defined as unsigned long. That
> leads to humours results like:
> 
>   bash-3686  [009] d..2   854.134094: hcall_entry: opcode=24
>   bash-3686  [009] d..2   854.134095: hcall_exit: opcode=24
> retval=18446744073709551609
> 
> It's normal for some hcalls to return negative values, displaying them
> as unsigned isn't very helpful. So change it to signed.
> 
>   bash-3711  [001] d..2   471.691008: hcall_entry: opcode=24
>   bash-3711  [001] d..2   471.691008: hcall_exit: opcode=24 retval=-7
> 
> Which can be more easily compared to H_NOT_FOUND in hvcall.h

Much nicer.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/asm-prototypes.h    | 3 +--
>  arch/powerpc/include/asm/trace.h             | 7 +++----
>  arch/powerpc/platforms/pseries/hvCall_inst.c | 2 +-
>  arch/powerpc/platforms/pseries/lpar.c        | 3 +--
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h
> b/arch/powerpc/include/asm/asm-prototypes.h index
> d9713ad62e3c..068760d61e7e 100644 ---
> a/arch/powerpc/include/asm/asm-prototypes.h +++
> b/arch/powerpc/include/asm/asm-prototypes.h @@ -36,8 +36,7 @@ void
> kexec_copy_flush(struct kimage *image); /* pseries hcall tracing */
>  extern struct static_key hcall_tracepoint_key;
>  void __trace_hcall_entry(unsigned long opcode, unsigned long *args);
> -void __trace_hcall_exit(long opcode, unsigned long retval,
> -			unsigned long *retbuf);
> +void __trace_hcall_exit(long opcode, long retval, unsigned long
> *retbuf); /* OPAL tracing */
>  #ifdef HAVE_JUMP_LABEL
>  extern struct static_key opal_tracepoint_key;
> diff --git a/arch/powerpc/include/asm/trace.h
> b/arch/powerpc/include/asm/trace.h index 33f3b479138b..d018e8602694
> 100644 --- a/arch/powerpc/include/asm/trace.h
> +++ b/arch/powerpc/include/asm/trace.h
> @@ -81,8 +81,7 @@ TRACE_EVENT_FN_COND(hcall_entry,
>  
>  TRACE_EVENT_FN_COND(hcall_exit,
>  
> -	TP_PROTO(unsigned long opcode, unsigned long retval,
> -		unsigned long *retbuf),
> +	TP_PROTO(unsigned long opcode, long retval, unsigned long
> *retbuf), 
>  	TP_ARGS(opcode, retval, retbuf),
>  
> @@ -90,7 +89,7 @@ TRACE_EVENT_FN_COND(hcall_exit,
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned long, opcode)
> -		__field(unsigned long, retval)
> +		__field(long, retval)
>  	),
>  
>  	TP_fast_assign(
> @@ -98,7 +97,7 @@ TRACE_EVENT_FN_COND(hcall_exit,
>  		__entry->retval = retval;
>  	),
>  
> -	TP_printk("opcode=%lu retval=%lu", __entry->opcode,
> __entry->retval),
> +	TP_printk("opcode=%lu retval=%ld", __entry->opcode,
> __entry->retval), 
>  	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
>  );
> diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c
> b/arch/powerpc/platforms/pseries/hvCall_inst.c index
> 89b7ce807e70..6da320c786cd 100644 ---
> a/arch/powerpc/platforms/pseries/hvCall_inst.c +++
> b/arch/powerpc/platforms/pseries/hvCall_inst.c @@ -125,7 +125,7 @@
> static void probe_hcall_entry(void *ignored, unsigned long opcode,
> unsigned long h->purr_start = mfspr(SPRN_PURR); }
>  
> -static void probe_hcall_exit(void *ignored, unsigned long opcode,
> unsigned long retval, +static void probe_hcall_exit(void *ignored,
> unsigned long opcode, long retval, unsigned long *retbuf)
>  {
>  	struct hcall_stats *h;
> diff --git a/arch/powerpc/platforms/pseries/lpar.c
> b/arch/powerpc/platforms/pseries/lpar.c index
> adb996ed51e1..5a392e40f3d2 100644 ---
> a/arch/powerpc/platforms/pseries/lpar.c +++
> b/arch/powerpc/platforms/pseries/lpar.c @@ -902,8 +902,7 @@ void
> __trace_hcall_entry(unsigned long opcode, unsigned long *args)
> local_irq_restore(flags); }
>  
> -void __trace_hcall_exit(long opcode, unsigned long retval,
> -			unsigned long *retbuf)
> +void __trace_hcall_exit(long opcode, long retval, unsigned long
> *retbuf) {
>  	unsigned long flags;
>  	unsigned int *depth;
