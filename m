Return-Path: <linuxppc-dev+bounces-29592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC53CC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 09:41:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5g1p07rBz2yVB;
	Fri, 16 Oct 2026 20:41:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792143693;
	cv=none; b=Z0sebMA6RiuBK6DT8uF2Si1OpdlyBasMA3MrkVYRGa0Iuu/7Sp2IIVkcdCL6T6MCiYRplJP5rBdv/RdTZ/jQSpytaLcku6giUzeARwUyvIHWLh2D5+u8swDf6JY0qn29rE8Qu3Olreg6+d2LBiSLwVubkXiTa/Egty9gOo8yL2OK555+z2zta9Wl075j+ZyrbOElzCMo4WQfKlS7FJrjAcRcEFhU9GpK5vduvD2GrmueoJiWyK3CNfxR0fW6NAS3q3/CJ/z/kZZy9jKbegZj9+qySQkOekzh/fcO25sRaR/A/hbILNaAz17dEtrfy4Z4xtU4UG7zl4pyGIUgquKCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792143693; c=relaxed/relaxed;
	bh=nRCFRjaFz0SAwW6KkDSCBMParRvSKB0kWDwKAtQvu2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTdWG9huk5HSlUByuptvXf/2cM6o04/JZOkL53IUEpB2tKBCPfoI2VrHdV2Yv5I3rLI/ydZkhPUXddRF8IPjbKxGmrjkEjp1knRSncw0YfgaW+O5rzUPe0p1DdOWZkjWsW+IgEa93rci7pTUSkEpQ7YSAfs9joqA80ZjaPyzYlqQ8aIBzuB+f11cgECDgHKkUPyEMZst8uV3s63B+zj+S+Re6FNbNuyec/u7FWJIJu1zXXt42U4DKVEBAIE2Tu9GaTKSwRBRA+yjU7IRhlTyNULpRWp0Yc5DFrzxUzSkYYYxplCa9sSP0vMaQMmFNtdKJrDPSk+quH5d9rbVs0NoSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G8rvLmix; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G8rvLmix;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5g1m3zLkz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 20:41:31 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G9TTD93000512;
	Fri, 16 Oct 2026 09:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nRCFRj
	aFz0SAwW6KkDSCBMParRvSKB0kWDwKAtQvu2E=; b=G8rvLmixil1GUopPlq3nP4
	kRk/Wcyh3a7JvhCtYukjQSyafZo2WfqQdD2eh7Tq9S/oweWtkW/6c0q4XSGFurD4
	yAuHxN9gdCwuFlWAD/MEMiy/eZDydUSDqzCVmTSLxGGvIMD1ibDYvZ1mUQOOJFaF
	2TOkG6y6cPFSZu91ZofDAATRgwU6YKyzUQ8qBLzLvMxyJbWxOuNo60anRrHwOhiO
	EKch45PjNfyaxcfnrjoPKtOJo+fe0LzCmPm36NYV2UL4FF8PIrbE4TUr7GDL6DuL
	Tyb5k97Qcz+a+HlATHLgE1FXZCe+EgtDKe1ecUjLVQtXaRzDVLoSsCIvx10XgBiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhxkrw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 09:41:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69G5NUjL2057775;
	Fri, 16 Oct 2026 09:41:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hawqwv8rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 09:41:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69G9fCeO29688380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 09:41:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9894158055;
	Fri, 16 Oct 2026 09:41:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6748F5805E;
	Fri, 16 Oct 2026 09:41:10 +0000 (GMT)
Received: from [9.123.4.253] (unknown [9.123.4.253])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 09:41:10 +0000 (GMT)
Message-ID: <e7d7ad26-42c8-468d-97a5-5fc5388091c0@linux.ibm.com>
Date: Fri, 16 Oct 2026 15:11:09 +0530
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
Subject: Re: [PATCH] pseries/hotplug: Add CPU-to-node mappings for all present
 CPUs
To: Srikar Dronamraju <srikar@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20261012155549.557256-2-srikar@linux.ibm.com>
Content-Language: en-US
From: samir <samir@linux.ibm.com>
In-Reply-To: <20261012155549.557256-2-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXxOvwZ5NAHTt6
 lGGzVlowyCwWRzfHPwpgqipONc/WKbHphvK9pD3tB+QHhprSh5+StllQCaL4z1OKHczr0x/EHUd
 FDiFlMi2rm2giRFhtiJvcAkgR/xDJMA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXygpt/bSOzAMY
 6HqVWKz8FUxitW8BR1v7b3Nlti4HPozjnC878uDuFMKrAXNBDkJLuqlQzL3jN0GiugZlu/jxdPg
 9cwCErEg7TjpQdDkZXAH0V0xcge/i7aj4Vi3jDYfN4H5nRrX+ZR7GWI3uD34a3y9d7ujbOcEhhB
 tNFW0udFIT5bxUtMKrYtzKHbgaLgimTapiJhNSwcNlwrlvs3UI5/ceSDaQY2XBOY0oUzXGG3v5z
 0dgtyj12ucnmZi3gKlbIzY3yf5/5IfjVJbFnitCfPPiiv6BhHqWiT78D42+QqR8FIPfQDPqH8te
 F1bBePgp9noPlVFpRBxExMCiJhh+pHk/lZOoaof1T5N41KkSZ7/xs/6MqvWialo3DloMd8DwRV8
 WNKQ8F/fP50jLFzsrvMmKa74qjpaS295xDr7A0JZBWjGpvz9fQ+ziqgYRY2lRXt4YMdfvhQjy1U
 tkSYJSo2Nh4DMnikRjw==
X-Proofpoint-GUID: gdufwl0g-Y2sVdGa8DpeMMLSI_UgJbDP
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad1f13b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=yHc-3fM4LxQ1CKjjhJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ol6t_Hj6nNiJeNO8LrMpu1zuGEx3_YU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160036

Hello Srikar,

On 12/10/26 9:25 pm, Srikar Dronamraju wrote:
> When cores are added while the system is running in a lower SMT mode,
> some threads of those cores remain offline. Moving the system to a
> higher SMT mode later fails to online those threads.
>
> For example, on a system with four cores:
>
>    1. ppc64_cpu --smt=off
>    2. nproc
>         expected: 4
>    3. ppc64_cpu --smt
>         expected/actual: "SMT is off"
>    4. drmgr -c cpu -a -q 4
>    5. ppc64_cpu --smt
>         expected/actual: "SMT is off"
>    6. ppc64_cpu --smt=8
>    7. ppc64_cpu --smt
>         expected: SMT=8
>         actual:   SMT=1: 4-7; SMT=8: 0-3
>    8. nproc
>         expected: 64
>         actual:   36
>
> Post commit d1099e2276df ("powerpc/pseries: Honour current SMT state
> when DLPAR onlining CPUs"), when new CPUs are added, the CPU-to-node
> mapping is currently updated only for CPUs that are immediately onlined.
> CPUs that are made present but remain offline due to the current SMT
> mode therefore do not get a CPU-to-node mapping.
>
> When those CPUs are subsequently onlined after switching to a higher
> SMT mode, the online operation fails because the required CPU-to-node
> mapping is missing.
>
> Update the CPU-to-node mapping before applying the SMT restrictions so
> that all newly present CPUs have a node mapping, including CPUs that
> remain offline in the current SMT mode.
>
> Fixes: d1099e2276df ("powerpc/pseries: Honour current SMT state when DLPAR onlining CPUs")
> Reported-by: Samir Mulani <samir@linux.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index bc6926dbf148..b5dc942eec63 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -402,6 +402,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>   			if (get_hard_smp_processor_id(cpu) != thread)
>   				continue;
>   
> +			find_and_update_cpu_nid(cpu);
>   			if (!topology_is_primary_thread(cpu)) {
>   				if (cpu_smt_control != CPU_SMT_ENABLED)
>   					break;
> @@ -410,7 +411,6 @@ static int dlpar_online_cpu(struct device_node *dn)
>   			}
>   
>   			cpu_maps_update_done();
> -			find_and_update_cpu_nid(cpu);
>   			rc = device_online(get_cpu_device(cpu));
>   			if (rc) {
>   				dlpar_offline_cpu(dn);

I have verified the patch, and no issues were observed during testing. 
The patch has been tested successfully.


Please add the following Tested-by tag:
Tested-by: Samir Mulani <samir@linux.ibm.com>

Thank you for the fix!

Regards,
Samir

