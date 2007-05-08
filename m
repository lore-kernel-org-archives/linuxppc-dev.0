Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5531CDDDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:32:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48NWKxM003585
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:32:20 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48NWKqO174904
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 17:32:20 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48NWJ49029456
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 17:32:19 -0600
Date: Tue, 8 May 2007 18:32:00 -0500
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-ID: <20070508233200.GO4452@austin.ibm.com>
References: <20070508162650.704.83752.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508162650.704.83752.stgit@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	pavel@ucw.cz, wli@holomorphy.com, dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On Tue, May 08, 2007 at 04:26:51PM +0000, Maxim Uvarov wrote:
> 
> Patch makes available to the user the following
> task and process performance statistics:

[...]

> diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
> index 5e47683..26f0cc0 100644
> --- a/arch/i386/kernel/entry.S
> +++ b/arch/i386/kernel/entry.S
> @@ -331,6 +331,7 @@ sysenter_past_esp:
>  	CFI_ADJUST_CFA_OFFSET 4
>  	SAVE_ALL
>  	GET_THREAD_INFO(%ebp)
> +	incl	TI_syscall_count(%ebp)	# Increment syscalls counter

Other arches have this protected with #ifdef CONFIG_TASKSTATS
why not here?

> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index c03e829..329c2f8 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -202,6 +202,11 @@ _GLOBAL(DoSyscall)
>  	bl	do_show_syscall
>  #endif /* SHOW_SYSCALLS */
>  	rlwinm	r10,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
> +#ifdef CONFIG_THREAD_PERF_STAT_SYSC
> +	lwz r11,TI_SYSC_CNT(r10)
> +	addi r11,r11,1
> +	stw r11,TI_SYSC_CNT(r10)
> +#endif /* CONFIG_THREAD_PERF_STAT_SYSC */

Why not CONFIG_TASKSTATS, as in entry_64.S ?

Actually, grep shows that CONFIG_THREAD_PERF_STAT_SYSC is not defined
anywhere.

> diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
> index 9f5dac6..9fd97df 100644
> --- a/arch/x86_64/kernel/entry.S
> +++ b/arch/x86_64/kernel/entry.S
> @@ -229,6 +229,7 @@ ENTRY(system_call)
>  	movq  %rcx,RIP-ARGOFFSET(%rsp)
>  	CFI_REL_OFFSET rip,RIP-ARGOFFSET
>  	GET_THREAD_INFO(%rcx)
> +	addq $1, threadinfo_syscall_count(%rcx)   # Increment syscalls counter

again, #ifdef CONFIG_TASKSTATS,

--linas
