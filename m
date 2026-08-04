Return-Path: <linuxppc-dev+bounces-25327-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECE8C55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:20:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDk1B0rtHz2y1Y;
	Tue, 04 Aug 2026 16:20:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785824414;
	cv=none; b=Mu6rZ0ee+SVPE7OrcUp1w9hYHK6KkijM0SOu7Zzg3MoWgzAGUrSgGS2pkizAck2fo5nVq3dmWLJwXzCcaj1Npz3k4571RurJsw0HTXfaU4Tygql92MvKMAuREqs5ydInqV77URtmyuIB1O0a53Qj1zOEEM8ZtN3iqlBPrsdVVL1KwXKMNROO5O7lIbfeEjNuRhkrqfeekU5Is53qrHRnVRDPZXg4vPtbl/ktFVH0IGbcekliONlC5H6aPbHZgQGrfiwhw9FriEgLjCg+8/ek97sakTkSYhBfIdGTRZysYcwIX+mYZHFQEK6eOcrMmm7Yk2VcbyLEJXlPImK7LzrmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785824414; c=relaxed/relaxed;
	bh=8gLd1RIHSC34QsMLHxM2Rpb/4a4o9gUGeTJ/pTrH+c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leRCMjnZANGc7jCZOFl3+TNrz64n/4ye2m6HWqp1yjUgaoyIh7cW1Gin7PV4irggbveO60YnoSgG6y44hHJyEuPCuBThxYX1KuAXRng4ERrMWWQ4SbkcZpZLGTInAEC/xqfUMPxL9P8TCBzxe4Fg/m4D8BzaqMP/mpvmE2wTwC1UufYQjBLTFf5UOozuAh4LnCybtlzDd2w6DQdY3HwjnU7HCt5Li7QBndDHLz7MMatazhS5TvciD/hBuIBgEOiXgnDsaC5eH1v0BBJPA85i7RZ4/Prk9o+58Aml81G8F/jtCxXxdcBJVB4VGPb3vYAqYdd7qcSPWRtORYAru12zYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HdI9/xLp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HdI9/xLp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDk190snRz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:20:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HgDn1784177
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8gLd1RIHSC34QsMLHxM2Rpb/4a4o9g
	UGeTJ/pTrH+c8=; b=HdI9/xLpisJGRUHTkgoxKRS05kH/a1+HkX9/InxSAq5dTW
	rRJD6HwYrBrf04Wb0QWPcWj1wwNiruu8MnxJnhxqzoVCx8cSBFgS7j05dt+X7B3T
	Q87DuVIwP85sfs3VeXaw24DZFpxuucD+UGCB6sQQpLFJOcueV0TMZg73i8d93J67
	G7K3swbmUNt3W/29lrfWCPAkUhdVy+Qn9V9SlOF2JqlP9ByM93gMKILIxP0hi6/5
	NtVjrJ42Uix+SSZUJ1p84W/T20GgAc2gtCnWGmj+MC+79S/G8g/Fu/jTXklFUG+z
	OeqQeoN7e3SSFDTmwb/dtOau5muikEMcxIQb7Khg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqmcms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:20:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746BGea027258;
	Tue, 4 Aug 2026 06:20:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw0tta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:20:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746K4LY26804810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:20:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A866B2004B;
	Tue,  4 Aug 2026 06:20:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F27C20049;
	Tue,  4 Aug 2026 06:20:03 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 06:20:02 +0000 (GMT)
Date: Tue, 4 Aug 2026 11:50:45 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] powerpc: Add Power12 architected mode
Message-ID: <20260804114608.61661ced-92-amachhiw@linux.ibm.com>
Mail-Followup-To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Praveen K Pandey <praveen@linux.ibm.com>, Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-4-mahesh@linux.ibm.com>
 <20260804004514.39870804-35-amachhiw@linux.ibm.com>
 <anF-LmYhztmpgs1s@linux.ibm.com>
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
In-Reply-To: <anF-LmYhztmpgs1s@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mHlizE9XQ7EkF6HehDuP-6nH0oG7eeri
X-Proofpoint-ORIG-GUID: PSidsBiIZA5a4PUZLVOOuDzTe7pnWPmv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfXzN93dCk2Z/fT
 8HuR5/H2KnpgEGM5O8v24VW6zNgsbTey1vf+QlcbLH/r1Jo9eWiw7VIof9aObLVZeWOo14bRIVw
 QET8Z/fdNzTTCtKROBVwX3rDs+3ts0Q=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71849a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=CBI-5FZ-qGlV6aM45g0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX++XIDGAsttVP
 RiWb5xAzURQmNhI5HonNfObvfLdbYYD061QfF2Th+T6SYMHLroNDD7ULkz48UQX+SMz1qhGjY69
 v/ksUSolGRNYly4RR9uqwIDbolrXFIwI6qUXVNOdg49l3stKRIDiikRICewvmrK5gsDcXHHCde5
 OrrXQwKbY1GVnQCFCbvFQeMH8+ioxbgh/uhUj9BTrCz1fICvlGyqMK1MVIh+JI96O2npBUO27J/
 iRL5ZoKJB++LQYVqVZtsWbaXj4l61OIhC+WSN8jCInHYyEbRPT2EXxYa/6vgDVf2gqiAZU2/flL
 5NCv+005yAHXkqJ2i4l5CbdkiPz3feohVvnd9x4GdSsETK6+OSnH2LLOw2cGp2wv9qMeL8KycuV
 H35mLBUv1BmwdRaZHwbDbfZ+4QWlOKpmNoIfI8gkbbVHo8CVm8sj4XNbZcHtCoLF1rZgar/3H8p
 Mq+YtKM4ldtWDJQ24pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040048

On 2026/08/04 11:30 AM, Mahesh J Salgaonkar wrote:
> On 2026-08-04 00:47:49 Tue, Amit Machhiwal wrote:
> > On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
> > > Power12). This is used by phyp and kvm when booting as a pseries guest
> > > to detect the presence of new Power12 features and to enable the
> > > appropriate hwcap and facility bits.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > > Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/prom.h           |  1 +
> > >  arch/powerpc/include/uapi/asm/cputable.h  |  1 +
> > >  arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
> > >  arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
> > >  4 files changed, 26 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> > > index f4991d10d89ec..cd025c7225ee7 100644
> > > --- a/arch/powerpc/include/asm/prom.h
> > > +++ b/arch/powerpc/include/asm/prom.h
> > > @@ -118,6 +118,7 @@ extern unsigned int boot_cpu_node_count;
> > >  
> > >  #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
> > >  #define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
> > > +#define OV1_PPC_3_2			0x20	/* set if we support PowerPC 3.2 */
> > 
> > Minor: OV1_PPC_3_1 and OV1_PPC_3_2 use extra tabs relative to OV1_PPC_3_00.
> > This is pre-existing style inconsistency in the file (not introduced by
> > this patch) but new additions should match the surrounding code. Please
> > consider aligning them.
> 
> This is bit tricky. Prior to 3.0 the ISA versions were 2.05, 2.06, 2.07
> and so on and pre-existing style did make sense. But it looks like from
> 3.1 the style changed may be for a reason because it can not be written
> as 3.10 which may create more confusiton. Hence, I plan to stick with
> the new style which is introduced from 3.1.

If the extra tab is intentional to maintain visual alignment for the 3.x
series names, then it make sense. Please feel free to add:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit


