Return-Path: <linuxppc-dev+bounces-22691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34B8CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:44:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfcsn6yzrz3brH;
	Tue, 16 Jun 2026 16:44:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781592269;
	cv=none; b=McB6y+UQoJSpagrcWlGVDkQGPKNwwKv51fbhE311qvIPrV+dmcVC09i93AA1Y7kpPJ9J6BPY8IhALz36UNxGOCGq8d+LQw1JWBLugXtucTmYkjH0m6tOPOyqdQ2EmhFEqng4RfQ7w+6tfrh6hqJCukRREn4PmvmQ8habIbmjumhkb9Gm7VCEWo7UfUTG7z3NxDNyvVhy+4b8bfgszyJS3fSUtJqgksaYxz60c7v6DqrZynyJjp/cRd/wTe6ZDdTMku85/paBMQzGh8euUrfE+lJ3ScgYe143wM0T7VKU3x/qCyPIhzay9SDAuT3SakkoNQDF3zdFEgIM2gyHBHcXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781592269; c=relaxed/relaxed;
	bh=7uNl9GBgEAqIlOEUXHxq7DHzchcjA9ZBuaqcaTOgwUE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=U1cXOUNXxYfhVupk3mANeH7BYotmExkOui0Va05mw/SxLXkEcMwdzKmMv0lVTsGlavazH7PCsn0KpGnZa3dIo3YLKaKCmnDoSELiVFHULcjw7f8nqVm/te1zSj6IWBEzvR8a5PXnTmDtifpJpf/CYS7ivZfqEYLNlehMW6XLCnL6tgUUFm7jnxlfrMamdQz3lQGIuDSC5wJY8QqbQlN53uCRl4GBWUfxDuHp4CVZlhDF0ZvtnABS2GvNtqW1+y63Ujw1dx8zF3xRLyVjGs2cprw74Cs9FIp36eCNTU+jRqy+yZ2KC4oqcQSHyDhxt76iywvuPkbGJJBMrt8vYsQECw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=glpvOQNw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=glpvOQNw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfcsm56mBz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 16:44:27 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G6IPcW516245;
	Tue, 16 Jun 2026 06:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7uNl9G
	BgEAqIlOEUXHxq7DHzchcjA9ZBuaqcaTOgwUE=; b=glpvOQNw1XcPch70XOTOBt
	EjaHJY5Lt86MJ8vNuMt8TWoZ1RcgIsuG5QnTzD0umu4M1OfaSmISHYJ5/uNdkM1p
	MBc6KBEE9g6IDV+/U/PNmIbIRSAk3rvnMHYYtFQ3Jk5Yq674EJZ+jf22t1ngaL5R
	KaJRxxztcYuUBuxCxETsE9/GDnC5+oOmBJIZ9yqBQsCJVcG+x52xnWTHDa+u3Xo1
	FWdZTTj74H0KQB2u6cmUc43Z7OGNhhObPfy90KcrldPDW8t9OfCDBW7lozALhMTY
	oQFNetkItK0lItmxdeU1gmfywFgWHPGB22UgpXcA7eo7qWi/aTpIBdK12ks11ZYw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm48bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:44:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G6JZpv026342;
	Tue, 16 Jun 2026 06:44:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg9wsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:44:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G6hcSw22807220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:43:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 891DF5804B;
	Tue, 16 Jun 2026 06:44:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195CC58063;
	Tue, 16 Jun 2026 06:44:06 +0000 (GMT)
Received: from [9.124.214.164] (unknown [9.124.214.164])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 06:44:05 +0000 (GMT)
Message-ID: <c50b1713-a115-4150-9e1d-e144663a6746@linux.ibm.com>
Date: Tue, 16 Jun 2026 12:14:04 +0530
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
From: Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH V2] powerpc: Restore KUAP registers on syscall restart
 exit
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sshegde@linux.ibm.com, ruanjinjie@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260615162617.2861795-1-mkchauras@gmail.com>
Content-Language: en-IN
In-Reply-To: <20260615162617.2861795-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MCBTYWx0ZWRfX3f8qPhEjsGJy
 Z5CMTwTpE/ydMDwP8hjToLsBSCDaRHdv1KYNfUeZ9G+cttvSk/18ZAa64iDGViaLw/3hx0mSpd1
 fqnW9mG8lMOxgo4rVbVydywlaOolmSI=
X-Proofpoint-GUID: hukI-6XXNai2Bllx36xzTstFte1THbGD
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a30f0bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=x4X8Z9x8xB3-J52ghU8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MCBTYWx0ZWRfX8Jfrb+1xtRpJ
 UKtHNed9e9tvP3cuQhqbIYFZbkVKTaaSAEfHZfDTn8VUMtYT19kOGO8g3AtvdzZAA87QAY6ao8j
 VfTCE9VAm1saAt2mR5xO5CH6wPzg57VPVnrtmcJfBEdrU8PVGZCx8ThlaBW8luE+60ZzMCzT3aC
 TX1G8w24AeM0cncFGH1XA4y3AknXl80MMYBynR0h27QPA/8Y53p4oY/ZoXINy0qNGwVUmdlBtki
 U73xFFN41s/Z9vAWByCAJH9lUWgjULFE+/LFq1vLUlxQ6t3q5asoYEu4/ao9RrMZOKlMWHrMgc8
 DHHvHMkGVcF6skgamcM8TLIBgjd8yQbQrwFmdTX2g+T8DI5Ip4K7IboZbZpa44arhAbBw+mQkXy
 VNC67XnRwIjcfTJkS24vIZ4E9Cm0pOqPfdSlxkNmsDS7TQu4RSgaFLM/IDL6KSXzVMx84vE2Xvu
 XpIK/Y6MnuuCRHOKdBA==
X-Proofpoint-ORIG-GUID: wrL-A0dI5RqC_uDHUTfggpOQhjUj4F-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160060



On 15/06/26 21:56, Mukesh Kumar Chaurasiya (IBM) wrote:
> During a syscall restart, block KUAP so that pending interrupts can be
> replayed. The original KUAP state is not restored before returning to
> userspace, causing subsequent userspace accesses to fault and eventually
> trigger bad_access_pkey(), crashing the kernel.
> 
> The original KUAP register values are already saved in
> arch_enter_from_user_mode(). Restore them on the syscall restart exit
> path before returning to userspace.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Sayali Patil <sayalip@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> V1 -> V2:
> - Commit message rephrased
> V1: https://lore.kernel.org/all/20260613123831.1510474-1-mkchauras@gmail.com
> 
>   arch/powerpc/kernel/interrupt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 89a999be1352..f04978080837 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -166,6 +166,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>   		goto again;
>   	}
>   
> +	kuap_user_restore(regs);
>   	regs->exit_result |= regs->exit_flags;
>   
>   	return regs->exit_result;

This fixes the reported issue.

Tested-by: Sayali Patil <sayalip@linux.ibm.com>

