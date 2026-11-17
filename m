Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D9606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q2Jl2sdW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTTYB5n2pz2xnZ;
	Wed, 18 Nov 2026 02:43:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794930238;
	cv=none; b=hHcpKIGIVZ+Gv4coqFqgPqdxv0z3Z4+aQ7Z+La73zpxwCK4GywXdKsAXZNv2H3fRVVLD3e20pTkNeFVactOBZ4F1opBfX3cgcy/ksexdJkhyMZtHPpEofTp3CuvtSlW9EBpY6CJ4rb83qYep1rTU71xZFGCS40Mz2zUdMiWctxI+wMSeuFGrwntxyZ+ZmpC6nC4eDfirpjWxlLBs5nccpoWms6T9bnxAUb1EKe4iPrCNLHNFCN0PpF17h3dyv0EpEK21gKzevRz588ODZfboT2OwAUVYeeL+u35LhEMibddTnX1A2DtcZbRRNQHjZQdbPvDuME8IEU/i2ygpP4c+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794930238; c=relaxed/relaxed;
	bh=rmlNl+cN1v4ObBPuPGFVK0GCt9dkXWFacMXpgZLubfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnnlUXwuldWVzXz1988RfSL5z0XNm1sn2yg67rKbx5TWc6SsU+BjAeb6b7BKzWNbdTlQkfoGXoRJUB0bky4aQll3PG5hKmz2F4ZGVlG/oxW2q24FB7ZMypsO5B3llPw++yExYrpwKLSLBmgMmqRvNpkgglZ2qpl1tZ4Vn76mfk+ZcMZYIKwlsh760ca5GN2gw9V0L/2gaPcMj8JtkedqzWEkpjBN+zH89O5EJAmcvwSGnxO+4E6DtOH+l+PhKsQJBZ+exdqwFEzVwEQOwpfSw0wBw5KzugMvs04Me/SM1PMAqLgg+EpSKMDL19Dd7jfg0K4cSO6XlB/UdJDhhRhXBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q2Jl2sdW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q2Jl2sdW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTTYB08D4z2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:43:57 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQV0E1096766;
	Tue, 17 Nov 2026 15:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rmlNl+
	cN1v4ObBPuPGFVK0GCt9dkXWFacMXpgZLubfc=; b=Q2Jl2sdW7R/r+rRsLKXYJD
	nAc+mng8ZG27UM+XVUSbUqXSPgBC3rPO7YgOQX+oQbLjRa7ycJd9T6eoNTOOkAU4
	JzFuMUjM0O/Kk713/wrYYlXnNypnEknghpD+N49++ObMjGh2Pr6Q+CFR8+LbDDbq
	Tx6p+LXYabDlJxOceNRW2u61MOY9G59uQ2NveRTzt/uFO/7UMbqlGDI/4+luvocY
	vwSVTbTeOXdG+gqtOkzvr7pPFrmvGHddFY4NzRDYQr9tqMYW+v536emLnUxpXeRK
	yQkwY/6vB73NFK1i8+vl8SPKuzCUwBYts8ksRt6yzoPFRfjbzX0Z293/aUZINIrA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfat43c3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:43:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYutg713417;
	Tue, 17 Nov 2026 15:43:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfdjxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:43:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFhgAA44040666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:43:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D19C20040;
	Tue, 17 Nov 2026 15:43:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0D2E2004B;
	Tue, 17 Nov 2026 15:43:39 +0000 (GMT)
Received: from [9.124.217.181] (unknown [9.124.217.181])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 15:43:39 +0000 (GMT)
Message-ID: <4b5c9a61-5876-4508-87a2-5451d363a181@linux.ibm.com>
Date: Tue, 17 Nov 2026 21:13:38 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] powerpc/watchdog: Disable preemption in
 arch_touch_nmi_watchdog()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, chleroy@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, stable@vger.kernel.org
References: <cover.1794924821.git.ritesh.list@gmail.com>
 <3cb2893bf883be87ea1c3712344ac03f727937d0.1794924821.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <3cb2893bf883be87ea1c3712344ac03f727937d0.1794924821.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX5zMOjNZaoSCU
 sOrqbYEexznfceCYddY+QiLKtxOkgTHsl8W360ARlCOVGBnNtyuu6XGShSNDS8HS4Xlwj7x5zHt
 BKm/vetgkzKZbftZZVm5nxEN7SKfNvw=
X-Proofpoint-ORIG-GUID: h-wmP1IUSblYLkRfDfVYj5uljJtAMwN6
X-Proofpoint-GUID: W-TGwsihpCE7ooHZ-hsMEY16rcbokUKZ
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afc7633 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=_Q28vid90O0EagN2oV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX4fAeVGJSlOR/
 3Le4Gbt7cvGgu8g6yggHeUAbDUaPFUaqOSaPUcVdZwsgTFvJyMRXW/nHjRbYgOs+pvLrCOc57LM
 h4Ze3djpVXjhCLy0/qnUj2ygmQfFb6cbRaM+rDZXn+rpufJVxjNpdfChrmRxOh8RszRT4MERs3+
 /FNW/j380uLXbDEVQWV6ycOiiTrXeOrWkGW+m181TQzEH4XbUIHuBfcw5E/5ZTWXag709DhK6ve
 oetIb0O4BLp3ptaJJUaJmiIrRu7eqAJx+raY0KfzvPUFfvjhxGZXL5wCef9/1ny5DYUTrSKz6p5
 3xxMW4/cjhuAmYYaht9H+OaSUJ5FRpqpg2/YiXtGOcz/eogIWqdAvlp03ojZHzTxPPVg/DQZAtm
 oQhHoPaw0xzJEvpCKqmd/WpjPkAcYQMZdeOzpF7eFA8OKZsNCT6euJz9EjJ5qvyXTGRgTnQXsV5
 MUq8M7KjPBPkX+eHdfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170061
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/26 7:55 PM, Ritesh Harjani (IBM) wrote:
> touch_nmi_watchdog() can be called from preemptible context, e.g.
> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
> smp_processor_id(), so with DEBUG_PREEMPT we get:
> 
>    root@buildroot:/# echo w > /proc/sysrq-trigger
>    sysrq: Show Blocked State
>    BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>    caller is arch_touch_nmi_watchdog+0x3c/0xd4
>    CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>    Call Trace:
>     dump_stack_lvl+0x138/0x150 (unreliable)
>     check_preemption_disabled+0x120/0x158
>     arch_touch_nmi_watchdog+0x3c/0xd4
>     show_state_filter+0xf0/0x338
>     sysrq_handle_showstate_blocked+0x24/0x38
>     __handle_sysrq+0x134/0x3a8
>     write_sysrq_trigger+0x178/0x22c
>     proc_reg_write+0xf4/0x150
>     vfs_write+0xfc/0x71c
>     ksys_write+0x8c/0x150
>     system_call_exception+0x310/0x590
>     system_call_vectored_common+0x15c/0x2ec
>    ---- interrupt: 3000 at 0x7ffd01755b98
> 
> Unlike the generic version, which only sets a flag, we update the CPU's
> timebase stamp and its SMP watchdog pending bit, so a migration in
> between touches the state of a CPU we are no longer on.
> 
> Disable preemption across the update. While at it, let's also mark the
> function as notrace (since we might be within a tracer when this
> function gets called).
> 
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> ---
>   arch/powerpc/kernel/watchdog.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 44f178e07531..32d4e716cb0a 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>   	return HRTIMER_RESTART;
>   }
> 
> -void arch_touch_nmi_watchdog(void)
> +notrace void arch_touch_nmi_watchdog(void)
>   {
>   	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
> -	int cpu = smp_processor_id();
> +	int cpu;
>   	u64 tb;
> 
> +	/* Callers may be preemptible. Stay on this CPU for the update. */
> +	guard(preempt_notrace)();
> +	cpu = raw_smp_processor_id();
> +
>   	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>   		return;
> 
> --
> 2.39.5
> 


