Return-Path: <linuxppc-dev+bounces-19386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29CBEF4EC2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:52:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq34k2fN5z2yfS;
	Mon, 06 Apr 2026 18:52:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775465574;
	cv=none; b=N/5n73EqZwasxMyFe5hYewr5z8d+MmzRWdly6y2tNKmsrVC4jt4ltUuK+KHjPUw7QKnkTGomdoQZm+hYpEAn6K7lHor7PI2iOqHMPlKzQj0fb8CC57qhaenPzjU/17Lu8u7kti2zM/4e+w60fedABQIE5FRznd5I+aArIgXzCVmRm1imzFOpWOZbuxvcijE5JtT4DVJko1WeAwmIjfmYqxYD6pqMjsldAoaTUAvAdwrTJWxrQBRCnv7sYaBtVrzbY8oCek27FnS1y84CbThXkG72UmqQed3I6qQoCsq6tcQnK21WvgW3A+UX8LY+ZGZmUfW/zkXwWy7cFMeuT7A9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775465574; c=relaxed/relaxed;
	bh=EQW2I4U7bV8z7FYEyl3xqb8uH+Ibnhrhs0k5VCX1Qyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3hn90mwwJyheQklW9ow1YghyxHtMabi0FyXr5HEmIYGuAQd6GNbN08gvbGXC4qu2hFW8HTg03uE+g8jDiQrtQY9RdjJUr08rcJQ/RDsC7twsmeODLfZ79RM5dsTgrgUbYpzJJ7HhSI6VXqBNJxQbdi08SdcccPy6DISQls08JPW5AX5uP343MyAstjDR8SX6URTHkYN0auQCThoSIUBLIOjYYyWHoE0dd85L/yRGkWrGR5naLTY2c6HEldQ1GI2Qc9zLCry4j0NDxnNglnKExXVnQ648ewY809Q8z71BK3fxuKotKOu/j3WibJgMYvPdDL8n8446moiwUVew5ECvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IFnIF9H4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IFnIF9H4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq34h5FvYz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 18:52:51 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6354uQQU1683612;
	Mon, 6 Apr 2026 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EQW2I4
	U7bV8z7FYEyl3xqb8uH+Ibnhrhs0k5VCX1Qyw=; b=IFnIF9H4uNKdoiAHnRT54b
	ZDhNypit2Nqah/Gedg9ahq85i4/ZTP9boVUdJIpFSx9zwrFiv+Z8KWBlcTSWPVAA
	z8KQZsHHI7OqP5EqtiGdHEgVx09TVEc2EHR4c2f9MqBsyw9rRb5e95bd1B4Gwl0T
	bhUechYUK4vGgsRyx0s2Wdysw2E/FAhMEVNs4hYms15QO5UEYvmTCwaK2FlwoLjA
	eC/yb87g0l7/uHHbNP1c4ldcBh4p0LhNQIko/gvdSaDpPRPObVBK9hTAWlrlYgJh
	Shw4Ky7BbBVdDDQF4BP8BXYnJTxQTaZ84twdBYjxo+lVH0ONME2Gh52NeAPgDdug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bwftn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 08:52:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63667Tn3022906;
	Mon, 6 Apr 2026 08:52:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbefkbxmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 08:52:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6368qV9b49217866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 08:52:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BFA92004B;
	Mon,  6 Apr 2026 08:52:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA4F520043;
	Mon,  6 Apr 2026 08:52:28 +0000 (GMT)
Received: from [9.123.2.84] (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 08:52:28 +0000 (GMT)
Message-ID: <da6f75a7-8a68-46a9-9897-1aef11d33829@linux.ibm.com>
Date: Mon, 6 Apr 2026 14:22:27 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A."
 <nysal@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <20260330062206.170437-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cdelrcAt7lwfoA51aNpm7PkPV8h4Xenr
X-Proofpoint-GUID: J8ubDtUD-THXoGgGuGwqRY6QKH6yb-e9
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d37456 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=1UX6Do5GAAAA:8 a=nagqxatW70gZwnD_QkIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA4NSBTYWx0ZWRfX1SNYgPYErOvS
 cO/0+q4qmYZplzTVu3f1k1R7YSVrd3TGbuhQmJUYSHE/yuN/W95s2cXPlwfZx67kTdA7RaW4SYV
 zMCoQo5wGs3Cq0WpanQrIgTnAICEvlYKeoJbnKdGBqgtFj7LjbhIKb4LdRRl5PESx0Ti3OPqfOP
 dZ6PhjLwSltMa9YNvGHJAWll247Imb8dqcuDU8jZQByQX9GHdbJQXSrX7cuu2m4Kfn/Cf3Q4+Rt
 A/2ynctomKI8igiggZC4dibJ8bqlA/MYd4Rpc5VUhn8xGZRtoaAUv583gGKC+eFfEa1P92ncEtC
 7t93BlzICZwQObKCC4Euv3JCVw5nT9YHqVD0U1+FbPAWhE3S4lwCPRBvFGwGICk98IGXo3fUrBP
 TpRPuouIJ4tHGrEZxsWZOQYP/mhnN+FIQx5iqT+DAOQdFj/u2uvOARugR/wCDG1gh+zl797fAbb
 tHJY5vUtZMSvbIQsZnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060085

Hi Shivang,

Thanks for working on this issue.
A few questions and concerns about the approach:

1. Was this issue only observed with QEMU-based virtualization, or does 
it also reproduce on PowerVM/phyp? The commit message and sample logs 
don't clarify this. If this is QEMU-specific, I think we should fix this 
in QEMU rather than working around it in the kernel.
2. The approach taken here moves away from the PAPR interface. The 
kernel currently uses H_SIGNAL_SYS_RESET_ALL_OTHERS, which is the 
architecturally defined hcall for this purpose. Replacing it with a 
per-CPU loop that checks internal kernel state (paca cpu_start) breaks 
the clean abstraction between guest and hypervisor.

QEMU's sPAPR implementation should behave the same way. The hypervisor 
(QEMU) should maintain a list of CPUs that have been 
activated/online/started and given to the guest. When 
H_SIGNAL_SYS_RESET_ALL_OTHERS is called, QEMU should only reset those 
CPUs that the guest has actually started. Unless the guest makes the 
RTAS start-cpu call for a CPU, QEMU should not include that CPU in the 
set of CPUs to be reset.

I think discussing this would help determine the right fix location.

Can you refer to the following commit in QEMU to see if help in this case.

commit fb802acdc8b162084e9e60d42aeba79097d14d2b
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Tue Mar 18 15:03:48 2025 +1000

     ppc/spapr: Fix RTAS stopped state

Thanks and Regards,
Vishal


On 30/03/26 11:52, Shivang Upadhyay wrote:
> During DLPAR operations, the newly added CPUs start in halted mode.
> The kernel then takes some time to initialize those CPUs internally and
> start them using the "start-cpu" RTAS call. However, if a kexec crash
> occurs in this window (before the new CPU has been initialized),
> the kexec NMI will try to reset all other CPUs from the crashing CPU.
> This leads to firmware starting the uninitialized CPUs as well.
>
> This can cause the kdump kernel to hang during bring-up.
>
> Sample Log:
>    [175993.028231][ T1502] NIP [00007fffb953f394] 0x7fffb953f394
>    [175993.028314][ T1502] LR [00007fffb953f394] 0x7fffb953f394
>    [175993.028390][ T1502] --- interrupt: 3000
>    [    5.519483][    T1] Processor 0 is stuck.
>    [   11.089481][    T1] Processor 1 is stuck.
>
> To fix this, only issue the system-reset hcall to CPUs that have
> actually been started by the kernel.
>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Srikar Dronamraju <srikar@linux.ibm.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Nysal Jan K.A. <nysal@linux.ibm.com>
> Cc: Vishal Chourasia <vishalc@linux.ibm.com>
> Cc: Ritesh Harjani <ritesh.list@gmail.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> Changelog:
>
> V2:
>    * added set_crash_nmi_ipi to saperate crash's case from other nmi_ipi
>      users
>
> V1:
>    * https://lore.kernel.org/all/20251205142825.44698-1-shivangu@linux.ibm.com/
> ---
>   arch/powerpc/include/asm/smp.h       |  1 +
>   arch/powerpc/kernel/smp.c            |  1 +
>   arch/powerpc/platforms/pseries/smp.c | 29 +++++++++++++++++++++++++++-
>   3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index e41b9ea42122..cb74201f5674 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -47,6 +47,7 @@ struct smp_ops_t {
>   	void  (*cause_ipi)(int cpu);
>   #endif
>   	int   (*cause_nmi_ipi)(int cpu);
> +	void  (*set_crash_nmi_ipi)(void);
>   	void  (*probe)(void);
>   	int   (*kick_cpu)(int nr);
>   	int   (*prepare_cpu)(int nr);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3467f86fd78f..3390ee8adf79 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -594,6 +594,7 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
>   {
>   	int cpu;
>   
> +	smp_ops->set_crash_nmi_ipi();
>   	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
>   	if (kdump_in_progress() && crash_wake_offline) {
>   		for_each_present_cpu(cpu) {
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index db99725e752b..c6c2baacca9a 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -51,6 +51,9 @@
>    */
>   static cpumask_var_t of_spin_mask;
>   
> +
> +static int crash_nmi_ipi;
> +
>   /* Query where a cpu is now.  Return codes #defined in plpar_wrappers.h */
>   int smp_query_cpu_stopped(unsigned int pcpu)
>   {
> @@ -171,12 +174,35 @@ static void dbell_or_ic_cause_ipi(int cpu)
>   	ic_cause_ipi(cpu);
>   }
>   
> +static void pseries_set_crash_nmi_ipi(void)
> +{
> +	crash_nmi_ipi = 1;
> +}
> +
>   static int pseries_cause_nmi_ipi(int cpu)
>   {
>   	int hwcpu;
> +	int k, curcpu;
>   
> +	curcpu = smp_processor_id();
>   	if (cpu == NMI_IPI_ALL_OTHERS) {
> -		hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
> +		if (crash_nmi_ipi) {
> +			for_each_present_cpu(k) {
> +				if (k != curcpu) {
> +					hwcpu = get_hard_smp_processor_id(k);
> +
> +					/* it is possible that cpu is present,
> +					 * but not started yet.
> +					 */
> +
> +					if (paca_ptrs[hwcpu]->cpu_start == 1) {
> +						plpar_signal_sys_reset(hwcpu);
> +					}
> +				}
> +			}
> +			return 1;
> +		} else
> +			hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
>   	} else {
>   		if (cpu < 0) {
>   			WARN_ONCE(true, "incorrect cpu parameter %d", cpu);
> @@ -243,6 +269,7 @@ static struct smp_ops_t pseries_smp_ops = {
>   	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
>   	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
>   	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
> +	.set_crash_nmi_ipi = pseries_set_crash_nmi_ipi,
>   	.probe		= pSeries_smp_probe,
>   	.prepare_cpu	= pseries_smp_prepare_cpu,
>   	.kick_cpu	= smp_pSeries_kick_cpu,

