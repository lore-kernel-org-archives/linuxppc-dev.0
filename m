Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C84606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i++tGijZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJqk34XZjz2xMQ;
	Wed, 04 Nov 2026 00:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793713899;
	cv=none; b=m4AMcThgzYkbdhaurQ7z4Ajut1W7+Lv9pz1OnYzS4QgzkB/KVdWoUUvVkTRllo/Vpg22Q4hYiCloXpTja5oCfwc9moTaPk3+oJxnh/zOhmyRo/8kzbt4xdsrqf5SotS3hrWxsnPsDm3DhYMnk9qHtR9WUiWUXh67L22yK3jzCDKJhvaMMH+envWXAqoa8fnB1x/fC3wYjgilwD+BPxoel5Hnv41R1jeQILwF1RmhQW0zFKMrY3b4NNHM6D+WqHDsv2WWeQW4szoSMLMz5YYW31Ll4CKWPSUTx4FNOeVoopRzzbtMEz5N27gRI7Kr9nHw3oeAKZCxnIKtakcDnt9HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793713899; c=relaxed/relaxed;
	bh=amMRRZdMr2jGfMUqswfwghZn650KtRuPeSCOo/86gME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgXdTu+9ZiCAZP9WFMWDcXML91ll99BC5D1QtsUSsJZK5w3lx5rXxHjoBvSamTiFLz2wEr00DaD+T4ZjliP6LhdUgP8wFlmOnEs0P5YiG2i+FRU7J2dqVnaWi+bN+EpejBDh7F0d22u6/YpaoqGyVjPfVV2t0lCub5yXk2v5dvf5EfUjdyTSqb5Ncqt+AbXqOh0Q1irbYv2zHBSTKny6wh9ppBqUgFp1iaQF9MFegSt2WvLLP4jnbe/QGMopQseferDh43wzr62i1fgDkuW/mI9u0orMeu9EJ+DDPHAjgdA2LtbkHyXMGDfxNjotVtcv1WYAoBQ95V5S/PnhfjZ6JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i++tGijZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i++tGijZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJqk20921z2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 00:51:37 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DiBWD796960;
	Tue, 3 Nov 2026 13:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=amMRRZ
	dMr2jGfMUqswfwghZn650KtRuPeSCOo/86gME=; b=i++tGijZ7hR50B3l9GPxIq
	Skwee+UbQmd/XbkLoN4SVVeKZX+7QYDtj1ebfJLKt7vTNd2RZpbpFbMo4LrJiFhL
	83bv19zSeJeHYSKu2rn/ehA9Y5SZIKkEHgRVOuVnEeEpcQ/PPZKEpjORSEsQm0QO
	v44KwQSs3J6EWYsnrcqOhkNdRJ2rkcU3PEpGplD04S/al3vPmPGiB5FLInewmbn5
	R0x2unI9fgFjrrbEHMkdc/yLx4IS3oNpmuA67s/wCHksFT4adE8minQTTf3ETKpX
	/1UQNrcnG4tGbej178ehKXA6vY67x6f9gYlgoWqQZf3IyXh0m/TQn0OsOFTfIvfg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd5uux-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 13:51:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZZwE2643583;
	Tue, 3 Nov 2026 13:51:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gtjbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 13:51:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3DpAxi45679056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 13:51:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A632820043;
	Tue,  3 Nov 2026 13:51:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 139E82004B;
	Tue,  3 Nov 2026 13:51:07 +0000 (GMT)
Received: from [9.124.210.158] (unknown [9.124.210.158])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 13:51:06 +0000 (GMT)
Message-ID: <dad757bf-831d-4fd3-9aa7-912686792e97@linux.ibm.com>
Date: Tue, 3 Nov 2026 19:21:05 +0530
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
Subject: Re: [PATCH v3 0/5] powerpc/eeh: Add RTAS-based error injection
 support on pSeries
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: phM9KG2FZYKfUgyJ1G5xJj26iXu-MzDu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXwDOPzlfu4LM3
 7e7teHjA1FQu5YEExDjj4VQo3YAqmIhS8b4IHmxkODc873hOT1i+dVqb5ferMBPEPUbEZPGQHHs
 gt+N/4lXPQdaBbkZRD01dbFKKmrVzhn4UBxRTJfls0i7M6pB8iJYG2aXs6uO/VtKeyM52+NxNn9
 e39jZ/mdZ+uR2/hOA0fpO8nmqJgwtkWGqgH4SevABD89biarU92nSd5VlDOmKNyCtns5+wSh0RY
 HDYIQEaZZPlpGLNTRfaVlXSmkLnBLzsJ+4jV+OIliu8f0GJ54ztE4oIBFxgEcXzT69VpiUxbny2
 Fh0c50XYf9SH/Nr+C/+alY16cK1Z3YaMshvLSs6BwcYa+kLD7oesI1Z9cuRGgbvS8PTyaM5VzEf
 c0GhwXqEOzlL5B/PWb2gDBa3Wrk502WZtspL9HD6Bs8rmT0phdeFPdYsiNqYcdn+w9JElTlEq28
 VJTnMUhxUGIl4OmTLjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX0YKLHXznd7MD
 5ifwbWA1zCIFfhgaNJVRV0Ft6/nKTBGh8QjuJAqhQSpoT3faAXErZneAj9v6FhA3ktTW0QjdkQL
 LYdU5YNJomxFAO3lknYfEkDQdlybRIM=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae9e6d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wt1o8H50IsT6fsVrqxAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q-Z2Z5kjThjNDbi0Ik4UnNLL83gVK7Qc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030054
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Greetings,

I have tested this patch on my KVM guest environment. I am able to 
inject EEH errors from host console using location code for a VFIO 
passthrough device.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>



Thank you
Tasmiya

