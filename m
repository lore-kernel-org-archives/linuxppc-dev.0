Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD1606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jgorg7FU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBWl747LFz2yFQ;
	Sat, 24 Oct 2026 18:30:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792827043;
	cv=none; b=AlD6ksE5bp7616TX8JmSR4D7jubWunycRl6DnTNsdRgMLmHmEvnkUvr6+NFeN3bL9kEBzd4mWuDREYTQHcnHJ+NxwmhYuTkc7/TLDvQBijD9KKcDST3tvn7KnGnoW0vMhycMncvt28U4PfKqoldlCEQ2GuyIgHQKFFZGaEq8A+j1R/aiPVbs11V0asirEdnSoQifHg5jzbay3apTvQt55DvyQ+Ffx3RPBo8GvpWAr6bY7ihqDnjJJ4wBkmZRsGWOW0tdWZatCgVxdNVhySEHnepyGMCAMstPIHUeG+BLUIZ5HQ3151e9YGN8IBNxJjG0tcU7aAusUYwwNiBOOzkjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792827043; c=relaxed/relaxed;
	bh=uI7aiYQ48Fid8WtjKOPYCepGlYl0QFiKvAR9UraaOj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRn0fJ6jaZPNgq3B4FthBecKDqgVEBtwxpnhaPx+TywjLPhNbmXXHdDq7KF1Xj+IsfxnTlXgAKc/S0LwHD1IbgR/2dXF5RdiU0/dgLBlMl2o9bWpUUYLMTbnyvJv8BM1a7IErCpxSxICPij2DD6aj8bDLWDx6Ld7pTGhzzN7n7H+05SRl8jX253e7sVG+CPdMXy8UZbf8PHktcG+ib+X2rrcaznHyxzp6ffJbF+QuTwi+1AhmdDlKsZBhDumBK7G7P+sYHBa2+lu9HGfhhxIer0SFCWpvAKEQlRfcNbJwkV4d/4jgSGhscpDyn0d6LP0tS/hbvmnPnbm1Tv+qT25uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jgorg7FU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jgorg7FU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBWl61hF0z2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 18:30:41 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O31mHd627908;
	Sat, 24 Oct 2026 07:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uI7aiY
	Q48Fid8WtjKOPYCepGlYl0QFiKvAR9UraaOj0=; b=Jgorg7FU3BwW41Cxqsfoxu
	PKAENVtHlWcAXORCF7Mjs2xbppP7+XerACtFgP865CF9LSgC/dzwAFl+ZJI5LavB
	W6qoKUMzgwahLdW8skllkseFLBh+TbT1rU/GmeHn/zv1V2Hw75rMI4fIZnm7iGOU
	2mZRR+MsQ3B97pXQFdQ/ewkdCk0bG1I3Wb42edFbNrQt0VrhcLSqMGJ9j2L4hFtv
	mWdLYuYdymHru72MqL6IfX04RWL2zLRrwlGevWUDLAhw79DjAlqKBzrY4igZuW3I
	JMVEZBeAQy0xlh+Bjo7J6WXBgk2l3/htGigljKmSJK5yVOZJTod/PtSGPw1HRx6w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6gnfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 07:30:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69O24tYm2956305;
	Sat, 24 Oct 2026 07:30:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg287av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 07:30:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69O7UPFb50594204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Oct 2026 07:30:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EBBC2004B;
	Sat, 24 Oct 2026 07:30:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 327F120040;
	Sat, 24 Oct 2026 07:30:22 +0000 (GMT)
Received: from [9.124.220.45] (unknown [9.124.220.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Oct 2026 07:30:21 +0000 (GMT)
Message-ID: <4bb9ab68-bb2b-49a0-a066-4de1405971a1@linux.ibm.com>
Date: Sat, 24 Oct 2026 13:00:20 +0530
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
Subject: Re: [PATCH] powerpc/irq: Fix build with CONFIG_PROC_FS=n
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
 <20261023211503.3764302-1-sashal@kernel.org> <ecdg558l.ritesh.list@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <ecdg558l.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adc5e95 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=ZiliM2NqM_YteYZ0dKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfX6QM9tRz1XmsO
 rek0Uh97ISlYub/Ogi4BJAJhzQYaTYvq1kML++2lzSBQtOpa1yOXf48iAZzp2IHbrsdcXeTg55K
 7tljTmVtL2kHgoMnSMI6vjET3YmuMSgvvFJON9YNaBR+FUKrrRsheOZw+Sc3UIxfhliz6mPieCv
 Nm6LUBOfuBbMBc25YtA0kddMFGUwHVVGQRFu2R/7H94+A9GLx72sxB6FR4fnfgzK5wk0DC4aEL2
 oiBqFeppgcng0j/0Hbeqt6+3rclpJWFDhu+y5qxcmVUEkuZX0KiMYC37SFy0TzmlSvPTWL6oZqX
 bbFfBa4NtEX1aG4A6dwLL/H0gkz1YQGFwPx4vpF9ptBsQOynutPuE+7rhstKtLuTos4hDZrd8vl
 L8x5gEDOqG6AjyeX7p3azbft4irGJ+/+52a2+UliUl7lVtk/eTRpkoR82QKVUXNmt0zLemBj2gq
 7t+c5EeUxWDlpDhlf+w==
X-Proofpoint-GUID: 7P7jaioRhXgNMr6Z24JqAYEJDaz1v0Ul
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfX+n0kkxAlhgm7
 brew0AybCbrhPw86QXXMR377tWjLmutpJ/0u9G1oJKqX91iRg7eLLkvlOvDQAHFPhvWtVKHRWIY
 5Fzfwqp6vPSzPltMleEA4pJQjTODSCo=
X-Proofpoint-ORIG-GUID: iLMvGNDTpMGUTszTaDwDKrcp5-cYcA20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240028
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/24/26 5:39 AM, Ritesh Harjani (IBM) wrote:
> Sasha Levin <sashal@kernel.org> writes:
> 
>> Commit fbb22ceaaf8f ("powerpc/irq: Make irqstats array based") made
>> arch_show_interrupts() call irq_proc_emit_counts(). That function lives
>> in kernel/irq/proc.c, which is only built with CONFIG_PROC_FS, so
>> kernels without procfs no longer link:
>>
>>    powerpc64-linux-ld: arch/powerpc/kernel/irq.o: in function `arch_show_interrupts':
>>    arch/powerpc/kernel/irq.c:134:(.text+0x4b8c): undefined reference to `irq_proc_emit_counts'
>>
>> arch_show_interrupts() is only called from irq_seq_show(), which is in
>> kernel/irq/proc.c as well, so build it only with CONFIG_PROC_FS, as x86
>> already does.
>>
>> Fixes: fbb22ceaaf8f ("powerpc/irq: Make irqstats array based")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202609271531.8kf2NTjK-lkp@intel.com/
> 
> Looks like it still slipped through.
> 
well, fix was posted a day after the report but was never picked up.

See the fix posted here.
https://lore.kernel.org/all/20260930072329.1110379-1-sshegde@linux.ibm.com/

Diff is same. Since it made into linus tree already, all is well.

