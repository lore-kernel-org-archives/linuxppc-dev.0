Return-Path: <linuxppc-dev+bounces-29467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC32CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:15:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4QXG0F3Vz2yLY;
	Wed, 14 Oct 2026 20:15:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791969309;
	cv=none; b=ebXSCGXECjjqg6T+PXU2k3eM5K9M4oZGTB1O3DuTo8x0YVKc2i1r1IGNWV1q7MFmRxhLZ+qCW3ud787vfcP7tapqk8rVwXFpEuhvfwjEXWlzEg1EAxNOmwOijoKa6lqA4nR0auyJ6slbWy/H+t11Qff97Qtdh9d6i82HipYNYGOo8ivDEsoqJdn4pLVmauBiSoJKoBojtY9M/PxEU4ehNBQzqLm9sUDzX4iHjVPrtcAkSB9oAesZp3Psb6w65H/ZZCOY5K+//MzAhCtQoOA2LkfKaeNRqImQoxmguU6DGQAovHF++9vUVQls6l3AnSDJFdwdqyZt2+OmUHUJihXw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791969309; c=relaxed/relaxed;
	bh=9MMuWmaBQE0Yk81UrgCWRU+L8Qsuq2BfoEqTh+Kyjgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWHu5pnTRYHm1ayuT7Q9Zflrg3px8xVdq58dxDvnQ7CcK86/73vdSpnrbDBe0v2DQjJg48Srn4h16cPMV+mRiP4iXA6LM+TF0/QFZJ03vJTL8zhw2KEyeE0r+BL2crpnc3J8S6jJX620cgqZz9zySWQkW7ZBEZDncFp1YkSrQ1YQXsFb2eIAb4HnB1rmTPm4j+QRbxMyzY/w70Rkx98V8mQMrUX+yaELvEAhEJlhnob/9Zn5vXMkWrYab1ImrRh1bX7wUiNEOOoHHKmnNWUfC0i6zpmNr2O4FwzJTfDdhdta3aO/ajx5teNthUMtwrTpHcEuqonpzlhBC7y1FU/qAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KvTtKK3/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KvTtKK3/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4QXC4Qk1z2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 20:15:07 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKNu3I727758;
	Wed, 14 Oct 2026 09:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9MMuWm
	aBQE0Yk81UrgCWRU+L8Qsuq2BfoEqTh+Kyjgc=; b=KvTtKK3/hcmyf66a/tCTxX
	bT0OXIqoPJdQ9rtI5IfPMp1SVm58aIC145L258jcA1pQTkeUgdtZ1369iDU2R6Jo
	HD+t2kKoWuCYE7K/mp+uM/SMEA+SZznvT53KyI54cajJmfG/JlUEjolb7uaGPJnX
	ughy7a/9EaWKQd+dHReU9TPu2DvFesCHwvDqs/rYlwbHaDIkN1YSiuOEF6qeIEA3
	uhX2yywjtgbQ5LowfO11LWgcIpAswLo9CcbPZP2Q5A+Jsoiawf+qVKwWvfqEsUCg
	PLyYetV9HCwMwwBntqfX6ri22L4pnKKD8d4I7f+o8DC5D+pVY3nnJNZ0V9/Htk2w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0jyr9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:14:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E74Z6u3303971;
	Wed, 14 Oct 2026 09:14:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6v1wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:14:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E9Eg7G25887152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 09:14:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C83520043;
	Wed, 14 Oct 2026 09:14:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20DA420040;
	Wed, 14 Oct 2026 09:14:40 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 09:14:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, ruanjinjie@huawei.com,
        tglx@kernel.org, mkchauras@linux.ibm.com, ryan.roberts@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH] powerpc/syscall: Avoid atomic test_and_clear_thread_flag on fast path
Date: Wed, 14 Oct 2026 14:44:39 +0530
Message-ID: <179196918692.1557523.17395120735511864815.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929071744.2965058-1-mkchauras@gmail.com>
References: <20260929071744.2965058-1-mkchauras@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfXzCAdLouhoV3n
 y1paSCiSazFXyRL6sSFbQ51H5/GBdS1Zh+OiNC2mZ9bTW/pr417TEG1gbk8l1tYJ7OHDvBlyqvm
 NExSTKnOZDm2Uj7e2J/s1OpRr4JaNlLHQeuXtAQmw/viF9B8i8RsXyVUXFtsDfEosoOamOf5LRw
 1SYUbaEtbJSVKUU1RsqOYM4PrVlcznyJHcgPpbX6he//VHC9jANojE+6nnaM6nFvnl5+abewTLe
 jjdE4mXDI7BWscKRHLiqnDELnww0WFsZQzrDVfegfUMRGp17RKqiY27YDc8S6z2MB8eXTV6j0G5
 4g+LPyW+fjpm9WVObonC7yBLRuEspEoU/EH6345J2kb2nW8hQPKPngp+TMI52eUMn8bnv3DnNyw
 vTKQy1MtUpCxegdB9UkhvVwa9S8ZYiyCUFFsEEFsyJw0rQZEYYhlBIEuhGY6mlApej3bVJQ5O33
 tbsl4kTsJK/yZd2Ba+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX8wh7QTUYDeuZ
 M1hAqmtXmhJoyu0GCKTmDtBDB2wq2PFRZJfRuAsfWtQjj7Fxx9Cq2JRI2IamyYsruyvd1vwcbZn
 bmMYIbK8vlPZMrw/YYua37jDz6+/fi4=
X-Proofpoint-ORIG-GUID: TfzCe80kH1Y6V91PPDAJFVeunKSOuUbw
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acf4807 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VpCeHquL0c4hwlvbhsYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: CSNDcm0iyy1Kz1Fm51xw5OJ1n-rFbNO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140036

On Tue, 29 Sep 2026 12:47:44 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> In system_call_exception(), test_and_clear_thread_flag(TIF_SYSCALL_RET)
> performs an atomic bit test-and-clear operation on every system call entry.
> This introduces an unnecessary performance regression on the syscall fast
> path.
> 
> Combine the TIF_SYSCALL_RET check with the unlikely error condition from
> syscall_enter_from_user_mode_randomize_stack() using non-atomic
> test_thread_flag(). If the flag is set or entry failed, only then clear the
> flag via clear_thread_flag() and return the error value.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/syscall: Avoid atomic test_and_clear_thread_flag on fast path
      https://git.kernel.org/powerpc/c/66236558dfac63d9bea5b0b6a66a4d717529c118

cheers

