Return-Path: <linuxppc-dev+bounces-25382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5755C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 14:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDxPh0Kq7z2yH5;
	Wed, 05 Aug 2026 00:53:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785855223;
	cv=none; b=Wk6PKcXrbBzP+JEoMTYzQ5BpVfE8v6ieMIupesxjX0TDK88ARPlAZ2C0Y0mKC9AHPURz2NEAt8qnQB1PqTTcgEtwmhTcYSJoNOOoXdXc10clfnimHJNmjdUzw1fiGhTShv6uuOPY5J09LpwII44Rq+7+wBtsnsYa2Eo7HJzrAixbLOLQtwkvDHFCbk0YTKHmEUX5UHA4vVtOpVmB7XD82ZSCpR1SKy1lK6y9DpNrkz11p6yRw2PCa/zw0NGAlVerRmVUqrZGFfGt3F4HpQwwmqdK3n9pXl6Zc1xb06pq4JAP0nflj5P/DdTSPfVZLRAjpujn4gQMyoZEC/T+pwpAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785855223; c=relaxed/relaxed;
	bh=DBfwJ3gNCEpCqKjwmssLTJRAWFltPg69hfGcfdK/PN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLgp4IUWi04IHSbEkPve5kYikVs9/D0RNOdzMWURZCcRqn+UxXbjwCBJTvqWVPLU3jHSBNwukt+SaAXk3UH0qmllMSd3aGDRsIlMxazosrB5tfIb4fpdiJA15qOKrDD5JjCW9k7gWhfY91gKOSnSqCWxQbmnYE3dRC45QR7AQcyeGloyZvV3N/nFZ+l8CiSCGLHhDVA9T8Ch530oKAFzznYvPInGkckGxZVh+75qV5LoL4UHQGei9CWWjPtgEihTsDcDuEBjW8O5beM5VHwAHBVgGrumtSE/e4faJkVkuOwLQEbXJygVKIMyeuf7/uintEcqWQpS8DEWdDQFwKwV/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o/cCuLS5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o/cCuLS5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDxPf6m6cz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 00:53:42 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Clabt894265;
	Tue, 4 Aug 2026 14:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DBfwJ3
	gNCEpCqKjwmssLTJRAWFltPg69hfGcfdK/PN0=; b=o/cCuLS5Zc9wT0XiwHNpeN
	E2CFMS4vmBOCMB297Wd6arx3vXyxzW8ERuKjgoc1It2QpcBSEMsQeOMchPoTfNr2
	dEsF+LEUaxEYKt38SW3HKx1lkCmb1le07VcCONrPeckkj/DUj0koFIG/79Ca7QzA
	hR0tzB2jXW7bkPOD3wdhcBZrUu89CNZAcx1zO8Zor8lUyn6GRtK45hdIsl5AzL4W
	0E0Q6UEMOueXAMngJXgeWWiVxlV8vjLoA6Dw2UB8rqzzcvfZWGM+DWepMKywz5m3
	N8Vatj9g9hhb+/ePPuaGVUCo+1by57176UF27t6L7svHU/Uu4AuZbxFbTWj94VFA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4xd71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:53:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EfIMq000385;
	Tue, 4 Aug 2026 14:53:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k2d6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:53:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674ErPuf26935922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:53:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE09420043;
	Tue,  4 Aug 2026 14:53:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C60D92004B;
	Tue,  4 Aug 2026 14:53:23 +0000 (GMT)
Received: from [9.39.27.209] (unknown [9.39.27.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:53:23 +0000 (GMT)
Message-ID: <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
Date: Tue, 4 Aug 2026 20:23:22 +0530
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
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX2IGB3MsfLEmt
 0oEg6bQXZkWv5SqcaG62riK1GmbsxZHcIPiuQ+nLYcjLM3rpwh6nqsfQwPrYruhO/Bp/erf2HeC
 Yt716sOjXPL4+xOwC44lzqu2yoLu/B4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX4/IwkIhUj01R
 er4NpNTbbqEs8zr/WUg5oysaWcFMQd80Phq9kWVrHmTPZangtT4BRutvsVaKr+FSOHXCAGa7UtT
 E19+eo2Yo5jH/ihPYHEGNVNECpSGNvlqxfe7LlA18Nqdsb5Q4OUWPhMTQ3iWUqMhhERI0CIq+YY
 xPZ2W0Dc8Xkaxjl8t2Re+EemW9awg4qgVYtsN7CAeOjHXkV/p63ZbINesv/Cf2b5ZDrBJXqvTn7
 UuW9KWONlYEquaPoFsQTnpQ2aXXQST8zNy28lScBmiDxwCeztcBAKshimZcGjsCxE0OWbrPULNg
 jedlwr+TC+1t0M6XL0M1Yh9v4EXFYZJ1VkL+ClDwP4qoP8MGDBOMnHBdo2fdS7dhNG2hcZWUK5Y
 uOckcCf7Fo2K80l2Q4obg8KgAVY0W3wFDJLbv/BMoiAptfei5G7E4dU5ZNWF1pwSIvNz/qbRURH
 noRh80RYNIwTuzs4hIA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71fcec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=dHNt9147D3xgIyPlxCMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tFHu5O9I3pqZTjqJH_KcgWltEx4u8evU
X-Proofpoint-GUID: RmOa5D-wxCTEuaPXTzfaAD3WPZ_WWWbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040120

Hi Venkat.

On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
> Hi,
> 
> I'm seeing a boot regression on a Power9 pseries LPAR. The system hangs 
> very early during boot after:
> 
> Quiescing Open Firmware ...
> Booting Linux via __start() ...
> 

That is strange. not sure where to look at without any logs.
Is it a specific config that fails or this specific LPAR that fails?

> No further kernel output is produced.
> 
> Known good:8cd9520d35a6 ("Linux 7.1")
> Known bad: 075b74841bd0 ("Linux 7.2-rc6")
> 

Is the kernel built correct at 075b74841bd0 without any errors?

> Initial bisect:
> 
> A full bisect from v7.1 to v7.2-rc6 converged to:
> 
> c5e8e224eb7a
> MIPS: RB532: attach the software node to its target GPIO controller
> 
> 
> However this commit only modifies:
> 
> arch/mips/rb532/devices.c
> arch/mips/rb532/gpio.c
> 
> and appears unrelated to a Power9/pseries boot hang.
> 
> I then narrowed the investigation to the PowerPC pull.
> 
> The following commits were tested and boot successfully:
> 
> baa590018fbf powerpc: rename arch_irq_disabled_regs
> dec63ea6faff powerpc: Prepare to build with generic entry/exit framework
> 09a9d3a8499d powerpc: introduce arch_enter_from_user_mode
> 893082ac769b powerpc: Prepare for IRQ entry exit
> 
> The following commit reproduces the hang:
> 
> 334f3f6d7a16 powerpc/entry: Disable interrupts before irqentry_exit
> 
> 
> 
> Between the last known good and first known bad points:
> 
> 
> 893082ac769b powerpc: Prepare for IRQ entry exit
> ...
> bee25f97ad24 powerpc: Enable GENERIC_ENTRY feature
> ...
> 334f3f6d7a16 powerpc/entry: Disable interrupts before irqentry_exit
> 
> 
> The only substantial architectural/runtime change in this window appears 
> to be:
> 
> bee25f97ad24 powerpc: Enable GENERIC_ENTRY feature
> 
> 
> 
> I attempted to test:
> 
> bee25f97ad24 powerpc: Enable GENERIC_ENTRY feature
> 
> directly, however that commit does not build with my configuration due to:
> 
> arch/powerpc/kernel/ptrace/ptrace.c
> 
> error: implicit declaration of function 'trace_sys_enter'
> error: implicit declaration of function 'trace_sys_exit'
> 
> Therefore I could not directly classify bee25f97ad24 as good or bad.
> 
> 

Can you try one commit after this and see if it builds?
i.e  "powerpc: Remove unused functions"

> Please let me know if there are specific debug patches or boot 
> parameters you'd like me to test.
> 
> 
> Attached is the config file I used.
> 
> 
> Regards,
> 
> Venkat.


