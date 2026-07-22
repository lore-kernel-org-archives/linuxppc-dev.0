Return-Path: <linuxppc-dev+bounces-24640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1CAC44539
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 10:41:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4rR71cq8z2ydn;
	Wed, 22 Jul 2026 20:41:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784716915;
	cv=none; b=fjOuBzjEGiaUWG5z77Q1JRtT1cOXnVV9XbQYCcfcYj3e42VkYBErJbxV9TzyP6cisLpc3GAjqRJDFSWAw0l2aF6k5Lb1074lB7wYrL+vDOI2RhEmb2HcwOF4Axd1h18BjKQA3VuSJYq9OcH5QYMtnK8CGO5FeZ96y3glQyoILk3DlDrJ7M/ahoVx5hBe7TlEqHfGMkWl0qP7Zi0WPWI1cefIrppD8FANj0ZIxP5JiqHmqfCU+SeQZ2sgrjn2P495KU+8vLAuTg0csAYrmF1q8GnuaHJ6y6pols5Y80qWUOJvw6RtVr9fmkduzghKQKZxtZ0HapOgPSwkUNcJ3kdWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784716915; c=relaxed/relaxed;
	bh=WsrC9+ziIUZXrztaTXCNepnyNzn+NRJNPbsqew/0bek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7Q+rcX9IsA2HrhSQg+r3f/M2XtLminNxshraidi2W7ByyHpDOZKR7xBVLMp7DEv02wTERo8Iiw2l19xH3zDe4HCFBipSKuV/3nvhtjsz7DWPQMZgJ3pjS49Mho1I+gyNeTH/fGTKToFLRJCdkWG4V2X5kTowBfhBHJ3yThoFdddvGQiBOYqRVVnAi6MeA28CJlDGBWJPRoEzzMNNCwvKR4MxHUWcJ0yntpcjdw/JtK6moJsEC+aKS0JHyLUY7rxcHkNvFfY0D4peAxeFpo8pdMup4ny9DsqNiLTMyClagWwAwBGERaUwPnkzf4dbWduKVM7HSfFUHaYv0Jo8Qmw7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ER3wBCCz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ER3wBCCz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4rR573Ddz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 20:41:52 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9C6Ku3592524;
	Wed, 22 Jul 2026 10:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WsrC9+ziIUZXrztaTXCNepnyNzn+NR
	JNPbsqew/0bek=; b=ER3wBCCz88cm7YphNArQ4svw0txKwX8UMKLiC6n/Vm1Xf2
	hrwBqevxJz9KedaqbrLFIGKOtl+uDp2j5l+O7ZDSh4WtiA5EdGUFLXv2RufZcRDx
	NlMRIaBU8cPRrGG4IYPz6BwmGxdEbnL+3wobmE6Bqmb/QgheodxYgk2nXiLHcjjK
	KQOw6bodUTnkMOHN2PV367UeT6CI4DXDBH1PnLu84kqcGSfESB1pA9TPhqZ9gWcr
	L6hBNWbSh1zhs4zbHde5m7DCseVM92ithne2P0vpx2FGi5O0nwYTQiEwd3GnKw3U
	wb9fStI+I/xvEA95US1pYXnxdZk+rFVVXzgbBlaw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k98j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 10:41:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MAJaLw010522;
	Wed, 22 Jul 2026 10:41:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gepvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 10:41:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MAfYjv50659598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 10:41:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F126D2006B;
	Wed, 22 Jul 2026 10:41:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC65E20070;
	Wed, 22 Jul 2026 10:41:30 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.220.116])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jul 2026 10:41:30 +0000 (GMT)
Date: Wed, 22 Jul 2026 16:11:14 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, hbathini@linux.ibm.com, venkat88@linux.ibm.com,
        yeswanth@linux.ibm.com
Subject: Re: [PATCH] powerpc/irq: Fix missing r2 clobber in PCREL inline
 assembly
Message-ID: <amCeSt9ygusnVhX5@linux.ibm.com>
References: <dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com>
 <al33jmn9PmMJwYlz@gate>
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
In-Reply-To: <al33jmn9PmMJwYlz@gate>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a609e63 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=QfpCyNM8KlB_h1IiE5UA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5OCBTYWx0ZWRfX8LP3msKbVmnz
 oKzvKukWIwzC6yCAndnNCWtv8JkLi31RDc1V7zS3rOAD6n1Hns1OsA2qDzCSp/7d7HFmZ8wBoGw
 XuOH+vJtSaagRTOy6ohNP7KcRwX2BrgusB5js4ELmHWHA5pV4h7rxB2kXZ5uAz6dIvPu6viSUyV
 +IA4RqNLSmRVuDdRt+3rp4fbaXvkKJuRSfhtIPnV1M3/1p18BNFiapGlc6fwMSFGQgoeQXRU6Tp
 qoDFXigMonfKsSFsKGiFFpwwe6wdXOmnfbxqx4SkgEyPRLtr2VhlQqLzIr9tMFjmTivZBrP2OTV
 j+UpdeUvJ4YUnb0KqIjrU1FN2U710ZQVo3RbRq+1VeTQmVyfMT7XE0PUdje7eEKhkCxcY62O/T4
 c1IsmuPptavA8qmqRru4muqk/Ethunozbb6deuvz7xcr1sacbB/A/PSM0dEJ55UkWahFJ6k6MBT
 UZdRxgIwlj7nVtSgh1Q==
X-Proofpoint-ORIG-GUID: SStoUwGfBLGCEfxv758EmCz_S3HYIYon
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5OCBTYWx0ZWRfX6+vYQ7RmSwde
 08Ufqg7ulwEzbbvK2KgkuUiXSoffdAoW08gGIlqRo3prXUB4JDWnSvOYG5nkxAuAvg8sgp90dq7
 Bn0Z67ko2JsTqhceUNVDlAEVeXFR4wU=
X-Proofpoint-GUID: Oi4oJgHey68BdrMq8G81AWCzJR5sIYib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220098

On Mon, Jul 20, 2026 at 05:25:18AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Mon, Jul 20, 2026 at 12:43:47PM +0530, Saket Kumar Bhaskar wrote:
> > In CONFIG_PPC_KERNEL_PCREL mode, r2 is no longer reserved for the TOC
> > pointer and is available as a caller-saved register [0].
> 
> Just like on many more ABIs.  Yeah.  It's the first that PowerPC Linux
> supports though :-)
> 
> > Both call_do_irq() and call_do_softirq() use inline assembly to call
> > functions with stack switching, but fail to list r2 in their clobber
> > lists. This causes the compiler to assume r2 is preserved across these
> > calls, leading to register corruption when the called functions
> > (__do_irq and __do_softirq) clobber r2.
> 
> Yeah.
> 
> > index a0e8b998c9b5..26df38bdd334 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -218,7 +218,12 @@ static __always_inline void call_do_softirq(const void *sp)
> >  		   [callee] "i" (__do_softirq)
> >  		 : // Clobbers
> >  		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> > -		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> > +		   "cr7", "r0",
> > +		  /* r2 is clobbered in PCREL mode */
> 
> "Note that r2 may be clobbered in the call, when using the ELF V2 ABI"?
> 
> PCREL has nothing to do with it.  Well, not directly :-)  And the
> clobber list does not specify registers that definitely *are* clobbered,
> but registers that *may be* clobbered, instead :-)  Registers that *are*
> clobbered are in the output list (and given a name there so that the new
> value can be accessed, etc.)
> 
Thanks for the review. Will send v2 with updated comments as:

r2 may be clobbered by the callee when using the ELFv2 ABI.

-Saket
> > +#ifdef CONFIG_PPC_KERNEL_PCREL
> > +		   "r2",
> > +#endif
> > +		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> >  		   "r11", "r12"
> >  	);
> >  }
> > @@ -276,7 +281,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
> >  		   [callee] "i" (__do_irq)
> >  		 : // Clobbers
> >  		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> > -		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> > +		   "cr7", "r0",
> > +		  /* r2 is clobbered in PCREL mode */
> > +#ifdef CONFIG_PPC_KERNEL_PCREL
> > +		   "r2",
> > +#endif
> > +		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> >  		   "r11", "r12"
> >  	);
> >  }
> 
> 
> Segher

