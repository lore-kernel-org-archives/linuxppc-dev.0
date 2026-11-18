Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F70606A335
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SNV1YPp9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTkv53Qnqz2yDs;
	Wed, 18 Nov 2026 12:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966321;
	cv=none; b=Fl7/IsrfWC3cTxQxwoAdAWDV5tlqQUjcydnTtpEYoLufZhJhf9o3Q3DYl3lR1/jj708dyfeHkPigHoEQyuetxi58AnJdg2eRknBPTzLuCbYLEPmvwxQiwO08+o8usn2v34ieeaWkraU/rellmKRlLcJfcFTlMXEB8la/7PxKFMv5xbMj737gJxbk0GPVVTJ3lcwMy6ykxqioK2KbGij0OX6d3+SZV5l+WURST9/VeQ+c/64Ybgo/HHhRoLZdtF9EWzJVOUQcLOiNkHA5qMUjcqGHBi3QgIfenrCnB9FA72BOepfm7W/yRd4bu6J9LhKj8dpNHj+zhnra3+YrVP2Dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966321; c=relaxed/relaxed;
	bh=R9j5M4HT15opFR8v1JB2sqnP39qLM4ouLAjZwCC700I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jnyo5v49z1OBT6G6YzTFdGue0MrQbzmTDT8DKPAm1t9/KLwq4FOm8trA/EMgEI/hoaA3I1IKI0uWop3yR6ayYOJhMB2i7MEDnCHH4tIQaNOkeNqK18bMvO17/q0ZdV9TuHDE9fkdin/xvbfHWI7WiUBYXsrF2443/RJo1qfq/FV0xc0op4HeBEgXP/OqaqTplZ7aC2r4qQ57vTOJDrDDt0Ik4+FvQ2p3qQf3TgNI0fxaDH37USAvi/ELe71CN4+jmgDK/8QOKYd2ThUKegkdE/ONjxefkvq2bAY70tQ6kqwgMyrFXwmQogFXkoxjM5ZiK5z9T0BxS8d8AQQWuQBlTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SNV1YPp9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SNV1YPp9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTkv44mcBz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:45:20 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMvPAN3659992;
	Wed, 18 Nov 2026 01:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R9j5M4
	HT15opFR8v1JB2sqnP39qLM4ouLAjZwCC700I=; b=SNV1YPp9sFR73JgWtXMy4H
	CV6t9kl5d7nIx5aR8iUvs3GV8tDzvKqln6zWNikyEElPQdYv2pu4TKpWYFO2525m
	x46/wXNB/dGj2ewkF3m27Lmogq/Cj8527MMxOx0BtAiNVMyutCQWYjjX1s5ovaZ/
	udwUxV4V0t5TmwOr2hVZKWFddqv/JDNosdnpwLG5SCK18DFaLDR+TP/8h/XUBn0H
	kwL1MCVnV7mtk/0XhYaN2Yr1djodBIG6vtSnb7XXDJgoVW+WDIwiqPge6EcRNTiQ
	2bo+fk5UX4t3e2R8x/kTzKZkhaHVlkwmkixrnGtb32PS1JQWPSPswMeEXgo99N6Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vgcvg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo9NP1131307;
	Wed, 18 Nov 2026 01:45:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00nsfyv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1j7xQ40894750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:45:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C07A20043;
	Wed, 18 Nov 2026 01:45:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A56B12004B;
	Wed, 18 Nov 2026 01:45:04 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:45:04 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mdshahid03@gmail.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer allocation
Date: Wed, 18 Nov 2026 07:15:03 +0530
Message-ID: <179496619906.633156.9084787030500702662.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261102143719.165508-1-mdshahid03@gmail.com>
References: <20261102143719.165508-1-mdshahid03@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1CA5ISBQmyyeNAHxuwBu8hISuibNX2V9
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd0326 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=8EgdSkIYbPKlfAzbgCIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -VbbuyyTXy5SR2LHo7nKmbLK09KHxauh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfXyDDRv9ccvt8z
 9/jrRzoZ3bJfFKo4FSc8pZ8Ni8ZuWMJDtUs29PASbFt/7OrngFu/7DFRfq6rJlsYRoxfvdUbi0y
 iazDSLDN3peyTUaT8+J905nSXrYZDRGedHWjcmTaA1N0AGfAdJBnyhMT9GCemTN8uw/F65ZTt3w
 DH8IplWKLAwuGHUQ36ifnqY0aijKe7QXxZSCBZ0MIBKgGiSfkGnC5se5UUwaP/OTK6OZ6RUw4gY
 uEod/UuJth/IVqDo9lF9owCj4iWeOyrTkIO5Y28u1h9CRnfX4F8O1pTSj0vYJQ9PHEru00F0dTE
 4bC4MTmA6L1ecgqbYKkBmBTfJ7RNIEBvd6NcXuI/Tw3PfiCZs6M6u473cLejQXgzZNWaCXoBo70
 N1uo0I6ufAtEXD/y7UCB+XupUVXVl1ocTvYa60+eaWEOQyVCy+/1+e8uW6j3csNWaMyWFD8Inpg
 AjwbnhS1M5rEiAM05Vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX54mpeFCwJl+I
 qDeJIM9/XiRzWFP21cPCMNvQiC4HoVmu0CrmB6ZYmcIS75QvKxDbqLrQul9UfXcf+hQNY89ZVaA
 Vn3QVGjpCmMxrBYFEA3JpYxlRyj19tY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 20:07:19 +0530, mdshahid03@gmail.com wrote:
> The DTL buffer is allocated while holding dtl_global_lock, which
> is spinlock.
> 
> GFP_KERNEL allow direct memory reclaim and may sleep. Combining
> GFP_KERNEL with GFP_ATOMIC does not remove the direct reclaim.
> 
> Use GFP_ATOMIC alone to ensure the allocation does not sleep
> while the spinlock is held.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer allocation
      https://git.kernel.org/powerpc/c/9500416c8aa7c271b85be6a0d5856da62b60223a

cheers

