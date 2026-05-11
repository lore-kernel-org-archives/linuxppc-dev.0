Return-Path: <linuxppc-dev+bounces-20694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA94CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 08:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDXhT2SY5z2xlh;
	Mon, 11 May 2026 18:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778487593;
	cv=none; b=atlGJGobjQGkJnUlSb0h6X7B22C1UyfNJtDyEWotSrmcAb7o9ElDHpUQQ/XTsTLv3mEqYM4KEEFBSEePSgmZBW1b1vxl6r0PZILWhRQPDV33AKfxdND23NH9hcWq3C1JWOWfutNw4oBef87p1k1OYUbjP4y3JGMN2E5hJOuw3CUlXqCF7umlAuRfIe2suZZbyr2MhhH6nqxOnnIoZmzOIVj/a0C/l3PnnaQKx4JxJT2KKpQuxlXR/CBU3H8VHPBLlu9rlX1483VUNsJsPenL2937Cxa66j9AdP1f+sWShHY4nL79kHzMPW9BXc3HgCDdfg3xwR4rUwEAR67b3yKRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778487593; c=relaxed/relaxed;
	bh=5skeTQrgKgaoUQFjMs+9nYQVMNnHu8e04zHpAr+imq4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjJBMuHWMhLH6wSr0a79IqL2/lnIUuu2xy75exxPhon9Wss3EHtH8Gdl6k/8E126d+LzHpulSuP5Ihp72r+9MdGWmarE383CDJc4QxRKixTrUfVwQP8/6wga14nnclbNWUa6JHIjOoCZW0S9EKaEaqJnzqypCGrqJwO9owlf2/4TtMV8aHf/QRD7ozk/F0A0wnPoBP4ViWiql80fI4rj0jCoVI7xXqJRzNZSz0gfkRliemo5xpHA13AXrzNeZy+GQJL2Rb7K2vkzBduerZGeHla2r/XzF3fix1E5M5ANWIeiSV2zUmtSd5wp+vBovXFUBgzIxgsLgMgS8iDRlo0zqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QV7nIJ5M; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QV7nIJ5M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDXhS2ZDhz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 18:19:51 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADG0J42940561;
	Mon, 11 May 2026 08:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5skeTQrgKgaoUQFjMs+9nYQVMNnHu8
	e04zHpAr+imq4=; b=QV7nIJ5MWNi7eRMw6gp8nPPjE7TkwP228qy4kJ8B+1QcEk
	3NYNFSCmjmrs4PKyA7zqCkpLXJ3XAHtMgrDv+Iv4aE3ZRGvijSle2L5bKx0mhBCK
	3ASb+NCnsFDK+61Qf7QHAbtqXjJgFvSf7PtnyFRiHZ4HULEXp8ommzUIQA0QP7aa
	xIQrL6FTX2yfBW1Noy2JqZMdP0MHSigxWHQfXxHp8FNKdhq59AwTtt4BYxFCnJfE
	cARAG6g6ZkGt2xoJ4xlxPm8SqPxHFu519XJgdJGQDmV/7xaPG0ogz77E/9CuOhhX
	ab0GhKxYUmvbw86uu3saOyiB+MKbY9vjv5kLGXMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqq917-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:19:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B89lQC003744;
	Mon, 11 May 2026 08:19:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q4gtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:19:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B8Jdac47317416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 08:19:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49AE920043;
	Mon, 11 May 2026 08:19:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACA0920040;
	Mon, 11 May 2026 08:19:37 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.41.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 08:19:37 +0000 (GMT)
Date: Mon, 11 May 2026 13:49:30 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
Message-ID: <agGREsKnaQQBB_ti@Gautams-MacBook-Pro.local>
References: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
 <20260507151014.fd9d5732-0f-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260507151014.fd9d5732-0f-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4OCBTYWx0ZWRfX1gpDTzM0r7d6
 f2LjosBx2SINSHDJkt3uzpuUt4Fc6cwujcOID0XkHvIOUfvdTpWMjKRT2IEV4lFTa0ZMyO+LIYp
 8Dg9h856yV9qBKrHoKj9cGa71fT6sjxnk8VEr9uRJDEZzbMPLCBWOS+C06t3K0vy4mEUE2kxoC+
 bkjzPAgRi+7NsO12JzOFZsvy/y79Nc5K8wBXSuNSMG8r3gZDro7yqZuJzh5iCLdqt/Gr+YAhGek
 vaD/cVHyCLLXdEVSoUaHlKoCdjJMG9UCN8zFws0JCaPuejxT8cBRULtsUXQox01tvZ4b6DjE+3K
 hMWkr9aV5x7HSWmxSEXK4avFCP+x0hBxxoFfmw+YUxA573rO1o7Lfn7HUThDJbFZ7byNNfksKk6
 TZrtFiYQVqV27sBIxyS8RfK3Adb9yjKI5MKPPRrMEtVu2VVtQk+QrmBidU/EmJeSvcFb7zSo/eY
 PeSjvQGBXYgnVTs/7Qg==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a01911e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=kE01fTQ8JUY0VEJNiJkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yL18fCqFpeXbY6sGqg3k971s9iYvblrW
X-Proofpoint-GUID: 4J2kyQk9TNTqw_BBeXKri3kOw5BC5krV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110088

On Thu, May 07, 2026 at 03:12:29PM +0530, Amit Machhiwal wrote:
> On 2026/04/28 02:15 PM, Gautam Menghani wrote:
> > From: Gautam Menghani <gautam@linux.ibm.com>
> > 
> > The macro kvm_trace_symbol_exit is used for providing the mappings
> > for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> > trap reason is displayed as string instead of a vector number when using
> > the kvm_guest_exit tracepoint.
> > 
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> > v2:
> > 1. Remove the trailing comma after last element
> > 
> >  arch/powerpc/kvm/trace_book3s.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> > index 9260ddbd557f..5d272c115331 100644
> > --- a/arch/powerpc/kvm/trace_book3s.h
> > +++ b/arch/powerpc/kvm/trace_book3s.h
> > @@ -28,6 +28,7 @@
> >  	{0xea0, "H_VIRT"}, \
> >  	{0xf00, "PERFMON"}, \
> >  	{0xf20, "ALTIVEC"}, \
> > -	{0xf40, "VSX"}
> > +	{0xf40, "VSX"}, \
> > +	{0xf80, "H_FAC_UNAVAIL"}
> 
> While we are at it, should we also consider adding 0xf60 for Facility
> Unavailable? Anyways, LGTM.

0xf60 is handled by OS when problem state tries to use a facility which
is not available. So we won't exit to host for this.

Thanks,
Gautam

