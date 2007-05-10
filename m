Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 04702DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 20:44:07 +1000 (EST)
Message-ID: <4642F27E.10700@ru.mvista.com>
Date: Thu, 10 May 2007 10:22:54 +0000
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508233200.GO4452@austin.ibm.com>
In-Reply-To: <20070508233200.GO4452@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Linas Vepstas wrote:

>Hi,
>
>On Tue, May 08, 2007 at 04:26:51PM +0000, Maxim Uvarov wrote:
>  
>
>>Patch makes available to the user the following
>>task and process performance statistics:
>>    
>>
>
>[...]
>
>  
>
>>diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
>>index 5e47683..26f0cc0 100644
>>--- a/arch/i386/kernel/entry.S
>>+++ b/arch/i386/kernel/entry.S
>>@@ -331,6 +331,7 @@ sysenter_past_esp:
>> 	CFI_ADJUST_CFA_OFFSET 4
>> 	SAVE_ALL
>> 	GET_THREAD_INFO(%ebp)
>>+	incl	TI_syscall_count(%ebp)	# Increment syscalls counter
>>    
>>
>
>Other arches have this protected with #ifdef CONFIG_TASKSTATS
>why not here?
>
>  
>
Thank you. It should be protected.

>>diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>>index c03e829..329c2f8 100644
>>--- a/arch/powerpc/kernel/entry_32.S
>>+++ b/arch/powerpc/kernel/entry_32.S
>>@@ -202,6 +202,11 @@ _GLOBAL(DoSyscall)
>> 	bl	do_show_syscall
>> #endif /* SHOW_SYSCALLS */
>> 	rlwinm	r10,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
>>+#ifdef CONFIG_THREAD_PERF_STAT_SYSC
>>+	lwz r11,TI_SYSC_CNT(r10)
>>+	addi r11,r11,1
>>+	stw r11,TI_SYSC_CNT(r10)
>>+#endif /* CONFIG_THREAD_PERF_STAT_SYSC */
>>    
>>
>
>Why not CONFIG_TASKSTATS, as in entry_64.S ?
>
>Actually, grep shows that CONFIG_THREAD_PERF_STAT_SYSC is not defined
>anywhere.
>
>  
>
This is mistake, thank you. I have to be more considerate.

>>diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
>>index 9f5dac6..9fd97df 100644
>>--- a/arch/x86_64/kernel/entry.S
>>+++ b/arch/x86_64/kernel/entry.S
>>@@ -229,6 +229,7 @@ ENTRY(system_call)
>> 	movq  %rcx,RIP-ARGOFFSET(%rsp)
>> 	CFI_REL_OFFSET rip,RIP-ARGOFFSET
>> 	GET_THREAD_INFO(%rcx)
>>+	addq $1, threadinfo_syscall_count(%rcx)   # Increment syscalls counter
>>    
>>
>
>again, #ifdef CONFIG_TASKSTATS,
>
>--linas
>  
>

In general I had the following idea. Defend with CONFIG_TASKSTATS all
syscall increment counters in  arch/*/entry.S  code.  It will allow to
avoid this overhead if task stats interface is not supported by kernel.
The overhead is too small but,  it is not needed to increment counters 
without interface
to get them.

In first version of patch I have used only /proc interface. And it is 
available now.
So I don't really sure if  defines are needed in  entry.S code. I tried 
to do
some tests and  it is impossible to catch the performance difference (small
overhead).
