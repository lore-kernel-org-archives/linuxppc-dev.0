Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409MfW41HWzF28y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 18:12:50 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2R7A7Br056177
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:12:48 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gyg992nx7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:12:43 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 27 Mar 2018 08:12:37 +0100
Subject: Re: [RFC PATCH] powerpc/xmon: Use OPAL_DEBUG to debug srest in OPAL
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20180326150946.23555-1-npiggin@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 12:42:32 +0530
MIME-Version: 1.0
In-Reply-To: <20180326150946.23555-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <25588979-81cd-2a63-59f8-728686855117@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2018 08:39 PM, Nicholas Piggin wrote:
> xmon can be entered via sreset NMI (from a management sreset, or an
> NMI IPI), which can interrupt OPAL. Add checks to xmon to see if pc
> or sp are within OPAL memory, and if so, then use OPAL_DEBUG to
> print the opal stack and return the Linux stack, which can then be
> dumped by xmon

Nick,


OPAL uses FSP/cronus interface for many of debug interface (like OPAL assert, 
getting opal console, triggering FSP R/R etc). May be in future we may add new 
debug capability.
Once secureboot is enabled none of these interface work and we have limited debug
capability.

Here you are using very generic API name (OPAL_DEBUG). May be we should have generic
interface (exported via debugfs?) here rather than SRESET specific one.

-Vasant


> 
> The OPAL side of this, with sample xmon output is here:
> 
> https://lists.ozlabs.org/pipermail/skiboot/2018-March/010856.html
> 
> This could be plumed into the oops printing code as well.
> 
> Thanks,
> Nick
> ---
>   arch/powerpc/include/asm/opal.h                |  4 ++++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
>   arch/powerpc/platforms/powernv/opal.c          |  5 +++++
>   arch/powerpc/xmon/xmon.c                       | 27 ++++++++++++++++++++++++++
>   4 files changed, 37 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 12e70fb58700..afcc0c5ed5b0 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -27,6 +27,8 @@ extern struct kobject *opal_kobj;
>   /* /ibm,opal */
>   extern struct device_node *opal_node;
> 
> +bool in_opal_text_heap_stack(u64 address);
> +
>   /* API functions */
>   int64_t opal_invalid_call(void);
>   int64_t opal_npu_destroy_context(uint64_t phb_id, uint64_t pid, uint64_t bdf);
> @@ -289,6 +291,8 @@ int opal_sensor_group_clear(u32 group_hndl, int token);
> 
>   s64 opal_signal_system_reset(s32 cpu);
> 
> +s64 opal_debug(u32 debug_type, u64 r1);
> +
>   /* Internal functions */
>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>   				   int depth, void *data);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 1b2936ba6040..78b9ae003553 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -323,3 +323,4 @@ OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
>   OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
>   OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
>   OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
> +OPAL_CALL(opal_debug,				167);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index c15182765ff5..0b7ff5fb18f8 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -64,6 +64,11 @@ static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
>   static uint32_t opal_heartbeat;
>   static struct task_struct *kopald_tsk;
> 
> +bool in_opal_text_heap_stack(u64 address)
> +{
> +	return (address >= opal.base && address < opal.base + opal.size);
> +}
> +
>   void opal_configure_cores(void)
>   {
>   	u64 reinit_flags = 0;
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 82e1a3ee6e0f..ade1adcc1ab8 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -452,6 +452,15 @@ static inline int unrecoverable_excp(struct pt_regs *regs)
>   #endif
>   }
> 
> +static bool in_opal(unsigned long addr)
> +{
> +	if (firmware_has_feature(FW_FEATURE_OPAL))
> +		if (in_opal_text_heap_stack(addr))
> +			return true;
> +
> +	return false;
> +}
> +
>   static int xmon_core(struct pt_regs *regs, int fromipi)
>   {
>   	int cmd = 0;
> @@ -510,6 +519,9 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
> 
>   	xmon_fault_jmp[cpu] = recurse_jmp;
> 
> +	if (in_opal(regs->nip))
> +		printf("xmon: cpu 0x%x stopped in OPAL!\n", cpu);
> +
>   	bp = NULL;
>   	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
>   		bp = at_breakpoint(regs->nip);
> @@ -1484,8 +1496,23 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
>   	unsigned long marker;
>   	struct pt_regs regs;
> 
> +	if (in_opal(sp)) {
> +		struct debug_struct {
> +			unsigned long nip;
> +			unsigned long r1;
> +			unsigned long r1_caller;
> +		} db;
> +		printf("SP is in OPAL, calling OPAL to dump stack\n");
> +		db.nip = cpu_to_be64(pc);
> +		db.r1 = cpu_to_be64(sp);
> +		opal_debug(1, (unsigned long)&db);
> +		sp = be64_to_cpu(db.r1_caller);
> +	}
> +
>   	while (max_to_print--) {
>   		if (!is_kernel_addr(sp)) {
> +			if (in_opal(pc) && in_opal(sp))
> +				printf("SP (%lx) is in OPAL\n", sp);
>   			if (sp != 0)
>   				printf("SP (%lx) is in userspace\n", sp);
>   			break;
> 
