Return-Path: <linuxppc-dev+bounces-25730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9356FC5B569
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:06:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK2jJ5w7Pz2yvG;
	Tue, 11 Aug 2026 17:06:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786431988;
	cv=none; b=ELFq1nLhWr2fODajq31TD8+yaI+jKPDXHSlZzZfMxjniPYQKXE6zV0LjUAdE5tUnePCFAdYiljwVilvMul8/+Jlq5IXOVxzS3cxUk62yTcbom7MJOdQIhXTKhIZ76J0ZVKwt939IT202NbPRgitsU94oNVjPm49Ko3y4exAupOBjohciYaAvIYku372B6G9SlQ2YyMTdI7EG6+B8wUyZbTNov8nyToxmAKyfbmb68YdYzdBiy61rjhFqNy795PxXHZTaE46436ItXCa+rxBoqTwoTbJ+J3tQEWZlZyo0Rsum7WPik7MqmuSDxDNwG05tWgIjYgvqh+gENYadBG2Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786431988; c=relaxed/relaxed;
	bh=tug1GRH9aW37dU+R0CaXrLLMIIAYu9AyDGwIbwZrY7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GL732I8m3d8KTiVD5D99mW4cGm/hzYh1sqkXBHPdeZ1O+1UyVk70b1St03NA3JoUow5AWqPQ83ypczQ5dBsJLIvrCgX+4ooxEEH98rQmg6I2OzHBUkyf3g5WfO0tPvwS/8Kr4yF+0m0v/oypY98BVQvXkXKrm2FhXTJFewKiK+rqhS5cGyHHo+YtOdIBw5BhPrCW1aibCVijr2brLrv1zRdT/8CSVDsMYA/MFqg7DuOdIMUJ5lundCe+4nK9Nly10S3pswasPfGISUsH+Q1IBjdioFnA02xgmFxMyAIUyp0N23Sm2BSBMpCowFdXVFTj0tqj3mhVOo2cgaIh1N1L6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QSVBtNXr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QSVBtNXr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK2jH0R2Xz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 17:06:25 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1cr62878860;
	Tue, 11 Aug 2026 07:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tug1GR
	H9aW37dU+R0CaXrLLMIIAYu9AyDGwIbwZrY7I=; b=QSVBtNXr5+3NtXvbkwBw3N
	iz75/7OspnR89sGXi1r9qgrliJ05WzFd5WkvqUnKfNzajVBYMeFQjntGReG4bJJg
	oZrAHXAV4qJONyX41mVnBdHVl9xQhi8RrGqxSoS1U46YN2zykwl9NcNXkeisG4dQ
	IqCHDmzQnWz4QkDdNaGJaNcpIZcZYrVVYjNZxpG5tirmPgLyY1erBnk3HxeoM2gx
	W+WFPCa8+uCS7F4fJxgUOr4GkwdU7uH2Z1dNx0o/Agp5ZvzhTiU4QWacr1zvz831
	D7dMdG8pV7NXpJERC8FYEO1KTxRLmz/3WMFBIZPhMmSqTuhTjdaPYxgejmX7EITw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2u59c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 07:05:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B6uEb8022681;
	Tue, 11 Aug 2026 07:05:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxyr6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 07:05:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B75toE36045188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 07:05:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F6A20040;
	Tue, 11 Aug 2026 07:05:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ECB820043;
	Tue, 11 Aug 2026 07:05:51 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 07:05:51 +0000 (GMT)
Message-ID: <f383ab65-3d65-4053-8340-b28082f751d8@linux.ibm.com>
Date: Tue, 11 Aug 2026 12:35:50 +0530
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
Subject: Re: [PATCH] powerpc/kexec_file: Use inclusive range checks for
 excluded memory
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260810145827.157972-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260810145827.157972-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ac9d8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=nbPvJ5SdgmQPYtCXlAsA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: vaQxq8X2pSi4GGQSI5Y1AECtjvtAx9UD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NyBTYWx0ZWRfX1jqkow1i3dQC
 kOFd+HbbdjXzLI0keM5oyIMWqWOXjxG/5Dc75IdRgTkYrOyy1EA9DdZy0PPhfOZkMGu6pkhzVkx
 HWqfwC14NfuO95TqHp//Dueu0svxCDw3zLiIKO3q4MKGbYw7pOl02Ty8RHosX0+4fD0podOT/sy
 rBw4so4ixVFofyecRNXi9cnZDq8Ct2a47beEltF+NIRsUalp/hQXNKrucP7izbO9d0CTwwaSfzs
 dt/AlxB62zHU4lARBJYQLzFuWjNMHaFOXA/AWe1Q8hotnJWBJhy4s8ldUV/NwxQ71tj+tgX6Jbn
 KlGTPMzjxiAhSDKezYj4cWODjlC7YhGv3M7ilS9l0BUUb30yskWVGNdrNZCT3Frys9u/Ek9yajc
 fKJAKbArmXT2oQLHOReVo0z3vrdO09ZBc8c8j3LcuIOjPF9fcwMYAvb+SY+58VSJEyIWwxBZBOn
 azcSqSUWMwYbwSgEwtA==
X-Proofpoint-ORIG-GUID: eggWLUutUGyj67VcShAvdRclPQKAuhbJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NyBTYWx0ZWRfXw4nH2mVnrpP4
 X6FitTA/QgrFKli8h4Vvy/8I3rKcbub5F+SNg31d4iMvjSNl31rEm4Xp5ggUwWJVU6MycrF7w8O
 mhwRB49ymyv5CDq7bo2KDadWZkwPlTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110057



On 10/08/26 20:28, Thorsten Blum wrote:
> arch_check_excluded_range() checks if a kexec segment overlaps an
> excluded memory range.
>
> Both ranges use inclusive end addresses, but the overlap check uses
> exclusive comparisons. This skips ranges with start == ->ranges[i].end
> or end == ->ranges[i].start. Use inclusive comparisons instead.
>
> Fixes: 6e5250eaa665 ("powerpc/crash: use generic APIs to locate memory hole for kdump")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Sashiko found this issue when reviewing another patch:
> https://sashiko.dev/#/patchset/20260809162403.18142-2-thorsten.blum%40linux.dev
> ---
>   arch/powerpc/kexec/file_load_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 40b74cc4ed3e..32e2b7412a9f 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -58,7 +58,7 @@ int arch_check_excluded_range(struct kimage *image, unsigned long start,
>   
>   	emem = image->arch.exclude_ranges;
>   	for (i = 0; i < emem->nr_ranges; i++)
> -		if (start < emem->ranges[i].end && end > emem->ranges[i].start)
> +		if (start <= emem->ranges[i].end && end >= emem->ranges[i].start)

Like [1] this also extends the condition to check for a 1-byte overlap.
It is unlikely to occur in practice, but I don't see any harm in doing so.
Hence the changes looks good to me. Feel free to add.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

[1] 
https://lore.kernel.org/all/ee531113-5a56-4e6e-bc16-95941aa5bbfd@linux.ibm.com/

>   			return 1;
>   
>   	return 0;


