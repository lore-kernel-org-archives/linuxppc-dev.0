Return-Path: <linuxppc-dev+bounces-21061-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CEACD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:02:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnK64hnXz3byP;
	Mon, 18 May 2026 16:02:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779084170;
	cv=none; b=cshqnezF2hITdfKrqWnFbE01NTYAusPSDSiwjlIt9tsTOqP7O9qmvUc6dWr5zSNuWnPb3TFMsHgcVpYDkWETRpnGMtSvO0gemq6xN5iQ0xPD7NJwl4TafAxtwgPU+pYpQCc+PeyXz9/cx0HeiKVLaKBB+4nZ94qPbxFziMTAI8dY8wgAemGTKr0cjmKaXO8NQ/BWIpHj2Z5jSf2Ck3CUYcjNauEP5Wa3bh94mdLcJIjtOseWNVrCOEGr64uJHluHbmFM0Z0TRzJ3JM7JADaGULcghTa5O5SB+ld8ZeUVltARPkdRIDggBhyHSwDbHyrIF/D5aanjuKsFBPsyklw3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779084170; c=relaxed/relaxed;
	bh=u4e4+MzPeloaa5eq93jr1M0tS8Ki+Q8ynCwUcev8HlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUk77gLrM8R5oeG634YoEsJH2SZswbtAt4gFxb5aoHz+EFzRc6jU+/6MQeVpuBuPBYRGIxy+CYw0aKjeAxo9m60sugPuqFf2EX6i0JREx9TZqa3PNNzohXE2Bk/ijRG7EqMO2jltbgS3jt4beEwxIhSCttL+wxrVnN4bkHlH9QeyuXYsb2u0IBDp20w/bQcbfWxmegW2hEmf+0GwERikE2CEX/RWl9c9pOmShXz5z+Ixz93XnqIPPG2/7TcAtenD6tQJDH82TVNAaRS2jF9qyOm0O/vYvhSESJaa91rDI5qXz8e9uixlAaHP6dcEXNRJ/o64qcuKnMaAbHOYEwgtCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZgRM0otc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZgRM0otc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnK54jkVz3bwR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:02:49 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HJboDJ1876843;
	Mon, 18 May 2026 06:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u4e4+M
	zPeloaa5eq93jr1M0tS8Ki+Q8ynCwUcev8HlU=; b=ZgRM0otc/P3Ma9Nof/lNLh
	b9vuCCL2mtldXy+FOx2yP4eKaCxDu8srTb9997fPwb95MxwOuZTrJeCdsWZX+ktD
	hPJPUYUeW3HQYI6p+E27gNbu/k4ZlNzIy/AtBaguqXgzYq0j6v4MvbNws01bFf0o
	qiUlNk8RGVBaAd612I6X68a50wY3xjTzr7ZaRb9IIcgwyZsB7S0e1GW9NA/L2QGN
	sY5lfCFtHa1mUMjEYI4/RMg17UPwozoaHE9z6mT1OQbXsm1j9C6FiEBweilchm6a
	djpGm90tq+Y/8npDcXTPK8N8Q9aaq7ihVZZYCXxoF5CVWBpal00I5UWGEulz1SNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8860hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:02:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5sAou009037;
	Mon, 18 May 2026 06:02:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhcbga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:02:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I62ena48300510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 06:02:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7998E20043;
	Mon, 18 May 2026 06:02:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF8062004B;
	Mon, 18 May 2026 06:02:38 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 06:02:38 +0000 (GMT)
Message-ID: <45af9f95-da07-45b6-babe-dbae0f7eb318@linux.ibm.com>
Date: Mon, 18 May 2026 11:32:38 +0530
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
Subject: Re: [PATCH 3/3] powerpc/kexec: fix double get_cpu() imbalance in
 kexec_prepare_cpus
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
 <20260518050855.1147242-4-aboorvad@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260518050855.1147242-4-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UzyFgxX_jkVt8H868ceh3EF4ElsNY7dT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfX5qpda25PIm6S
 Hgpeu/9HRz26Zs3F6ZBX9nan1VrsxMrII4mU9n+vO4bvyzrt0Dwzo2SkqZnmMCW3fR5XHqgwOWH
 hmzo8YeIUvkBE1KnpCzjHs4TEbA2rvPaajc6RWh+9cZ3CVT6n39xZTLU+ccvgtFdf6Wf9ix1GMh
 smLZvQNkYtwAGO8oCKShmurGq9O+x52P3XnTC2qQIiZHIjcERil5HjOuvejzGrf3AHSCerx9cLv
 FD+e+e3MPFodURov/jeWCHRpYd1Xjz6woBTlHAMSF1+1Bq4kDbmO3lREsYA++4IFMeZrD+b4J+R
 Lpnvzvp63/HORCQvoMMCS93IYaEH4GMNOxMKvI5wmWJdmcYyec+bcZjElr952eDZ4OiBgsWem0x
 i3IREDtRgwdYwIYEbGSdZuQAEqZezU+14bBA6Y46Xe7daAmucLqMNAmmCyaij+JTOcbEw/eErYl
 Jg13pUhcQ/nO4gVhcFQ==
X-Proofpoint-GUID: 0QB6blTLBVZg7d-qTshchTKYAS6O_sgp
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0aab85 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=REhrpbHZYlxIgP8uR5AA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180051

Hi Aboorva.

On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> kexec_prepare_cpus_wait() calls get_cpu() internally to obtain the
> current CPU id. kexec_prepare_cpus() calls kexec_prepare_cpus_wait()
> twice -- once for KEXEC_STATE_IRQS_OFF and once for
> KEXEC_STATE_REAL_MODE -- but only issues a single put_cpu() at the end,
> leaving preempt_count elevated by one extra nesting level.
> 
> In practice the imbalance does not trigger a 'scheduling while atomic'
> splat because the kexec path is a one-way trip: IRQs are already
> disabled, no schedule() occurs after the leak, and
> default_machine_kexec() overwrites preempt_count with HARDIRQ_OFFSET
> before jumping into kexec_sequence() which never returns. However the
> bookkeeping is still wrong.
> 
> Lift the get_cpu()/put_cpu() pair into kexec_prepare_cpus() so it is
> called exactly once, and pass the CPU id to kexec_prepare_cpus_wait()
> as a parameter. This keeps preempt_count correctly balanced.
> 
> Fixes: 1fc711f7ffb01 ("powerpc/kexec: Fix race in kexec shutdown")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   arch/powerpc/kexec/core_64.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 825ab8a88f18e..9d7e5a1e6e5b8 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -164,12 +164,11 @@ static void kexec_smp_down(void *arg)
>   	/* NOTREACHED */
>   }
>   
> -static void kexec_prepare_cpus_wait(int wait_state)
> +static void kexec_prepare_cpus_wait(int wait_state, int my_cpu)
>   {
> -	int my_cpu, i, notified=-1;
> +	int i, notified = -1;
>   
>   	hw_breakpoint_disable();
> -	my_cpu = get_cpu();
>   	/* Make sure each CPU has at least made it to the state we need.
>   	 *
>   	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
> @@ -246,6 +245,8 @@ static void wake_offline_cpus(void)
>   
>   static void kexec_prepare_cpus(void)
>   {
> +	int my_cpu;
> +
>   	wake_offline_cpus();
>   	smp_call_function(kexec_smp_down, NULL, /* wait */0);
>   	local_irq_disable();
> @@ -254,7 +255,8 @@ static void kexec_prepare_cpus(void)
>   	mb(); /* make sure IRQs are disabled before we say they are */
>   	get_paca()->kexec_state = KEXEC_STATE_IRQS_OFF;
>   
> -	kexec_prepare_cpus_wait(KEXEC_STATE_IRQS_OFF);
> +	my_cpu = get_cpu();

raw_smp_processor_id() is better here. All it needs is get current cpu?
caller does irq_disable above and that renders call for get_cpu un-necessary.


> +	kexec_prepare_cpus_wait(KEXEC_STATE_IRQS_OFF, my_cpu);
>   	/* we are sure every CPU has IRQs off at this point */
>   	kexec_all_irq_disabled = 1;
>   
> @@ -262,13 +264,12 @@ static void kexec_prepare_cpus(void)
>   	 * Before removing MMU mappings make sure all CPUs have entered real
>   	 * mode:
>   	 */
> -	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
> +	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE, my_cpu);
> +	put_cpu();
>   
>   	/* after we tell the others to go down */
>   	if (ppc_md.kexec_cpu_down)
>   		ppc_md.kexec_cpu_down(0, 0);
> -
> -	put_cpu();
>   }
>   
>   #else /* ! SMP */


