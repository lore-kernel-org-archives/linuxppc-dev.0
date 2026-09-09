Return-Path: <linuxppc-dev+bounces-26874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA605C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:18:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrGf0lLrz2yr0;
	Wed, 09 Sep 2026 16:18:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934714;
	cv=none; b=dMiiLVAWtRGyk1xuZ4Okfm27O/7aKkZcT+o2ulz/Gihc6RlQHA8CMyCrvW6XUCHEEw7HYLmL4hnhdsMw+ZaOtsc/lFDnX7XvAg32RJBzDgqEpsfWZpYgwhEU8BDCkQh8+p2Y5eYpMNftXZpdxYcZd01itNGryE9AAhYin64yfsRWea7l2wbwCG9mvY5s8RPncWZzonT7gYGp+ubE0/nTVtkmZomHq1qDJoaxZ9IczG3AUULiA1hP5J+xAIZ5brroRD1mvEWeixFtbFnTaCLcukSwwO6rlVW2KsW2+g6n2aFEYbfD3oSmPzZmsl/EOqF2b5qpurUW1+x0tgHartBCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934714; c=relaxed/relaxed;
	bh=DPMrtfYRFHgVVUKyAaGLJ0ASx/E2yQ11mtZtFR6a1hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD47J4uI+XBNBbc0gLhr1t6prOaGKRAAwlcmR+Gx7rrQT6UZDPPS1W80pz/Jd+VRpFVK4p6JlrGmGgmKFsdstP8z2YLKF/kvUB5e0N9ICOmN65hLbWhWeIgEYjN70wzJ+HEreDCLSikBfHMQYs+NvFPe3ACKaYfOSPSLxYEwdXoyR38X8Wa48PB0zOEgdM36jsHbEcuuaW27DgHhHVzH4xOAcRbezgxURpe6h0bEJjSKHCVQe+vqYRSwZCbrjEbbwIf0UNSN1lNDR/WdPjv7GAPvRgKDYRyW4eLfbcCs9cylrfoM3QPHJG4UtMzFJNzDh7O7qpalnOE9hvhrjETNTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eXHn06hk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eXHn06hk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrGd2JL7z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:33 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1caw385523;
	Wed, 9 Sep 2026 06:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DPMrtf
	YRFHgVVUKyAaGLJ0ASx/E2yQ11mtZtFR6a1hg=; b=eXHn06hkPPzQcFP+aZvxMb
	wxG7mp4cj1DKK9rOjdsobXgKhpKeozK/CfK3kXmrNxX+3fcms3ws67y9BYcLUtsh
	v3Az+481/3ZlojWnqFuz3dKxv5qC5NMiTbBDgQdl1lVnRSDRaeeLjqvk9zQSCpeC
	gtKdit7MdLTJHF4GI2wGOZSI+erhH0UsI4KxSgPQBhm8ubSgrcwNYrcdvu15TNqg
	jUndk4MPDPJW380JKqCHvac0sly+8HW/Y7lh3zdt5nm6zU1FkKEbGm0HJZM3LdWz
	ikPKQYL1b/T4Ao8sqMNHOXrnSM7o8tmi4nh1xgs/HU5cV6ViptzTW+qh3kP0RfBA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk40be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BGK6029555;
	Wed, 9 Sep 2026 06:18:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk0mnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IOwE47251954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D0B920043;
	Wed,  9 Sep 2026 06:18:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4CCD20040;
	Wed,  9 Sep 2026 06:18:21 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:21 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] powerpc: Do not restore KUAP in arch_exit_to_user_mode_prepare()
Date: Wed,  9 Sep 2026 11:48:20 +0530
Message-ID: <178893459266.174069.7557874308297448634.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>
References: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>
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
X-Proofpoint-ORIG-GUID: NO8IeJP6OftICR1vMONB7OWtqojAPIAc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX5BS7CjtX07jw
 uQN5YUl3P7CGWlMDCX3LGoGUfuvHO23PRgF7bmLQ4mAbnJr3UnrpPHu54UM0Mu8my+xb8+ZCiUF
 h5cGSHgEuf9cCq7txEjiEwQLUdfoJ+I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX8XaCom05lZgz
 WkeYtRYvPjfgT/uZI2Y1EvWwldqXMRA+MyGyOJ3tEDPebaYPQa5ecLwp+gg//P7fum1TmH9ulCI
 7SJvHuvoCfMqP6g1E4vXoT74x7u10NU4VOm0z5OXrfHoaKdaJK5L4D4BrmG9vUa4ECHds+M1eWQ
 E880y+BHzMdtVuXR80wcjwd5OH0InsciX2LxBqiHxhTLTS2C2yVaMalvCz0649+gaiS5f563zIl
 hmzmKpWcQ2iZb37Eak/KuqVSTJQ0JT+Qd9WW85UIBL8GS7+CJEbLSl6lXV1MkfYaMbIccXM/Adr
 +Oajshi8qEIAgl4KStHG/dc9jsBOXD1AwY1VKgqoX9vkwigQid+COqAwrU80lCikCE/UbyA1YYu
 2xf91415/vkJ1KcO7BICiDStj1e2CJ5Vi7womb/JzEUtOTUqiBBXJCEGR1KfWJGHVxnIQyOs3r9
 AuLYQAWPQp9F2WD9YKQ==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa0fa35 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=l5fDNrRPcUJBkFjJG3UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aE5Oh5nDmEl9jVFRH9SOaExqdKwLc6db
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Sun, 30 Aug 2026 20:24:30 +0530, Ritesh Harjani (IBM) wrote:
> KUAP means kernel cannot touch user memory unless it explicitly is
> enabled. In the kernel it should stay AMR_KUAP_BLOCKED. While returning
> to userspace just before RFI, kernel should restore the user AMR value
> back.
> 
> Looks like GENERIC_ENTRY might be treating arch_exit_to_user_mode_prepare()
> as the last architecture step before returning to userspace.
> commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> therefore called kuap_user_restore() from that hook. But on PowerPC that
> is too early. After irqentry_exit() / syscall_exit_to_user_mode() we
> still run platform specific exit routines.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Do not restore KUAP in arch_exit_to_user_mode_prepare()
      https://git.kernel.org/powerpc/c/c2549d749539487239475fbc8c614a1f9244d655

cheers

