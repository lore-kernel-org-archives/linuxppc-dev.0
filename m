Return-Path: <linuxppc-dev+bounces-27426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F74CC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:28:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkjWn4PxYz2ylm;
	Tue, 15 Sep 2026 23:28:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789478901;
	cv=none; b=lYNuRofQpV7TkxUqcRfuqHZ1tAXb2tTcSsWW8YLIzdvGiLYCntMs6aYtPukH4/Mesy8MP7UtW0L0YtzXNNelWE6EkNQFBLkM/n2KBz3gcJhSBlXHNP4wTPojgRhsYXPFfsmTuLDRR5mHiecmxuzWgfC/z+Z61pTPzg2s/SDvGR/hXRSgjKrHBHp78VPIx7VSfncniC0E5j1KLaJ8O/RCiRcD7zXp5V4p2TW5Yq6F6pKr/CIjqH9Fn1qE2jQ+XT51PS3MmF806PVQP57qZHhUjh0tPtsYUx1r5ueSqjXQy0YcHdnBtD6sYnJ1rPKm6qt/6caFyWDRGX0dquFYNbokNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789478901; c=relaxed/relaxed;
	bh=8oS9W40Kxi3jCDLjbplhmNHApFzpmxWBjEyHqggrd0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNxlogGybiFKnpqTAvYmOStLUAjpHeNEI2hSRX/BkX+nSiVLCiz62miURVsttT8IODpCJZA+8oZhnm9wsmzplzmhmgg9RBXSbuAClwnYRCBuoaBaJ8X5w3+VC5iE0xrVhlvPMTB1QxBmv7BajtFZEsepiVfvIuf74KqCiVrO5hED0Uo9QVehRK+aMPE6EI7oUs6Jt4lLWdD4V2MlctH/gcDRfdSiGQ/3FKMlRBls1ab5DSMnAYy3UQUjz9TmYKT85V9NKuitl+RkA3E0MWedEFarHRrDTJ0ngxxignDzLrTBRzXO3GXWHKbHvEAWJLRR7o4am8MdBIXlc+xWrLyx4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jnmr+6bd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jnmr+6bd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkjWm5J3sz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:28:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1cwV879799;
	Tue, 15 Sep 2026 13:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8oS9W40Kxi3jCDLjbplhmNHApFzpmx
	WBjEyHqggrd0A=; b=Jnmr+6bd5JlMLNu1gUkunm9XI3jex6vE/3DA/zjHS4Nlnd
	QQzW3P//6McQCzjWz959MU60PUorYfn3houYI4t3dMOJGjUIdsw2/AupgiWzOT0b
	D3La1ggZhB0CqFFBRjptRLE/q02J9reVfo7iZG84tIrp5z/jeK2icg5tkv5hCBlU
	BZt9REZHCEM0sz0OYEinvxGb7TP2FDV9fPXYwZmgkIy9jvoBWkCtCR63lGjvORPO
	CJoS4CIpkAzl4n6dnw8hCU/inXvRxtKRvSUIUQ032EWKBcRSHlA/5YeGAbpDhQB/
	JvYI07jM0enx7oBMLcaWb4NQYgUEByg3IfJmxlbw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83q97x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 13:28:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD56PQ739092;
	Tue, 15 Sep 2026 13:28:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d2364-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 13:28:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FDRusb42402280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 13:27:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CEA42005A;
	Tue, 15 Sep 2026 13:27:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C78632004B;
	Tue, 15 Sep 2026 13:27:52 +0000 (GMT)
Received: from dhcp-9-123-3-18.bl1-in.ibm.com (unknown [9.123.3.18])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Sep 2026 13:27:52 +0000 (GMT)
Date: Tue, 15 Sep 2026 18:57:49 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S HV: Fix comment naming a
 non-existent KVM_VCPU_RUN ioctl
Message-ID: <aqlH1QKaLP-4mNy3@dhcp-9-123-3-18.bl1-in.ibm.com>
References: <20260915084441.3846947-1-fuad.tabba@linux.dev>
 <20260915084441.3846947-4-fuad.tabba@linux.dev>
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
In-Reply-To: <20260915084441.3846947-4-fuad.tabba@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4OSBTYWx0ZWRfX/MU2l+5qWr4I
 vzvkD9PCj/CkBx1I7vx5Oj8Na5YrnftJRDDwyQrA52HalBXJX3nuUoaQl7EAYLK8nMjVCiRXnXa
 uB8FISwe7UlfD3H1tNLohmnrZNcMh0QfWR1VSPvhxPOwS0MPWpKFagUi9IZOzg8U2fxOlWTOtf0
 T+s9sKyF8sBKI0YIe3dq2UAPQhrNjtRZPqdxzNJaMLAlMgfPnvDIvaZhGE35CC5ALfkzPatiiPc
 wmxBNb54WGtlC+Ctdx7sqgqPGRMeUYN6Jlt0DR0bMCGuWlMok/cDDB9y3kvp6QRI4yG0QApwRia
 Di8DZfMBZjF1PSy1yU8Kst8nLkZKfgv2SZXKVxnT/QF8z7ib3htj6c7idmtUjSf3hOTusLaQG1S
 FLNE2joxenwVqHiB1Dl8InHzmlAJmAjY5wcReV4+TN+lp6q3MQsWCbzI6GMzYguMSo5MKHMhevh
 TyTndstMDaWOy8n+oTA==
X-Proofpoint-ORIG-GUID: _0Ubch5FA5CSZaCYcQERoegakgj3a6NK
X-Proofpoint-GUID: y3fBKQ0zr8qklAFyFjxogaJ2nr2fiwy2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4OSBTYWx0ZWRfX95G/Cj0NlyCS
 ZlbGyfEmhHWE1n0L9K/FzaFP+nlglsN69dqeW/TBgnO6H3BYUGlTOlEXApU7sfJlo0PRr9yldgM
 +7Rtl9HD+wH3+IaJ8lrzei531JaoVU0=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa947e1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=90UzZmcSQ78tuVnzBuAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150189

Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

