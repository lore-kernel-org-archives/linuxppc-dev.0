Return-Path: <linuxppc-dev+bounces-25326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECACC55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:12:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjrN2fnhz2y1Y;
	Tue, 04 Aug 2026 16:12:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785823956;
	cv=none; b=kEa2Sx4q3fXjxc7NZSJls0TZRBL+axAoluTyXQ2I9RKo/qn5PRSHgvjRe8EkQlCUV5KUkeaYx4YF7IieOThWoJ+7tqj4HBHex1wdjZ2Xa/10DgLyPp3vGM3WhHgst9o97wFT2FXa8U4tP8xa/Bz6QdpxAk5AdOrAp3HfAfuawwrISxYrP6/CPAF1vkBfibc28n49Ts5DIZtQCLwYv8K6hlini5r/84156x24twYphMjB/VgeMxKD44aPf+bKkMNIVrleCcY20eQWj9/LrdmIfujYk3durTpITSp7rLJ6gQvu02UcI5ZisSRD4qipcek7ShV1ai7ksP3Hn1LRU6tP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785823956; c=relaxed/relaxed;
	bh=EOABR0oUFT5Jv9ehWs/AuyqzMjC7QL8ZBVy2Ua60f/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csMTpmDGaKwNDB/q3bHTKMVHJEnRqTRPbLe642VZ/oJIo/CZGhptoiJpoSY1G+VZGk5D8PTUa8AGBUOeopG1Kp8Qj4IOz+OiDpBfPXG9Z378c5aIEtrV4l4j4/ce3U0ttcm9NYqQM4/Wy/rrfAzgCCvUVO92jzeTr982B/uKeaYNUanvnwN5q3CLNO4WLvC7ba6sXtppmzwW20DkqMIzS5806tlmE2cmdEIoKrzEhRypguqGkZOJFNE/QrCd5K3bzIieWPS4ggxaeosljjKmf6ALP+qqJZAhNaMI//FU/iPhqpvwjhWNag4MWmMSPt5bkOWSyESdhKj3/zdac6qGug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YGFNj7px; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YGFNj7px;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjrM4pBcz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:12:35 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HZ9u3631240
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EOABR0oUFT5Jv9ehWs/AuyqzMjC7QL
	8ZBVy2Ua60f/I=; b=YGFNj7pxiZar8l4HalzRr9H5JhRVYwnGR99u3jAo/Fme3e
	C2+Kf4TCP8W+YOiELx8oJcvSwWVZulP7+5AF9O2vsrAWQWY6iLTL/gkwiNeFcUhA
	RDJ8BRw2beD/0p/R2qf8lWl+DCGJs2nFjYgCZpqlJ7TnubaNsHp+SAvjXwMc1aA6
	FC8wYfI9P1E/ksSUcqP1gpOo9Zw/IMBVC+jnVqTeSZeJGM975VlMDJgNhuLsFbJL
	ZgnpSpW3g56A8fBGyB2HWy8wisEbrB6STEXdNWJDqtfVpS6F8w1CBGuhuXiVz0ez
	yO9ASROhvxfcOjrBGRDFy3lleFZx1083MN0RFn+g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3vdf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:12:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746BKi8032377;
	Tue, 4 Aug 2026 06:12:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8nbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:12:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746CR8D35258698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:12:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08EE2004B;
	Tue,  4 Aug 2026 06:12:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267E620043;
	Tue,  4 Aug 2026 06:12:26 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 06:12:25 +0000 (GMT)
Date: Tue, 4 Aug 2026 11:43:08 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] powerpc: Add Power12 raw mode
Message-ID: <20260804114204.a3cfb76c-7f-amachhiw@linux.ibm.com>
Mail-Followup-To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Praveen K Pandey <praveen@linux.ibm.com>, Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-3-mahesh@linux.ibm.com>
 <20260804002831.e8e53baf-75-amachhiw@linux.ibm.com>
 <anF9MpdSSkwzdDmH@linux.ibm.com>
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
In-Reply-To: <anF9MpdSSkwzdDmH@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7182d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=9tuBssuDt47AZIqsfmkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: cAzZIDmyYr2aYrQDj9jGSnexDZta4lqQ
X-Proofpoint-GUID: lePJWLZZHwOrq-p78NxaoUYk4E0--rHs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX159YBdVamV99
 gY3S6XiQ7CfBNBZmmLloGBe7F0thjxLdqEP32fAcTFe3P8Ot89Zn7OJvYmgeMGXmZOIbXmKwZzO
 YWRURlNULEAOlrCsxDxcAPOtiboOZSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX5m33fuS4rp6b
 MfbY9Il/bgBBoBvQMZKSVa6DMtRFX8dN5zr3XhpoofNsREdLBC4/X2NBqEyHakzqEANklaIljwk
 +MdSn6KkOW20iF+UwkZmYAOuKlJ4mWY1eJhJQR2bnrbHrn0eo2Ue/r/lmpUJn97lXprRdPb5QKO
 y7R8IC81bmmKwnp4KOKpmYpPg8/JQKnRJvRcMxD2BGPihkCzKeQIEHmVHhppOwL1IlsPcBAxh/O
 qm+H7iZkWfHawn64wKuMAtMQ/USOl3wbPcq458S0TLNqcgm2KA+j4wH6M+7xlsof/BODL2mA3Ks
 Dr1FJtuEgePVfwbRsTzHJgDJy5uHtdcX8Fp+WQqK3fuXHXpC4DUew0TIyW1i0WnFpt8MdFDq4Nu
 G2Bk5B1hwnni6T3JIOiTpoh5PvnAvTvIujqinHfwZFoOD3CjuGahzsYUyfV+HeoV3YytxlDtbhs
 ZNV+xQa+fjW0X6RAElQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040043

On 2026/08/04 11:22 AM, Mahesh J Salgaonkar wrote:
> On 2026-08-04 00:40:10 Tue, Amit Machhiwal wrote:
> > On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > > From: Nicholas Piggin <npiggin@gmail.com>
> > > 
> > > Add CPU table entries for raw mode.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > > Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > ---
> > > Change in v2:
> > > - Added Reviewed-by from Nikhil
> > > ---
> > >  arch/powerpc/include/asm/cpu_setup.h      |  2 ++
> > >  arch/powerpc/include/asm/cputable.h       | 17 +++++++--
> > >  arch/powerpc/include/asm/mmu.h            |  1 +
> > >  arch/powerpc/include/asm/reg.h            |  5 ++-
> > >  arch/powerpc/include/asm/synch.h          |  6 +++-
> > >  arch/powerpc/include/uapi/asm/cputable.h  |  1 +
> > >  arch/powerpc/kernel/cpu_setup_power.c     | 43 +++++++++++++++++++++++
> > >  arch/powerpc/kernel/cpu_specs_book3s_64.h | 22 ++++++++++++
> > >  arch/powerpc/kernel/dt_cpu_ftrs.c         | 37 +++++++++++++++++++
> > >  arch/powerpc/kernel/setup-common.c        |  1 +
> > >  arch/powerpc/kvm/book3s_hv.c              |  9 +++--
> > >  arch/powerpc/mm/book3s64/hash_native.c    | 22 ++++++++----
> > >  arch/powerpc/mm/init_64.c                 |  4 ++-
> > >  13 files changed, 157 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/cpu_setup.h b/arch/powerpc/include/asm/cpu_setup.h
> > > index 30e2fe3895024..26d2c0e2c99c6 100644
> > > --- a/arch/powerpc/include/asm/cpu_setup.h
> > > +++ b/arch/powerpc/include/asm/cpu_setup.h
> > > @@ -9,10 +9,12 @@ void __setup_cpu_power7(unsigned long offset, struct cpu_spec *spec);
> > >  void __setup_cpu_power8(unsigned long offset, struct cpu_spec *spec);
> > >  void __setup_cpu_power9(unsigned long offset, struct cpu_spec *spec);
> > >  void __setup_cpu_power10(unsigned long offset, struct cpu_spec *spec);
> > > +void __setup_cpu_power12(unsigned long offset, struct cpu_spec *spec);
> > >  void __restore_cpu_power7(void);
> > >  void __restore_cpu_power8(void);
> > >  void __restore_cpu_power9(void);
> > >  void __restore_cpu_power10(void);
> > > +void __restore_cpu_power12(void);
> > >  
> > >  void __setup_cpu_e500v1(unsigned long offset, struct cpu_spec *spec);
> > >  void __setup_cpu_e500v2(unsigned long offset, struct cpu_spec *spec);
> > > diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> > > index ec16c12296da8..a3be81c47df3a 100644
> > > --- a/arch/powerpc/include/asm/cputable.h
> > > +++ b/arch/powerpc/include/asm/cputable.h
> > > @@ -194,6 +194,7 @@ static inline void cpu_feature_keys_init(void) { }
> > >  #define CPU_FTR_DAWR1			LONG_ASM_CONST(0x0008000000000000)
> > >  #define CPU_FTR_DEXCR_NPHIE		LONG_ASM_CONST(0x0010000000000000)
> > >  #define CPU_FTR_P11_PVR			LONG_ASM_CONST(0x0020000000000000)
> > > +#define CPU_FTR_ARCH_32			LONG_ASM_CONST(0x0040000000000000)
> > >  
> > >  #ifndef __ASSEMBLER__
> > >  
> > > @@ -457,6 +458,18 @@ static inline void cpu_feature_keys_init(void) { }
> > >  
> > >  #define CPU_FTRS_POWER11	(CPU_FTRS_POWER10 | CPU_FTR_P11_PVR)
> > >  
> > > +#define CPU_FTRS_POWER12 (CPU_FTR_LWSYNC | \
> > > +	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
> > > +	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > > +	    CPU_FTR_COHERENT_ICACHE | \
> > > +	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> > > +	    CPU_FTR_DSCR | \
> > > +	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> > > +	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
> > > +	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
> > > +	    CPU_FTR_ARCH_300 | CPU_FTR_ARCH_31 | CPU_FTR_ARCH_32 | \
> > > +	    CPU_FTR_DAWR | CPU_FTR_DAWR1)
> > > +
> > >  #define CPU_FTRS_CELL	(CPU_FTR_LWSYNC | \
> > >  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> > >  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > > @@ -476,7 +489,7 @@ static inline void cpu_feature_keys_init(void) { }
> > >  	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
> > >  	     CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | CPU_FTRS_POWER9 | \
> > >  	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | \
> > > -	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11)
> > > +	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11 | CPU_FTRS_POWER12)
> > 
> > Line exceeds 80 columns. Please wrap CPU_FTRS_POWER12 onto its own line.
> > Same applies to the #else variant below.
> 
> Linux has long lifted the 80 column restriction and increased the
> default limit to 100 chars.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

The commit log itself mentions:

  staying withing 80 columns is certainly still _preferred_

But I'll leave it upto you. Either way:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
> Thanks,
> -Mahesh.
> 
> 

