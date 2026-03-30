Return-Path: <linuxppc-dev+bounces-19000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECCEFC981D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 08:50:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fklLp5HqSz2xpt;
	Mon, 30 Mar 2026 19:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774860610;
	cv=none; b=MFp/3Tl2jF6Ap7DpVgGJZk6mhh5fGHd0Ka98FdVWvZSgMzZTrkFH5OIa7F+HG3Uh8Gx2he21RhgW8+vBLgLauNVPEEp8RV+6WSLTwOAouqgjfv4ASoZTqF9mnqILy2ZfYCZUH2Qvi71Xfsa5bAO+yRrzWDZ4DUhhiIl64daexP9iEUwx7RchE7OnpejWqP5FEMRDVdOojVZYAXNOEqRrjDTA4GbphojHS9UJILamNW4lclj90RNaMiRSr8AXFVDRl47TTXp16MoNiPazyxSnVlUGoWGI8H4IHghsRlHMvkzymFKkhpAoAixrpPxxyaWlOdmiQJQ0NJKQcSN3oMdZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774860610; c=relaxed/relaxed;
	bh=pPKn95xmlN9H8u/hRQKxHRwFKqwz/O5RJK8ioSDZbz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPVMSielOC47mFYFUwvZH8yOzwuopfBGiD0J8DLcOqzXsfkB2p+KAKNJRbJf+PuitM4EOLb8zEX1RxSW6Q3orzRTVS/Fp6ZtWtawbKusTpO9kYjyC/G6s76TnMM4y9z9OQtJ5hXJCZLIfxmtAHo5vBsmjVGs2ySGQ4CGHeUDvbxYdqTt0edCw4UGxbWTfXH6DC+THdpfTIIDUIuqVnNR+10VxEbqnT50o4X0STe79xo8UqSmAn2mENA2Qe+2N8vP1XNNHfyWc/TFex/HgJUYK6p7mruH7Bk8nCmV6i6PC8wZmC6LTH2SXyoj5ydq/P9ksFH47hVYxGibAV9E9rezwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dI+gsUqt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dI+gsUqt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fklLn5lvGz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 19:50:08 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U1EWAA503870;
	Mon, 30 Mar 2026 08:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pPKn95
	xmlN9H8u/hRQKxHRwFKqwz/O5RJK8ioSDZbz4=; b=dI+gsUqtkNb+GvhJ8VYaUa
	VaOLJ0EuuxthgzM2skiYDhEv/K+cvdrivwI8aXVXscohFuVqZzhaGcZt0So6gCCM
	+VsV04GPhKZ3s5lkcj4jQiERUhold1r2LwRqTWxOMzY+p8u5grurUnd5MCnnxXUd
	30Pbt8+nLPfF7BpvBmu9B0tW9NhNB9eCv6MPC+ed+ePKGjz3sHfUN+D2DDEMoyRo
	uXFLjvNpA4+VpdAl5vi7+r3SF17Qzz64cgpzaadNKcODPcZFODXMIcZ+DsC0FjeD
	WNncGr/0RPjhXrXGPTi9cIK0/qetVIwzRMfOzz6bigfAnhuvXvJo9SmV+v1IlNcw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q2x0fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 08:49:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U5eqd2022165;
	Mon, 30 Mar 2026 08:49:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamv46n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 08:49:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62U8noHP29557366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:49:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63222004B;
	Mon, 30 Mar 2026 08:49:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 425FD20040;
	Mon, 30 Mar 2026 08:49:48 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 08:49:48 +0000 (GMT)
Message-ID: <84aa93be-189e-47d9-a159-87bed9f10ee5@linux.ibm.com>
Date: Mon, 30 Mar 2026 14:19:47 +0530
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
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260330062206.170437-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CYuLoeqrbflM1CggovPEVncUO9bctrFt
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ca3934 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=1UX6Do5GAAAA:8 a=S1_OJBx91vrOljDkdD0A:9
 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: SEOYoTI1CUYKE1rh6C6tIXu1US6MiCL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2OCBTYWx0ZWRfX/0rYo0eyDjoS
 v1fjqPPQvhqnEYUiHFZ5bY4xJ+kj3qGZwA5V4C/dtlTPzH5dD7ddKLRnpCXsL1pwK3iPyYf2+++
 GzOSKcC2RAwHpuAFw4gVSHXJVc0RoxVdcCi/jM1kFYU21tcL/aUo9tN9EACw/YMZmrCB1hj5nNe
 aIUJC9x6isLwe2rwhaTUFDob8dUXS82Wh0maHEoUQ0yAdk901oCudXXwi6GL28BbeqSwj+qPZ2i
 0UCBQnq0esbulHpUz5fV6R12696lbwkgCZfTWkZqEgo87Qf8wbJvAfEqzP6jy49v1bbHZ3FBNAd
 H6G2xAlKlz6wIuo1HjBZUnaUSAMrcv13wltJZ1ogEIBBKeq6R3njBhAEa9XbN94jQ8imQYfn+1y
 DYP+8JWFw6Yurtk2USRpeJaGp4RSHtV+UOew7cmo4OsEjEivJEs/WnNIphH0YPt65SvfqHDrD60
 ytc7GrS0lLrgNLyABDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300068

Hi Shivang.

Few nitpicks.

On 3/30/26 11:52 AM, Shivang Upadhyay wrote:
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

Please follow inverted christmas tree for variables.


Can the below block be re-written with less indentations?
One level indentation removal could be.

if (cpu == NMI_IPI_ALL_OTHERS && crash_nmi_ipi)
	hwcpu = <>
else if (cpu == NMI_IPI_ALL_OTHERS)
	hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
else
	<existing remaining logic>

>   
> +	curcpu = smp_processor_id();
>   	if (cpu == NMI_IPI_ALL_OTHERS) {
> -		hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
> +		if (crash_nmi_ipi) {
> +			for_each_present_cpu(k) {
> +				if (k != curcpu) {

Maybe below to reduce one more indentation level.

if ( k == curcpu)
	continue;


> +					hwcpu = get_hard_smp_processor_id(k);
> +
> +					/* it is possible that cpu is present,
> +					 * but not started yet.
> +					 */
> +
> +					if (paca_ptrs[hwcpu]->cpu_start == 1) {

It either 1 or 0. So if(paca_ptrs[hwcpu]->cpu_start) is enough.

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


