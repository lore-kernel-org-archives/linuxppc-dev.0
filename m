Return-Path: <linuxppc-dev+bounces-25984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35571C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 17:44:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQDTT1R14z2ygL;
	Thu, 20 Aug 2026 03:44:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787161453;
	cv=none; b=DMHlLS/nE+KUEYQRP+h/XoVI64wB8dBR01TMYMgbzBAM85+6GNhp9LE4rxdAdFBHotzrPyQyVtmq7P3l5VSCCIINazkRKZXugIKNhQkMNEHFHL2vVMmmA7oM+twSWPfB2I5NKkDQszWPHjbdqcdUEbjQf30Cbup6WUPdU7gx2K35CNi1DkdmkRSnusFJKiE/xDUPG30zaqZdnwMslOxCGHMmccAESHFJbn6Dhm3eVkFr9ViVcqB4pbh+DSP6+y0yoJaiPfDf3STF6nWGSnvds/5i6IL8kOR9AmD+E0GeUVjvjghpti9Hqy+tNGBRkGtisUh7ZPaFIeFZtCsuN998UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787161453; c=relaxed/relaxed;
	bh=zJrS9dCogrCw/kuxt7atF9Cd5FO9Blt+ZakyRI1Nhp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hPgeeXaFiHTs31ZPxsrjBCMJ+vTkRrCBXHsRPVkRrKNXAPG8MYYjVaHdKdXKi6SxT8t39Y+pt+sQrRYnqR8V96aYVQ8jYLSBMSHZjTKu50gy54otSkkHvwWPYQ+wgCTAfG/FZlJbptqarhfFxY88hBzBsH2pO6LVMQP0ZzBrOuZf+1xtofrtVlMr7fCav17tKG8ybM48nuhuJPei9IVR9AoqHNqCqdKiOddmltC/X3cUT8vnOPkmtvV+onapHUunZkd9x1u9K7Fm3a1ELZ7JgSSmoxRNA+XVCiEt17r/rnfFVvlwDFNEc8SUmDk7SuZRsONpuEex7TNRRI+aeYZtHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DtIaKl48; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DtIaKl48;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQDTR5j6lz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 03:44:11 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1R203801192;
	Wed, 19 Aug 2026 17:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zJrS9d
	CogrCw/kuxt7atF9Cd5FO9Blt+ZakyRI1Nhp0=; b=DtIaKl486a0wVWFqHR2hHs
	nZiqyvMoP+PiD1zM1bWjvBA3as2O1NW3T82Kz1j2izUXAVUdr2iD051jNTONPmEN
	rWzauWCSTDjPHt0uf7vnAWOaguwngxPUplLDIaeIcSCzzJiQMLCvibV5tkO0WpsY
	f6grE9Wh8WBFj0uwl7VZzf3A+qTsGmQ0Jed5Ba6LdjPBCkah44nJWt5KHpHFTGU2
	TZ0apulnDkT6XRShobsNEok2NAn309KawwnYijsm4kMz161KEhP4zdv6PBG1ptuN
	nltyPpr+H8QSmF2CpMWCT1aVlsDUCdpskrxg2xFN1hx9Q0MFKyvly58FecOrTCXQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0dbpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:44:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHfIsj002761;
	Wed, 19 Aug 2026 17:44:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twa9f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:44:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JHi0Gu25756398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 17:44:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5A1E58058;
	Wed, 19 Aug 2026 17:43:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF1658057;
	Wed, 19 Aug 2026 17:43:57 +0000 (GMT)
Received: from [9.61.252.205] (unknown [9.61.252.205])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 17:43:56 +0000 (GMT)
Message-ID: <d93e491b-e185-4c41-ba31-28a37573f6f0@linux.ibm.com>
Date: Wed, 19 Aug 2026 23:13:55 +0530
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
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending doorbell
 across L2 entry
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
 <aceec38a-7405-4020-b682-5a8c31af30f9@linux.ibm.com>
 <20260819163954.3b08c1c2-55-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260819163954.3b08c1c2-55-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a85eb62 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fQgsUzIeWd7idk2l9RwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0IThoGAvELkdveJillOlbcIY8bgEeete
X-Proofpoint-GUID: 0IThoGAvELkdveJillOlbcIY8bgEeete
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX9ghAPxb0O83c
 gvAhcd3e00vMDexNrGx7DlkEXZz59pphLZePYZXYLk8mHEiPRjZnD2W3n0wM537n9I0cLrAv9iN
 aY9fBzjqD0ag8rtzDBfRWBqa4O9DNOw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX72shs0DH3V/9
 G0132SfIFZxn7ZTI58MgU9+R6miT+3pe4sOclJ4E5Y/FNxR71TUhkU6P13mUn+N8lDuE/h7k5OT
 06h/hC0hEPTi9GfG0/WwA6TIb5XTK8V+yAKhPKXj0K00tZ+0tjwlo1jr9o4UduilUbQgy2ZhVQe
 gwlBa6nvKHM0CuW3BlCXmR+mkopdbyubsitxzjsiuKfPs3KnfXoOk/A68nVjXLSjggptM1a1zFz
 99obgoJg6jJMKj6D+fwfX8EDYr39jjEO9toLS6pnnU1W7yMUe8xK4Rl3WpzOhh3YyZQz09Id8hG
 nV+Ny997pZXPWTlsgA7U/zQqex/81KNPMWE0LCC5FJhEMpwTSCCKV0qc/fE2kzvU3RpF+96V1m/
 I3UCRV2YhPLCLQBBwH95W/DY8P5LSlm792aMKwKYjbuuTA4ZiqsGClJCauq2yYgBD4tqe1OeadJ
 ckDLoKsyooegpb2XHMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190136



On 19/08/26 4:42 PM, Amit Machhiwal wrote:
> On 2026/08/19 04:32 PM, Anushree Mathur wrote:
>>
> <...snip...>
>
>> b) Even after applying the patch also it is giving same softlockup issue as
>> mentioned above:
> Hi Anushree,
>
> There was a v2 of this patch sent here:
>
>    https://lore.kernel.org/all/20260812034628.1122115-1-vaibhav@linux.ibm.com/
>
> Did you get a chance to test it? Could you verify if the issue persists
> with the v2 as well?
>
> Thanks,
> Amit
>
>> Though I have enough vcpus and memory on the guest (16 vcpus , 13Gi of
>> memory)  and ample amount of memory and cpus
>> present on host still these softlockups are happening after applying the
>> patch too. I tried reducing stress also on the guest
>> but still this issue is seen.
>>
>> stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G --sched other
>> --timeout 3600000s
>>
>> If you are planning to send next version of this patch,
>> Please do add my reported-by:
>> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>>
Hi Amit,
Yes I have tested this patch too and I am still seeing the issue. Let me
reply back for this v2 patch also.

Thank you,
Anushree Mathur

