Return-Path: <linuxppc-dev+bounces-28119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA64C98317
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:28:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrF5G1zkMz2y24;
	Thu, 24 Sep 2026 23:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790256482;
	cv=none; b=aEs8GZeaw7vWLyUI6wzvYCoxDfXsHg9Id1hJ0CBbXuvP/TlFWMP12M0Ex1LabzjTCdJGxV+q+TKqR+Mi9MltKwwMmAKsV86kdokBtdpzOZIuTdLONNsvoTis7auMwD7eFZy231B6fLVCwN17T4FXczkntJfzLpTPrpm5S86I6R0MEGFdHGSKF4kgznenvrR7aEs9dl0/Cxig1QAEwotGbrzwc2Y7DmZNsk+cmWaBHeVmxBH7A2RLKE+7NijVfAGvlQcMRUlSHlFHXddKvrz4K216C1vb4WzrOJdWPqqmQ9ref5iSFTLcJqOC80EO6ZMXemIhabUPj6ZtgkTQrh9QPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790256482; c=relaxed/relaxed;
	bh=BfnfwvTZSN2vMKmxqDVgfqXHHNIIo/HpKAiQSBe05nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ke2w2h4Rgwzu4GAFMK/InuDWTYzSUeJbnGNF00PKE69Z5k/XWOb+Kqgni7eXgpJV6Js/lQKwQaFiPnSj4bxOYTob7bXFtJUUSqHbeEf6BXO0TXbnD11v6B/i8pL6JjmADpBogbNlvG5UJ7xc0eQ7mo/CAIRZYtbEbGT20Hp7SfiDddKzVuAUnalwIbw1SJ+CohtzORG167MA9ls0hpXXnhgK/B1U1mw+xm6DTWnWU/NT35CxoEI29A0sru2ohW84IT+IQ8NG5kuW7PGRjQcmi0O2rH/F4MoQSHFnFaCO4BBGxCsJjzKKuq7eLCGAZv+Q8qzFK0S33aWm6BQB54vAGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MtycB3ur; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MtycB3ur;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrF5F1H2Wz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:28:00 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC66xe1009280;
	Thu, 24 Sep 2026 13:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bfnfwv
	TZSN2vMKmxqDVgfqXHHNIIo/HpKAiQSBe05nA=; b=MtycB3ur6Bw8QP5j3zn7h/
	sh6H/HpGoRJFDckQ5zUAUUeHlKOgko41DKcyqKRSR+28rqwkb6SUkOJtGk1rDQ+4
	AKqEiJIpP9IIonKruatbeVmd9lRdca1J0g3PgU3T5L6m0MQvMo2IIXAQ59T5NhGO
	uRgS3ZVhf6mGKBJN5EHubZEd0zknRVjuZrIlQKfQyDYfbiF2oK/cXz0Ggs5AMhFr
	afwFIYVKJ++hSRMBTesBOG/KIqcYKJurz8RHxezTrkw3Aq7vL/Vnd5PZJxYugRxq
	4s2S+/uhyzerGlGY6MejfpfsWoqojRotaF+VhchTPwIQp54L7Jc7sNClvpSSLakw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqrjca-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 13:27:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OCHghB2046999;
	Thu, 24 Sep 2026 13:27:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1x11w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 13:27:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ODRipD43712898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 13:27:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E0A20043;
	Thu, 24 Sep 2026 13:27:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B0B20040;
	Thu, 24 Sep 2026 13:27:40 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.19.125])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 13:27:40 +0000 (GMT)
Message-ID: <8188cc84965a78e29192c0300c082948aee113c4.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ppc/fadump: collect dump when CPU_STATE_DATA is less
 than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Anushree Mathur <anushree.mathur2@ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: sourabhjain@linux.ibm.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Date: Thu, 24 Sep 2026 18:57:39 +0530
In-Reply-To: <bc0b1c90-aad9-4696-ac85-0bb4e44cc7ba@ibm.com>
References: <20260828094942.2439404-1-shivangu@linux.ibm.com>
	 <bc0b1c90-aad9-4696-ac85-0bb4e44cc7ba@ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab52555 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=35fBO9U-A5zGmmBXFhMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX9/+5fTEjH6Qp
 qfYIkleWg90lOjVM8tlZzlepj7MFFt2LitYQM9Cge9sAeytzW/2uU5hFxqcqRWc8R9ZLGXi9QwX
 YvoIaTurzeRfhY+AXIiz1USz35VLnfWYNJ3RU4jJGJLf/5Ki4iqgCMbUlVFU+xWcgQkQt5ZbDiW
 bIoihphS2gDbvYdZ6Hkuga0uSkIBP7+JSzqU3NkzEBiTGQcQRM/xh6sviWeM8a8TtNYCquKRbNK
 lMuSx/+4ZHGyEfNdYd3kw3v31uhPLDZT2jTwCNSR8BfVPn9+57Zwi0QYfb8o4NghgGC1zV8Qabi
 MB5q1r+PXPJXzl4qzZ6A3n7ktxtV3m8kW+4tyeqUmEbeQeVZ5FSKuBRLXnSOnjHyvy66XoBRfIk
 ztD3gCDiMABVByx2K8xIuQLqwEgd57BWhGc++bfR2NHIbYdbC7yoDHNKhvbRJL3NUyfCilLQ9Hg
 AGi6hvT39wGH6dJsKLg==
X-Proofpoint-ORIG-GUID: a6Bq218bhdWklooa02sfs9HuE_2XBIHt
X-Proofpoint-GUID: LFRTfjH8QwP-div_KvdFyNRmaZoq3rL4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX0pf+TpN+H4R3
 FiIydTQq/iL9sWTdUo+8JXVGSTYV7ly70Uq0vez0TQaJ3QR38AorG5O6u9h39+zW7VS9+sdA09e
 hHO96kn4xad2lc996C+YGgozLur58Rw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240054

On Wed, 2026-09-23 at 21:51 +0530, Anushree Mathur wrote:
> Please feel free to add:
>=20
> Tested-by: Anushree Mathur<anushree.mathur@linux.ibm.com>
> Thank you,
> Anushree Mathur

Thanks. As I need to send another version with minor changes, I'll keep
this tag.

~Shivang.

