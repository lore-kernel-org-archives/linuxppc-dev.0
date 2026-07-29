Return-Path: <linuxppc-dev+bounces-24978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17126C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 08:30:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h959s0KJkz2xrL;
	Wed, 29 Jul 2026 18:30:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785313808;
	cv=none; b=ao5vtq5GLs5+vqRtHq1B5310O3TN3zDdrcV3R+o+nzoESj1KhAIGW9OVdOICK6n48AUp3yt9rDG+aLJA0dw3M0lWJRp0OUHt3tGqgCyVPUScLjppLwNKz0ocIwZOwTomNSh4k7McCHeod7YlP933EtrhMp0RSQT0UA7g13AxSWYpoCbk8DJuYT7JrpCUXumkJ/1/kssb8z1+L/D3rQnkg9r7mmvU6H0qnOTz498r8lisSfBgTB39dJbingpuXfqVUbDSNkkQcmkcDuPpZb5ljsii7LMaZzs2TO08cAhbun2l4gII/KStxxiPT8u2VFYN4bkJNHXF0vMJ+avT6MCU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785313808; c=relaxed/relaxed;
	bh=xTBu9Brigc9zLFFlYjjFxdYBp1hDvcKvewvbs2NF9oQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYvtzsdeGd0Oi6vg4smmV3OiwcO5w9B4ILyVxe54qNOTvu/QZPM3t5tAup4axEUjSqsvF+IiVlbHLYBclAY+Bo3e4T/qW4yWGtaePOhWO3cAHWn5CB4D6rVtouQnnQqT+++v9R/2rEO/0hAYfG/P37XENDUViX+nAT6WqvghOqT2auRES+fN4OPUsx0Do5t5nOSHt6LlSRM061OR1Ip9kdZl3dh9dZn6qfZwt6OH1hNjDJTT2vS7+lFaKW2xbD/K8QO7AZyEQ+WJ7H8NNl06eZkBjs2ovFqAhsX/qc1vWpSujPjhpazFQq0Ph7fXwTlr1a9xWD1vopQRPKAGsKPcGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nB1PBjMh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nB1PBjMh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h959r0vMlz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 18:30:07 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7m2qu3634257;
	Wed, 29 Jul 2026 08:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xTBu9B
	rigc9zLFFlYjjFxdYBp1hDvcKvewvbs2NF9oQ=; b=nB1PBjMhNyeWKT0I3rEUtE
	Do3BIMwZh2ZwJRUtWEwZWMFnhtt30A+64RJEjHoGqn4ixdCukzDyVOgy1EBIq2TY
	C/6PFQO5JJtGrBluYdm/UZcay7d9QsgQ28iDlvBzZF2xeidmeEmLC1nNQbDc23gN
	WN7OZB88qxVElFHTDJsI/kJK/WA3gW28wK2cZFnMtQGOXgfQ8zDu6caaXP01vhnE
	mdRbHkzn1nnUiXZu1seh2xFte2+t4qHvvBWOLbzzGua/4K5M3a4XlCMuV0HMXxKu
	ZN2IuNvZdp/lwmnsC5zxgHtIScdxdmOx2NOnDHQ0xJvy7NH/CJ195uJe5k1oq0HQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd0ykf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:29:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T8QSHR019653;
	Wed, 29 Jul 2026 08:29:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y5k5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:29:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T8TqU230212496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 08:29:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65E5D2004B;
	Wed, 29 Jul 2026 08:29:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 308A820040;
	Wed, 29 Jul 2026 08:29:50 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 08:29:49 +0000 (GMT)
Message-ID: <dfb0705e5b3a7a3f2f06d842b68910e6eca742f9.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is
 lesser than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
Date: Wed, 29 Jul 2026 13:59:49 +0530
In-Reply-To: <93bd50eb-0205-4ed6-a3cb-a29bda61db3d@linux.ibm.com>
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
	 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
	 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
	 <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
	 <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
	 <7eb8ed5f-0652-4675-9369-913a17463093@linux.ibm.com>
	 <4e7bd9342efa0cbdd162445a994f73c9ad473645.camel@linux.ibm.com>
	 <93bd50eb-0205-4ed6-a3cb-a29bda61db3d@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1d0Vcxr9yfaewvsKtKNh2BqsgKPSssPk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2NyBTYWx0ZWRfX69DtPFzraI49
 eFQ1cyt4lO0aL8CGOOKjc3Fqe33TeiUJRqdEXOWxItAz7ZLZNWSN7ft+okmd2z1G1Wu0uSHjjDQ
 ewauO3mKHEgOZK1/PgIw6V9gx5OXjhg=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69ba05 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=rpqpEAD7TqKRoYK_KpsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2NyBTYWx0ZWRfX5DxMEKmnpeU4
 I/1iZSLA9V0z16VQB7keOUa6Vj3K1kxbcyWUpMPkLlgvZFTmno/naeUtI0UJeXNYZGruC+zbxhf
 S7T4yBqYbHepAcG4SpYICpND/NbxhOoum1ovMyngKAsucE5v58etDWF8jSs7EcPttOBr8N/+o34
 bzQZ7xCbp9qUc0i8hZM6mbeUg8Bsqq8S0FRwJUFfv5HnnEIzso55vmMicURp/K9DJJiPJvRJEjI
 juM6+MlISQue1+BABnS/wi0KzPmbiO6/ZQx0C3nqoz/nQ4tyEBfaxq9o2F6hZcYWJyFxS0KLL4Z
 ynmUxtxs8ZLMr8zlFkSOSTztSAcQFr84D7484QJMOUUC6O8V7GB7qrVvrgrLhXdhZwPZv83OLv6
 mOa4uMf7uXliVe5r5Xt5SQUDEeV6ECB43kGvsF2aD3pozdRwZPqZCxr4BjSWdmLlTVtWwKxV9ju
 xZ7ao0xbmya94iQh8sw==
X-Proofpoint-GUID: qga9K5d7LE2WnBUUIQ7B1ZmnhjZgUc_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290067

On Wed, 2026-07-29 at 13:43 +0530, Sourabh Jain wrote:
> > > But the firmware not copying the entire Real Mode memory is also
> > > a
> > > problem for
> > > the kernel, isn't it?
> > >=20
> > I think it should be fine. Firmware will report it status flags,
> > right?
>=20
> I don't know. Does PAPR says anything about the error code
> corresponds
> to when memory to not copied completely?

As much as i could search, I didn't see this case metioned there. I
think if, fw is failing to copy full content it should report one of
the below errors.

- copy from [x...x+size] to [y...y+size].=20
- x + x_i is not valid=20
  - leads to invalid source address.
- y + y+i is not valid
  - leads to invalid dest address.


But anyways, As the source/proper description is not available, we
can't prove much here. Would it be appropriate, if I just make this
case for CPU_DATA area?

~Shivang.

