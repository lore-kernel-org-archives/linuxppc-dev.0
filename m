Return-Path: <linuxppc-dev+bounces-24068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641C4C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 05:38:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyZ9N2pnjz2yVv;
	Sun, 12 Jul 2026 15:38:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783834696;
	cv=none; b=Cp1moLJw+4v1FBZLZUGcD3SLZR3L/a7Z6mdMQq/CpYwcAmYni+qUkL1YqPJyQbYz/8zrAsaEHdUAKLuY7AqABI4/87NU491h7pCcEjEn0GbyzctXd4PK2E6oTlt5GW/zAkvn1oSiZO0x3Hyp8nMVxv2/SKAnfcIzzN7cDJtwt/FwUJNKKPio7mSGL3oyy+YTnokDKq8zD+xbmMBlGGJEfsVcJDmaqIeTQRhE/GqWVBNVvSwZVzrUoKz0skBrr4VLKXO5WMzN+fSDh8UvmGWFdBHJyKh542VQd51VkmJEkoNG+nTZyOTJO/ON9+V6Hl91rL0fQN5IeqCtcsGoCQqSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783834696; c=relaxed/relaxed;
	bh=FmrEDx8QxMchU1PCvAPUFKd41C7Mk0v0R+yTy+YcmbM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m+ASsuCn1x68s6TODm+VtXuKPt9m4ey+2DoPQGGLsxh9mIAYGuqfIqq4ibRiaQf+yRwXT+GOng8ioaYEbEzk9Y0LhG601GGQQOpmo/9hAhGz25fjCw09ak50p2Pjntuiz4Kbg3oIG4QK6XU7XloKrElvi5+5OKFDRVdMKdq+z10cbCTr/jFFSeT3KdxFoE5eXLeR27mv9xn3BKWKoaeVY4F7xk5U9eL2mwHrI8RJ8SBLxgCARYaAsNO+mY/Le0dfpdofKkEFB7x7H/A6G2mDPeu4utJimkcXCIFiwumSaZZeVAdwdTjYplQ2o5BinolHK3Ir7aAD2hww34Q4649lAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tpJ8bAHU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tpJ8bAHU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyZ9M6GMlz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 15:38:15 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66C4CC5S2755698;
	Sun, 12 Jul 2026 05:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FmrEDx
	8QxMchU1PCvAPUFKd41C7Mk0v0R+yTy+YcmbM=; b=tpJ8bAHUG8kPxxb5vGDVIq
	6O5OoxQhtwfjsmnXCd2wPVjFCG8s7O6+4vwqq0p+koTTBEr0W06YF+vTNvvcrgXQ
	uErDvCo4TgxBLBY4BNfMvygotU2aenEgChUqDSCtS1AIxsgnfMmTjyYaMOqBrr2j
	BZcZME5i+Vgj8lA4KwhMnkGwpmP0SNh6nhgY/R3raZm3LHZPBkLP/KKDrMs1aIAI
	kKF97QDynKp8g1JKLN2VAPdx2QVslr5MAscOeusdaXc7AHYn76vqHtE0nVSemyZL
	rLnia2Mx9psjE0pWsyaM7iFbR6U+ukROXTXqHUHANvnP1WhB25kF7Di04iIhH58A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf29uagk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jul 2026 05:37:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66C5YbmF028137;
	Sun, 12 Jul 2026 05:37:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvrr7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jul 2026 05:37:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66C5bkdm31261284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jul 2026 05:37:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B34F58045;
	Sun, 12 Jul 2026 05:37:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC2E58050;
	Sun, 12 Jul 2026 05:37:40 +0000 (GMT)
Received: from [9.39.28.183] (unknown [9.39.28.183])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Jul 2026 05:37:40 +0000 (GMT)
Message-ID: <ded27d4f-3e66-4cd7-9757-a2e52770c3c4@linux.ibm.com>
Date: Sun, 12 Jul 2026 11:07:38 +0530
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
Subject: Re: [PATCH v3 0/3] selftests/mm: avoid false failures in hugetlb and
 KSM tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        David Hildenbrand
 <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko
 <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1783446924.git.sayalip@linux.ibm.com>
 <20260709185319.cbf0c39dd47ee3853d212b7b@linux-foundation.org>
Content-Language: en-IN
In-Reply-To: <20260709185319.cbf0c39dd47ee3853d212b7b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDA1MCBTYWx0ZWRfX09MeEcG0vjIt
 7v6YhGGQP//AxKeZoVB57S/v5Phrt2sipl8TptJHgH9R3xgwWMmFzFq68NoEhGw4BHn3N6vcK2I
 uepkizLnWsilGBPM/QUSaAZ6f9RUClY=
X-Proofpoint-GUID: f_xJzRtk3x_iNQf7hVMdY4rgOoSj3IPX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDA1MCBTYWx0ZWRfX5DgCAFtuws9Z
 DIi8QDJ3z9AJL0DbldWqZCL3vjjogx8PrLV8bysPv7AuZB72j8iIUuizKjW9EhXXTvLRI2Cm8ZI
 OpNtmucVuHtbBpvvaNRNMxiP6Zk0rZN6qzZZeIQaOwkV4FLFNqHLs8jjQ4IJAbhEZvhcLSR/4wN
 TR4lK8q1CgVZUKo6+hitjdN9koo89CnlqF3saGiGmDIwktXIi0FBYAXrJyZSbRXKd7AyeGTxPy3
 63rRzBtxfyj83tWZeuEyVe5DmyCHo1Vw8kMZ9kQuoGv/uq3grwcV7zAm6oVxi/dN8hLspgmrJtS
 B4VrGo3w5JJLIXKarQRbyKEuHsPyZHG1gvaQe9lMBwkQRqVlXJ9rLwyavr6Dt/m8PhiP2gK7J/K
 /ZU9IhPpc8cBrFxZjWxn0WADd9mPQQ13vW3gYKOYGxQ8dHkWvQvxvS8dpy2IBPi5ELFVks8PkT2
 fOJ5YdFensaM4cgXIfQ==
X-Proofpoint-ORIG-GUID: roN63tJwwzI1npq61pQNk0ybmXMzHcGC
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a53282c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=YLSOTn8K_J3FlFHuE84A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120050



On 10/07/26 07:23, Andrew Morton wrote:
> On Wed,  8 Jul 2026 12:29:04 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:
> 
>> This series fixes issues in the hugetlb and KSM MM selftest categories
>> that can report failures when the prerequisites for the tests are not
>> satisfied.
> 
> Thanks.  AI review asked one question:
> 	https://sashiko.dev/#/patchset/cover.1783446924.git.sayalip@linux.ibm.com

Hi Andrew,
I answered this in v2, as the same question was raised by Sashiko:
https://lore.kernel.org/all/d73ef56f-077e-4995-993b-56b2c58b6b65@linux.ibm.com/


Thanks,
Sayali

