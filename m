Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E3606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GgHx3DNi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVP85VN4z2ySC;
	Tue, 27 Oct 2026 23:37:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104620;
	cv=none; b=cWTODQfx/C7f4yDfY3NkCa+cU2Q3SAcwnKqdJZJPviDxP/fvStkvkO6dlqj2ePeNTwmXakOmE5bYTHstiE6t+LObs8m7yZwbqtCJiPeRwmwjRh0jPIyNxM4vWQNqMy6bzjM+yvhpf/Sj4GdSO86dL2Uecjv9gc/MS+N/+87s+eI2KiR58f/692YJWJar/ckbYeHKLSCnZcY8oIoUulIC43JUezFFiCiv/aeRrrrRcXxlMpfpsj7238tgaveXNLWzqXXfPvQ9zG9Wvf9u82jpKd0YH84mtGiVUoJJygUWo2JzDoDBMWN89jEgUSafPyaDCm4xi6ipZ7Cmpt1Bpn18og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104620; c=relaxed/relaxed;
	bh=gAUuhtdA5WV/bRzLwbiy3hGt9hgQIFf9+QgGnDmBpGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9N3jKeAF3jTQQm8UDtiOrKnS576BtrIElCfZZgoxODg0/xt+iyE12EtAfMwI6yKVRsN0fDENw/zbHkJa9te+7cAWM3l8Ekkbe5eX2b5zdu1NuzOqBY700lTT7EYWToZA29XATWc7QHtBC7+qTJvj/nZmEnwTKREIG/QL6mCQKoeY0cbsjINZNRoyaactAuB7ZkkeizUk/o0qcFl2CLoKtfdoSK7N6TApnwWc6d5RPCari5ioJCmTZ7HoEjojWdUeHoHbk/LJUjY9Eqxw5dZ/PaAD8FbYjMhVskElD60DSbqvoorqorP0viUizSvObE71ODPMS78bvIJhgXpsZIR+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GgHx3DNi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GgHx3DNi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVP758sFz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:36:58 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5iM511504078;
	Tue, 27 Oct 2026 12:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gAUuht
	dA5WV/bRzLwbiy3hGt9hgQIFf9+QgGnDmBpGo=; b=GgHx3DNiVhwmZX1lqtX3wV
	X3WAIjAqX8EvvefNqVMgUpX9pQU1l4AdYh82OeDsRT3H/dg9WJD1GIt6jo6JyR4K
	EoySi4OVgwYc1zk4d9VIgPBgpmn0yxKYQ1OctDPQw93wH3KjgVq7XH2FdOgbAH2l
	AeZygedYwmqkuNeqVjGaqc+6gmmT+exdrnGNgg/04JjqwbukNxROvZIZGdGuKzvS
	BZQm6k9YNK9pFFXg406xQKGC1l48ujO7xqWQPwe9Cv5OS2vkoLPWpgtpJ7whwSC6
	xqKmaBmwX76VnYSQyridC8n4CHyiR9wto3M7d8ziXfezNiJNZn6Ej8x14FShdXjg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6yabq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 12:35:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAvUkK3997011;
	Tue, 27 Oct 2026 12:35:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn8aaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 12:35:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RCZQdi4719182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 12:35:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B24658063;
	Tue, 27 Oct 2026 12:35:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4D1358059;
	Tue, 27 Oct 2026 12:35:20 +0000 (GMT)
Received: from [9.43.47.205] (unknown [9.43.47.205])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 12:35:20 +0000 (GMT)
Message-ID: <96fdef03-624d-4de0-bfa8-12bdb552272d@linux.ibm.com>
Date: Tue, 27 Oct 2026 18:05:19 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/syscall: Return the preset value of skipped
 syscalls
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Davide Berardi
 <berardi.dav@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V . Levin" <ldv@strace.io>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20261018151539.440213-1-renzo@cs.unibo.it>
 <49f43f66-f516-413a-9842-bf6d8cef5fb1@linux.ibm.com>
 <atujOWJNfMZPVD0q@cs.unibo.it>
Content-Language: en-US
From: samir <samir@linux.ibm.com>
In-Reply-To: <atujOWJNfMZPVD0q@cs.unibo.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae09a91 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pO4xbdBIu-7luVm97lQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX3e/j/RJ72D6e
 ICIMLag0VlEE07E3h8HqvlUK5nwLt6zGOkY2L9Sz5qxZYUjeDaHhxN1H/jhscYnz+56c+n5rxNc
 MO+ZKpdv2Eqe/rbYGrAO7dFjJh4OTwkzJJuxDHE+U3jyIAAbTS5i/Eu9+r3L6E7q9B20KldsfiP
 ZfDRTf4iBl40nfh1tQvvUxsRlC2mHvwSXdT7IcPuW39LrCpbSthv7jOPv1zAAl9QuvQmjEGKTWr
 TEF/Vay57MGHcuOYaRUBDC2YYYxOzjYBF37Z7PnDVM8zk1UGdeAN83gV6cst4LlXzWtrQMUB9Z4
 In+jqPWaQOIuBxU+TNdtHYK5RK7sJr0t3lDimX3z8doaYp1Y1fOIvvixI4WalVweZZ17MtPjprF
 EqTRIwRo7AYRFfy76kH3TmM/L3sjyixzr43FFTh9EDtresWn+kViJgexYvU8TeHqYDLNW9kZXM3
 bTO6BITaHUxE0JKeIWQ==
X-Proofpoint-GUID: LP9ey2gZsnnDQJUXCgdDxIxMMULFPPSm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX/G5ZWtzJzEH2
 /2v/wD7osR2b6E/NJJ0rbyDmfIoVz5qXOxdsoT2rn0Z21SBvvqWnI4VxL3A/ecZ0Vi3QwSSEXqG
 xIB5tJwGRsdXjUtw4ngzfAx+ueeGdM8=
X-Proofpoint-ORIG-GUID: KlFWnw3E6Eucx9uCCYMqsxIpT4C2fZbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270048
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23/10/26 11:41 pm, Renzo Davoli wrote:
> On Fri, Oct 23, 2026 at 02:28:09PM +0530, samir wrote:
>> Hi Renzo,
>>
>>
>> I tried applying the patches to the latest upstream kernel (master branch),
>> but the patch fails to apply with the following errors:
>>
>> error: patch failed: arch/powerpc/include/asm/syscall.h:98
>> error: arch/powerpc/include/asm/syscall.h: patch does not apply
>> error: patch failed: arch/powerpc/kernel/syscall.c:18
>> error: arch/powerpc/kernel/syscall.c: patch does not apply
>>
>> The latest commit on the master branch:
>> commit 734bef548a96e8774d6eef5dfa2026c6edc4e80b
>> (HEAD -> master, origin/master, origin/HEAD)
>>
>>
>> Could you please take a look and suggest how to resolve these conflicts?
>> Does the patch need to be rebased against the latest upstream kernel?
>>
>> Thanks for your help.
>>
>> Best regards,
>> Samir
> fixed in v2:
> https://lore.kernel.org/lkml/20261023180735.853655-1-renzo@cs.unibo.it/
>
> Best Regards,
> 		 renzo
Hi Renzo,

Thank you for sharing the v2 patch.
I was able to apply the patch cleanly on the latest kernel branch 
without any issues.

Thanks again!

Regards,
Samir

