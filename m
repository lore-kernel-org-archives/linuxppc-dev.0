Return-Path: <linuxppc-dev+bounces-25434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC14C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:04:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTbw5WBCz2yLY;
	Wed, 05 Aug 2026 22:04:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785931468;
	cv=none; b=M4zWg4k+u8e5P9upAv/7/XSYE6LgZt5U32Pn/CmyDcNpU/KfLm+WYEA/6nv4twDbfq3yE7el8DUhdfQdlMkFQdpVgiI2lWXsqHyVa1hj7ZNp9NydvaBiASqsg7zU09LTvj7dxhaeDErnzuJPjzNOyTFLhJKIGOMeNDD4LkHedgL8QhY+UKFDhX3MIt3zzpFWzjXUuXVIemlA4uXJohlf8Nq0/Oh5X2szTHxtlZE2DPD/1c7HALJTht2IhsKERGI37EORAAf3fFV9TFyESvVAZQtX2fMcfIa4xarL36tcm3BwPpee+XNb7G4FZk+hCG9L4Dcl4tBDLrV9FkNsM5OeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785931468; c=relaxed/relaxed;
	bh=eonv3oMHZsuXrNPjwYVsk5UoJkgHfRvx1phvOe9Uksk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P9cWUrHhmSrt9EfPyayTRucXJ4FkW7M6fF6kHQ2yQVmZ2rDb7zHF5hVuxe/lK3WqjwKXYTR3DCDrdoC86iCk2DddhsSMjOyu88rkk19gBLonKKKVHuMTz6o0UlAtUcenx/TH00pSPIrDxc3vgStcWwnk4EHThXkczc7sqC2ExV/Zy91mF9aBEku6AlN2EUgVzTv+HBVS4YYWfD7DMKddTcMikVt12SCV5vfnf4Erym/FeL3nf70znAsH9cVwYkar8AAfdHQxvp+ipCGwzWiguhitI6CCa7HDEel27i422KHYN2i8/5yP4C9uZ+UTOkYd7y4UtXtTpWiGVwzfPbqdYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VEUETkzH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VEUETkzH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTbv6sRBz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:04:27 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758mK3l3438952
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 12:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eonv3o
	MHZsuXrNPjwYVsk5UoJkgHfRvx1phvOe9Uksk=; b=VEUETkzHuTXh70MuZEf1kb
	nmtVbNPy+fKv35QVP9OOGkyZ5ap0fgnZifq2SkIDZf/lPWwH+l1PXGwM5zFOC6c4
	Z2Nk0qZCHDEu68nP3sm/I5xAekoc3o+LzrMeY8R3H3Ll+l9POR5Wm++WE2mhjyu1
	WyH8pj/SwglhOiwa/A3rb2MUHXpCJJgDvSJ535q6UDn2/VwAFKN8QS5BZvf0vONI
	zi1hJeElvvwmHHvfXHp9Y0NGEkKl2D9Uc2afYXWkWXGq2PZa4FnhsEbsD4310ZPe
	yyEy5bNWNyyfKA2nAEIo1qvAyJysEds/h1zSjKc/f6vXALCSzOYZGurRVe3j+9fw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eutb7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:04:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675Bun2p029031
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 12:04:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k6df9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:04:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675C4MSw52167078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 12:04:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20DEB20040
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2026 12:04:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CC52004E
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2026 12:04:21 +0000 (GMT)
Received: from [9.43.76.92] (unknown [9.43.76.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2026 12:04:21 +0000 (GMT)
Message-ID: <aca34ea9-4adc-4836-b219-4c32c1c824c0@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:34:17 +0530
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
Subject: Re: [PATCH v3 4/4] powerpc/perf: Add power12 Base Performance
 Monitoring support
To: linuxppc-dev@lists.ozlabs.org
References: <20260805110924.3853410-1-mahesh@linux.ibm.com>
 <20260805110924.3853410-5-mahesh@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260805110924.3853410-5-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VNAxJUcPn_lDOo8qBfiUKT70PmceDktZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX4W7+rjmThWz8
 BoBgbmLFxRmAePBuciDNFNM9ys2VeAPN0472UX+AGmSVDuvPcVsQsR4DemndQgT54lKWH2RIR0M
 1qSRecayh5QSHt4pwrjo+gLkLZwOEM0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX7HOAhxWtifN1
 jAOedYfDB3rgx7incXWLo71Wtdh3sRF88oWcdBq+n3At/tXAArTxT8BHB1MxwotXOllqV45Yj5J
 mzZFcOOYWvzByRZQCH4b35Pho1MVYwr2fakOomvTk7LDSkRNiTuVvTb2JAM+jDPVH2Xi9zmgWvM
 Zcq24+HBWsQnv/o/qmznfLEo0Ct2OVCuTevZj2BgmwqIn8fCRwiUfFA7fKZgpL1fd76S9/m65OS
 f/f+sGRV3Loc44OpZQAK67JpMEYm1nV3tw4KiWCYKBQ7WlQ2RFJy12Tdoi7b+HsIkt9Ze4FXDAe
 s9OaJ2dyolH94aeGALCWlivOkK+Qt6NKRdcLAbjH3BP41PZ3Pk1vXCDmoJ3cELwxB+GzN+GzN/B
 QaQtdcHKbMjB0FTIGwDHGJOTQe+faEwxKJ/noUYSuDM2JPp3T8Z+ZW94DUsfqtii5xlBJ0C6ki4
 PrRyaotqEFRmcplSDDQ==
X-Proofpoint-GUID: VNAxJUcPn_lDOo8qBfiUKT70PmceDktZ
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a7326c8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=2QCfGHd509E9zJr3CTUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050094



On 05/08/26 16:39, Mahesh Salgaonkar wrote:

Thanks Mahesh, for addressing my review comments which I raised in v1, 
the patch looks good to me.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Regards
~ Nikhil

