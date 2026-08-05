Return-Path: <linuxppc-dev+bounces-25422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B337C55822
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:33:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFQFK5cDpz2y8c;
	Wed, 05 Aug 2026 19:33:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785922389;
	cv=none; b=cbxHhr9fJoY4Hsn+clTCS0YwbspD2gZWp9ocHS4y+zSeiae8XFJXYoI/Nb5C5zLwqxSkyRVjxtA7aWZz7Uyal30ib2ACTNbEh2KmHj9rRmtCiBAnUQcKk0O7ZbBJQZSY9c62x+DhWlpR4MpY9dd2MYxG+r0H9VI7b8DTq7FVAHG2OW74eQ0Gfk4oh0Twbs1HQCdd73JCxDkBz6ckwjHPtTAg3ViUm2BrGnxrH5Fghb+Ic2usQmFkTKIDYsY3Ae9xa6tPEduWxeDfJcoaW0FYPwWpJZ/40JtQdMjpvkcwTc0+oKb7ph15tD6fnl3XXMfb+4XpNDd9F0PTAXlJyZzShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785922389; c=relaxed/relaxed;
	bh=NV957z+JyAVwRsyNbsmTMGiAcOqFCl3FYRC6WkwZKI8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTvYfuWJu5Pz7eBoFsFUXdeI4nbALP5WYCAK2K6Ks3LCA58LMl3syJxmKbbL4JfUJmEqvTinZg3OD+48UZKhcP7q/587x7/BGcjMsQkPEaKe0V0lHchxrbKJKtbyZ3Ecm/kdv9wtxDg72f+QXpWZRa+xoNgstIh/Gc1ZLrnxiBRmIXMm0cMdDSaKGOrkvMVJxX1nlGXUq7sCcuS0ylO314DRk0noY6qRGm9ilScv4XIwVGmF5Q2ExSut5ZwQgLkrQgoelRWuy9n6Fs3J+6h8aWfveEEwtJLOGUm7QeFueonK2gkMsTbthR1NlwFdUSovZ1Ag1V/BNFcXuFNjjNNMGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IkHuWZnn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IkHuWZnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFQFJ43j4z2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:33:07 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m9fg3355846
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 09:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=NV957z+JyAVwRsyNbsmTM
	GiAcOqFCl3FYRC6WkwZKI8=; b=IkHuWZnniZkzMVlo+L7z6p6iH2yF4lwSfmAbg
	ryCQblauT5BT+SBFvwxiKXQWHC4EnF8hMjPnqgXC30tJKxwl2x1GtZLCBj6+3ZW6
	/BtvdDNyj2dh3ybk6pdbBKL756R5YqoSO3B6Frr8MHiN/BylIp2Bal66Y6qcjoO/
	FuCFaSjM0kB3QbdF33FkxCjx2OfhY7n7WjtNS9QwOTwtBrlmKaVphVvSsGvzFoS1
	Sx71izJ/z+tjaaADh/iZiIZ4mrFkehRXpoxh9L7pPHkVCMaDMetzFJeEk7t/VnpW
	fTPjGx0PvNHv2BHpGf1XdDgRCz+LVAuNPTCWORr9m/RtDu4Mg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42bj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:33:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759QN2M029625;
	Wed, 5 Aug 2026 09:33:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw61rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:33:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759Wx4g30408970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:32:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D07482004B;
	Wed,  5 Aug 2026 09:32:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06EBC20040;
	Wed,  5 Aug 2026 09:32:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.28.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 09:32:56 +0000 (GMT)
Date: Wed, 5 Aug 2026 15:02:52 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] powerpc: Add Power12 architected mode
Message-ID: <anMDDzxNs8nMuFmJ@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-4-mahesh@linux.ibm.com>
 <20260804004514.39870804-35-amachhiw@linux.ibm.com>
 <anF-LmYhztmpgs1s@linux.ibm.com>
 <20260804114608.61661ced-92-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260804114608.61661ced-92-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a730351 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=mWFba-A-fpZ79PAM_QEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: KZSXOS9A0if815vqKYzBaHjzQ5WPq4Yi
X-Proofpoint-GUID: SJE-CaaN2MAWcejPJsdsN1K_jI6Q_ang
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3MyBTYWx0ZWRfX2XGyPT5BHNL+
 CJwtGzrXGy4+gfFoeAbKivqjSWulbFYMT47bPfzFobueoHVEv0HC72uabkSa0S+7W0KsCWDbK4O
 WLfN0tccXyq7b/32ghQoNcB8DC5fHjM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3MyBTYWx0ZWRfX829sJ0CQ509F
 dM08TBzmaWcpavgY8Kr6FWSomIRdiQKzE9B7F12j7ed7EsXsQxDxgGphPQf6JP/+4kd+1VoBNPw
 P3PvqSZQncF7S2kDKJe5Bgy9mHmEWaZl7z8hdVguHQNwjAf/hQyxK+4wrYTHY0sSVez4gjajNEU
 cjik00cDaxHehmU5e6IYBBjYs1QMWN0VNXNz8c9qYZCEJShxzNS+dtANUXDmnBCSoS7GACTQxwW
 CPsEb2bqT+2/stIr8AX+Udjp8RavBmp+8+blwePF3O+4BdIRGDhHYydfzWDYyWjatDVvqzCT6W9
 dz7yDaZDk+TubqOZX/+OvwOwTnmnUrOlYQ1Fy8nMXAu+doqiukcyIcJszvPGcNte9YeKyK9AdgM
 cKeRzl24wZUuOmb8Z/vSDtaGcEEcTpVWFY3sNMkx05NjW9xuUfRTHStIUdAzu0jCYC9CgVLh8S1
 bCMcknAzIE9yKNcvLoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050073

On 2026-08-04 11:50:45 Tue, Amit Machhiwal wrote:
> On 2026/08/04 11:30 AM, Mahesh J Salgaonkar wrote:
> > On 2026-08-04 00:47:49 Tue, Amit Machhiwal wrote:
> > > On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > 
> > > > PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
> > > > Power12). This is used by phyp and kvm when booting as a pseries guest
> > > > to detect the presence of new Power12 features and to enable the
> > > > appropriate hwcap and facility bits.
> > > > 
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > > > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > > > Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > > ---
> > > >  arch/powerpc/include/asm/prom.h           |  1 +
> > > >  arch/powerpc/include/uapi/asm/cputable.h  |  1 +
> > > >  arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
> > > >  arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
> > > >  4 files changed, 26 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> > > > index f4991d10d89ec..cd025c7225ee7 100644
> > > > --- a/arch/powerpc/include/asm/prom.h
> > > > +++ b/arch/powerpc/include/asm/prom.h
> > > > @@ -118,6 +118,7 @@ extern unsigned int boot_cpu_node_count;
> > > >  
> > > >  #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
> > > >  #define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
> > > > +#define OV1_PPC_3_2			0x20	/* set if we support PowerPC 3.2 */
> > > 
> > > Minor: OV1_PPC_3_1 and OV1_PPC_3_2 use extra tabs relative to OV1_PPC_3_00.
> > > This is pre-existing style inconsistency in the file (not introduced by
> > > this patch) but new additions should match the surrounding code. Please
> > > consider aligning them.
> > 
> > This is bit tricky. Prior to 3.0 the ISA versions were 2.05, 2.06, 2.07
> > and so on and pre-existing style did make sense. But it looks like from
> > 3.1 the style changed may be for a reason because it can not be written
> > as 3.10 which may create more confusiton. Hence, I plan to stick with
> > the new style which is introduced from 3.1.
> 
> If the extra tab is intentional to maintain visual alignment for the 3.x
> series names, then it make sense. Please feel free to add:

Ouch I missed that. thanks for the catch. Fixing it in v3

> 
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks for your review.
-Mahesh.

> 
> Thanks,
> Amit
> 
> 

-- 
Mahesh J Salgaonkar

