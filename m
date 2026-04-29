Return-Path: <linuxppc-dev+bounces-20296-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CA3FF887E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:51:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Pxd2Qngz2yps;
	Thu, 30 Apr 2026 03:51:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777485093;
	cv=none; b=bt9R5EKynMJYf0dXVHy42cAKW23PjHvoYpdPzwK8ywv5qpXHudxtSYqMDV/IGYQ8qlTP2CcIx4gvwAWQI25Omp6IXR1fZyHNp28znahCGIN9hk8TKSeVk8is/hzvtvcjuqs95jBK8kM27CRtH2jjLL6fOIQXvtkaqr1uehKd7Q4UMeo4ULl2/yQGnPnhVf/14NaAJ33lYD2f0dD1puLBNGDbQXWgFmJNEvigq4judMe8a+f2jYl4P3e0Bve/W+9m/JxQZ5JrLjWXvScZv/lQ5K+7NH1kXm4w6iaLTzQCuaulnhuu98VsEOHfhUtdDmIvbHJoTn8AURJF0wgpRjPT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777485093; c=relaxed/relaxed;
	bh=xYE3ptMboeKeZb2D5Qu/aBBO+kmVBbJdx8RwSOHXorM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgbDLjqp/lojc6Xr3It/XNeZgZkP/a+uZFFAmP+BZqeQ0CyIgnsPgYm6JHhYtKCtwd1fdBaEMLAVHwuqmxI81jZszXYIMqWjmq+CWR8TjF7DSU+D41PrOptErSJV4J2qCbNHTB++fMgh2frkGWd74g7paQQhPnomW2Q6xpQT2gkdlhMTqfpGw/2gKhRt0RTz5n5Y/Ky8PYT+GUorW0HzRaH20tcFnNeKom537u7vB7Fqe6X/+0fG/9e4y7CtAMUeRKfvZaUwHICMfQQRer4KAL9CNUpteXdS5boyyxoaugFQiOoKMLrpHZOLtgodY0qw9ogDj1SIWqNPCtIyftoTeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hoGL89hs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hoGL89hs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Pxc2FGMz2ykf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 03:51:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF1onn396004;
	Wed, 29 Apr 2026 17:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xYE3pt
	MboeKeZb2D5Qu/aBBO+kmVBbJdx8RwSOHXorM=; b=hoGL89hshOy7qu3tT9OXh2
	06sc13pw1ZmQwXJop/41DrHedPcRkOn87kgjep7/mYOBgo5E+tNrLNHSfp9FGfZR
	6CO0gfPVsR6wzvWoHFKlLzINi+ITevrGs55g3FAnByNipXppIuegdoUkSKkk1LGl
	oHXXT1nf2kp2eAdFv3fHTDJPyermWXDpPcDBQnsaDNaXTPgvWiKfYz5iVsOsiavC
	su5lNMEAuoLCvoQ1yECofpr7E/MgQOw3nyPho1gzkzm77mym3XWNGhT2cXGy+K72
	caEaXmemUo3MOXRRYtNSYjkOXMpgvLbsFkipvPVas/rMFU2kA8URkwEwsPRLNViQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vjbhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:51:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63THd1Rx020550;
	Wed, 29 Apr 2026 17:51:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyf61k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:51:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63THpNCH56164654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:51:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA2120043;
	Wed, 29 Apr 2026 17:51:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7851720040;
	Wed, 29 Apr 2026 17:51:20 +0000 (GMT)
Received: from [9.124.221.220] (unknown [9.124.221.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 17:51:20 +0000 (GMT)
Message-ID: <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
Date: Wed, 29 Apr 2026 23:21:19 +0530
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
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
To: Samir M <samir@linux.ibm.com>, "Paul E . McKenney" <paulmck@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Boqun Feng <boqun@kernel.org>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f2451e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=SltLtrhv4OmeOPo6kIgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=sGiMcuukUhmiu4iKGgn_:22
X-Proofpoint-ORIG-GUID: _sOAm_Wn_KlF51Dlhb5XpF1pXgwTbLan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3OSBTYWx0ZWRfX2zilRbQWtkR8
 v3KGwBmpl5pBm77d04qsz0DkmjiKJ0Up26LcB/jhjsWr1t0KxA/bXM/X3zBkprgivvo8jAZnhUZ
 P704EBAIZn379VChyaZpLPCKe4d1KBdpXkCiuEd5knjdpZr+wSF9ewlCs+BhP/TDakDgaaPvpm/
 vnAaPhkIgr4Bb6o/HuV2dENP/R45hNtCAVOmJQr7k8cBoKeIkazk65LobbTU6R6ozPc5MjLmcKs
 Z1GxBEWMLSaO3D7Z9+obgwRaJvu1qrErLFFZ2PWy4EcasKfHEwiD6gNMEuY4OdGxiDURSpdf1VL
 xpu6x5QVAT0M0+VxWaHNS+Q8I9CU3oKyOjYBB6VQuWVU/ZSgGG8hEUq8Z3XKDmm3jC+FcnFrfyI
 s4p+4ARb95f3bRW/5H+J3YqMZvsDp80C0GJYtZQRafYVd9rJA37OMoT7+ZzJwE3fbhH210ZLWU4
 r9Xf6/7EZGcVtuT1HdA==
X-Proofpoint-GUID: vXQyVNRMRfTYp_w2LZbMfCxWk6vLQHUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290179

Hi Samir.

On 4/29/26 3:46 PM, Samir M wrote:
> 
> Hi Boqun,
> 
> Thank you for pointing me to the existing patches. I have tested both 
> Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC system (80 
> CPUs), and can confirm that the workqueue lockup issue is not observed.
> 

Can you try only paul's patch and confirm if the issue is fixed?

> Test Environment:
> - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online and 
> 384 possible CPUs)
> - Kernel version: Latest upstream (7.1-rc1)
> 
> Regression Testing Results:
> All tests completed successfully with no issues observed:
> - Hackbench
> - Kernel selftests
> - LTP scheduler tests
> 
> The workqueue lockup that was previously occurring is no longer present 
> with the patches applied.
> 
> References:
> [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d- 
> d699ca496f83@paulmck-laptop/
> [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
> 
> Best regards,
> Samir


