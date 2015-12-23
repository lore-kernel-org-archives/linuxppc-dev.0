Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA1811A0CDD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 03:12:35 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0118.hostedemail.com
 [216.40.44.118])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9C45140C04
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2015 03:12:34 +1100 (AEDT)
Date: Wed, 23 Dec 2015 11:12:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc: tracing: don't trace hcalls on offline
 CPUs
Message-ID: <20151223111228.10f25239@gandalf.local.home>
In-Reply-To: <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
References: <1450124286-4822-1-git-send-email-kda@linux-powerpc.org>
 <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
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

On Mon, 14 Dec 2015 23:18:06 +0300
Denis Kirjanov <kda@linux-powerpc.org> wrote:

> ./drmgr -c cpu -a -r gives the following warning:
> 
> [ 2327.035563]
> RCU used illegally from offline CPU!
> rcu_scheduler_active = 1, debug_locks = 1
> [ 2327.035564] no locks held by swapper/12/0.
> [ 2327.035565]
> stack backtrace:
> [ 2327.035567] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G S
> 4.3.0-rc3-00060-g353169a #5
> [ 2327.035568] Call Trace:
> [ 2327.035573] [c0000001d62578e0] [c0000000008977fc] .dump_stack+0x98/0xd4 (unreliable)
> [ 2327.035577] [c0000001d6257960] [c000000000109bd8] .lockdep_rcu_suspicious+0x108/0x170
> [ 2327.035580] [c0000001d62579f0] [c00000000006a1d0] .__trace_hcall_exit+0x2b0/0x2c0
> [ 2327.035584] [c0000001d6257ab0] [c00000000006a2e8] plpar_hcall_norets_trace+0x70/0x8c
> [ 2327.035588] [c0000001d6257b20] [c000000000067a14] .icp_hv_set_cpu_priority+0x54/0xc0
> [ 2327.035592] [c0000001d6257ba0] [c000000000066c5c] .xics_teardown_cpu+0x5c/0xa0
> [ 2327.035595] [c0000001d6257c20] [c0000000000747ac] .pseries_mach_cpu_die+0x6c/0x320
> [ 2327.035598] [c0000001d6257cd0] [c0000000000439cc] .cpu_die+0x3c/0x60
> [ 2327.035602] [c0000001d6257d40] [c0000000000183d8] .arch_cpu_idle_dead+0x28/0x40
> [ 2327.035606] [c0000001d6257db0] [c0000000000ff1dc] .cpu_startup_entry+0x4fc/0x560
> [ 2327.035610] [c0000001d6257ed0] [c000000000043728] .start_secondary+0x328/0x360
> [ 2327.035614] [c0000001d6257f90] [c000000000008a6c] start_secondary_prolog+0x10/0x14
> [ 2327.035620] cpu 12 (hwid 12) Ready to die...
> [ 2327.144463] cpu 13 (hwid 13) Ready to die...
> [ 2327.294180] cpu 14 (hwid 14) Ready to die...
> [ 2327.403599] cpu 15 (hwid 15) Ready to die...
> 
> Make the hypervisor tracepoints conditional
> by using TRACE_EVENT_FN_COND
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

I applied the first patch, but I need Acks from the powerpc maintainers
to take this one.

-- Steve


> 
> v2 changes:
>  - Use raw_smp_processor_id as suggested by BenH
>  since since hcalls can be called from preemptable sections
> 
> v3 changes:
>  - Fix the subject line
> ---
>  arch/powerpc/include/asm/trace.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
> index 8e86b48..32e36b1 100644
> --- a/arch/powerpc/include/asm/trace.h
> +++ b/arch/powerpc/include/asm/trace.h
> @@ -57,12 +57,14 @@ DEFINE_EVENT(ppc64_interrupt_class, timer_interrupt_exit,
>  extern void hcall_tracepoint_regfunc(void);
>  extern void hcall_tracepoint_unregfunc(void);
>  
> -TRACE_EVENT_FN(hcall_entry,
> +TRACE_EVENT_FN_COND(hcall_entry,
>  
>  	TP_PROTO(unsigned long opcode, unsigned long *args),
>  
>  	TP_ARGS(opcode, args),
>  
> +	TP_CONDITION(cpu_online(raw_smp_processor_id())),
> +
>  	TP_STRUCT__entry(
>  		__field(unsigned long, opcode)
>  	),
> @@ -76,13 +78,15 @@ TRACE_EVENT_FN(hcall_entry,
>  	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
>  );
>  
> -TRACE_EVENT_FN(hcall_exit,
> +TRACE_EVENT_FN_COND(hcall_exit,
>  
>  	TP_PROTO(unsigned long opcode, unsigned long retval,
>  		unsigned long *retbuf),
>  
>  	TP_ARGS(opcode, retval, retbuf),
>  
> +	TP_CONDITION(cpu_online(raw_smp_processor_id())),
> +
>  	TP_STRUCT__entry(
>  		__field(unsigned long, opcode)
>  		__field(unsigned long, retval)
