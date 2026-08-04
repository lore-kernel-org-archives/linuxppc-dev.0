Return-Path: <linuxppc-dev+bounces-25323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD9CC55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:00:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjZH4lTgz30FB;
	Tue, 04 Aug 2026 16:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785823223;
	cv=none; b=M5txnoW51RUl6Vmdc1uTaqSMTLljskAUqRDjXEqsywdx0cq0qeNAUU59Be3SpwDJwzVLU6m77lVWVzEPw9bmIOUNIaTfNhDqPByeU8c3klWuDW/wm8TImXsg3GF75nOJM4iX52MWopFbj/1wVsbMtKeFSnCaXtZQewdTCvQX3p9Ghpt2ffgBfyFKcIXDSCxq5SCo31/NMVEeogckUd+RXpkM5OpRgygsB91s+CCMrZlF16RqJSF8ZE8p7Qr1L7dNJFqpURPEQQm5D0lE1Ibps3eWs8zjo0WymWrnwDUyfNwwJ+7dc+fcGfHYTJeT6r31cAisYaFqvS/nz4VePZlgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785823223; c=relaxed/relaxed;
	bh=crEJdfyG654p4TMwjUGCaCZX3Qtw2TVuknptkd7OR7o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPvfJQ6zbcwvhRw2krSHGQT9JS1BTtRWepec9In2SgHuoJ5W6bMPVPZFLZQxBstVSv6HDb86QNhpVYXSuFkwITTZ2Pydlyd6Qw5Z5gAu3gEMkqn9tkzRJYyaVnLf+yW/X1ZbG7dM/Vd350zpdkDFKUT9dDmdfaXH7kKxq8HxIaklzxtgLFBDCLGNpzA1j2A1sZ7TpFfsSuVTSzzORexMx2yiwH5fhJ4GUuj0tP/kUJDzablxO0zk7AGQvLMc00x4W+GEpNomZniPVrZWY4FBoE1gx45Bw0OerI6JV1rhRoiQW4kKWVBe1zkIEAKvVmUUSrVlPKG1UNl20GLM34FHRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o9kwKubs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o9kwKubs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjZG4GZXz308j
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:00:22 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741JKfU3574517
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=crEJdfyG654p4TMwjUGCa
	CZX3Qtw2TVuknptkd7OR7o=; b=o9kwKubsAD+wnbSuvpJIf01vPf4MppBvuX2v7
	j2hlQMhX24EeKcRDUfwc2wI7RC9Mw4vLve6ha5tJkTkd4UBZcxwkTpwgEVjiiUeT
	f9q2Ir6Syv+W/sdwhOxjGutk/HY8bxLI1CNgoUeHRr6oRW5oIsqmjR6AeeV8WE1a
	Vqs8LKO/hzXajGPzgotRKCk/D0oSnd5uqgLweIwMLOBVDKRS5Md6ZCa/cZSy7q3l
	4PGcoIJyTdqhCNZ+442nw31YOtcRoelEoSob+ELO56e5mguLpB5dWiRDVcHl8b0K
	BPrKaA4tKNuSXtIDGT7kP9aqQxJ+uXCmiBmNGQmeFiUmVZ3YQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hm8un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:00:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6745ubwY014074;
	Tue, 4 Aug 2026 06:00:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8ks6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:00:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67460FBw51446154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:00:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C3932004D;
	Tue,  4 Aug 2026 06:00:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09FC20043;
	Tue,  4 Aug 2026 06:00:13 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 06:00:13 +0000 (GMT)
Date: Tue, 4 Aug 2026 11:30:11 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] powerpc: Add Power12 architected mode
Message-ID: <anF-LmYhztmpgs1s@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-4-mahesh@linux.ibm.com>
 <20260804004514.39870804-35-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804004514.39870804-35-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX67S3ZVVNkWwS
 iuXJZAbV/tczGNxAnAcqgUhaVn3TcDs8nlTE9E4e1d1W9ZW1/ZVwdaJu5zbjFzwhEJcWzMp4TeF
 ZJGmbDGexcAykPAz5nB0npKImyDGRF4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a717ff3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=MHLZa-uWRSxUHtPokI8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX643gT4miDH2J
 +La7vi2CjOTtZaWG1cNrpz3yJv2TVbIMTYvXOITMxUSrQSn52oemSvVxrZRh4Okf0pKJBHQz1KK
 CeEf4cSnLPUqjP49u9wTW0SF3bB1jMN0EbWzaLQ8WEbM+hZBIWGe5z/qyXsoPTgzv47YFlW2PJL
 1eRFCSLUlWcrCfsRMqtqq90t41701nGyzu6Fv1JcQAd1i84sxfMQsQqGkjh0ruMpC/sQGz6b5C4
 kCHGtuH0YmyxaNyq1YlbrSHLXM0zHCIQg7S0d0B42ObGrd+huG1DM8KfHvuWIrM0GdRVt9SSx7q
 R+PVLssGzGMxQwewaCfuiz2nk5hA34yexiWTgkr17kJd2G6UmJbmITJ5E4PROKPEfPGlM2qMQbL
 ptxpvV5cXZFvZ3lqUqeyEbFE4sRC5IVamcpcWRbWrn00zHVlQ8o+t9URdmpwAMu5OtEIanN2pvd
 xdN90wcafDSH3L2IKvg==
X-Proofpoint-ORIG-GUID: IJX9rpQUX-XxnrB4VWtNGchkdyCzyWpZ
X-Proofpoint-GUID: lolCy-yTrNtTNGVjbc71JMqsoT1NjQF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040043

On 2026-08-04 00:47:49 Tue, Amit Machhiwal wrote:
> On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
> > Power12). This is used by phyp and kvm when booting as a pseries guest
> > to detect the presence of new Power12 features and to enable the
> > appropriate hwcap and facility bits.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/prom.h           |  1 +
> >  arch/powerpc/include/uapi/asm/cputable.h  |  1 +
> >  arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
> >  arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
> >  4 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> > index f4991d10d89ec..cd025c7225ee7 100644
> > --- a/arch/powerpc/include/asm/prom.h
> > +++ b/arch/powerpc/include/asm/prom.h
> > @@ -118,6 +118,7 @@ extern unsigned int boot_cpu_node_count;
> >  
> >  #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
> >  #define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
> > +#define OV1_PPC_3_2			0x20	/* set if we support PowerPC 3.2 */
> 
> Minor: OV1_PPC_3_1 and OV1_PPC_3_2 use extra tabs relative to OV1_PPC_3_00.
> This is pre-existing style inconsistency in the file (not introduced by
> this patch) but new additions should match the surrounding code. Please
> consider aligning them.

This is bit tricky. Prior to 3.0 the ISA versions were 2.05, 2.06, 2.07
and so on and pre-existing style did make sense. But it looks like from
3.1 the style changed may be for a reason because it can not be written
as 3.10 which may create more confusiton. Hence, I plan to stick with
the new style which is introduced from 3.1.

Thanks,
-Mahesh.


