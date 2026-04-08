Return-Path: <linuxppc-dev+bounces-19465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8265EFD5F68
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr9716df3z2yxf;
	Wed, 08 Apr 2026 14:28:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622525;
	cv=none; b=FPzIOFQbN/cSqbuViBbGTKn7ZaSQJ+iyWv46PIUNpsJf4ZzXoyvlg3GcWQARYMoMOXzOByaZZ8N30lX2hm70nhtoWHtOiOjFxci+9exAIQGQp65kJaDeHqiQVJ+vS+j5nbP4KYvoCEgvpLX8E5PiLG+rKRAZbSMEKZK/22Cv/Mj4GS4IgFDp0a0TkETGkKHIjMyyEC96DXb7rOZYTbVjaA1Psku5RCHpAkG/rjJUaAV8YTLfNKPezBltb4SCaqgYWonAxLl/Np7YSCNtWjLOELy2CAcDBY2pCHzzhS6Re4apk1ysvneglcutV0N79oGyE7j2YPphZrcRUKWlmxUmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622525; c=relaxed/relaxed;
	bh=45cV8jSO9kpwSt8NEm25CGbpvGC+EkdYkBHQz8oLV5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1QHYXCOOjUFgJ0YtvpeC8tnDT6e57DSuE1DFOjsQT5+BD5g7gmkbfpuDxUUazyIngbc0bFNu5WWXwfCDzICSczl1rASWM4DYkForoys0FzobgxvGOGvjfOuku/v8mmJxD+gTshTekPANWUujS/4K88EOMkUeQa0cedUkcw4K6Hab9dM8/kJjszTf628yYt5ToTm6L1fBfzHEY5BlSFgjOQMQg/YyRfoBDMIkFTXKuMTzJ+5DGpcsEPlVW4k0bAVKsHFwi3OE49oKE6NI4P0K6TQoEHenCHSyCd30ImmWnifvKSngbWKY4yxkxANlq/uHs/LzvuO7QScStWlJQJAjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HgMe0gTk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HgMe0gTk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr9710lcRz2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:44 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EMOS12297382;
	Wed, 8 Apr 2026 04:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=45cV8j
	SO9kpwSt8NEm25CGbpvGC+EkdYkBHQz8oLV5w=; b=HgMe0gTkY109AsLWi1F6gI
	28wdJDPEN9m3RqJOPx+CytSfgtuwJiDTK5oENwBN/V0Sfeb4Ep2JRLsnIvZbSReL
	xZm96W8oJio68iDDoXi1Efi8WtuaGxLZIATfCyhXODafuUoVlVrZfngQAaIQrKpI
	SW3DJFyhy9Xlr+v+CPL20hC1TXI5eHGqXOl8iPt9VByBjXSkw3XtEd84X4w784vn
	aOW3i7X7vwijloVU4A9RtPy2nbvXm3jynLhSnKxyceyxTI41UaYGL3gTxA1WmIsI
	7AKdF2p98SKFIeKOlyP/SILDSQbp1ztpv7d2AYTbqApjDy8vVW94GsMEjM9XwDXQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwrru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63805uQX013844;
	Wed, 8 Apr 2026 04:28:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf46057-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SVQ715204614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3206220043;
	Wed,  8 Apr 2026 04:28:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDDAB20040;
	Wed,  8 Apr 2026 04:28:29 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:29 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/ptrace: Convert gpr32_set_common_user() to scoped user access
Date: Wed,  8 Apr 2026 09:58:28 +0530
Message-ID: <177562236432.1381144.783117814991277790.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2409643daab08b4bc07004c2b88f42085d1ef45a.1773136838.git.chleroy@kernel.org>
References: <2409643daab08b4bc07004c2b88f42085d1ef45a.1773136838.git.chleroy@kernel.org>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5d972 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Xnn0j8UZnTOuyrh_SIYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 6wiJU7Hy3BbD3yC8PDockxy9pN-zVzSt
X-Proofpoint-GUID: 638BhSFRPcLYcs6FJcZ_-qc-Fa5AHV-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX3fBNIPMgWeuJ
 8B6nUEosffGVeDVMkUtwjLzDBsD9XKG27fORn5idE4Uq9e43rsdIte2C+KF8vxK85Zv0O+eERSY
 j+m8lF6weFlEo/ACA1YmjpOYUYpIRaC9JkKuycesw8X2xKgHpK2EV+CR4TY4K/R0mlIL3Qy0NRM
 ncgwwiLwaKSpruh5EAJpH1pKkkKojssdhaOYbQx1OPg27c9i8mdZLTUE/K1hcU7jxKTTYWQdOhs
 MRGFirNoS5qp9UhvqyPhoGOC9uwPjoiEwTzngUIbuirPUfsy4dHbdvtVvKGApYe1s+hhHxEQw8j
 E2PrXfwrQXWP+Z45lT5EqOKq9N3c2JrBfVf0sJo05Kkwt+ZLZA3i0m9YTRh4/0pSbUPEAVWw2cF
 yhtQ/vuxd9Jl0VtGg57jN1DJyXJm1klN03aBFLfQ1pBPDcCY0As5B5NiiHfWtVw+dPozhQx+vm5
 L3XH38QD/i8Qn3q0Gnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 11:00:53 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> provides optimised user access by avoiding the cost of access_ok().
> 
> Convert gpr32_set_common_user() to scoped user access to benefit
> from masked user access.
> 
> Scoped user access also make the code simpler.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ptrace: Convert gpr32_set_common_user() to scoped user access
      https://git.kernel.org/powerpc/c/679fa9c756c7d6fcb6ae611f695d286c53dca076

cheers

