Return-Path: <linuxppc-dev+bounces-22106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F1CCD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 07:27:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWtKy1dFhz2yR5;
	Fri, 05 Jun 2026 17:27:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780644422;
	cv=none; b=QjiZU/pkNelen/HTav58NTWvRAJaik8wSeEvSRaib9uVq8cMleqhCML+2D8IGZ5G1lhZlxNDIg8Mq7P00aaTD1Gqm7N8sLlBafTw21YLe2Ls7N9YjjuHrqMvtMFuT/UdZ6tOO/KWlLd3QaCx0DtKTmQ1pHqCH1JPwuMOqKDjuXN7fYBe7308wOfrc3Ef3oJezox6PETGqDL/uxq8H4+skMn9NUrxi1ioyyrfyc96NbPQtdZsfFV32c0XGC0oBClAX86lHklijekasDtt91EtdNZnQwzrIx6AjF+dXsQtqctA6ijId7CIJ3w6/timME052bldzPhONUCTtt8C8VE95g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780644422; c=relaxed/relaxed;
	bh=pXmeAa6A0eeMzf8oUA1hZUGnWx8n3BF7bgiV9ST3KOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XOwyCUVzq2ZT7b7FB2gCNpVSCrZSRav9FquvO+Mr3ZDnFPj6alk2UDGCVKaVJQrJUR49vlKRX7TB3zW/tAMh+TwQUHwXILjcCRczf6QJZomOzU8UlBXMJYjDXjeab+fB+Bd/L3VflWXrL0OAE2t2WgOLdfZxkVlLfW5nbEXjhk6+t+1G27bs/oe7Cos2pZMli3pt6tW4UVxMBQSn+jJcM4GuTCZGXONsvjs2J4PIerDVNcSzjwof0nZHcMJuYNz2FeEVZlLiqdnnaKNP4nvPbzXs5c6QfACOhsLrr3h/yrJpmSTcoVesbqP85U4f+k2079cxW5jicP8oksm3TqwIBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gItBPrx+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gItBPrx+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWtKx32j7z2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:27:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6551Ykn82667091;
	Fri, 5 Jun 2026 07:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pXmeAa6A0eeMzf8oUA1hZUGnWx8n3B
	F7bgiV9ST3KOw=; b=gItBPrx+ngfuGpceIaKc2zCi9Nsw5e6pI2NzJxqID8ukrd
	/jgFa5ecopku7FitiQhk8ITzvTsPeXkamQkRcUKnAqZ/feDv9/BjxW+eyespoka0
	b/t95uK1vftmtRLjuVpzcMommP5PShvMOM/vNSq6KtOql5v2mFOdpBEHFzvVWSZl
	WL8s32Jl72L640EZQ/g2S33HOEGvBuyDq2yN+Q38y06PT+prj+uUcyhqhN8TQQL/
	LrOTd7pjIN3LsJl9ppql/kc2nMzuuFt/OnE5le5ZAgNzS63Qy2NqXehL98bTNlSi
	5d/o4/DVQMD3GM4qqAItzRIujWT6buaDfLdGenTQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtjn3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:26:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6557OEaV031539;
	Fri, 5 Jun 2026 07:26:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw8qsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:26:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6557Q1W633227496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 07:26:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1520F5806F;
	Fri,  5 Jun 2026 07:26:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A5C58060;
	Fri,  5 Jun 2026 07:25:54 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.210.197])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri,  5 Jun 2026 07:25:54 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 05 Jun 2026 12:55:51 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>,
        Amit Machhiwal
 <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh
 Harjani <ritesh.list@gmail.com>,
        Anushree Mathur
 <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
In-Reply-To: <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
 <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com>
Date: Fri, 05 Jun 2026 12:55:50 +0530
Message-ID: <87ldctmosh.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dv5klJ00atjHlKCI-UFdB4mmsQNPGgcc
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a227a0b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HbV5RZ6GBX0UAL49VfYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2NyBTYWx0ZWRfX6Pauc09m9wfW
 lREhGXSC8k5WPPwar/rFBYTfumn2ZYC3/MwHi9xgcEYsqVQVtBxgHNnpkhaz/yZAEYbmTy47MuZ
 x/sx2lERWbF2y1ZBoXsujP5svAqfBwCfJakcmyb0I2BUll5rkiMmTsHSOaC0Hu+c/NkDY9oqrOI
 s39QtqcCuwZ+I+qHP2te4N0jMMV/uUnLHdAQat2ZG7Kchw3sYPWQnJK/93wMZAEiUmL7+PWUA34
 MoAhH4X/kQmJpfh+knmjXh+NecJPZC1Jy+8qp1lXwGTtDowoEtIuY575Y0RFCtV0TXYd+KxDk/3
 04eJ/gf8igbFUSeZoA+GDel9SMgQfEkK2Ud5J1O0xZrrVQ4RWe2vb+UmVO/5Z+8ZvEbF1MbmMGs
 vyzV06dynj+qrNr012r6q68Xz0F7++fqGlSDWbsrl8ppR/6I3uIyxa+6uiYPuGZhCEJgC+8UldR
 rnvAejQtL9DB/VSIc1w==
X-Proofpoint-ORIG-GUID: tTAjuvZJ11_b-xicIG6gnOOavGc8y1HC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050067

Hi Gautam,

Thanks for testing this patch. Few questions:
Gautam Menghani <gautam@linux.ibm.com> writes:

> On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
>> On IBM POWER systems, newer processor generations can operate in
>> compatibility modes corresponding to earlier generations. This becomes
>> relevant for nested virtualization, where nested KVM guests may need to
>> run with a specific processor compatibility level.
>> 
<snip>
>
> I booted a KVM guest on LPAR with this patch in the following scenarios:
<snip>

> 3. P11 guest on P11 host booted in P10 compat mode: No error observed
This should have resulted in an error since booting a P11 guest on P10
compat mode host is not allowed with/without this patch. Can you please
check your test env and share the boot results.


>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>

-- 
Cheers
~ Vaibhav

