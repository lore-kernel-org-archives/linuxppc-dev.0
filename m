Return-Path: <linuxppc-dev+bounces-26451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E510AC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 17:48:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZqvN3T67z2xlv;
	Thu, 03 Sep 2026 03:48:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788371280;
	cv=none; b=ULyXvR9PY8KxOPJeGsrcn2XvvPWh0rC91Ql5inQHfk3ccZWfDr+g9p8+GortxJSYvEK2ee1U4iTLmGDGvKygCodkVeN/wVDYzrLqareSevuAYdTfIu2qE0XvgCpohof5aagnc3tkMwKBT0Pu7S+m2aZFcRKAnhgOFNbPyW5EwSg/heVvUX+baUwnXHKHd7udhwnCIBPFQSh+3C05lQczUQXnRgSgEuWjVPAd2sY1xz3JCJX6IXu8P8Ffc76cNbG4aALnDyHxPD4MWiDFAGKxEcoBcmSQEGYQ5QjR6OoIucEaWjFruhzIiSe3Vrrq+eIJUWaxeXOuiRiOzzG6Fn1zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788371280; c=relaxed/relaxed;
	bh=HGtwWmnQ6QwDDO+DyewXu4HaqP7hG4EurP/lr9Sz1eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbDR8uf76wPyNvb6rY8e40tX0QE0gG6ayzuGXy6lWNRF7tVQd050TtowXRMEpw/tEPY0N+WeNB4hTqxD9JROldG/LBDtVZIvT+suwIdABRFIZ5peb7pfwfU07FI1hGzypL7xY7Uw0ggF49JmUQ1VYy2dCuaOzZUjWBTXYID7xI7k8P9CKI2n6zFQkAFckkD4w4HqH36xW37vk67u6jf8rJ5Jgn6ZhqkKcxqzeiVW6DVcagysaxI3y4is8TyEE1HEBTXceuc/w8eD0u6Pfnm5JXSQDQAXjYWDVI1sBcp+ddIvKlzcfOr+cVYIRgqPa+s0wLNgQi8H2T/eY/m0HNVtyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pXJ51bzM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pXJ51bzM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZqvM4hVHz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 03:47:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HVaOG661164;
	Wed, 2 Sep 2026 17:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HGtwWmnQ6QwDDO+DyewXu4HaqP7hG4
	EurP/lr9Sz1eU=; b=pXJ51bzM+v6WL88TWOeaJMkj1nSVlEa101MtzmBfaTneIB
	B8Ry3a6/fLkuV4E44I15E99NZ7Pa9tYuPex+ARWyywvZOqrWeSatuJck2sLldGDL
	FLLdjhW/AuHBe0Ve2ovPjbT8LMAFqTWO4Le0cLKhTxShmhYzdqSqYtmt4pux+eFO
	c9w4YtdIqP5+FQfeWr7Ajw8Zf+lvioZBKEyx9S1AOdCdn/hbL0UvdFyi+VFbQCjl
	S5i7b/vmqjq1v/2/Nl7nA9W8gI2PxivpgFZabXZs5M0NRZjz2k2w7ONefhNdd1pe
	6iRKd/ARLvVl4+eg8FLJpTOEzDZEktygdnW35Fxg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5rd98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 17:47:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682HQpjI023346;
	Wed, 2 Sep 2026 17:47:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqkj7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 17:47:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682HlV6S44368140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 17:47:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07A752004E;
	Wed,  2 Sep 2026 17:47:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90FEC2004F;
	Wed,  2 Sep 2026 17:47:23 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.221.176])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Sep 2026 17:47:23 +0000 (GMT)
Date: Wed, 2 Sep 2026 23:17:20 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>,
        Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, loongarch@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/20] KVM: selftests: PPC pre-enabling
Message-ID: <aphhKDm7Vx7G5ivr@Gautams-MacBook-Pro.local>
References: <20260826230511.972824-1-seanjc@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a986138 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=6YN9JvpFNRzmbg3FydkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: tRZqKKrGtBjHG2Pu3xQZzuOyhRhv077A
X-Proofpoint-ORIG-GUID: pdLNL2iG2soKTiUHunO9uJiDJ8oxj9S6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1NCBTYWx0ZWRfX/3BQiO/4M77n
 AvjpUycO+mKHAdP0qa39OrRauYjGL+ZXs6GMp+BhV9vuxqhuESJqGvGyxDS/TncOIoaaNebyj2M
 Mh+XT8fPklmzmBP5n5N6hvz8btd17e0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1NCBTYWx0ZWRfX7sO1s5aw3bu7
 yGm8yQcHZ7WA2zwsrkIYdeZcloHnCw+pL5crxFHgEqUiWM+wUus/GNOQ/ZAwb6FjQLOncOp8A86
 94yCxLIuXJcEs1s8fHFlHIfo76aNyFoh4QlGJ0Mg/HjdkoTDg99uz3Cx41t/tSng59sXrFCxcMX
 9aSG+t+97OyBvbo2meC9X4F15bk3na1rQooBz40mnKd4Trt5E+kWB6Y4mk1lOazlBi5WcQ9xJda
 SX3oEaIKkegrcRVjJg9T55qxEXJTwuO+3co5WfoC4YNCD6rzXlwpMc5j+JSeRlWHRDM9Un/5kf9
 KZHm3YyKi0t11rguHeyczHDVWwZ1ehOeBVXz31LmkDWnFTcj2X+/2d5BWmQcgwNwjEJ/LAMcP6T
 1ZoI/atPvxfIYGWLuyusfsc18eNXNBHm5c/bJuaj5WtHgPMuR3aqb47eggYeMiaOlkvEFr8Yd4H
 SzqNL31hLQRftxAg6jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020154


+ linuxppc-dev

