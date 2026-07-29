Return-Path: <linuxppc-dev+bounces-25030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD0CC53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 16:47:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9JD41Jgfz2xnp;
	Thu, 30 Jul 2026 02:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785343668;
	cv=none; b=oZhxWIedbeGM1KtDVJysWe0POL2xCY4koyYG9hsLysDu5v4c0JYTrxO85uX+LAtsRyC5fN7KLDR4JNOb8NqjUQlrZY7kL1OgkjsbCQBnmFw3nVyOXdA2kDe7r9ZPll58rd8MExHLqt3Md4EJrPF1pL3JJh+PAIFlC9fjci+f8zigBnej3hfBIfh8huZxXnXx3aCjDHX8B+bzb+xzSuwfqiDcSdtwgg+5CZ4M1EdYqTLgcBmkmH4p5e+5ocg6BZzCTV2V+WgWHS19DGkfrz22T2Z621LFXeGEXJYYit7YzlGEmVkVgToydtFBikF4UWDtTXwIWCDblTpUaIxaQ9c06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785343668; c=relaxed/relaxed;
	bh=QmJXc50O3DXftNpv+ZKjpiAByIx0WyXGTTpzigNS9Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUrI8DV6/tnDmxIdNBNWrBoulCABHenPDtUUkyz5KFYnxd+ii7LlXVj+Tvij7g2xuSVRNluXi12CQVqAxPR0tIT8r8by3h5ClN8Q0OJlgpMdEZubOugy35Y+RmnQUPAYnZdvncPcNaZXQ5qzpi4LgBGVaJLvL9cUF8FYbA2yjgHax1GtnmK/4SYJ4Yx41gbQI6DXSDfqPqFr3WET99AVwfNbYeFKy7cJ6Spcv+AKtr/cSq7aqNEfcaZVZrNyy4VRH/zk4muYaYhJBGD3Y93bJFi758B5JZQ3Hs02761vVD9KaJhao69rtlDtX/4FjTCymrpsciNLp5ZeHWA71mFjig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wp0vYI3T; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wp0vYI3T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9JD22qpSz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:47:45 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHo2s282973;
	Wed, 29 Jul 2026 16:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QmJXc5
	0O3DXftNpv+ZKjpiAByIx0WyXGTTpzigNS9Ik=; b=Wp0vYI3TnYzgKdxC9iDK/v
	U5mQRIkR4SzWDDOlXS6FDP8hmbasn3mnjqlYvjmfVRe+WFD9OdkCUvZTYRXvO/SW
	105BcNTeu9hdx341kTZfshVvYOQBV7ieO0fhcf0Iui3qKJvhfF05o0p7SFPOpK3i
	g8P8qyXfHIAKcQWPB/Bhf+5Rwa4d52QcoNfKWClk244wpHp3KwgBZ7CCm9KxpVUv
	fJyQmKb9pxJuIJ0H4bXup0/aP1xynvDHhNT/xqUgi8gc0fqGDPp/GJ8zlCiv9QV0
	Go3nX84KTVn0yrRy40pzBxxhO3w6aAscTpuyWfA8ED4tqUGena4U7yZUjFYY+zbw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntwu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:47:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TGfJ6N025820;
	Wed, 29 Jul 2026 16:47:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqfqye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:47:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TGlMhn29229562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:47:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E590F20043;
	Wed, 29 Jul 2026 16:47:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E33520040;
	Wed, 29 Jul 2026 16:47:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.22.107])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 16:47:18 +0000 (GMT)
Date: Wed, 29 Jul 2026 22:17:15 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        segher@kernel.crashing.org, hbathini@linux.ibm.com,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/irq: Fix missing r2 clobber in PCREL inline
 assembly
Message-ID: <amouk4Znfoqo6G7o@linux.ibm.com>
References: <7c84fa5e24263d8247b4723118e6130d63b40912.1785131859.git.skb99@linux.ibm.com>
 <63007c21-4783-4a98-9853-62b36b737df3@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63007c21-4783-4a98-9853-62b36b737df3@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX37K0poUUDlCM
 bFXyONE3YiL5sJM8JO4xaxbEm208f5atTizx3pvDD/WktF52doLKlCGzhJxnm8nZdJbimXo4fal
 hp3X1OSCZwqFnJl6zPpF3zQpM+ptrsw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX6rVoZwAVcbpI
 Df0HkAIAnGMZ3iWm761CNK7nk05vNFHqfnOoAmw9T/S90rdusIUqZ1+zABTiKsTs2Omwu4K/Gkc
 GO6R3EE8zv64902F/j22vHBBPFrm3+f1zP3EsFE8Cw2glF6SeeKtHJlTRWStBDjFs6O7MHNDzKC
 xiQRZIu6G8i03uhJmaLsAbOQv8x9w08/1ooKmAVVRAk7lWM2eU5au7jVSyZgts+Yizq+nTTuMpz
 QTPaQzMptzkjfXpQ0UQV0riw1Yry/mrEFw0imq78Nh0W89Im3rjP8XZRM+Ie3bFc5Z5azRdbSGX
 WjNufmuZEiEsvIlnUzUwwBnARvOt7P0U/lZK02BDd6Z5xLDtSumI9GMEira1g7M3Vx1WSWfu5Gt
 kh04jH6koB9FEYnoq/RSXqzPGxwkKe97CmNfOyg+oTI3X7wMeIp/9JYLUFYafqFh+vk9bmrGHl0
 A9n7sufZf/aojbgDC7g==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a2e9f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Vt2AcnKqAAAA:8
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=qOWCLjIMUxcPCTePKAkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=v10HlyRyNeVhbzM4Lqgd:22
X-Proofpoint-GUID: jBpsqGauj-dpK5TcMUxcc5zbH5pFahB7
X-Proofpoint-ORIG-GUID: ZWBNx9zFYahI_BLu4xTJm0eXT2fLTUY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290129

On Mon, Jul 27, 2026 at 02:09:12PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
Hi Christophe, thanks for reviewing.
> 
> Le 27/07/2026 à 12:58, Saket Kumar Bhaskar a écrit :
> > In CONFIG_PPC_KERNEL_PCREL mode, r2 is no longer reserved for the TOC
> > pointer and is available as a caller-saved register [0].
> > 
> > Both call_do_irq() and call_do_softirq() use inline assembly to call
> > functions with stack switching, but fail to list r2 in their clobber
> > lists. This causes the compiler to assume r2 is preserved across these
> > calls, leading to register corruption when the called functions
> > (__do_irq and __do_softirq) clobber r2.
> > 
> > As a result of this kernel crash during interrupt handling is seen and
> > the kernel fails to boot:
> > 
> > BUG: Unable to handle kernel data access on write at 0xc000000404697638
> > Faulting instruction address: 0xc0000000000181ec
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > NIP [c0000000000181ec] __do_IRQ+0x6c/0xc0
> > 
> > With older GCC, the compiler would conservatively allocate
> > callee-saved registers (like r31) for values spanning function calls,
> > accidentally avoiding the bug:
> > 
> > <__do_IRQ>:
> > 00 00 00 60 	nop
> > a6 02 08 7c 	mflr    r0
> > f8 ff e1 fb 	std     r31,-8(r1)
> > f0 ff c1 fb 	std     r30,-16(r1)
> > 2d 03 10 06 	pla     r31,53297316
> > 
> > ...
> > 
> > 3d e8 ff 4b 	bl      c0000000000165ac <__do_irq>
> > 00 00 21 e8 	ld      r1,0(r1)
> > 28 00 4d e9 	ld      r10,40(r13)
> > 40 00 21 38 	addi    r1,r1,64
> > 2a f9 aa 7f 	stdx    r29,r10,r31
> > 
> > With newer GCC 14, the compiler uses r2 for such values, exposing the
> > missing clobber specification:
> > 
> > <__do_IRQ>:
> > 00 00 00 60     nop
> > a6 02 08 7c     mflr    r0
> > f0 ff c1 fb     std     r30,-16(r1)
> > f8 ff e1 fb     std     r31,-8(r1)
> > 29 02 10 06     pla     r2,36252592     # c0000000022aadc0 <__irq_regs>
> > 
> > ...
> > 
> > 85 dc ff 4b 	bl      c000000000015ee0 <__do_irq>
> > 00 00 21 e8 	ld      r1,0(r1)
> > 28 00 2d e9 	ld      r9,40(r13)
> > 30 00 21 38 	addi    r1,r1,48
> > 2a 11 c9 7f 	stdx    r30,r9,r2
> > 
> > Fix this by adding r2 to the clobber list for both call_do_irq() and
> > call_do_softirq() when CONFIG_PPC_KERNEL_PCREL is enabled.
> > 
> > [0]: https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg313226.html
> > 
> > Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> > Changes since v1:
> > Addressed comments from Segher:
> > * Modified comments to "clobber may happen"
> > 
> > v1: https://lore.kernel.org/all/dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com/
> > 
> >   arch/powerpc/kernel/irq.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index a0e8b998c9b5..b5343cfd6c9f 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -218,7 +218,12 @@ static __always_inline void call_do_softirq(const void *sp)
> >   		   [callee] "i" (__do_softirq)
> >   		 : // Clobbers
> >   		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> > -		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> > +		   "cr7", "r0",
> > +		  /* r2 may be clobbered by the callee when using the ELFv2 ABI */
> 
> Not sure the comment is correct. You get CONFIG_PPC64_ELF_ABI_V2 without
> CONFIG_PPC_KERNEL_PCREL.
> 
> Kconfig help presents CONFIG_PPC_KERNEL_PCREL as an ABI extension.
> 
So considering your comment and Segher's observation https://lore.kernel.org/all/al33jmn9PmMJwYlz@gate/
would be better to reword it as:
/* r2 may be clobbered by the callee when using PCREL mode in the ELFv2 ABI. */
> > +#ifdef CONFIG_PPC_KERNEL_PCREL
> > +		   "r2",
> > +#endif
> > +		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> >   		   "r11", "r12"
> 
> To minimise number of small lines I'd prefer something like:
> 
> 		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7", "r0",
> #ifdef CONFIG_PPC_KERNEL_PCREL
> 		   "r2",
> #endif
> 		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12"
> 
> 
Noted
> >   	);
> >   }
> > @@ -276,7 +281,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
> >   		   [callee] "i" (__do_irq)
> >   		 : // Clobbers
> >   		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> > -		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> > +		   "cr7", "r0",
> > +		  /* r2 may be clobbered by the callee when using the ELFv2 ABI */
> > +#ifdef CONFIG_PPC_KERNEL_PCREL
> > +		   "r2",
> > +#endif
> > +		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> 
> Same
> 
Noted
> >   		   "r11", "r12"
> >   	);
> >   }
> 
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> 
> 
Thanks,
Saket

