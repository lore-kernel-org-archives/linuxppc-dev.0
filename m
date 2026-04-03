Return-Path: <linuxppc-dev+bounces-19290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C41E85368
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 19:59:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnV1h5wNnz2yjn;
	Sat, 04 Apr 2026 06:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775246392;
	cv=none; b=PjdTkzDEhpEW2ccpTiS4PS7gIBlFVDb8fAIV36qvnGdtspfyHvZUR53FxaklFu0trt8TUBV8HbIlAem300DMX4sa2b3giwHEWaq0J9hmwXGvl+MgTOhKLmGAhL+XULl4M0BlxdplpfDSOQ91L+iSd0FkhrxZ+J3xOfay8pFHXL95rD6kIN/lSAxfNpLCAoTMARiusNcQilmln8ZuMhbe6v2Of86A9A5G7CBOyvB40b1rcKbz7lDx3LyQRZQuCS/1OPH5gwEQWpwRPxyDuIQ9VDFodZ9PvcPZFC1Vq32u1eOKR9/ba0rtQyeaZBBO6BXkatmL7coNNI/Ks2LiUTBAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775246392; c=relaxed/relaxed;
	bh=OVNyj2Jj76qFM+tO9FJUNvpvUkWT58xHyWuu5jTOYlw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gmdYavIA7LfLAbvHk7LgA3Y0Ijk73HnrmqFKSkHlHht6SRJzJoM0IJ+HCL/yoXrljpHG+BNVfF9ADC0ppaLxO5DAQf6FDk93w1ShUkk1B7cAQYN3AyMXUeP5YFNqJYM3HiIXca4xs8i1lxeOaepfxLMrjLMSkQC5r1Af26/n/Lnj3ShOkTQIQfx2Elm9fC1NAjZhHIcS7MPJxtw4TKDX8rphapxDniRqn1nPkGrjuIXpebwSIPXfsoOYglsCAcEVh5d13RwfCTfALTCYDbBnMelXLss7so2niNbod+AoIAe0jqW2LwB/+K1exbshrGSFBGHLBlzzjVFdMBAzCtRi3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S5hKRqq5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S5hKRqq5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnV1g4sLqz2yQj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 06:59:51 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6339lP8L3728728;
	Fri, 3 Apr 2026 19:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OVNyj2
	Jj76qFM+tO9FJUNvpvUkWT58xHyWuu5jTOYlw=; b=S5hKRqq5XMw7x1MN4VawRp
	Z55hyQHiaeEd8V7+mrdovCPVhK9AZLZgR7QxeDWpD0p9NhZ9NtFZVXJwJC1XLn85
	g/1sTH/g4/s17WerFAGL4lMvCu825UEMJWMHv1Irzy5BgzXsODyp3yFtPESlCJwB
	DvV+ceNOPSSUNjm5hciaunOuZTmii3DZHEPf73p/tp0G9QfuPhwOkz88H+RDSePY
	YVjUv54OWF2x2qCzx782dU2WRzUaBsVrk689a5dgQSe0b/YeeVm0lHTtNXfuZwXb
	dEzuVpStxl6qiIgqT2E/weiG8crA+Wa7BE0ttwBLaKkueYfALJHl6Lv7JdbAcROQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dh14pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 19:59:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633F5C2N031552;
	Fri, 3 Apr 2026 19:59:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk75t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 19:59:38 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633JxbMV7864898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 19:59:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21FC58061;
	Fri,  3 Apr 2026 19:59:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E69795803F;
	Fri,  3 Apr 2026 19:59:32 +0000 (GMT)
Received: from [9.124.211.212] (unknown [9.124.211.212])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 19:59:32 +0000 (GMT)
Message-ID: <e8286f08-abcb-4b77-952d-228ee1dbd705@linux.ibm.com>
Date: Sat, 4 Apr 2026 01:29:31 +0530
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
Subject: Re: [PATCH v3 04/13] selftest/mm: fix cgroup task placement and drop
 memory.current checks in hugetlb_reparenting_test.sh
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <1ac1cac332a692e8d2dd70922bb09c0582340143.1774591179.git.sayalip@linux.ibm.com>
 <7dadb91c-745d-4fde-8a2b-c141b26823a7@kernel.org>
Content-Language: en-IN
In-Reply-To: <7dadb91c-745d-4fde-8a2b-c141b26823a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3NyBTYWx0ZWRfX5MBkzgzA1UV4
 qMVrVKeKymhEVQTmw7N8t1ma4JJlMHknnQcknGuiI8QNTP39xAtr9A0tNvfRo15S5zH7H2stqNy
 r3Dwdf6EQX2DTLHQhu0hTIqKm7pk+AkeSdjJwtv9EepAoU4vtZjlpEvIeD9KHdCnSHOv7ibbdg2
 ZLc2v54DrDuTH2Pe2vc/SBT5B255nBzZiyIQl8iWjCljzRQcDp+/Fy+8iN5vkQeoTXrPut8A/BR
 JoxyaGKtj00jjFdZSxVEewYEl1fKY00vyZ/v8RmpFLlDppopnSt/sefB4vv27F+5fGv5+0+PwiG
 IS/SzkrlkqfuNTgQZ7dE71a/uHUO+DhBBORwmxtD36/6J+IsnaCoNwTjKujO+eQdaAR10VtXE6m
 S3ygT76rodWUjE4aDxJQmCarHPGkZ4LwLrEQzEkWGkYSb284S1oyiWIVXpb7/bm0MBq1Aqu7309
 NIt1GrODPAYIZGzEW3g==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69d01c2c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3LRxwzKv8Tv0BEPaKXkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: KVFWCwqj010Fi5fKpLtM7gvpgDBcnRQY
X-Proofpoint-ORIG-GUID: BSE_BQcmlXWY7GF8pNScHrx-nM-SzM15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030177



On 01/04/26 19:38, David Hildenbrand (Arm) wrote:
> On 3/27/26 08:15, Sayali Patil wrote:
>> Launch write_to_hugetlbfs as a separate process and move only its PID
>> into the target cgroup before waiting for completion. This avoids moving
>> the test shell itself, prevents unintended charging to the shell, and
>> ensures hugetlb and memcg accounting is attributed only to the intended
>> workload.
>>
>> Add a short delay before the hugetlb allocation to avoid a race where
>> memory may be charged before the task migration takes effect, which
>> can lead to incorrect accounting and intermittent test failures.
> 
> Isn't there still a chance for a race, for example, when running in a VM?
> 
Yes, there is still a small race window in the current approach.

I am looking into making this more reliable with a deterministic 
synchronization mechanism to avoid such timing dependencies.

I will send a v4 with this improvement.

Thanks,
Sayali

