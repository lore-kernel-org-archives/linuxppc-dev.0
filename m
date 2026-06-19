Return-Path: <linuxppc-dev+bounces-22828-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FA9CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 21:59:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2T00Hhz3bqh;
	Sat, 20 Jun 2026 07:59:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906384;
	cv=none; b=SHDIFIzVgHWPUBItIJpnh18iTKBXAr+3eV+u20eqHj/pIISj3lNlNNm/1aLKtzN7OH3nkIE1Jz6qoqAsD4SLAZKLE/FQT348qhSUr0zpvVeBZtwDUf0iCQo1zGYit9vt7yzRn1g1rRem+nBStbgwQc2gWIH7eUsOvZTgMI56sHZAf3jUMGu+LCa7hkqlucXBvNp9+PvKxtH2+XGUniyhGGh4TMDDrz+//LAFz7Mm5CZ8Vj10NXqbCKDeUqSreTMXvTZpprA3PNX6tawRPcNqzuJJZiUQp7Y+Fs3XCBByh9hvKlmClQhANPlZQ9bRGBrQuTug35ztuknuX84nfwOmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906384; c=relaxed/relaxed;
	bh=XgKLcl5VMFj4tw8BudfH0wced8+o/VKkPWvAoStSZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSIv2WmiVM1uGEGE66nic9UsfoB96hlDMhcI+DqSxXRCjXITYgSjnMSFkbtDaDCcdqIR0xgrrhSYkh2C6DWc7PtUu7uMUHHanxL1Ma4CxQMZBseshe/mjXFhX+PN2r5D2LKF3S3HMc7Dr+wsh7HOX/JITKPUYqHHqOL0qiHfZjYQNQbgmC6vB+FNzxVNaT3WcJFrWo090HyNA1E9DwmUiu5kgN4qy+SLEDY+98ip02IpTuTvSuYgu8yQoH5zjp6S5IVW6j6UQ6Qqm41wJHwE/zAt5O9YXl1IcHn7vSEGEp1qJMg0IwNK+btc+fDDBP4ZKYbn6Kp54oBfGCz1EVTAIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fxaBbMA/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fxaBbMA/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2R5Tggz3bqD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 07:59:43 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmIAj3609785;
	Fri, 19 Jun 2026 21:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XgKLcl
	5VMFj4tw8BudfH0wced8+o/VKkPWvAoStSZNc=; b=fxaBbMA/bqyWj5v7mcmhMV
	3bB+ZJSoiIydIbmKTmtahXOWXqO8INyDthcE/QpUoidgsMgVbMEkkoiWBTK2Rv/w
	CQHOZ/lotOcsF4EM0ZaWv3nNs7vI32tDY4PS57fgLwCx++fpw0SOetuwk/m1GMkP
	/odpERMLSFbpAY9PTLM2FZein2SNgf2zRt4e6juGyPFsvCnhpbNU+9kRwATOggRg
	YhIYu7iOQGdgV0W5u5gypK8R0oezszvMk/ia78SgZhFF6gSsYMzSpgyhDaDgiLVL
	BnSZUTpJHrXqaks/ZDaBx4Arxm0hwDSAkFsaovvap8hHisjih09GAvx752j4C9Pg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequfrd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLndrk011381;
	Fri, 19 Jun 2026 21:59:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172arsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxSZ549152338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D77820043;
	Fri, 19 Jun 2026 21:59:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A7720040;
	Fri, 19 Jun 2026 21:59:26 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:26 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] powerpc: fix preempt_count imbalances in perf and kexec paths
Date: Sat, 20 Jun 2026 03:29:08 +0530
Message-ID: <178190618809.653308.7398309926910414335.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082912.305100-1-aboorvad@linux.ibm.com>
References: <20260605082912.305100-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX+nO9FMZIVyVj
 ji7tdP7mfFZI2HgEX0VSpq+g1vpcnJOTUxO+FnknGuOAfQ5zLXaVncCb/YmL+7Q8gWF9Q3nicd8
 fCZ741Ahwn3cPQYRO0V0LeK8HqyV7+I=
X-Proofpoint-ORIG-GUID: RW_XK1qNgOxXlhzzUGRG2X2qGWbLrSFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX4PCyX69o8JxV
 LBRMT46QdXS9feq+9W1UNsRrJZsu4eo6IXiY0FIiWyupf9yPa3mwJ/d0oVPdF+TKptqGQcWqHuM
 D3YgWCPOB1ZgxPtAu9UmgvwWSj30VPlbppxhHKC3bv8i5i5MWCGgL7cJve90/vz+AopkilMqbXI
 qIrYQClHdEZRXQdgoWgh4rMbNF5j4j6VT7W+LXeV/YT8YOw/hEgk3fhxy7xbxQqomeq/5Sv+w/c
 2s7lk4Y/L+eMgJmTsKSG73i3mN2rt5tgTatOGnQHalYfpFNjlkhtv3QB9lz7XttGpxcbdqVbbwv
 3AHbnusF9IqbhjVKilKh60II0YYDGe1tcKpex8XlmgfjP/Dl8K0Qzkg+Sn2FBThnSBs0LaYSjIJ
 /+7wJfICfSpqF5G/m4kLqt+JF0jqZSBMe/0luJ8Fd4QBl1zMrfVFBRuesdG70fPBZ8ZLDD2XCuS
 y/+SfsfADMR8s+42vag==
X-Proofpoint-GUID: eDtnBeLAUuaK7w_cxlaZkX52WHwmxwDJ
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a35bbc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=ZoOJJehYrJv9vKhu22gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Fri, 05 Jun 2026 13:59:09 +0530, Aboorva Devarajan wrote:
> This patch series fixes some minor preempt_count bookkeeping issues in
> arch/powerpc/ found during a preemption leak audit prompted by the
> lazy/full preemption model changes. These are get_cpu/put_cpu and
> get_cpu_var/put_cpu_var pairing errors that leave preempt_count
> incorrectly elevated or underflowed.
> 
> v2 -> v3:
>  - Patches 2 and 3: use raw_smp_processor_id() instead of
>    smp_processor_id(). Both paths run with interrupts
>    disabled, so the plain accessor is sufficient.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
      https://git.kernel.org/powerpc/c/81e3a86030462824a67d697739cf3f387f4ba350
[2/3] powerpc/powernv: fix preempt count leak in pnv_kexec_wait_secondaries_down
      https://git.kernel.org/powerpc/c/0ecd26e93e698c8327521910fc6296f5b84a4b92
[3/3] powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus
      https://git.kernel.org/powerpc/c/5c86f1c1f972761a04bf22f4c0618d1aa714185b

cheers

