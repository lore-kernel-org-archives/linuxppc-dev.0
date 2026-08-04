Return-Path: <linuxppc-dev+bounces-25319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E81C55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 05:52:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjP94DSdz2y1Y;
	Tue, 04 Aug 2026 15:52:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785822749;
	cv=none; b=hObdVsF/z8TLmAMnoI/UM7jbJLF3d8DO7SNjdbe70rg5wv242lH1T2rRJtnTHd/3K8wFYboOGQgPkvLu6vNpgFKPilZtXd6XQ1BJiaI+TC9ky2DWVK2SlH77TKkIrd0qP2TW83PCUZ8OgxIDOtI/CHfoM9uptSHmHxRLftUGv16Rdd94pUSsyIOpIoUGxXrzMkE1pm+k1t7DJ8M8L5RjEuCa1jTJrBjaEal//Q1K6r8AY9QbeNVgqI53rarEq/jYoeSaJ61ylOxgcZFzd8JqvUbiB0dh37aD9qpaNqi7AO0rcgMNLNI/N8G/UZIzgQxkeDuOEFPqY2R+ouSdZOi85A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785822749; c=relaxed/relaxed;
	bh=0FPnRHfqDf0iyU5roqhA47J0ClmPnxJnQwD67KU8oYo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPF4ZpzfqYfP9MjMVpuQJ1EXtLOZfrJ3wSiyssyJi1MKnvLZOQ85HHIVd4S+wrDaUsnGOEVw2SQpgA6TQyCSF634q0X1gKZN7LhQ8Wj+yiyy3L2Q+UpenrVYFGwL233gEQQsK+uAtf/DYC7C3j04wHjOUu5oSeYG1PoJNCqygzvKIYSW4mGAkwmV+MUXdCXiOrSybMvnXO9X6Nl7cEz1hyFKg2Z4p6v3+E882Ta0VmrzLQSZBSVgghlj4jNA5nRhLGcHw1z5eNz+JDZ20wsfsOa/inNAR/mB+Rqwco+2Lp3LTcKQuilFWGa3d9rLAGSDteDaBe1eA+jlWA7vq8Cd9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tnk6+dYJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tnk6+dYJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjP83pzRz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 15:52:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741I1UF3577274
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 05:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=0FPnRHfqDf0iyU5roqhA4
	7J0ClmPnxJnQwD67KU8oYo=; b=tnk6+dYJMsCrN3YEuXMpnQEkzd+bLEU9bwbrh
	+v4ogo90Ee+A1sQQKnhw9RnMSPaHJwqwGxWHnrNDJLt9cNef5+yGj1LV2mJmOA/S
	I1jz+e+niHFOy1Qy6JyGk3cXoGudqMSIp/yBGVjw/EU9UKleOYs2n6lSxEH+ZNIq
	y8x/AQ8Fo0dEY1liBdBarQ7snTXL0C8sY2s8pRnovUd0UaaQBJEaczsVi3m8fuSO
	Ut2KvtRmeeA98ykh4DBgTP1GSO941pKxObNTqI7qMX/lV9drd6alIDMfsXibBO3H
	2ChwJ3lHwAl4c70P0GTIbVciK+WcKmx4YeKUBSn0E+p8F2j/A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g43vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:52:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6745fJMs012086;
	Tue, 4 Aug 2026 05:52:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k0n5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:52:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6745qKHD49283388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 05:52:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B02D2004B;
	Tue,  4 Aug 2026 05:52:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEC5B20040;
	Tue,  4 Aug 2026 05:52:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 05:52:18 +0000 (GMT)
Date: Tue, 4 Aug 2026 11:22:16 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] powerpc: Add Power12 raw mode
Message-ID: <anF9MpdSSkwzdDmH@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-3-mahesh@linux.ibm.com>
 <20260804002831.e8e53baf-75-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260804002831.e8e53baf-75-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX6KdT4H0ED4YF
 qCL7pIWMm8GaDmtlyjr9VFh3cd6b/IIZkFLdjEKa3quDNpAFM8TIMKsZiR88+CYy2NMHoO1t3CY
 A24K5a1By7+nbq0cqQycE8hfG3anPn7S3vJMoEpEh1LdN695AqHq+7a4fVoZ58A22qNZll7ozro
 hp9XlzDSWO99AyvXMTNBhKY9ZSc3tURK4TPND8Ybcqow7Un2Emuo9385ueUcuqVn9PqB+fLWGve
 HZ3IvAekvUrDZzAdVxrAezo+Km0aDYOWlOfIW43czJKwIOepKmEqYlFC6VCCqx/4CLWPoXBDSCS
 VElytnHmNL9H88Vv2AeqK9Q3B2Dy95Be5gwh0suHJP7lMX/rYITXy21VFOpd/cJquG5fJ7xd3x3
 D4W+8VnJpWMdpvhG6Kd12P+dIiTbh5b0DaxmAnEYc/eT3nVM5Rmkyaql2ajhn7hJ7WD2bsWWGIR
 yuRZa9cymryRrzzvk8g==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a717e19 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=DxvRWNY12QaXXTUUDJEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 0Xn98TtcBAJK-UT6N7VoW5pxHxO84HcZ
X-Proofpoint-ORIG-GUID: wHp7SLmfEh2Y-iIFgLW9M1x6xyFtv6NM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX6Vse0tbJ0CUG
 pLufWkxgE3IjXzMaVnhtum5OWANBwzxOJr4XUVsXLpXL9FsCllV6HWSTDcCzw/Y1gD7GggWl+kH
 LUZr1NTVV/GGnp+1FEH4BnRvGKx86Ic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040043

On 2026-08-04 00:40:10 Tue, Amit Machhiwal wrote:
> On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > Add CPU table entries for raw mode.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > ---
> > Change in v2:
> > - Added Reviewed-by from Nikhil
> > ---
> >  arch/powerpc/include/asm/cpu_setup.h      |  2 ++
> >  arch/powerpc/include/asm/cputable.h       | 17 +++++++--
> >  arch/powerpc/include/asm/mmu.h            |  1 +
> >  arch/powerpc/include/asm/reg.h            |  5 ++-
> >  arch/powerpc/include/asm/synch.h          |  6 +++-
> >  arch/powerpc/include/uapi/asm/cputable.h  |  1 +
> >  arch/powerpc/kernel/cpu_setup_power.c     | 43 +++++++++++++++++++++++
> >  arch/powerpc/kernel/cpu_specs_book3s_64.h | 22 ++++++++++++
> >  arch/powerpc/kernel/dt_cpu_ftrs.c         | 37 +++++++++++++++++++
> >  arch/powerpc/kernel/setup-common.c        |  1 +
> >  arch/powerpc/kvm/book3s_hv.c              |  9 +++--
> >  arch/powerpc/mm/book3s64/hash_native.c    | 22 ++++++++----
> >  arch/powerpc/mm/init_64.c                 |  4 ++-
> >  13 files changed, 157 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/cpu_setup.h b/arch/powerpc/include/asm/cpu_setup.h
> > index 30e2fe3895024..26d2c0e2c99c6 100644
> > --- a/arch/powerpc/include/asm/cpu_setup.h
> > +++ b/arch/powerpc/include/asm/cpu_setup.h
> > @@ -9,10 +9,12 @@ void __setup_cpu_power7(unsigned long offset, struct cpu_spec *spec);
> >  void __setup_cpu_power8(unsigned long offset, struct cpu_spec *spec);
> >  void __setup_cpu_power9(unsigned long offset, struct cpu_spec *spec);
> >  void __setup_cpu_power10(unsigned long offset, struct cpu_spec *spec);
> > +void __setup_cpu_power12(unsigned long offset, struct cpu_spec *spec);
> >  void __restore_cpu_power7(void);
> >  void __restore_cpu_power8(void);
> >  void __restore_cpu_power9(void);
> >  void __restore_cpu_power10(void);
> > +void __restore_cpu_power12(void);
> >  
> >  void __setup_cpu_e500v1(unsigned long offset, struct cpu_spec *spec);
> >  void __setup_cpu_e500v2(unsigned long offset, struct cpu_spec *spec);
> > diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> > index ec16c12296da8..a3be81c47df3a 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -194,6 +194,7 @@ static inline void cpu_feature_keys_init(void) { }
> >  #define CPU_FTR_DAWR1			LONG_ASM_CONST(0x0008000000000000)
> >  #define CPU_FTR_DEXCR_NPHIE		LONG_ASM_CONST(0x0010000000000000)
> >  #define CPU_FTR_P11_PVR			LONG_ASM_CONST(0x0020000000000000)
> > +#define CPU_FTR_ARCH_32			LONG_ASM_CONST(0x0040000000000000)
> >  
> >  #ifndef __ASSEMBLER__
> >  
> > @@ -457,6 +458,18 @@ static inline void cpu_feature_keys_init(void) { }
> >  
> >  #define CPU_FTRS_POWER11	(CPU_FTRS_POWER10 | CPU_FTR_P11_PVR)
> >  
> > +#define CPU_FTRS_POWER12 (CPU_FTR_LWSYNC | \
> > +	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
> > +	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > +	    CPU_FTR_COHERENT_ICACHE | \
> > +	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> > +	    CPU_FTR_DSCR | \
> > +	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> > +	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
> > +	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
> > +	    CPU_FTR_ARCH_300 | CPU_FTR_ARCH_31 | CPU_FTR_ARCH_32 | \
> > +	    CPU_FTR_DAWR | CPU_FTR_DAWR1)
> > +
> >  #define CPU_FTRS_CELL	(CPU_FTR_LWSYNC | \
> >  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> >  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > @@ -476,7 +489,7 @@ static inline void cpu_feature_keys_init(void) { }
> >  	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
> >  	     CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | CPU_FTRS_POWER9 | \
> >  	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | \
> > -	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11)
> > +	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11 | CPU_FTRS_POWER12)
> 
> Line exceeds 80 columns. Please wrap CPU_FTRS_POWER12 onto its own line.
> Same applies to the #else variant below.

Linux has long lifted the 80 column restriction and increased the
default limit to 100 chars.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

Thanks,
-Mahesh.


