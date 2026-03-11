Return-Path: <linuxppc-dev+bounces-17998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6122FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:15:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTR2KzJz3cB5;
	Wed, 11 Mar 2026 13:14:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195291;
	cv=none; b=MnkB5hbNWmOGG0KQulaaVBqnEOPh66f6UZ8fXI5FXHpTkOQFmMmuksydXsnqXZDcfMSAYfxzEwzmgf9ADx5hvXtVNvnMujzf0NMWQbXNg/FrCl5VAiDkgzB2LPceqnGTz2tLL+gbWlPqXJPiE/zQdRCMNSsvVMEjnO5andt59R9rvV/buTiBdl43AkHoEBqZhaJorAkxSRhpRll0AnmQm/WhjWwuzOp7m/8jmXHQT1xo7rckUTnPGq/5ULzZ5b9PwggkwdSaO4wh17dl4Ee7CeMLDGIwIRoalqG9rGLuH6iLq2c20HX4H0bBCGR6eu4a5vbC/srEWPhqapkEhlGh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195291; c=relaxed/relaxed;
	bh=HsQuhb4PDqGzYmjeDA4A7LQyti7aVQTEOByyf1irGk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUmsRmbrsvwLEyz7nkHhwXcKO4kaFNIPi7T5UFxtxGwaTxs6/7Q4BikD0sC186KDhc4tE9tjVd+XHmiY5j15GIpouoW/Rct7EbgFcgh1E8sXycHOaeh+SNg+c0hgvio/ToDuCinqYl6cIe5zH50G+3GjeVfLhuyjXRko6BjPmiIhS5D/jpEdbssX+0lgVfQ+PVhyGShKRILp7y+Q/TlF7GFzwKIaJXiThwSIAIjJsUlC0zdViWlScoH5i3LsuJ/SPpWVo9K+ld1azX9CxqUTnPgatrm5BJEtF/GmEIfZ9rHvu/uvT1FZSLgfDU6RiTuXYxX3TXryL+9pi/YhUee3eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tiJiX0x6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tiJiX0x6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTQ3t4Nz3c9r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:50 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AGlAF9370491;
	Wed, 11 Mar 2026 02:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HsQuhb
	4PDqGzYmjeDA4A7LQyti7aVQTEOByyf1irGk8=; b=tiJiX0x6jNHWUcXGF/ubZ/
	XOBXuIQ1EH7IJHyeuR9dFOxXfKOwvqUpUvRxsCHXGKhVNMWrASa78EH7Gzbqr2tU
	afgZsZhb+xnbsUAZAZhLaXQVKul2WBqI0X7nedwfK842gULwmxSAZTe/dAX2kPge
	Eq2mfAti8eiNt8Rys5XRcUy5WI39hXJ4r7F1V8aaedrKqwlXsWsMIBUQmtBFMX6T
	RQWn3PVTJ9fCSPZDXqajRMwgGqUOS1YYUpIRIb3l53PsngCIXu2smgAFqaO26/sj
	F2KFjnrrdeb/X1tb9QUbOqfBYD57xCZP5c3W6u90d/NU1W9TWBc2YNcJkm01PCKQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mnasv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B1NJP9023013;
	Wed, 11 Mar 2026 02:14:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng4kqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2ENgC42139942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7E0C2006C;
	Wed, 11 Mar 2026 02:14:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B94E2006A;
	Wed, 11 Mar 2026 02:14:21 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: Correct MSI allocation tracking
Date: Wed, 11 Mar 2026 07:44:20 +0530
Message-ID: <177319508349.269267.9488718055542693297.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302003948.1452016-1-namcao@linutronix.de>
References: <20260302003948.1452016-1-namcao@linutronix.de>
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
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b0d002 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=NCz27aoiHFB_FWDnMMMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX8xQR/MhxUl8X
 cRO+I9wq+AgL6iGttPEcXW/VYWjeW+Qcty2v0nnXfLVvRyQthrs6P+23TwhJMw4xSOs09a5UYsZ
 16f2UMUTPPg40hZ6NycN4TnWKXflNSk0eFpiFdhwK+e8+deE5kwykZhMn01e72F9eclyOMN77FX
 6Su2nIg0y/uJ7vKkg7G4mEVUGRT5U7cHYtjNN5dGQ05ety3Bx46SNMRfBVRBpv9dRzH8vExfpZS
 0WenaZ/9XoAzaWuzwaDKFANEOH1UOlNpr2R5S8zfFVIgqiK0D4+6jSPN7LxYjPTPPzalxTC2QO7
 hmOIEVrN2iRJDooiCnjFXTLMEnGu2JIR+drsuClSDJI3SiBcpCxNh46RD2e0dm3Mv/7dDVOFHtx
 w3ursakx99uzt8TEiVT3rowYQR0d/3k+0lFhXqsSES2HWBPk+uyq2uAb5n6q7JANRweC+qKazpI
 mq1IQDgMvkEH7k1dJYw==
X-Proofpoint-GUID: WH0uVrNZ4EaGxjvD2lL8qIfBzZt8ePXc
X-Proofpoint-ORIG-GUID: IKf5F4qSJQ-HRdcUSgYITaCLRcz1NFo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Mon, 02 Mar 2026 01:39:48 +0100, Nam Cao wrote:
> The per-device MSI allocation calculation in pseries_irq_domain_alloc()
> is clearly wrong. It can still happen to work when nr_irqs is 1.
> 
> Correct it.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Correct MSI allocation tracking
      https://git.kernel.org/powerpc/c/35e4f2a17eb40288f9bcdb09549fa04a63a96279

cheers

