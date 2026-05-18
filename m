Return-Path: <linuxppc-dev+bounces-21075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D87CD4F48
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 07:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJqrJ2y06z30FP;
	Mon, 18 May 2026 17:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779090992;
	cv=none; b=UpbhBYzOMUIwJVP+4TWvU1A3knCbwopjV2aemk1NXFYHgZkBwAoFeONB56TSakHi8xK+3Wmq26vdWSuIBlIoAckqhrXHv80Xpm8GVJMGSCZi9lsKjZQFR6ThrqE3qy/Lt9T215s7LfTJ05DsqkgEwTjoXhUiu/xVy2q9eF6ooHBifpXKVon4RfLe1CrIVhpK3WlfXYy76d+aksKbnyVnz0VxhKW6HSDh878UzqeY3ZHG7ENM1ffvm+WN7DkON7D9P4j8yPHx901AJBh7qMvd64fvfB/nejSVRrQ8RM4Uj1mI8B5swEq71AKuxBtyYuKup70C/PeeGoqQcxrxGO3C6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779090992; c=relaxed/relaxed;
	bh=qBhdU0OU6M9kpYW9wYCtuDZDwjrCXYM0/44GzD2hCAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6Bt8Hd96zbHS1HO4tZbOsASNja5rPYStpUcgD9YMDtJa0u7CUiKjKUloHQoBMOVd944vT8b68pAlVqrXcPhL17KkWlQFmgfzI7b3cRuGwlim9xVAfgpgcCgHA2ylYY8y+nOteptkPNPBdjmQ8suzIYy/fGzXmLtmgklyrec5wtV1zFmVsPyvBfUhtzIm9DcAeQI5GcrKmAhKRd0aePtuT/SFyxvNYj/YIhNIoNY3LApZ8/13O82b5c3QntS/Wq3IxsWxUBNzJLMlWNFo6judBDH+TGpr8mjGENmIMJJwstw6rTuW9GZzBwSALqyeBr1FN+NWqLClWUATCJOMOjmfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tIm/hyT1; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tIm/hyT1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJqrH4DM8z2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 17:56:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I2tIAf3264940;
	Mon, 18 May 2026 07:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qBhdU0
	OU6M9kpYW9wYCtuDZDwjrCXYM0/44GzD2hCAQ=; b=tIm/hyT1IrK+C/2dFGa5C2
	TpVaSl0DQMxksE8lqLJfS2/Hns2cG8RVoK3FYUiPiDoNyxt6oHzZHIHshs0sTT+p
	ZrvTRISv6WRRcYTdxx5KlmHctXPBEl2FBxt5ZAJq9TaiSA87wG78nUuTkwzMhDVL
	8X8QSBOzpu7cZCedA902ZPPnTmjBG7SCA+hm/Pbum8Y0Fmobb4xFeclrzNlkD2cx
	LKbHCcJ6328q/QGKZhx/SyAevi9v+yrwAXkQ02HXzim3iNZdZ7ylQ1HZvxkX3ugX
	9U/MrrybkUKsuSY3HlFxAS4aC6qDYqeyKLhdLR+8qE7ussKgqEezCqgneU64mQWA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havxfta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:56:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I7d8qZ018908;
	Mon, 18 May 2026 07:56:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjvv8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:56:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I7uLAP35652088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 07:56:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E953220040;
	Mon, 18 May 2026 07:56:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41DB42004B;
	Mon, 18 May 2026 07:56:19 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 07:56:19 +0000 (GMT)
Message-ID: <99da8dfa-2624-44fb-96c5-ff7eddf717ac@linux.ibm.com>
Date: Mon, 18 May 2026 13:26:18 +0530
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
Subject: Re: [PATCH 2/3] powerpc/powernv: fix preempt count leak in
 pnv_kexec_wait_secondaries_down
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
 <20260518050855.1147242-3-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260518050855.1147242-3-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2NyBTYWx0ZWRfX/f9Ocma7GF8Q
 vKkEF02IJv799yfvQh1AOkkDoEUda4IMpaObWgMCa3A5ohJhrDiYA9QGjDOAMk5dRWVjPACJfow
 W4OY6AJiQAWiSRTLNojnbBDULwWKf9oVqWzC8lgIf0scVXuRDoaU546v5I4N3O1qlLXQo+u5oEp
 v0gecMXUg4EDte0EzCjA39zB+2+mtfN1KaKjDNrg8gARlMP9aw/RHwfx6e142aGEnd5nIxDRNsy
 4fIEG101WVjew0inrG0zqYatlps6Do0/KdjS28W5WVBSgBly+YZPUIvbp44BMC6Lnyq5hwlTMcz
 ur0WgdKiMZTjkMJkZ2AqcVviVXYvYD0VegOb9TlqH5mIcqe2gmdMS0RUlwmhaVX7OxUM0mI6HHh
 IWeo225YUqqfT+xiwpBbcu+1epn/aBX9k6OP89SOv4WEkXLnpuw72tY0a32QKl8lZOQgj59bNK/
 at7pYDvl+41ZeBPafVQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ac629 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Q5ngmOl2cO7kx6Bf89wA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: FPVb_X1u32GPsju0ATEqqLFbQ0WCYoes
X-Proofpoint-GUID: Lm-PYFwGKhxjP33c4yIq1nGM2un8-_iY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180067


Hi Aboorva.

On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> pnv_kexec_wait_secondaries_down() calls get_cpu() to obtain the current
> CPU id but never calls the matching put_cpu(), leaking one
> preempt_disable() nesting level on every invocation.
> 
> In practice the imbalance does not trigger a visible splat because the
> kexec teardown path is a one-way trip: IRQs are already disabled, no
> schedule() occurs after the leak, and default_machine_kexec() overwrites
> preempt_count with HARDIRQ_OFFSET before jumping into kexec_sequence()
> which never returns. However the bookkeeping is still wrong.
> 
> In the kexec teardown path IRQs are already disabled and the CPU is
> pinned, so get_cpu()'s preempt_disable() side-effect is unnecessary.
> Replace get_cpu() with raw_smp_processor_id() which returns the CPU id
> without touching preempt_count.
> 
> Fixes: 298b34d7d578 ("powerpc/powernv: Fix kexec races going back to OPAL")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 4dbb47ddbdcc4..177da0defcb36 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -396,7 +396,7 @@ static void pnv_kexec_wait_secondaries_down(void)
>   {
>   	int my_cpu, i, notified = -1;
>   
> -	my_cpu = get_cpu();
> +	my_cpu = raw_smp_processor_id();
>   

Is it always with irq-disabled?
How about !CONFIG_SMP and in kexec_prepare_cpus. I see it disables interrupt later.
(though it is a less common config)

So use smp_processor_id()?? One could compile with CONFIG_DEBUG_PREEMPT=y and
see any reports.

>   	for_each_online_cpu(i) {
>   		uint8_t status;

