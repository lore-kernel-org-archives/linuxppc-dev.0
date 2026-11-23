Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD243606A31F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tsJe4qMG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6nY1cFwz2y7p;
	Tue, 24 Nov 2026 00:52:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441937;
	cv=none; b=ILrVtnmrpQwVh35G+E37yOr7rtgCJwiz5pCbm3iy3Zsz2nTXxZmlXhdkHWxL1YyMfK9XMAS5PXEPivZiyzuo6K40he4syVJJlzHDlzUjC3xXBUxoccaS43I6j38CbiCXNUFNLbk18c1s6vnC7pC5Qy7MvQUrKKUBkWY6S/cPfYC6CD4FPHgLRDzq4ipE76UxSbrH40/jERqbriFoVBB0YWSX91OYKahQ3UgT4dTw8nOo7H/lALytzYgWrtSd4mUmB86r/XwvjIji6UDwdOjZW7xe/x7UrBQdEv7C0z8JMVB1jFim6c4C8xrKU0mymNgVKS0v1V+2UKOcC6pDI0FwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441937; c=relaxed/relaxed;
	bh=gvtuSEuq3O0wmB0Ckf3q3uStoiooG+ltEGNRtrN7EfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv1ty9MQ8YttbONl2Fpi1R7uYAmdE1JOP7fHihUCEXRoGHyOtpYcPYTtw53v93/5GGOO3KgHAcItJO+fXf1PWot+E6pFg73qSmQt/g3uAHhjgrtpQhAjHb5q0a1pY/rsi8FR5FJto9KwK9dO1JHS268xkHMw0GAMx1YPYDInUJc4pma/2BXKHGpwIINbLK2gupS2vBPtm8U2CHBAl4q8ucdNS7Ukbx2Qu0xyNLQHuDES2iFNYSzpXowBhQoeN2d4ork8jy93ZbB+YWeG0qyZXABvMCzPYx8qvm/voavl5/8DnJ8LlGKzRvSXpRHMLXl6oWHofUNgQWc4MkJa3y+45w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tsJe4qMG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tsJe4qMG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6nX1H4kz3bsm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:52:15 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYdgC2482459;
	Mon, 23 Nov 2026 13:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gvtuSE
	uq3O0wmB0Ckf3q3uStoiooG+ltEGNRtrN7EfA=; b=tsJe4qMGh9Nody8kFfz/J3
	uMqDvQDx0pzTMtPdblVEuujA/1nDcq4nWi8NR1efMMWJMxfbac9NkLishW98IHtQ
	5mnonYawc/+XbZ4D8wjWjUJFM8LWwQkL9qsBUbD7UjmunW7WjFc2gX7QfGwz4vLx
	jIxZh7WZCUV+3w7D1B9NOKNfpvT8u3/Wm5gpqRP1l+rQVmJourEmH1ChR/XoX4r+
	p1HRHaspvz2qsdu7RiPgn4kg9Pw5rsl3b6luZs4kPgukiGYQGa9Yf9o7yf6+6d43
	qPjgZazcU1DzxHXTAYa6Dqwd6YsEMdVMIhkNAs1xuQkZLbY513vRUEirCmmUOG0Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4b042-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:51:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKIQS3356321;
	Mon, 23 Nov 2026 13:51:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjy09r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:51:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANDpmAc49152358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:51:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53362004E;
	Mon, 23 Nov 2026 13:51:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515A120040;
	Mon, 23 Nov 2026 13:51:43 +0000 (GMT)
Received: from [9.39.24.192] (unknown [9.39.24.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:51:42 +0000 (GMT)
Message-ID: <7f8be085-6489-46e6-b85a-11384fd6fe26@linux.ibm.com>
Date: Mon, 23 Nov 2026 19:21:42 +0530
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
Subject: Re: [PATCH v2 1/2] powerpc: Restore all registers after a traced
 syscall again
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfXzfDNk1k6uwQc
 SQIi8XFXfZXLff9WALwrA93wFgghwe2PytK8ZWHMCdWlHwSXafFNfneVAHy6Wq1Gg+1uthKqe4p
 QFTM2J5YoQ5WyN+4wYOEgkP37AnJNzQ=
X-Proofpoint-GUID: 42Rt-00EdyeM8r7bScqstnDBX3V00Z1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX0HzRZNY8HXFu
 hwES0QoCLPTOVlQ9cMryRZ1T0q6iswjrx/f2pLwdY9hgjmwu3nm9XdiNDhRHp0nqXkZUle2Hm7i
 vmumevGY3wlcI7ljLafDc3lVf4Yfg/mvCoQrZnTlvjByBM40dmlV6LRR+bK7nezdOEr6JPOiIhM
 79751zJXNJr/4/L893QCpJQeYYZTtQHD8tbU1VpB1eVFulfSiQeP1Ci541mUEMrhJ1mOwU/Gc7J
 GffB9yQpbJzvgFlN9+iPrE0nuPj5BMjmu5yaGFb8vEQYCjNURrSUspO3hkAhI1+BoRtAp30Kpkm
 9byQ/w6m5D9jPalShVszr3F8vg0Dn3shRqt8NP+NIbTWlFgw/xRwwo2XDEW56DGzquTC9pNyxzX
 J7To8Gus0jhKKRpQXik39T61KEp6Qn6a8COl656AcmTsQS2vsc8UMnXsQJEwj2Fb2MTvRi3qPqy
 QthvKfiBy6eXxOJJhAg==
X-Proofpoint-ORIG-GUID: pwskPV3SnK_Pt0eepNlN2XJOX_fQnyk1
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0444f8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c-BUV6-UA9RXfy5hkpwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230054
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/14/26 4:36 PM, Michal Suchanek wrote:
> From: Bernhard M. Wiedemann <bwiedemann@suse.de>
> 
> syscall_exit_prepare() asks the exit assembly to reload all GPRs, CTR
> and XER from pt_regs only if the thread flags contain any of the flags
> in _TIF_SYSCALL_DOTRACE. With the new entry code based GENERIC_ENTRY the
> flags are no longer set.
> 
> This breaks tracers that modify a stopped syscall, for example ones that
> re-execute the syscall instruction by moving the NIP back by 4 at the
> syscall-exit stop with the syscall number put back into r0: the sc then
> runs with r0 = 0, which is __NR_restart_syscall. dettrace fails like
> this with "No filter rule for system call: restart_syscall". A tracer
> that writes r4 at the syscall-exit stop of an sc sees the tracee
> continue with r4 = 0 instead; with a 7.1 kernel both work.
> 
> Check the equivalent syscall_work bits instead, and drop the now unused
> _TIF_SYSCALL_DOTRACE.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org # 7.2.x: c7585b8e99ad: powerpc: Don't drop _TIF_RESTOREALL on syscall restart
> Cc: stable@vger.kernel.org # 7.2.x
> Assisted-by: LLM
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> [ms: reword commit message]
> Signed-off-by: Michal Suchánek <msuchanek@suse.de>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

