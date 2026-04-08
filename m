Return-Path: <linuxppc-dev+bounces-19477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FFFFD5F68
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97s1KWcz3bfP;
	Wed, 08 Apr 2026 14:29:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622569;
	cv=none; b=PFbwd4aHxHg7pe519G8SWAnJa0WPwdYpioZR2FOVe6bLEn3sBGwgeyEZthM/2KhKszFrWsnvEjR39SbHFyJ6uXXu1A5a1+pi/ST3rVcy5kEZ51Z8+30qzjB0KM+rWiuqt2uqejY1U8i/F9LMGGvfiGI5CR5jjyzBxTqtuSUkUmi1tb8rmqeiUXiSlns+Zvjp/j2u0zMNMXnGtmwdptksOi+KcfwmCniAIJyAa43HtiGOup/MMue+4Rn0gqjMlVB9W03PwEqGMIRy6Ka8rsXFeLDlR5IbCIM3bxaquEr0wmWZYKipDQyfKmIkOI3NrDgHna6aCM3VSq4raKSZi7wqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622569; c=relaxed/relaxed;
	bh=a8aHjAvpS1Ur8mX/Q5vEVG41XGQWebgrhBt7RryPtYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKA6MH9SQMz+kWTuDLjEWyhSVh8u8jIqTGQ+69S2jwaVoOdUu4HYPLa97S5O/TcB3bnFn+HjU9Kat7SfOoJBa22Ycuzy5GzvdVoqNHW0hLnJcGES+epImpOEqdg1en1AunUlV/gAnp46iW2F1RDiVAOJHn1rNSJI3KigQJPsr8a5C3pj4rH3KLnl70nc8CyiYKhrNCQJAZAbXTFp/N/9EHe2c7HGVpW2m4AaTv5TxpNTWYlYw8a6BynUAeinF6JG2pb/JZ1W3Z8imwnPwE48hm82OcdQFT+8pP0dxfyqgU8btECqFO8s4BNRbO/JAjzoJJ+AhF2IYFpsFM2M5z/xWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dg1anDAH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dg1anDAH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97r4SMFz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EwvWa2590969;
	Wed, 8 Apr 2026 04:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a8aHjA
	vpS1Ur8mX/Q5vEVG41XGQWebgrhBt7RryPtYU=; b=dg1anDAHW92/NE5AY1W9SN
	FKHXg6z4IvNsIZ33TpUrU/eC6y7us1Rxx0BkaWc/6J8lngyqi1YMcEtmuFBusRWS
	Pbgg/sYW7vZCN5jpNiWmvV5ABTOV+FuHKb6IvA4jFrkpZswt9uoseD99jmZqvjkF
	XElt4asQVRYEokic9t+/16Tv0F9Lg1TuBuieacxTWoQU6NtOgLJ0HaA0VjHYveuK
	hWlfP/RpEocSW9wMoXz0evLcaMU2zGy51JByKunkLKONwHD6DStMlckOGX1kz9M5
	ER8PM7rS/jPIV2h799s0/ZIDm7waA6JbQwS4M4VMoA0pb+ThmV1pcjf0DkVNhF7Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e67uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380Pln4026655;
	Wed, 8 Apr 2026 04:29:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384T3c245351276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA5420049;
	Wed,  8 Apr 2026 04:29:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC0B620040;
	Wed,  8 Apr 2026 04:29:01 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:01 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] powerpc/ps3: spu.c: fix enum and Return kernel-doc warnings
Date: Wed,  8 Apr 2026 09:59:00 +0530
Message-ID: <177562236428.1381144.14186364589664426663.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225055328.249204-1-rdunlap@infradead.org>
References: <20260225055328.249204-1-rdunlap@infradead.org>
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
X-Proofpoint-ORIG-GUID: 6l3gjHbJW0fQvkWbGAadT7JNQGN-YkuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX0d+UUOaUyphp
 05C+TcGVFAOAqYyLN39+9QlfIMqonIWTY7/H6FKRwHGyxLve9iLUQ5vhB5A6eWcYJlqsmFyS7Zd
 sTwK2eIY3XsqcTsDmX81fHqXgZfVl3+sOYUau6h+J2sy/mOOY43isw2GEijhn6LG2+B9t1QUgCc
 lYIothtZZIqf6EImGHOyIwxt3t7Qx9OaSWtuJLlum+GSSqsfJ/AYrkPzO0Ahi5JQ9STRW4gUNiY
 x9qCzTss8/L/9VUZeUQ26XST8TqbxlqvyXZE9Q+mcorSOlNPzvKnwF6+akyKOORK+oEEsjjzZ6q
 ZDzi3KoVAGe3Hd4IU3QBz7RGo+9IJkjWOKkIvuKgxZOjwrkG4c3iWfxmsGGyJqoJt/nAWUEiwK7
 4Kg1qzvx6A2cYtMYAbjWAaSPVUDhHixkRJL+aLXAcuMOxucDqedIhyAZSyzd6+WnEswHFpIOE7D
 W2lv7HMxRC2QMpFzPCA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d5d992 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=q2mWX1oaS3YY57LI0soA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sd0C-OCyPleSyQnAR17ts3kOpswzO_1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 24 Feb 2026 21:53:28 -0800, Randy Dunlap wrote:
> Fix enum and function return value kernel-doc warnings:
> 
> Warning: spu.c:36 Excess enum value '%spe_type_logical' description in 'spe_type'
> Warning: spu.c:78 Excess enum value '%spe_ex_state_unexecutable' description in 'spe_ex_state'
> Warning: spu.c:78 Excess enum value '%spe_ex_state_executable' description in 'spe_ex_state'
> Warning: spu.c:78 Excess enum value '%spe_ex_state_executed' description in 'spe_ex_state'
> Warning: spu.c:190 No description found for return value of 'setup_areas'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ps3: spu.c: fix enum and Return kernel-doc warnings
      https://git.kernel.org/powerpc/c/26d76caac47f44b3ee4cdf080614bbee07713007

cheers

