Return-Path: <linuxppc-dev+bounces-22184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6F3CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 10:00:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYnbD4ZK3z2xWP;
	Mon, 08 Jun 2026 20:00:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780912808;
	cv=none; b=nGeMRcT8S5LSddDeruG6i7glXIbl1X6rp7yVwI3grNJRXkf0dizrQ2gyrAmpP22pPI2A26T0VnQbJFK5O5/Fa+vxtLSvmqlqmT5rj5AxDW9YWLjoHhBdtWn6SYQAbI9lFNvVQgMvgWfzdX/C/0tsF9xhF+y+NFp2pBPsGKRSdwc6nQla5cEOmTdzdAA8ikkJTlYrvI9Yo4VWkcWwhND6CGf/D3c8RnfZ/fwzlfyrqCv1Rgx9jAE6zFPZNNbNbY6LgNkC8JdXZhyAzYE/LwHchnOnNuMs58KX8CeJlNhd7dOE988fJiK+/h3JYLeKECQu9RNIUi4WuXNg1En09EcQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780912808; c=relaxed/relaxed;
	bh=65j6K3TwLBQrNRKhondLRsIzcSz2RghwB/4ES/qifHs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NhB+u8GXJeYIpj04WIBIbokuOcnu08ZVbbbnqIofqyZfnelcGG9DKha9boMKPYkV+SpOFdPmkDQew6UlvbUBZ0RFCI3Zjd82DEwyi5xpNXDEIG03n3q0LHaopSAXuOqZfm5vicRR/BEDThR/S2eRuF8VQ85i9YXJu1UAfk1ijAbjAMMemwjhShDhfaVUUEJDg4ayy2HoFX09fsLVVi6sfSMRogQQBhBVNeJA4a1axCTHvGA/yJxBSoW0/SaNGTUA2fPZGD1JKmsZJNsJYtkAPZpjb2RhndJfNvdv+fvlZMw40CriVhj2cPzrRo5NRu1qcQ3txhT/Ri+3J02x47eYVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UV5EEmLM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UV5EEmLM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYnbC14Swz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 20:00:06 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6589JnGc2817660;
	Mon, 8 Jun 2026 10:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=65j6K3TwLBQrNRKhondLRsIzcSz2
	RghwB/4ES/qifHs=; b=UV5EEmLMDZHqmVT5rQDQxkhbNcFX77CbFN73v9mxnO/1
	DtzDJlfofNoiZyIIwbLymoAy7mhzJQPutxptqfjwUCPH2XOsfnDDv7AOR6+htIad
	Pnm9DPspSzefLg1+K7Jwnz07Shb+h3ddVc4bd/eMQbypjn0frh7vhc0jq4LknXAb
	hKjPXDvLy7NBkG2eoTQHzASRSJ///hCJscoxFgns0XVIXZeG5zL9GvyFXzswKwj8
	9m1wFt/ipiJoz5aacMY406rMi5vGREE4RQGrWlwx2vhnXcVPms2/hpRf3gg7oynH
	a+sIOh1D9fAAn5pSaDEnlCuMjUA6h5c2zeT8SRAbxA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23pq1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 10:00:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589ndU1010122;
	Mon, 8 Jun 2026 10:00:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vvv9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 10:00:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658A02eu61473074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 10:00:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C31F258068;
	Mon,  8 Jun 2026 10:00:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D455806D;
	Mon,  8 Jun 2026 10:00:01 +0000 (GMT)
Received: from [9.123.9.7] (unknown [9.123.9.7])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 10:00:01 +0000 (GMT)
Message-ID: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Date: Mon, 8 Jun 2026 15:30:00 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org, venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
Subject: [BUG] kernel BUG in team driver: buffer overflow in team_add_slave()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2692a4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=qBxafnndnmzGIJbaEr4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EeGipkoIuz3k5KIeLN3h9n4452L9zIqE
X-Proofpoint-GUID: EeGipkoIuz3k5KIeLN3h9n4452L9zIqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4OSBTYWx0ZWRfX0ddjqY7emiR9
 DZZvPaoV2dNPCtRetacd+xFFzYlp9m9rnMcyx/VN1m3NCQl/1Zrd7KL1g6uSwpJ21F6ZtP/8KDS
 +qOwCC8mCzF6eFgD0FQiuLDqvGu9z9pPZsp21H2MeYORSRjsbHHZFQnpEBBeht39wuDiIbM0vfM
 RrbHxa6mMn8KzpYem4GLTq/+DCWlzrpT72sea+XbZXdB9Z0lZRti16FF0GaxfIRsBd8333qsgFr
 qhS/i8TEaNFfGAUcSkOfgaW5ILdBWS9GjkRrdo+Uc3uoeYqRFFHMjHK86GCRAuz9BwDwOrJoaDF
 RDQfq3WEhAJp00LNaAWc6CcE3VLwQG8+qfnTtmvet/ainqvzSnmxgi+kbmBsMYVBZSJAK6KRYEt
 lvBx/t30de8nQ/oI/4Goi6SJYo9NgP8FOUQ0UaQ4MKNq+IpYbsDPM1chgpeI1UQAlYBoPKyWSfd
 VJ/2v2sxlcGsONNJKvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080089

Hi Team ,

I encountered a kernel crash while running selftests on kernel 7.1.0-rc6
on a POWER10 system. The crash occurs when adding a slave device to a
team interface, triggered by FORTIFY_SOURCE detecting a buffer overflow.

**System Information:**
- Kernel: 7.1.0-rc6-160099.42-default+ (commit d548c6f4301b)
- Architecture: powerpc64le (ppc64le)
- Hardware: IBM POWER10 (9043-MRX), pSeries
- Config: CONFIG_FORTIFY_SOURCE=y

**Crash Location:**

[ 3492.897824][T77143] kernel BUG at lib/string_helpers.c:1044!
[ 3492.898057][T77143] NIP [c000000000ac1120] __fortify_panic+0x18/0x28
[ 3492.898096][T77143] [c00000000efdb350] [c00800000b857a18] 
team_add_slave+0xc60/0xcc0 [team]


**Call Trace:**

__fortify_panic+0x18/0x28
team_add_slave+0xc60/0xcc0 [team]
do_set_master+0x19c/0x240
do_setlink.isra.0+0x388/0x1450
rtnl_newlink+0xac8/0x1030
rtnetlink_rcv_msg+0x450/0x530
netlink_rcv_skb+0x74/0x1b0
rtnetlink_rcv+0x24/0x40
netlink_unicast+0x2e0/0x430
netlink_sendmsg+0x210/0x580
____sys_sendmsg+0x30c/0x470
___sys_sendmsg+0x94/0xf0
__sys_sendmsg+0x84/0x100
system_call_exception+0x154/0x2b0

**Reproducer:**
The crash is 100% reproducible via selftests:
```bash
cd tools/testing/selftests
make -C drivers/net/team run_tests

Please add below reported-by tag:
yeswanth <yeswanth@linux.ibm.com>


Thanks,
Yeswanth Krishna


