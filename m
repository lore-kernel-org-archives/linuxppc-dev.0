Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3861C67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 13:44:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFFE20643
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 13:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFFE20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dyRj2KQwzF374
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 00:44:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dyPd3bktzDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 00:42:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42dyPd2w6fz8tSM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 00:42:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42dyPd2fvvz9sDr; Tue, 23 Oct 2018 00:42:29 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42dyPc6PRzz9sDC
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2018 00:42:28 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9MDgEsj030458
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2018 09:42:27 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n9dddpnp0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2018 09:42:25 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 22 Oct 2018 07:40:47 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Oct 2018 07:40:43 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9MDegHC59637966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Oct 2018 06:40:42 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEAF67805F;
 Mon, 22 Oct 2018 13:40:42 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6C5E7805C;
 Mon, 22 Oct 2018 13:40:40 +0000 (GMT)
Received: from [9.195.44.147] (unknown [9.195.44.147])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 22 Oct 2018 13:40:40 +0000 (GMT)
Subject: Re: [PATCH] powerpc: Fix stack protector crashes on CPU hotplug
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 22 Oct 2018 19:10:38 +0530
In-Reply-To: <20181019055927.20009-1-mpe@ellerman.id.au>
References: <20181019055927.20009-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102213-8235-0000-0000-00000E19D56A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106349; UDB=6.00572921; IPR=6.00886433; 
 MB=3.00023857; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 13:40:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102213-8236-0000-0000-00004316F093
Message-Id: <1540215638.30725.1.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-22_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=972 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220119
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-10-19 at 16:59 +1100, Michael Ellerman wrote:
> Recently in commit 7241d26e8175 ("powerpc/64: properly initialise
> the stackprotector canary on SMP.") we fixed a crash with stack
> protector on SMP by initialising the stack canary in
> cpu_idle_thread_init().
> 
> But this can also causes crashes, when a CPU comes back online after
> being offline:
> 
>   Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pnv_smp_cpu_kill_self+0x2a0/0x2b0
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00168-g4ffe713b7587 #94
>   Call Trace:
>     dump_stack+0xb0/0xf4 (unreliable)
>     panic+0x144/0x328
>     __stack_chk_fail+0x2c/0x30
>     pnv_smp_cpu_kill_self+0x2a0/0x2b0
>     cpu_die+0x48/0x70
>     arch_cpu_idle_dead+0x20/0x40
>     do_idle+0x274/0x390
>     cpu_startup_entry+0x38/0x50
>     start_secondary+0x5e4/0x600
>     start_secondary_prolog+0x10/0x14
> 
> Looking at the stack we see that the canary value in the stack frame
> doesn't match the canary in the task/paca. That is because we have
> reinitialised the task/paca value, but then the CPU coming online has
> returned into a function using the old canary value. That causes the
> comparison to fail.
> 
> Instead we can call boot_init_stack_canary() from start_secondary()
> which never returns. This is essentially what the generic code does in
> cpu_startup_entry() under #ifdef X86, we should make that non-x86
> specific in a future patch.
> 
> Fixes: 7241d26e8175 ("powerpc/64: properly initialise the stackprotector canary on SMP.")
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/smp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 8e3a5da24d59..951c476faffc 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -61,6 +61,7 @@
>  #include <asm/asm-prototypes.h>
>  #include <asm/cpu_has_feature.h>
>  #include <asm/ftrace.h>
> +#include <asm/stackprotector.h>
> 
>  #ifdef DEBUG
>  #include <asm/udbg.h>
> @@ -1014,16 +1015,9 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
>  {
>  	struct thread_info *ti = task_thread_info(idle);
> 
> -#ifdef CONFIG_STACKPROTECTOR
> -	idle->stack_canary = get_random_canary();
> -#endif
> -
>  #ifdef CONFIG_PPC64
>  	paca_ptrs[cpu]->__current = idle;
>  	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
> -#ifdef CONFIG_STACKPROTECTOR
> -	paca_ptrs[cpu]->canary = idle->stack_canary;
> -#endif
>  #endif
>  	ti->cpu = cpu;
>  	secondary_ti = current_set[cpu] = ti;
> @@ -1316,6 +1310,8 @@ void start_secondary(void *unused)
>  	notify_cpu_starting(cpu);
>  	set_cpu_online(cpu, true);
> 
> +	boot_init_stack_canary();
> +
>  	local_irq_enable();
> 
>  	/* We can enable ftrace for secondary cpus now */

Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



