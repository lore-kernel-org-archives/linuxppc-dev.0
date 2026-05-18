Return-Path: <linuxppc-dev+bounces-21076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C5CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJr6h071Lz3bqq;
	Mon, 18 May 2026 18:09:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779091739;
	cv=none; b=n3HMUXJ3G8Qcs8rFkmqezB3OvIpX+FpmQCB/AmdQe9j1A3iudeayqYPb2U5aozgSmlRRUcaPg853jAin2gAiOWR080gF4MY8VwzoxfHdcePPuv3TLFpDoi3UknMKA0GvXrm552LqxApHBU6urxUaf/8v2o39t5YH0KjPoL+hR27rg5knsnneas7g7RscEfpAn0efPYhKJzPjopuSxEnAdH3eD6pFELYq47lB5NmlgNmAIZ6n01AMVqZwkcy2dsjDt7xHZMEOPEYk+lOda9bIHPEBAsaynTm7A33Todwj5ETHPUpfL+FlFWD2///kSXtI3mbAr2K/vF9L/qKhzv4j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779091739; c=relaxed/relaxed;
	bh=bNyeh8mq/gpwIs4XKZJHzd3rt23GQ+A4b2deit6agps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1nsNiGr9yjNAHvBQFatZzJHEljShGWXcP5GcWmbNS4bVqvIObMG1j8TeJx6rWT6Y8Sn34Xs9eACuzRGpDXPLUExZ8+9//7QWy9Ko6KxYms8AJmsu5WvSU+QNbPCwSEHv+E9j2pcP731QBKhb+ZfDqiSWhWiGW3o8ihD1ATSBTCt4DaFJxJthPI+g4msaBpfqOOAGnMkVF50x5ApSKVjjrW+TN5zSmaPbTH0D/wVCiaqZaBlcSjuNvjaL6jb8Ov6PF4ZI8fzyfOj5O/h5X0iRxM32hXirRFrY6tV4/CM18EIv8vtsVgQxGL3HHyvhGirIKcfZXakixBK7lA31s8NxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JBbRyKbc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JBbRyKbc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJr6g1p56z2yF7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:08:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HDsRbg733638;
	Mon, 18 May 2026 08:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bNyeh8
	mq/gpwIs4XKZJHzd3rt23GQ+A4b2deit6agps=; b=JBbRyKbcoys4Kv6/WontCS
	qRtjvsnQk/UmtMoEKLxiBHftLGac4/WQMIfiPbmRaG/ftGOQ3M3OKnunmPhrqgk9
	pTs8vsYH4B/yAFrt0dMDZQkaqF6kQ2YRIgH0Hy9iv8c1SHikVCSGQMh4OF+3XZm/
	biLfeCF2QZB73mJDNz1mA79JUwpV9J+MoA2mcH71q846dtTbVYRh62KV1NzG67L+
	L/XxsL+BA+7ivl3T2BDRhfvjtkvNV9yl6J7gic58iK34pcQKEizz0MNshWrVnBU/
	xx7EpTndB2tC/1qJftcro7v2EP1ze+fqinmF/WTycNV5mXx3FSkxWiirnYXuh1yg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb86hh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 08:08:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I7d6Bl018884;
	Mon, 18 May 2026 08:08:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjvwy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 08:08:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I88oLF47448476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 08:08:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1866E20043;
	Mon, 18 May 2026 08:08:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A5120040;
	Mon, 18 May 2026 08:08:48 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 08:08:48 +0000 (GMT)
Message-ID: <0c6d2855-61df-4fd2-bede-0c204f4fd2b1@linux.ibm.com>
Date: Mon, 18 May 2026 13:38:33 +0530
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
Subject: Re: [PATCH 0/3] powerpc: fix preempt_count imbalances in perf and
 kexec paths
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NyBTYWx0ZWRfX6UdJrj9VYHY8
 gfvU4X9yCmo0C73pXUsfo3Gm7F/y5O2hnnaFz87x2ZP/5UKzt44LI/mHxIKOo4LZmorShvGaLhm
 VyntXw2plOkIs8UDJFurTfgMgKVlFHqnrq/pt8/Ixdx1wk++Z1s+jM4v0jTqxha9VTYeelbhUh9
 4ALUu0hnrq146Dmx22ODuUKql3nuXE+KSto6knZYJQATOK1gb+aDwUrSHE+NKsaIMw42g7qpXMU
 c36kmpB8Bsq4+RUsLnd70fFO3bou05fxm3HCfsL3lkO6KfkmMVgQpLUuqKo9lHRk9jIrizFMepy
 NyO5/uEHzjFhXbIk7FY/kGwWa/jO1FcX44ORdqbbtFFnroPgkawSPbeigzWkEB93y8ClEUM5THm
 n7WCwXytsqUaEuqwncT5kKSYEABsYQnNCvlqMnYuknR7wHN1+c787jSSWQ3gxojADG7XnvQ3vBw
 0CytiuhQSqxjmlFxT2A==
X-Proofpoint-GUID: XgjLBzZJ9ym1LC6G4bg5mxyPOFdSUTys
X-Proofpoint-ORIG-GUID: nc6fjzRy3tsoti0Ti6ROiiorrgPE5ScS
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ac916 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Od8FwbK5lA2R0pW_jqYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180077

Hi Aboorva,

On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> Hi all,
> 
> This patch series fixes some minor preempt_count bookkeeping issues in
> arch/powerpc/ found during a preemption leak audit prompted by the
> lazy/full preemption model changes. These are get_cpu/put_cpu and
> get_cpu_var/put_cpu_var pairing errors that leave preempt_count
> incorrectly elevated or underflowed.
> 

Thanks for fixing some of these.

while we do this, Can you fix these mismatch in preempt disable/enable in
below files as well.

1. kernel/kprobes.c - kprobe_handler - Does disable, but doesn't enable in some return paths.
    A definite leak.

2. Maybe platforms/pseries/lpar.c and platforms/powernv/opal-tracepoints.c.
    In __trace_hcall_entry/exit.  It maybe a very corner case,
    I don't see a big concern there. But it may be remotely possible.
    Need to evaluate whether it should be fixed or not.

