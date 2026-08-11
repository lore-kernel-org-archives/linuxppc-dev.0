Return-Path: <linuxppc-dev+bounces-25728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12A1C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 06:22:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK1kQ23h2z2yvG;
	Tue, 11 Aug 2026 16:22:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786429342;
	cv=none; b=m+/tmKmQICWPa0kM/ArbSo0YteX5nEE9qMKUpXmd2KxDhyx3zvuVNkosNCiemGp1nqOQXrz+CR7C8E/GjvZq6eaVEb069v3vzRU8bPdNoe61RiaYKUvnNB6S5SwQWO8pnmjUkEnDjXS+uoUzNObe1AeSfHntFZi9uJCGg2Z1XfFp6rsOaG17IHMhahvBXsQs4nGxC36vg1dXOaDtXPCY2opc7ZObiQiyIfI3KMb9rOz46sIeMncnVdTW4U6Weujlim+VbAMbR0bTV3qgSQmC9qa1xqOvGgpy4VYrVPpv5cKi8CzOFg72ur5V1HM3wrQuZsCT2TVDxGXL8lOwYwBD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786429342; c=relaxed/relaxed;
	bh=zNhBP13xIL/sN0KZlPwcsWMMFOExxnubJcIThbHJjU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihrXg8X3e9AQ31X5zG91Z8Vz5JRAqydIH6rFZyGcHgk0DNgRroof5kfOIfpGHWu4ycKVoBiavbk1YIqyB802IToVHE2e67TQGaq60xYuS15l4cNFeapZfJ3G3CiTn94WmnEBVswKbXWxty1dj2Kezu9tP4F5rf+v8KMgHUvPIcPH0h8XgwjV/cEEU/f3lBtWpX//HRmyndc/Ld35ss5R7fR454LCeyZDPf1KsuJRWhXAZXfqYqF1qVHx3z0iHElN4J1AlWYLkFpMKA1urnRiomvuulQCY2MWUFLHOPEuSsDKd8Y68LW4HZ+QpgChMSb78wbVJr1blatP3sUF2VTrQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XbSZdRcx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XbSZdRcx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK1kP1BGzz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 16:22:20 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1bDY2999522;
	Tue, 11 Aug 2026 06:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zNhBP1
	3xIL/sN0KZlPwcsWMMFOExxnubJcIThbHJjU8=; b=XbSZdRcxTf8FgR/2eivnyj
	zR7KbZlPYy+gZ/NLK7Xz/2W5Q5gumOyniu6iIhEiBMuhy5xhV79sEmrsnrVNi0gQ
	/tGyiqdpwWCQro1Y78viwkpAjKUI11gpcfRio72sSi6GiSAfxURTKAIHerTtQrcy
	GxzVVmDuJTocxOd8OBzU47pu/T0JHGRkueLJHWBtPKFuNv2MJt9cI6dWG5Uler8D
	UI0fiMFV45q1XQ1wTq1UbyZ/r9n3Q1sC9Zqqo+PNPl22KV50i4vVTifqJPnfHSvm
	2S9JEEqcPyz03gWattFLy3UUyOsdvsEnZB4A13AwzL9jssSumHOpYKEKhE1giQIQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw30h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 06:21:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B6BGuF012127;
	Tue, 11 Aug 2026 06:21:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gys2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 06:21:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B6LoMv51642846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 06:21:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D745720043;
	Tue, 11 Aug 2026 06:21:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78AF020040;
	Tue, 11 Aug 2026 06:21:47 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 06:21:47 +0000 (GMT)
Message-ID: <ee531113-5a56-4e6e-bc16-95941aa5bbfd@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:51:46 +0530
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
Subject: Re: [PATCH] powerpc/kexec_file: Use inclusive range checks in
 add_usable_mem()
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260809162403.18142-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260809162403.18142-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7abf85 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=q5xIMcLi4I0S6iHGE8EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Pw-NbXelEi3kTYo3v80_gyRVJvy9RnA7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0OCBTYWx0ZWRfX1rbgR83f8s4M
 /NSvMCAY+Pw4FyHoSIruxwu4uoTrA52/t3TVSfBZCJRSQt1Jp5bCSFmbVjHSdtkCOb4RM1nYOXQ
 2Wcd7eIqyiLQNH2HTMrkIJVdhcHrMxGACTgdRI1BMMDJLZ4FTrfPWMvqwwOi8d/ycZpNSHkjwmJ
 25N/JhzT4Qw48f/Xy19SkFUu1GyhACsOhv51cMZzBHvs5XDF/CrlXq7WA22tbTINaoVbSpMu/yk
 ZTYvJPPesxWmXU9xWixCJ9BTQV68ltPV3b5cZBEpRNbT1osofuTuDoQ4LpS9pPW+dn+LpzVIRJ/
 9Efd1/22ONVJiJYN+QqmsxmAjQx0cCP49CtpRwgbVTWEvaHjSmaq1L1O27vOywajc76pbKgo6x6
 D6WuTQ6KFpU1QoAyTIHKbeL8EkvFWgf5MpdQUGs2FxrQ3gBI6LkTaDEu1Wv89KykKXFbhzZ+P0W
 FW1SPjAEUbUTwjlXA6g==
X-Proofpoint-ORIG-GUID: BiPUHB2qOTORXGhuuj7bp6UlVG6YgFdg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0OCBTYWx0ZWRfXw52iODyZ8eJB
 yNm8+US1RzOXKD++EkNf6uT0rwcnb5FaaKM43j1MgZXiSF6SKbT4OlF6NtG2UeR6AKJZlFdPRtH
 U6G/mIZaC0YXLagk0gdpRbfTAv30L0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110048



On 09/08/26 21:54, Thorsten Blum wrote:
> add_usable_mem() adds usable memory ranges for the kdump kernel.
>
> The ranges are inclusive, but the partial overlap check uses exclusive
> comparisons. This skips ranges with base == loc_end or end == loc_base.
> Use inclusive comparisons instead.
>
> Fixes: 7c64e21a1c5a ("powerpc/kexec_file: Restrict memory usage of kdump kernel")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/kexec/file_load_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 8c72e12ea44e..f9e872693ca7 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -113,7 +113,7 @@ static int add_usable_mem(struct umem_info *um_info, u64 base, u64 end)
>   		loc_end = um_info->ranges[i].end;
>   		if (loc_base >= base && loc_end <= end)
>   			add = true;
> -		else if (base < loc_end && end > loc_base) {
> +		else if (base <= loc_end && end >= loc_base) {

This is interesting. The updated condition basically handles exactly a
one-byte overlap on either side of the usable memory ranges. In practice,
it is very unlikely that we would have such usable memory and LMB ranges.

Thorsten, have you encountered any problem that led you to propose this fix?

- Sourabh Jain

>   			if (loc_base < base)
>   				loc_base = base;
>   			if (loc_end > end)


