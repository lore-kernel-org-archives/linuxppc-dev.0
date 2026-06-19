Return-Path: <linuxppc-dev+bounces-22821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFDCCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:32:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghcSD5DWbz3bps;
	Fri, 19 Jun 2026 22:32:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781872364;
	cv=none; b=OuFUzxYfpO/lsPmha9zLZj3z+N+5ivfUSyUtP4eSg2Dfv7EH4/oknOSEHbTPs2qxJl43FFi00VFeNS+XH9wt7gb5VTkHzV4DtNmAMnsUfxGXjFqaVgvClFg+cRGtc1KUIxRgZiRnN8QTBnXX2R4OQMjjBGT9tgXvrxAf93lVEa+iqqkaSkLydHEQlpR6cxbJuZ+wr/vqsrmrdZJIneTkSouP+D8MDyO5QmQuJj3DVYtQ6eWGcxv8yDwHbPdTP15NeokZkAZ6RB5FAQOj7P1CoM8vkxYW6GDxDa2f+2GmbcEAyXu8Cnut+BZ20lrlS2NAmjsCv5N0Y+wnF+FBHf9rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781872364; c=relaxed/relaxed;
	bh=8W5L4P51TPTDo8osQuHTkbur7XJ4M3tR0eMXpuM6vs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT8G2kiMYJbEznpVOhwKk3pvyhzCT998JXG3E9sDp0SGaRq5kXdOzAb8moSenIregEwuYfU8LR7H9rpLDAF4zwb/hJAHdBIB0Rz6xah9QRs4RjcU2WN+xNj7aklrozyGiEUPVAzsNI6i2Schk5WQhBM+QcVDSCt8ST8hCl7XMGCc2fC5mFjXfZgTC+/tjejAIb8/RQ1bd4aDwEJ+56TYnOdwrS+EGBmALpXUEkW5HIaqArsSU2UyVGKLpgX0ofZBwdFMdtRRZK7BWcyNaEA6V79ZWD1OCpTtiQHgw+aQJZZLVTBzMFY9JSl1g9D1kWoUif1VslVvLRKnLsCngT6dbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R8+sNZI7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R8+sNZI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghcSC4fSXz3bpp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 22:32:42 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mEFU1711462;
	Fri, 19 Jun 2026 12:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8W5L4P
	51TPTDo8osQuHTkbur7XJ4M3tR0eMXpuM6vs0=; b=R8+sNZI7Ct5okXA8fl7JFv
	4rKFOQCv6KslouEREGS3BAGlDHxJ57XkOfbUZ9mFHKnz+ehMIrgP3cq003qyTn7K
	CGdmuwAqIO20TALakrT9QDhtjxXQzPG5Gw+alcfqDERNOyUSyWTvnGKvJZa/549/
	qnXWjRKMfUVpKPE2hGEKf76T7jahx7WEsnxyPAbUP8ri/O/psarDsATXRVJCYuG6
	hzSxn/oPk+uy9O5yi+S511+7iSs7xcoAHSKWe08yXsEFpOvWvoeJLehiv2l8i+aB
	x+s28nSqSbwTGbEjiBew2y2+EcRd290icR8ViMTpGDrsPYe00E5gkE+b4NOz5guQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtwjbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 12:32:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JCJaqf023381;
	Fri, 19 Jun 2026 12:32:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172grjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 12:32:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JCWPGb46203294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 12:32:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B92AB20080;
	Fri, 19 Jun 2026 12:32:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDFBE20078;
	Fri, 19 Jun 2026 12:32:23 +0000 (GMT)
Received: from [9.124.218.121] (unknown [9.124.218.121])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 12:32:23 +0000 (GMT)
Message-ID: <763622c4-d2fc-4e84-8474-fdd72a64b5e6@linux.ibm.com>
Date: Fri, 19 Jun 2026 18:02:22 +0530
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
Subject: Re: [PATCH] powerpc/32: Use HAVE_PREEMPT_DYNAMIC_CALL instead of
 HAVE_PREEMPT_DYNAMIC_KEY
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <d26da63caddc52de7894c763304ec7ecb23909a8.1781866685.git.chleroy@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d26da63caddc52de7894c763304ec7ecb23909a8.1781866685.git.chleroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KksRwkVvbRS1YVAkr7x-YK9vZyyz13Sx
X-Proofpoint-GUID: 5rI5vqLo2cjLoPDpE-SAkF0HnxbUb4VK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDExNSBTYWx0ZWRfX7mjDCsaAp6Gu
 Bjflc0JVFYbhKafKIn/KC4upFDEyWsujXoTpfhaIUZnQycbdYnTPYupczBvrpguhr/FpIEYA4/X
 Xyj60TUrvW8XMjlYcF34C+AfRf2PJZHlmBnTAVwDa/OVtO3qrobnNIlh/aC2fEafuqV45R4txfl
 Ob2MbJH6P2xej0WuIAlpO5rAh9zRtndTlEKtsbf1hoG95ir4QDr/GhkUcO6ihs6NhCzpzRLnodt
 44ZZ+LuH+tXC4n10iz7KdVDhihpvOs4f8oG72FY3HGVMb50Zm0N/lRO9MGRrKx5rx59ueZVDY00
 CHXAvchR0rvxHZlqtrPs3gXfLxKtSKgup/CDzvgc25AE2sMlpv6rsVWuHdIDR1nS2GR1b1iapWl
 1OoHfl9GCwaeoB1Y8dCFlGjBEQkBGji36tup+tgwhBle2nyC5SYUNwzH30pl0WMFPaBYpUvhpPc
 O01+P6jY8TP5hoZM23g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDExNSBTYWx0ZWRfX9rcJN9bhDEcz
 F9eQ+o4WBsvoz6GTj9B7tCcW6CDCRLxmz0lhor/EFTw9l0mTq4lj/ebAkqNtPqvwqFk1XyJ5ESO
 wML9WOz9738BgaJAcR1XXr5177O7mUA=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a3536e1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gDzEomWgUn4-idOrWXkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190115

Hi Christophe.

On 6/19/26 4:28 PM, Christophe Leroy (CS GROUP) wrote:
> powerpc/32 has HAVE_STATIC_CALL_INLINE, so
> HAVE_PREEMPT_DYNAMIC_CALL has to be selected instead of
> HAVE_PREEMPT_DYNAMIC_KEY for less overhead.
> 

Do you have any way to quantify this overhead?


> Fixes: 6ad7751537e8 ("powerpc: enable dynamic preemption")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>   arch/powerpc/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 81642206f7de..7475907cef5b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -281,7 +281,8 @@ config PPC
>   	select HAVE_PERF_EVENTS_NMI		if PPC64
>   	select HAVE_PERF_REGS
>   	select HAVE_PERF_USER_STACK_DUMP
> -	select HAVE_PREEMPT_DYNAMIC_KEY
> +	select HAVE_PREEMPT_DYNAMIC_CALL	if PPC32
> +	select HAVE_PREEMPT_DYNAMIC_KEY		if PPC64
>   	select HAVE_RETHOOK			if KPROBES
>   	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_RELIABLE_STACKTRACE

Patch per se, looks good to me.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

