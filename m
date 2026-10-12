Return-Path: <linuxppc-dev+bounces-29212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833F2CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 03:32:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j331H5JfYz30Vm;
	Mon, 12 Oct 2026 14:32:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791775923;
	cv=none; b=BcH+BcVZ2m/5/lrGbeHczQMGD53XRW35jf1TBs3Y0PjShA6qNsYhwRKmbUVH3HI4/Qr2+77hT2/PM05eNeDdWRB6vf4JHvYJHv9rPLhMK75fjBqSKIqa8jTdrVZZdteDLQYARjchArU4ya0wrfV32aN9H3cpwDUZCtwelSHDh+nkNDnHmnDhNJUox2XGkyeZi4GjznfnXF0HrA/X99W3jnog5jbzgGakhXOBLfVuMpPfmEeZa0eKoTBYYJ6KkbS2mxCpVoL+FrY2z+pRH+8f40FB+SUpUJYUjDom0cXk3vZGQrgWg0ctG3HmiEmFdjScxc7grR0kq6cO3F4+rXI+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791775923; c=relaxed/relaxed;
	bh=eYssi47o3dRCFN6DwHh9vsgDGnOp4ObALU4n2uIrXqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgBoxmx1lCEwoIvUz9G8sAy+KHrzC638lQn6/hevVDt3fxB6epQTlZ3ePgm8ecyIj0hzzdJm/+FlYaKU7Q6HyZNqYato7/Jswt4yRSQcihkux5MRz7HQeWHiqSqyVE6B9lHOUcRywXjl6oxQOnvFSD/TCmdiFiHZ1yp6G4IFLocyw/FaFlVRK9+ibb/QSQQDdM0WcLy39AZxxu1nB8CbL2rMATdGuDKBzcNxwiSaSarapJCRTCsuQhvfGRnVudGaxC14YXe0sxe41NY4MaFel6/c2urq4ZVOsBA5TOhDjBqXvldgIjjhDTAepwd0WxGQ5lYGCbEq0aw2qGR3asad/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gAUVJsGK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gAUVJsGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j331G6bBbz30VF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 14:32:02 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EF3s2912501;
	Mon, 12 Oct 2026 03:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eYssi4
	7o3dRCFN6DwHh9vsgDGnOp4ObALU4n2uIrXqM=; b=gAUVJsGKV6JZrvx2tLSGtQ
	R0xPWYYM4DOLMEUI2RQy+0/vEyFoG9ZIoiYC2GCEHQ+yWVN+2NnWWrQW9x9ZAmNq
	O8I989NDyWTN8qYM67gvn8bFL2VBJ9bici7a7WU+k3TZ3Lkw0qxIVZNkNnNRU5+X
	/3tMhUcrL44K3FzF+bkza/A/Q6/eDZtnrY+l5Q9mUZZ3h1WYdptOLeUldEBMd0GL
	tS2sFIG5hqI9KOHivQDyHhMXrGkLeJo3aqyK/GfTYW3wBo9orPrxpFjNS3fg97FG
	xACBEcDuVdZUQLtRcZLy5F5BK1CUwLDKfXieWVY7FcOrYXiJ9U9Wjz0FUtWuYv7w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpqhw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1o39n522192;
	Mon, 12 Oct 2026 03:31:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjkhx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3Vd4B13172992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A99B2004D;
	Mon, 12 Oct 2026 03:31:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 610C820043;
	Mon, 12 Oct 2026 03:31:36 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:36 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        mkchauras@linux.ibm.com, mkchauras@gmail.com, sshegde@linux.ibm.com,
        ruanjinjie@huawei.com, ritesh.list@gmail.com, riteshh@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard
Date: Mon, 12 Oct 2026 09:01:35 +0530
Message-ID: <179177344613.763259.8907823268058997618.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909123240.58786-1-venkat88@linux.ibm.com>
References: <20260909123240.58786-1-venkat88@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfXx3LoZ2aJ5fuA
 RaHneouVYRpsCPHruCD3FnUtGHVOG9EVeS9Ud73O6RiOo+DvVf2OvxCpfTD4PVjEveL+PNDbsv5
 d5xxLZEK5c9givPqRwIYxtuFnJ2lUpwwOGNyw5cbzlYw/s533fhSV9OaQgtcwJDQvfkvZ1WIut1
 KRD+wBwuuFJ64jVYt01sfb/dpZn2lsbQ6gL/bwYMXySj1GDWlOt0SJYnWAUz+6pX4jw8Jg5SN95
 85yR1gz3dzpgBkou/SBRaq/PuV52PhfCPPzQIR/z5uHlOHZxv0De3rTl6lHIwzDgz8NppvjjbzA
 FjsnfND8n/Xh+9jig33y5NWK73EtLD7z6LbhO9c4STzb2rO51R+oVlaTLL76I6kMoLlUxdnSar9
 PxbRffPefqm1irghEYweyfoP3Ei5fTt2Kcy2CqFLkutJPnWjELTUSNZQnKf1kbLpG9V+ZZs3ZK9
 zGwO16n0F92JCJyd80A==
X-Proofpoint-GUID: UdzcOa3WXOjTsV_8XjgcIc9nO9W3pqyM
X-Proofpoint-ORIG-GUID: C2FBzHm1Pgeb85kqjsyRY0WE0Wp_UqYy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX2v+5nitgl5BT
 rNxce+oqi4zMCiQZX0LnvYz2IqIe0wMMDRZsA9ZzbgTt9Gu0dWEacEiO3MBuoEIkM0l8FvkKmLN
 D1YfFUw2U0twwecRdFNXIH5t6JYEqmE=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc54a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=n4L4VzJl01lLlt-TqUAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120012

On Wed, 09 Sep 2026 18:02:40 +0530, Venkat Rao Bagalkote wrote:
> radix_enabled() uses a jump label which is only valid after
> setup_feature_keys() is called. Before that point, on a pSeries
> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
> cur_cpu_spec->mmu_features, but the jump label has not yet been patched,
> so radix_enabled() incorrectly returns true.
> 
> The dangerous usage window where it goes wrong in early_setup():
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard
      https://git.kernel.org/powerpc/c/644ffb02746690c0ebfe143e066f81c9bde2975e

cheers

