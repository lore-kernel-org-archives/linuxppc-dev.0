Return-Path: <linuxppc-dev+bounces-22618-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF43CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 08:58:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf3vQ36kkz30gJ;
	Mon, 15 Jun 2026 18:58:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781513938;
	cv=none; b=nSR6Dw0MZ+7lz+stt4IUGLWScEJKqQ64D0/ONX+STPze7VHum7Ucz5D/i1pFngWRDsvEvhk7tEJuk8rtT8DYcfD4NjP9PEvIt1siy/y/uhQgaJfUn8IMUqDEn7tpv4mWwzgJ1W3ZjFhRk/CZZH1fveywDdHdbj/vXcHKWpHc71ML+5X9MOhx2g89kNNTKmS/xjTjLug5U8lMYjiXazdP39wUF5+C6O5vTb0XxuoPBqpVHOgyUtzn4th9GKUhJdBjUwr2SqRAzKMSGV9Met5gdjU0HHJ0ZF4ok86ebRvL65PnrPB2Tq+bgV6yko2MxbIP8E4K3NU7PlbznNstDQeIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781513938; c=relaxed/relaxed;
	bh=WcCdRgrAw20TXN9kIc9eNWsa0IpcuvOMmAXVYTjTg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt8ChxM77fHSGXll6L9sgezkSOLaxKlSLBzmfIAwiNIGP2t19eNTBl1vKwxGlMtqfi8eIxvbQBvFvL6bJ1eo0UpNPQxMp9E0bxzBOxLlOuCtQchwkHDq1LYt9pvMq5jlyM3AQqed2hm07472azP/4cb0MTK7jHH2Z69Zajklzy4CXCqNp+IiHszyZoFPmBVgTB9/A7anO6jaUyIdi/unuZzrGbuR78Tj9GHYCRtQMTN6vdnUpsUmTXf9+iH+Mjz4sdqDdPekz1d8FLrGK0OO1gzDYuTSVSgHuEd1xVP6wjZgFRLVPfujn56WPnqMI9fXjBUlb0/pyER4mQe6z3N+pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jBavBT/9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jBavBT/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf3vP2b1nz2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 18:58:56 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6IdLB1555675;
	Mon, 15 Jun 2026 08:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WcCdRgrAw20TXN9kIc9eNWsa0Ipcuv
	OMmAXVYTjTg5Q=; b=jBavBT/9pdkfaOqEvSlecBoDSoYxgjZ7c+tgez4Nt15T0g
	ftv7u6kd6MEigjBzidO4J2qk8s4BCRbFKSzfImovFQNfbusY+dZf0oppXLrmpied
	wjkXITJdV6Y4RFn2BvDJY8EmTnrbyypJCp5emzCfu2h2GJlOX2MhkwSl9Dxcdu1B
	ivDsLzCE1DO82yYQjbw0D2Kt6c+aye2SzC/uoVx+Lr6gW0bDnMGt8gJdmKSk4PFl
	dr4tQQuLAdyuq7CirsA7B+LO6YdjDUO2bAnZegQoLxEAR5aqGscBN0C6sl6TZBA8
	j/6fnc/YERYG+l4/So/8I6L37Z2tWiWVABR8pLyQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nfnkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 08:58:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F8nahP020004;
	Mon, 15 Jun 2026 08:58:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpwy16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 08:58:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F8wfeQ50856240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 08:58:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49AE020040;
	Mon, 15 Jun 2026 08:58:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80EA920043;
	Mon, 15 Jun 2026 08:58:38 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.107.79])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 08:58:38 +0000 (GMT)
Date: Mon, 15 Jun 2026 14:28:31 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, harshpb@linux.ibm.com,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v4] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be
 used with KVM
Message-ID: <ai--tyVGpx5M2oRL@Gautams-MacBook-Pro.local>
References: <20260602121706.8423-1-gautam@linux.ibm.com>
 <o6ho8iyi.ritesh.list@gmail.com>
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
In-Reply-To: <o6ho8iyi.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2fbec6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ifxq_PvGPJpn4PbyUuYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX9CrYeIR5uS9r
 2bOcXyVFUvIMHHwlr1Y4ruKdtb8u2HPp8WRE1UW8qqvM/KGDtCMAbzlkQpeRLksLgXiGfSnvx4Z
 NcUwKY1L3sIQXMT4fMF7tnuVaoxnNd2iPUevklZBMGTZRDdVbSmgvhKuZ84M+4cfB6RcQ1+WDMR
 XKcr2eIIC1KPjntEy05UHRhWrL8wOvcnK+I9Grz7a3merCyIqQpHn25G3Ep5yoyRKBPKcl82UJx
 z44HU97vs/AXomzFhBZHVoX3/tRV2CQZMwp01hIt75s/Hk2fNV7JubHBEmOEbbGHj74HA34C7Vu
 dpRYPXm8/p+QnxxDkfvQVcSYAcAfwuBJinIPT8GP9iyoQJaYvdts2PIloEkoJ1sUlOf4cxRtsiW
 ncNYxBXluLVVXuigJTLhtDkNxVH4773bpihAGGadLHxLnzMR5xmrF4WrnEy6/eBkxT1GX69Br1l
 vW8WmUEYgKZBX1sgZwQ==
X-Proofpoint-GUID: sNKMapnCSoSOLkEDoHUk1LT-bffSjoTS
X-Proofpoint-ORIG-GUID: YqAwS9Iln65TzhCyMHAI0yCzSlS0oIgB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX17fkp/J1CLMI
 D2hOylExD0rHsYJJB6Lw2bGh7pUlVyYVSQ2YRr+N28xxI/cCOEoZ0Js8mxQfBBTeiesxXWOWbLx
 186gIZ1D/Pb7QWPTf9CFV+bacM2s59I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092

On Sat, Jun 06, 2026 at 08:37:49AM +0530, Ritesh Harjani wrote:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> > cannot be used for KVM guests at all, unless explicitly enabled on
> > host kernel.
> >
> > Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> > being used.
> >
> > Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
> 
> Not really a fix per-se. So we need not add this fixes tag.

Ack, will send a v5.

Thanks,
Gautam

