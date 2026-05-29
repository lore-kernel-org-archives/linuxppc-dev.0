Return-Path: <linuxppc-dev+bounces-21721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D2CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 13:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRl4g0tQDz2ySg;
	Fri, 29 May 2026 23:46:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780062371;
	cv=none; b=GsXoclhT9s61G1U/nkBwhbGbaffr2a13ll4wI9AxUXZt+6HVr2+NgwPmQ0NDd6gyaU6DrKNJ1kFdzB2FKhxRQauXsi5PATrmxtLzI87EKWSuHNr57aUYP0hwhf3+ym2uKQhHDrRgYhScmh3lcWwKEXx9T8hln37Lv7SLyrRDnFq62p74N/mNQSG1pY4EJNWVyyG9gb3n11midjNM3th0TpVLUtr0IDM6urYViFUe7AolequmhHdtnZCkjogDQ79WfjdDsfozTC4u/LRrznro4q1+sgF9qD0K/eNzrpd27+u36JxpmOF2AjTDD8PwFN6RzCg177lDlXvCNIrRFm3Grw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780062371; c=relaxed/relaxed;
	bh=lT2nvVWAW+jmcHfLSb8VHUm48u54E9R6pcLe+cKiLpM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XWVCM5TyNh9n5QIw4fKMCgnxHMYQg4CPp7Ul6vpdf2AFeQe3nBAxlf9DKCoNj1lmAf8o/VprZUqmWk3r0RXrlnqvjNbqf8ssEQBe1mD/QtUTnfrcUH9OyLwd80AdlTQ2Rq8qwnnUI/7WyJhM9fMtuw2TKoJmoCJnNi3nfPOG9BKxDrhZXR28CwkLS2+hQPotXBUDEA81swZ3xA1JxcGI6Zacen981gR8ZDeZqVnhgCt5o126uNu4nSK3Ru+WCqJOSqgELHM9FSeo+1yRFUmx+qUZ8xWBvheBvJ9obMZK5yJZPhmX1+gv4n8Vu+bT5KJIbkJCLPE5n6VbKWLThU7FuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gnSJsILr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gnSJsILr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRl4d6Y4lz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 23:46:09 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TArrCt1467901;
	Fri, 29 May 2026 13:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=lT2nvVWAW+jmcHfLSb8VHUm48u54
	E9R6pcLe+cKiLpM=; b=gnSJsILrbaUM37+CbU4zl3Ik/2dTHQR7sd2nA+g13MHx
	fiC4RHJg4TLfW4kOdozxPIveJXBABOxlbrzxMOR6CJNIut4qytCONL2sjDLX8u+m
	zlKuWQmyaTELgietBveC19g/Yxb3f+Q1TT7oYZz89EUPX1h7uU70aB93Cg/pbzOf
	ROYo8XUNjxQ6FGCNXcrd6WcNAMqJAeUJubEBTNjP61XNeK47X+CXxShUgV0uJUAd
	TH7JGB6XtGbO0xZ161jaJlyFX43QWl6io3ry5JouJTnX0gWIZ1bhiSBqEaGe5xpO
	JfrZD1q77wxatsv58ZU2RrSI7QiygwLWvLawC8CngA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886gxtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:46:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDd5d6008963;
	Fri, 29 May 2026 13:46:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdsqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:46:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDk4Ug22872786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:46:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E024A58050;
	Fri, 29 May 2026 13:46:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B002A58054;
	Fri, 29 May 2026 13:46:00 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 13:46:00 +0000 (GMT)
Message-ID: <b18f42aa-9182-4bcd-8b98-6255dadf7d5a@linux.ibm.com>
Date: Fri, 29 May 2026 19:15:58 +0530
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
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]selftests/bpf: task_local_data_race test crashes on PowerPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2nNU6B8nMxCW5yvfKlamJx6nrcfu_BG
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19989e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wbOSOQyIEbtBsbREJHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNiBTYWx0ZWRfX0jktDWc09TsF
 UoJx4pS8NgU9G4iRzZk8Bvyecxg4cq28mGtovWgSlCxBXSbzSiqdI6wHo8EDWxWwiB7wY4xyfRu
 Swupn8VC9KvZUtd5CEjLfWAwV9yzRmMR2Cpvu4a+GMiaTRnbpZDMK2CFDfKzA9rzGRmGgf/1tQt
 WkZZ+psK/+yoeyg5OPPobzzsaAvoqTzpW5/TeSmnvIJ2fz9GGgYEDb4nr1AwdjRH87posms2+iE
 Fy5gkG0PhdIW3YAmEpaE0o07+dK1FZsjtIFaBocIu/DwMXI17eMpb4n1Ni0bmN+OdfXFnmtBmxR
 RSH8UdiHRZFTWWUqBmz0nHf5feflsw4cFl1SN5FwoiYos9kBeoClinik+HPqmsLKIShPXWUltRh
 bUTjGtykEeVlEbvID4obqvwTIiFGWZpmysQ7GwINecChZNaAGM4AUFzUjSA3ZBbia63PBTY34f8
 2BnW+ei0bLTAdUbVwPw==
X-Proofpoint-ORIG-GUID: B2nNU6B8nMxCW5yvfKlamJx6nrcfu_BG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290136

Greetings!!!

The task_local_data_race selftest crashes with segfault on PowerPC 64-bit.

**Test Failure:**

#466/2   task_local_data/task_local_data_race:FAIL
Caught signal #11!
Segmentation fault (core dumped)


**Architecture:** PowerPC 64-bit (ppc64le)
**Kernel:** 7.1.0-rc5-00149-g8fde5d1d47f6


libbpf: map 'test_tas.bss': created successfully, fd=7
test_task_local_data_race:PASS:skel_open_and_load 0 nsec
test_task_local_data_race:PASS:calloc tld_keys 0 nsec
test_task_local_data_race:PASS:TLD_DEFINE_KEY 0 nsec
test_task_local_data_race:FAIL:273
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x34) [0x106b5874]
linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0) [0x7fffa4660474]
./test_progs() [0x105bed50]
./test_progs(test_task_local_data+0x64) [0x105c0094]
./test_progs() [0x106b6064]
./test_progs(main+0x7ac) [0x106b82ac]
/lib64/libc.so.6(+0x2b224) [0x7fffa3cfb224]
/lib64/libc.so.6(__libc_start_main+0x1bc) [0x7fffa3cfb47c]
Segmentation fault (core dumped)


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



