Return-Path: <linuxppc-dev+bounces-17362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E6FD530B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 07:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMgLb4c5Dz2xLv;
	Fri, 27 Feb 2026 18:43:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772178231;
	cv=none; b=eGlhS3St8shroHY70BZtD953Q/pxt9KKlOvkr1vP8EJOqK+bSjyJr4rGbA49TYKAzUhPao5DRGCFq51NQfksFx2qbFsNCXwkEf1xRAw9JAZ3uurAb3mcuHS6C+/XFH2IDw+X9DS3PkkEiq/uBBlXDQ2ZlRzn6EImPDL40H3MIKohNdU/B7BXRuZ/AUNKcT12DmW5BT6t7vIbgMF/e3OTX6eSILXdUOkL2ucOJsHadaCg7OTeopO1+a/gTNMjvZ3kH7yGobQpVx+7aqYZpDnjnSn3mMlXjrHpu/0ts//XF7iDvHiCcn/e+vPUtD6aFOFSb0lMPaPdADUUKpISlg0Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772178231; c=relaxed/relaxed;
	bh=YZAmYVKAHaKfhJJk0dIamuGMsroeax4aMbFavjE10yQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=eOEYymZdKro5U+KMaa3ce0TSE/2nx8mRK3Vd/kMFroq1Lk9rK2skP4dzmHV40WgK6hvyYvngPug0HaHPR727A8Pm/HIj+B1mg16mOBmXNggLOstrFjcLVgf67IXntts3F8cuyflg9+HRWihYbsxS6xuOSi2VqRMimTaJpolEhaQroKTNuday8C4RUcX2aAURFebNz6KygX8phkc4yFW67CBN4z10vJ4GGvsbnYPJNDtuajhR7Ktljq2XVAuUSuU+dUz3TbvCWg9hJyu05+t99H5fETPzdGzip/gSDd5IkHPmm96nx/MDFYjf1tsvPHzmGSsgVPpVtfUtShGRs649eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8N7hLLe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8N7hLLe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMgLZ6GhWz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 18:43:50 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R6Tq8s2750096;
	Fri, 27 Feb 2026 07:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YZAmYV
	KAHaKfhJJk0dIamuGMsroeax4aMbFavjE10yQ=; b=f8N7hLLe9hlmNt8dsWfhB6
	BtgvJh+lX/Z9lYJeWY58JTKbQUpPg0c3mX6aM3N1l7XT5EzohdZEJaS8TWWHYU8A
	IiOD4v8ECgIRVy14DnRRt7bidhdqiyQd8wc6yu6tnuUoeIqEQg6Qve5SCzbZQe5R
	2N3JTn7dTNhLXXODm8AFv5FNm92VpGvIReXfDAtgBFZWWwOO/UlRZHq/dx2wFExP
	Lp0l6aI2bE5S4r1ii/nNJYpz2VluPpG0XWqTqff0xpXJSyaSVMFBrGSLPRJRr689
	8gl6fFSpv6ayzHQ66k41+/9hrhtXSf6rnUfks6kikZGKN78uhsPNrcg2ir4mj0dQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf472bjmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 07:43:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R5CmUK027812;
	Fri, 27 Feb 2026 07:43:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr28nwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 07:43:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R7hk0K33620676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 07:43:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F7E258051;
	Fri, 27 Feb 2026 07:43:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F1855805A;
	Fri, 27 Feb 2026 07:43:43 +0000 (GMT)
Received: from [9.61.248.160] (unknown [9.61.248.160])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 07:43:42 +0000 (GMT)
Message-ID: <21e1fd09-66e3-46b5-b0d7-cee096691267@linux.ibm.com>
Date: Fri, 27 Feb 2026 13:13:41 +0530
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
Subject: Re: [next-20260226] static assertion failure in amdgv_sriovmsg.h
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, YiPeng.Chai@amd.com,
        jinzhou.su@amd.com, alexander.deucher@amd.com
References: <2b5eda65-a1dd-4858-a6e1-ac2f183ec410@linux.ibm.com>
In-Reply-To: <2b5eda65-a1dd-4858-a6e1-ac2f183ec410@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O-tYqmp1tIoy7vUYYCBZYU3xteEvwWOx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA2NCBTYWx0ZWRfXzGNorrmWhP4h
 KaiMPTchFsT5uYO28Po8u33cguv5IIt5jCyBc6U8C4NJH6f/Bm37hOk8rPlVd78mUNWkHBd6WDD
 FH76GycEKRZCjdQoqR9RFrQrGILgt0E3rTvI/YSsj15ijmtEStgqiuKruUS1EjtoBs6lDhNcyYd
 6eooReZC7IjUXQ1dJxdg+eLw51wJZ2W9xjriyi1Cg9RdcFfPoctlUT1kCI5ZPXrAum/Ni1S1rAj
 CYoI815LGFoUlruNCNwZR7yFCoQlLoOS/VPkSlAFMqg/a0Bsb6RtI4leb7PHXs4GiSWVR5jQK4M
 MkV0qfcMrj0S6v0UEqoH48buWp8DFsZQ7tb0zCTlMy7cyNqlRAwhf6WTcPdLCV/oLM03owFkcnC
 yUKfFiL+eotEdVjs/dkxfaxDjJRlXZQkS7vODp1C/SOLn71laZEC2zbKwNMsNShPfykiYLQg3qP
 E0VTnfM+CQzUVqnlxbA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a14b33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=-mW5i7DV_e8FodwH3HIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O-tYqmp1tIoy7vUYYCBZYU3xteEvwWOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270064


On 27/02/26 12:46 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
> IBM CI has reported a build failure on latest linux-next repo.
>
> Build Failure:
>
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:521:1:
>
> error: static assertion failed: "amdsriov_ras_telemetry must be 64 KB"
>
>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


After reverting below patch, build is successful

cb48a6b2b61d7ebf2f1099041067800ffd8a5c2d: "drm/amd/ras: use dedicated 
memory as vf ras command buffer"
>
>
> Regards,
>
> Venkat.
>
>
>

