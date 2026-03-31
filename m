Return-Path: <linuxppc-dev+bounces-19044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EA4FF60C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 04:34:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flFd82MPtz2ybQ;
	Tue, 31 Mar 2026 15:34:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774931660;
	cv=none; b=ItjRBg2jdRsfK4PDVJOF4doikaLqdAKTmhu3P5cC/+2KYUrulC7lhrkqdmSMI170KTKn3wpWfKEF/0tEqSrmMr907HFapYjFamYCrHOfYYL3VlGhh8KS8FZpAeen/KYshpYzu/1OvP8gni2Cf+kNJpSubcaFE0x6/0igAgtSeTt7ae+OqT4+M8p04wr7O8gprcdkh7tFK1DdxNOPC4W9q93L/UzoQoVkRmUb/qJnvOq3OV+2Rg4v5lQIOWcERFUxRCvfm6kr4QHLFG9pPBtOpNUKh992FXLaO/oj+gJH1YktKu60/jmANJH6uCTOOJrKBRBzgE4YANm1bVNutJ/Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774931660; c=relaxed/relaxed;
	bh=Ydmd9w8T/DJzKWFfW/1wzZaVilx2+1BILJJyyEuaOeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ven4mGtdoXPCefKEG91RKc3wgiBZwSZqY848GX8yzMe4nY/XFtR01OjkJR46TnMAzb0w1CV3Tn6zcpnAR+E3+2zmAOPz9RK3BFUAHoebMsV0ho1fCrx/zWrtspUexjnGyutfnhWo/xwb41mA+xjrUDaXI9ufUBzGyTp81yVCgXvDA8gps9khRiZ2+ypLJWxiFai0LkMyPZ5pvwwmbgLCUBN+zfDinDubFHWVt3m5e9MzyR7r4ES3dvKmyScuwNMOYTTHb+TbO4Jxv9lXZhTXO8F6nYBTfl0QZNoAXrvRS4WWJsmSO0xHWRBDqb8OhOZ6bovC56D8jGzBnwAn1uEBcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f2R6RT2j; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f2R6RT2j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flFd71DZNz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 15:34:18 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UE9NRs294922;
	Tue, 31 Mar 2026 04:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=Ydmd9w8T/DJzKWFfW/1wz
	ZaVilx2+1BILJJyyEuaOeU=; b=f2R6RT2j0ZSXnBxRj331HiJQksmDu/9GDTc1d
	lvy8WDMIC90QsJ3nNN6ydWyBhZAKHsMjOZdyShGTHi+J9HrGnbvA+tW1215VVEW+
	GMHpCSLLNJKJbo1xKghR+JuVIfjfEEUqSxnCSQzaYdv931KUfZz4E6kNXA7y5YRg
	qmTApp5hHxJMyu2JcUWSuzeSURu/exF3fpoAK4gwtpZyvZKgzGh2euwD7ofS0TqH
	uJUnDJzUFaIjVD6vKsjGOe9l9a35XzVrSvPLRiz0kBODISN7GM+W5wyMxfPtZqhv
	ZjiVBOczi74FwtZ38Ri+zXSq2enJ/gjnWlsm47sOj0YWjGg6A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1sp8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 04:34:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V00oR1005947;
	Tue, 31 Mar 2026 04:34:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spxypgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 04:34:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V4Y0Vh42729924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 04:34:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34F720043;
	Tue, 31 Mar 2026 04:34:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D04220040;
	Tue, 31 Mar 2026 04:33:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 31 Mar 2026 04:33:57 +0000 (GMT)
Date: Tue, 31 Mar 2026 10:03:56 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
Message-ID: <actOtLSoqSMgmEQh@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260330062206.170437-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cb4ebe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=1UX6Do5GAAAA:8 a=0W6u05j36Tmt_vxpGP8A:9
 a=wPNLvfGTeEIA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: H3fB2zHjQeAJnwYfVafYmWqBtImBI2Ic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAzOCBTYWx0ZWRfX9PbvKKeArHtp
 2yexzw7UABbg+1hOhyZxVRjbpgK83XN0IwiBzPki/vA8dY4zXii6Btvyifr2O2SQM+VtmcdAtWn
 nJ56ni1c853k9kWQmkSncwG/HRfQ/TyX0Www83JUz8/4oJkvbfzrkBYDEsT4GOAqBwh1KdwGsvC
 U3oKivFPujE9J+afNew8Ae0EEKeHSLowsqOZxhAPw8H6YkatWfvpSAJdxxXqxLasluFLun4Te7Z
 TWZIlkMib0jwTVLq36Cqgv+/Qrn3BbPisCYP/Op9AiKirkxEP5ufI+Cow5AS+MVzRqp+gtSe+38
 y/IlRA+O3Eqv4V10sh6aTQwQsrkFlHWmX4fc6sEoOYx1Wb4r221juMduT2IjyYu6oZtpL0HaykW
 z3x1hkAQiEcceehYPH/jeE8a+vy4+ZeJUpqDj8dL8IzRaUwHmFiK7SEI/ciVaSPmw/zNad9P+GY
 Y4ighTvC21xvQx6J54Q==
X-Proofpoint-GUID: Rve6B8CFscjZxprw9FxntOv9_st3M5yG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310038

* Shivang Upadhyay <shivangu@linux.ibm.com> [2026-03-30 11:52:06]:

> During DLPAR operations, the newly added CPUs start in halted mode.
> The kernel then takes some time to initialize those CPUs internally and
> start them using the "start-cpu" RTAS call. However, if a kexec crash
> occurs in this window (before the new CPU has been initialized),
> the kexec NMI will try to reset all other CPUs from the crashing CPU.
> This leads to firmware starting the uninitialized CPUs as well.

What would happen if an non kexec crash nmi was delivered when we did a
DLPAR operation and before the CPUs are initialized?

> 
> This can cause the kdump kernel to hang during bring-up.
> 
> Sample Log:
>   [175993.028231][ T1502] NIP [00007fffb953f394] 0x7fffb953f394
>   [175993.028314][ T1502] LR [00007fffb953f394] 0x7fffb953f394
>   [175993.028390][ T1502] --- interrupt: 3000
>   [    5.519483][    T1] Processor 0 is stuck.
>   [   11.089481][    T1] Processor 1 is stuck.
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
>   * added set_crash_nmi_ipi to saperate crash's case from other nmi_ipi
>     users
> 
> V1:
>   * https://lore.kernel.org/all/20251205142825.44698-1-shivangu@linux.ibm.com/
> ---
>  arch/powerpc/include/asm/smp.h       |  1 +
>  arch/powerpc/kernel/smp.c            |  1 +
>  arch/powerpc/platforms/pseries/smp.c | 29 +++++++++++++++++++++++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index e41b9ea42122..cb74201f5674 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -47,6 +47,7 @@ struct smp_ops_t {
>  	void  (*cause_ipi)(int cpu);
>  #endif
>  	int   (*cause_nmi_ipi)(int cpu);
> +	void  (*set_crash_nmi_ipi)(void);
>  	void  (*probe)(void);
>  	int   (*kick_cpu)(int nr);
>  	int   (*prepare_cpu)(int nr);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3467f86fd78f..3390ee8adf79 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -594,6 +594,7 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
>  {
>  	int cpu;
>  
> +	smp_ops->set_crash_nmi_ipi();

Shouldn't we be checking got smp_ops->set_crash_nmi_ipi being non-NULL
before calling. Dont we expect set_crash_nmi_ipi() to be NULL in PowerNV
after this patch? Or what would happen if set_crash_nmi_ipi() was called in
PowerNV code?

>  	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
>  	if (kdump_in_progress() && crash_wake_offline) {
>  		for_each_present_cpu(cpu) {
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index db99725e752b..c6c2baacca9a 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -51,6 +51,9 @@
>   */
>  static cpumask_var_t of_spin_mask;
>  
> +

Nit: Are we adding an unnecessary newline?

> +static int crash_nmi_ipi;
> +
>  /* Query where a cpu is now.  Return codes #defined in plpar_wrappers.h */
>  int smp_query_cpu_stopped(unsigned int pcpu)
>  {
> @@ -171,12 +174,35 @@ static void dbell_or_ic_cause_ipi(int cpu)
>  	ic_cause_ipi(cpu);
>  }
>  
> +static void pseries_set_crash_nmi_ipi(void)
> +{
> +	crash_nmi_ipi = 1;
> +}
> +
>  static int pseries_cause_nmi_ipi(int cpu)
>  {
>  	int hwcpu;
> +	int k, curcpu;
>  
> +	curcpu = smp_processor_id();
>  	if (cpu == NMI_IPI_ALL_OTHERS) {
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
>  	} else {
>  		if (cpu < 0) {
>  			WARN_ONCE(true, "incorrect cpu parameter %d", cpu);
> @@ -243,6 +269,7 @@ static struct smp_ops_t pseries_smp_ops = {
>  	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
>  	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
>  	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
> +	.set_crash_nmi_ipi = pseries_set_crash_nmi_ipi,
>  	.probe		= pSeries_smp_probe,
>  	.prepare_cpu	= pseries_smp_prepare_cpu,
>  	.kick_cpu	= smp_pSeries_kick_cpu,
> -- 
> 2.53.0
> 

-- 
Thanks and Regards
Srikar Dronamraju

