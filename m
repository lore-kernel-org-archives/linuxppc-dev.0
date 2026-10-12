Return-Path: <linuxppc-dev+bounces-29263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA5CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:11:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3KBb0lRHz3bV5;
	Tue, 13 Oct 2026 01:11:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791814263;
	cv=none; b=bUVUZdvJDumQlJgoEXJhv2enwKPLzto403l0Rz4aei6yjeQGKHIB8GtCkqmndD3t6U8t+rszMkXRKLvh+wIF5rCXkZEY7K7hxqt0B93J+fSm8+QL0xRBva6JbP0j/6s4RPieheX5FrGYm9dLBUrnB4pRuHbzkovyYl8gDwRnK6VnmNYPVW8JwGBa3E4TWcDQjrTPuCXa1xFgE0+n4rMchDQR6DfSAJPHnWY48QMiLDWTUCPIJ3RdR54bMQtBWc+HSavYflfbsswEdo2NMouiaoIz4ev9iCB1v9E/aoz+IvwRlAkvclwD8LLufrAkC1noy2L3p1DiJbgRPxXB1HSYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791814263; c=relaxed/relaxed;
	bh=efBpskySx2r6rwOhoxKbmkJwGKa4F1rH4LPN+taI554=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTx7FjYD9HBpcTRYs8Y59ZTFSWJ5Y7R51pEVUvrc5HHwm+4CtjydBKeJYLgyjN3hFbAmxSDr+FbvsycTK2cEOuqGclYXAQgW3tsXVszStTtVvA6K1Otc/FaUP5qZEYGF5Gegs8BZezPoUER6Mi7cQZP9GlfT3CJ/+hon45vN4WJ07mUoKs4FnzseLgVW45EcApzCTdzPiQgp20+QGG9Ng3H9SxBPwAFIfTchmsjSOxDdgL9hIQ24KYWCeG2nDtwTuXbG3XhVmyilDZ3kJ4aqe8163Iea7Q3Z7xVd7yTC4yKeL6J57TRSROZRdRV6jycLpTZM9BECZ3AgZgPNkfogGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WMm/OEI9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WMm/OEI9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3KBZ09qtz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 01:11:01 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE551181594;
	Mon, 12 Oct 2026 14:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=efBpsk
	ySx2r6rwOhoxKbmkJwGKa4F1rH4LPN+taI554=; b=WMm/OEI9+RIS8/Nhnp2aEQ
	aWERC/vRo/IOpUOJlK08SAwPtQwWcQz6MhRjaalK9wsnOZJAdta3O7/7NbAR1DHH
	ENfI4a1YPhjm60tDNM2Pg2hnU29bBFqr0/YsHmpHdYrgSxoD45cOdNzmt2FvqUtb
	3uZH2q29tTidRyRFIXYGz7Bdx4LaT8KGZjv+stSJBA39WG6GP8f4wtjNds3P2dls
	1ZzNVVg4atc3o9rI4gUQcppFZxhYfoxdfygtdEuQ+MkBZ/WFVfQqogxhF7/QdC8Y
	vuNXv4Fh91TFKvP5YeUIxv4NdUXMbVQ9vgV9BkRMOFz3qqEQN1Ys8J+EdwQn2zEQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3995f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:10:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4seJ1286234;
	Mon, 12 Oct 2026 14:10:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyd7p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:10:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEAb1454985152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:10:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C94D20043;
	Mon, 12 Oct 2026 14:10:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611BB20040;
	Mon, 12 Oct 2026 14:10:34 +0000 (GMT)
Received: from [9.124.214.197] (unknown [9.124.214.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:10:34 +0000 (GMT)
Message-ID: <26486e03-b1f0-4a84-b6df-75b747d9f1a1@linux.ibm.com>
Date: Mon, 12 Oct 2026 19:40:33 +0530
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
Subject: Re: [PATCH 1/4] powerpc/topology: Introduce llc_override debug knob
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, npiggin@gmail.com, mpe@ellerman.id.au
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <20261012102037.2477378-2-sshegde@linux.ibm.com>
 <aszPQppmUXcJER1x@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aszPQppmUXcJER1x@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VWKI_jMXA0P5Zyx_NXJLsX8_YrN_R6By
X-Proofpoint-ORIG-GUID: kQ4lXvMh1A4bc9lxmT3TKRTcZ7Z210ZD
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accea62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=2npZI0HAQQjSB1Li4OYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX/7CEXfTH6q/I
 bmjpEeTxk9H9SL8rrjbP3u4sjYMHIOgTlhy5027nxmfdyOotxN3z6UMfjJUxmOVWsO6d3v5hMC0
 bszJHaL0D3r977XEl3jAEPJ/iwxsNNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX1rwqEcuFfmtc
 0/daJ/3l8GNxfP9tjACqytZ3EHcHswXtOhv2EK8acSgjZdcwQHp/3kp+zk+mXxwL+FUBKlbS9HS
 hAtclkIrMLQ6RCdRvbvc0qb3pGSx2Xo5Fp8AVOcnlfeI0GlE2iGtt+Ss0+ifFdC8eSdeCxFKEIJ
 70n4hClKgeprpEQh6AOrshM7ggdAfYezb9qiUa0uWLq1l+E6Vg5FtonZOv+k08LLMklYGc5QqsF
 uABke0og7822lcLfoCg3vs7WjIdvjploeStu5PgXBGQJq4PfgIt24idAEEVK4lHO43NLSpLGTgi
 Bgt5LdBJAmGYbiPYAu0W6QklnJMmKumUha8nhFZahPpbtv4kGnmkZifGEX5zJx51C8inO+p7f50
 4u59f22sfpYN2Og55Pc0gf3ZEzR+jmZPH9hfIjh/qs8t7ECNIGQPw5JCWCIIWzkCCrCU61Lx4My
 e8SpV/jhlmrCH3tnxbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120054

Hi Srikar. Thanks for taking a look at the patches.
    
>>   #endif
>> +
>> +enum llc_override_values {
>> +	LLC_OVERRIDE_DISABLED,
>> +	LLC_OVERRIDE_SMT,
>> +	LLC_OVERRIDE_MC,
>> +	LLC_OVERRIDE_PKG,
>> +};
>> +
> 
> For the current experiments, would it help to keep it simple and have just
> SMT and MC. I mean we can include disabled and pkg based on our experiments.
> 
I think we should keep disabled. So it is clear when disabled, there is no adverse
effect of it.

I think keeping pkg for experimentation seems okay. If not necessary we can remove it later.
Having at pkg gives you to try increased number of cores in a llc. So it may be a useful
too IMHO.

