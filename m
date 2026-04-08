Return-Path: <linuxppc-dev+bounces-19464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F86FD5F6D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96x5yG6z2yvQ;
	Wed, 08 Apr 2026 14:28:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622521;
	cv=none; b=W6rf5XwrpvQrw56a+jmUkez0h0aT8BOH1MbpJmQnXX5tc/dKH/a7KlPCJp+B/oe6i9DdT/mVkZK5O7N27tS0iIGuchPCbFbC8/2uM937mW9exi+1Jm7tmKgL64ePWEZk3EvkiPuN4WY/EPe1ZJ47gx9dSI6WUDr0Be/pVubp+/+5ZrTgC2oj6pGKUunCb0jWNaK7rVVsNO63CDYyqPnXnmxOvC8a6p6QuACe2fJ6FQvFqSKHpN8YD1GGGp3JDxlSeflseHYa2dZzul5l4iqg72l5r7Tk1BVyXeNgRDZp2ovaKOQb2wFL3eR3EEEoSdlN0nIdJXFhCn2HAK/AiYKZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622521; c=relaxed/relaxed;
	bh=+Gpikute0WuIWdifxVjY92g0g0olyDmfbzLCJ6np/Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipLafB+P4bsi5SNGkznFscOZLgQnCG2w1ykcXMCWMBDLr0rT8v9eF+XcbC0tBzgVErGGlR+cj9A9utWjau5c2EiSLaCqjNIEdz6HuDQzuuVdDP5tcMFGoxZx1dMBcPMW99bW610j2cUKNL0K0xJwsQXxtliaJIPww8BK7t+3Xl9QltLEhtoHIpbv7nC2Gi+HBXA4hugKJ4k5tDVXI8Mv9QASyvMvxAXSzVYZlhAiyQItHP5jOf9yHAswTGC/Rx5rCb0R41oZY2MgpbJR2Ul5Wc+10ag24RhzGuNkgXNG7+wUfLBzHug41oStpRPjpBn3C9/YEJOXWxaoFUGCqsNIDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H7rMF4Hv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H7rMF4Hv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96x1GbGz2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:40 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DbY9F2591097;
	Wed, 8 Apr 2026 04:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Gpiku
	te0WuIWdifxVjY92g0g0olyDmfbzLCJ6np/Yw=; b=H7rMF4HvlfvI9BXHDKOD1z
	L577kUtAAuqemXpMww5yBKHlOSDFVllkPTzX/AKrZ7VllMaNyYaJwW+N34wtLgt2
	s0bLOzIl1xwjmq3yKXd9dgrbhpgL0/ECYV/Gol4RNzYPrd2XpIrSTFYcPcRRYL5b
	PrSsWoAvXGmSrRjzYgQbJlYpJcJXmWX5r6eexWlivKYL9Qqb81rbdTTcjBm9oQMQ
	t4ULIUV30svRJKk8gWaOzeStZlIr0pULZPEwPD+cl1x8cVkEhhVr3Ad4NGdOt/Vb
	P/MHOZX0vV0YM/WrP4TvTvYylu9H3mnChNV/OcuCbs9wXIhAxdDfBSbMUJxIFYXQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e67u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63808CHO030068;
	Wed, 8 Apr 2026 04:28:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7dyr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SS0R29950326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3E7E20043;
	Wed,  8 Apr 2026 04:28:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C13720040;
	Wed,  8 Apr 2026 04:28:27 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:27 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/net: Inline checksum wrappers and convert to scoped user access
Date: Wed,  8 Apr 2026 09:58:26 +0530
Message-ID: <177562236432.1381144.1746283265091398315.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f44e1b2760dbed35b237040001a91bc8304b726b.1773137098.git.chleroy@kernel.org>
References: <f44e1b2760dbed35b237040001a91bc8304b726b.1773137098.git.chleroy@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: U7HRNt9leZWL7msFqMYzpmKrxg7Z6DmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXwn/uQCBXyVpK
 /GJ5Nx+8550dWv1BLX9ES1ILuYqIo5+xza1UJs7//p4PSxK3A3gjrWPj6BS5uUWCTKS+rI8pgXN
 mNnxgKNFG8IGh7PDyWCm5rgJDGTjK3y8wayeYBER7u3vDLReV7ObKufTU/Ikq8G6pVTo96vMiWj
 XCL7T4rz0MQdBOesYShStqrh7dIr0A9sm/fCt9scz3NwASk2ysEvqVyk//DpwzHy2Q5ZVF8filq
 a29CB9ty6yBygREMJxRvlvvPd/1qFR1uJzA3GYW/N9A4KD4gOZSzckUDL5YGHe1BUAFI7/rhmA7
 A6rVgI+zOzn5GALwERucryv+4k3Ubaf7zfCAneIBWONfjJSwSJjz/RvPrnLhlhimofekAUjTbVH
 Ns2uB5JlpKMAGA28WT1q5DLLnKE+sLa4L+pt6NRsVngHJI25kr42NYxa7DAwFBaCbTluBmSrrby
 D+TuSNd64SKNEqtvLcw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d5d970 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Xnn0j8UZnTOuyrh_SIYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: vIGpbhzGF8ZRbVr6dqk-82HWxH0seSM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 11:05:54 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> provides optimised user access by avoiding the cost of access_ok().
> 
> Convert csum_and_copy_to_user() and csum_and_copy_from_user() to
> scoped user access to benefit from masked user access.
> 
> csum_and_copy_to_user() and csum_and_copy_from_user() are only
> called respectively by csum_and_copy_to_iter() and
> csum_and_copy_from_iter_full() and they are only called twice.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/net: Inline checksum wrappers and convert to scoped user access
      https://git.kernel.org/powerpc/c/cae734710dd156e2fbb4d66cdb22bbd5080beb52

cheers

