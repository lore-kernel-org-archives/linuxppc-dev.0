Return-Path: <linuxppc-dev+bounces-20964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C70CD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 08:33:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH0p61v14z2yXj;
	Fri, 15 May 2026 18:33:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778833998;
	cv=none; b=kbkCG5J8hyT74KBIcLrWfIM7vi2uJzAeK5nx++T45StVKdk+ToKzpPjfJpQ4rGdVOkcVPQ3jwnEm9zGA1KkGfZmrdgzSWzm5lQCcQfV7yqXJQyqU/zLivgkSFAbwKKQ5SAqvwn5MR7ztQTgFx9MXT9wQ7Ez20ySZBP3rgWtaclMSFjSBhDEqT7L18pJlOHGpoR8QjLPpf8Id09NzvCFpPA+b1jniOc6Jgrp8CWFEsrPliH23BFT75zjuet8MJRkB8q7FbUin/Z+DtZqeL6xhfCR5rrf6+b86Lu6ATDFDWhe57hzCSvgVmfPpbEfqcWCN3vapbi1er8lCN1no05ae8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778833998; c=relaxed/relaxed;
	bh=TaDuseA/itOKlEBn4YEX/bd94cnHw2cIDKLG8NsxiA0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OsLRtb6DfpGLUhvvNNW3tHaRLMz5g+Qh6yOyNzFeh2ZVfbt6NOKA43ugGwvpjL5roNaEL9WM6ZVLTOdPAJ4ZJvM1fCjr3PAhbbhCPy5EgLuePobATHUEJIuo8V6JP3Q/wT0mxhY1/xjxq3cJoyTKeRz1NGtJhE7GBhIQyheEoPMu1+umkhskuxQ6uXLSwySNSKN71dPzb+C/t6vTDLM+u42PK5nSUre3iZIAShPVO7qdzXKCHaSk33JpaEZ8BhrRRBjr1VnjBAQrk7KXZ+xQBSd4lTJXgks01loKVXJl6RdWQto1wtLYQBub46HMjIYifNZaEoMwnHSQE1snqrcq7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jIElVNx4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jIElVNx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH0p53Nxnz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 18:33:17 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EJ72Zo4089555;
	Fri, 15 May 2026 05:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TaDuse
	A/itOKlEBn4YEX/bd94cnHw2cIDKLG8NsxiA0=; b=jIElVNx43xLKGNI5XGyUdi
	w6tdO8nAUc6m4mTwYEk7diihX0ij0vlNOyNk5MMJKynSyWzZqtGMg07IJi3N57NQ
	7hQ4v8Ih4SjU4+ZCTR/gw51LOlZzXI1WLug04W14XkP62TNeSzpG1PLjggVKTpJq
	fXs4sTPvDAbXCAbtUNMoQRHZQkM2FxN+5283ZV/SbtLY+uuZNz1oBTUXJSnxwraw
	Lf8mEdMRE0hHga0YmBXmBT+K5RrBtbYyTQ/0+D4z8yHMk7fTO3qxaGtBkyvTkJ1r
	eHC+zCVPVfr3pyN4/iZBjEtoFHFW3undu+KkqYkgVXLM5i58hEnqPmkigIaUxK9Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m93sjvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 05:30:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64F5O5IP001743;
	Fri, 15 May 2026 05:29:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcsuq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 05:29:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64F5TwV519792594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 05:29:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A5A558057;
	Fri, 15 May 2026 05:29:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2352F58058;
	Fri, 15 May 2026 05:29:57 +0000 (GMT)
Received: from [9.61.247.83] (unknown [9.61.247.83])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 05:29:56 +0000 (GMT)
Message-ID: <d18c4a14-c26f-460e-a04f-2998bc4e9e25@linux.ibm.com>
Date: Fri, 15 May 2026 10:59:55 +0530
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
Subject: =?UTF-8?Q?Re=3A_=5Bmainline=5D_powerpc/TM=3A_Unexpected_TM_Bad_Thin?=
 =?UTF-8?Q?g_during_core_dump_on_POWER9_=287=2E1=E2=80=91rc1=29?=
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <364996ce-aba2-4213-8d20-7dd481b43fe6@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <364996ce-aba2-4213-8d20-7dd481b43fe6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uP4dnc6RwQYcAzrr_oZFpRSHwsTyigzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA0OCBTYWx0ZWRfX2qd/Z10AKm9f
 N07dbptnmXc3KBAWZ5slVhbnCW5AUF7r43byGE7r39CQl3Du5v9Mz791TXQbBT+5IlOxsNeV+3G
 klC56rj4w/oOYiGDllxFRWO7L+94wWQbAjYVBdzNXJq+uU6O5jppTYgCkGEIb2kOu6OtPXZ0Oef
 tZrChBpTDyIN6RQr43EgutjtSROe6JJJU5HFNa7603fbFmX4mgYAHaZvjP9Qf0a8XVFpxdyRSJc
 rrQoRIK4ZUuOdd8RCCBDvh7BJMD3czMf/qsTlW62Tind6MoUYsLlW8DjF55Ln2C6FodARkoPsKT
 dNaZu9cQ0cUSUCqckPbLSEltxqqjZQXDNKAd2g+akD3c/ineLQ8h9GJE0C1MxBNhy6jyTzyuPxK
 TX2ewCxQhbGkEZrZND9zgWdwrU3hQ+a66lw5I3XCklGI+A91PmNfFlRD2QgpM1kGBIkhDYFJfty
 NlZkV7yqD+sXhnfLDfA==
X-Authority-Analysis: v=2.4 cv=ZZEt8MVA c=1 sm=1 tr=0 ts=6a06af58 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=5KLPUuaC_9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=wohju4B2r2WM4v6AVBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uP4dnc6RwQYcAzrr_oZFpRSHwsTyigzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150048


On 28/04/26 5:48 pm, Venkat Rao Bagalkote wrote:
> Greetings!!
>
> IBM CI has reported a kernel crash while running 
> selftests/powerpc/signal on a POWER9 pSeries system.
>
> I attempted to reproduce this issue manually, but was not successful 
> so far.

I’m now able to reproduce this issue reliably and consistently. The 
reproduction steps are simple:

Run selftests/powerpc/signal


Regards,

Venkat.

>
> Below are the details of the crash as reported by CI.
>
> Crash Details:
>
> [ 9798.880148] Unexpected TM Bad Thing exception at c00000000000dbac
>                (msr 0x8000000302a03031) tm_scratch=800000010280b033
> [ 9798.880160] Oops: Unrecoverable exception, sig: 6 [#1]
> [ 9798.880165] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
> [ 9798.880173] Modules linked in: nvram(E) rpadlpar_io(E) rpaphp(E) ...
> [ 9798.880233] CPU: 8 UID: 0 PID: 1039530 Comm: sigfuz
>                Tainted: G            E       7.1.0-rc1 #1 PREEMPT
> [ 9798.880245] Hardware name: IBM,8375-42A POWER9 (architected)
>                hv:phyp pSeries
> [ 9798.880251] NIP:  c00000000000dbac LR: 0000000010001e58
> [ 9798.880262] MSR:  8000000302a03031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[SE]>
>
>
> Call Trace:
>
>
> NIP [c00000000000dbac] interrupt_return_srr_kernel+0x15c/0x18c
> Call Trace:
>  tm_reclaim_thread
>  flush_tmregs_to_thread
>  vsr_get
>  regset_get_alloc
>  fill_thread_core_info.isra.0
>  fill_note_info
>  elf_core_dump
>  coredump_write
>  do_coredump
>  vfs_coredump
>  get_signal
>  do_signal
>  do_notify_resume
>  interrupt_exit_user_prepare_main
>  interrupt_exit_user_prepare
>  interrupt_return_srr_user
>
>
> Please let me know if further details are required.
>
>
> If you happen to fix this issue, please add below tag.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
>
> Regards,
>
> Venkat.
>
>

