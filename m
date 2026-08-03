Return-Path: <linuxppc-dev+bounces-25225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23FDC5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 04:46:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD3zb6C2sz2yhP;
	Mon, 03 Aug 2026 14:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785732395;
	cv=none; b=PnXBHdyloIn0096d2cfufjm9ym2YeQ7RBzlfAJN3iv4Dt0P2n003tGRVsxVzGyu3wPZbysKcO/KPqm3capnto4Fz5ViHc03tFRIT7Ig6Jex+16d7XInl+XyLd6hfDBWBW5/i+cW0A56rBxgIJrQBjQ2qE3mi32mfwh9pbUg3FJaMMIBdF+4WgR9l/pdY5vwORweS6LidCYn9kbMNJNCTrF1k6FEbtheM59oR6xVVxBqbywFAoxAtOs1q1aSKkPDQ2q980G5wkkF5RdWwLpD8Movm/Ckpm7tzxuSspfoJpfltqjBrYUfZ1LbY2mu+mps0UNTIa+y5+Vxql5IVan298A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785732395; c=relaxed/relaxed;
	bh=VhfEadtNE/5absOGdEBhv7D47kRnlUqymRtnJWMmPLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqd8O0d9S7T3WZpeX/vCaTuHovRMlQ6avVxnm8bIguH0T3e+pPMp/yOoYgGND3tSfvjW5cfcq3A96ALXrc+QrvrLO4wdTnZJdRY9SAHWmFSTZA8pMbmLNEaDMRk1N5QtAyc2f+ZTEyRuu1J+5NnK53G7EM+n6gXmdRLaKJi4wSiyVSlbCpM1IZMbbjuDQqyW3g/cweKtX7eL5j/LCTZFTmUzcOIvqnYDurotle55U2OEV6HyJo0ZzO+82vSbYGm7n/xnNa4VkBiFUXE5a2WRC8yjmoX8oPi7SmrmJJHg2bbqmT3OO1EPCglD2IR5TRptVFT3HtAIK1/of5HfA3FTyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XHy/iesW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XHy/iesW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD3zb0rcbz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:46:34 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmpiL2566607
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 04:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=VhfEadtNE/5absOGdEBhv
	7D47kRnlUqymRtnJWMmPLk=; b=XHy/iesW989S38bNqyHKXESQxMc0HsVYuEw55
	cOEWU5dfTt+IxZma7D+1l35V9giX5OXirZte2ZbMiVMViwNL6VAfsCynwM5aNzke
	4nC3Ql8BE0lNWUyg8I88Ahex2b/k2o1KM/5+Cbhe3UnY9xVuNjyHIRNuXwpIMplk
	lBjR1CbVsN5QazIUgkp501Tb8GGYyfMEP2/EsoolbM0RRWxXT78QilNaprkWkT9J
	/ub7VTn8yRsBYO8zrcxLpTaJw/UjTgSQY0PnyHtuL6iTxws4FhgY9LG3ewKnGOVQ
	xR0y0Akav4ei+XvIRklirY+3C0XR3RwlIbHI9hunKMDnZdcQg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqetf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:46:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6734fTpn024370
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 04:46:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg3j37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:46:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6734kSXk53608888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 04:46:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CBE20043;
	Mon,  3 Aug 2026 04:46:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210A920040;
	Mon,  3 Aug 2026 04:46:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.27.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 04:46:26 +0000 (GMT)
Date: Mon, 3 Aug 2026 10:16:24 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/pseries: Limit PVR list to 16 entries for
 CAS negotiation
Message-ID: <anAc201oMWHrU2Ld@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-2-mahesh@linux.ibm.com>
 <181d7792-08f8-4cf2-9490-249de89a2428@linux.ibm.com>
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
In-Reply-To: <181d7792-08f8-4cf2-9490-249de89a2428@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s4CK8UTk58FgiLW8Td_3FS1TpUBPLlpy
X-Proofpoint-ORIG-GUID: s4CK8UTk58FgiLW8Td_3FS1TpUBPLlpy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAzNCBTYWx0ZWRfX/04O4mwVOdFr
 ETbFxiW2p3OfYRoBf0E3qeJo3PSWPMM8WfQAz/YERPqAdi+AwniZTiPq5hA+EfYjQ/czlhbnkiM
 M3fukcsx4TOXzMPJ/PfZGyG39MudyrE=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a701d28 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=yOO7L7IfpMSU1IEtoJIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAzNCBTYWx0ZWRfX+S1z6xzglogq
 i7TnzaLVgZ5X3Nq/PcCUm8dUUcE1JmD/C4aV8r/TYt6N2svwojePhnxgLZtBp0OMEdmhqkDQcCJ
 2rmQBYMs4+Xa6UdpO2fsdxymxGTPYk4S0gScYqtkwb1ZZpP6EcEzgCkDUZYBjAdGzWfF3UenKhu
 jcRVW1UjhzbjXq/7OuNisG7aIWUy9ymSoBu8EUrGWiSqdu0f7CkX/PyTAUdH0fvUpJbt35SiJ+I
 T3iEi6NHlmhB4OfjyWP4oNM9e0bxN2/0B/90aU25+40tpQUZFl/0Dezv0QE5LmUPFA7ilg3vMqL
 CTAH4sI76Y2krE0UDBNuRuPwmcI//VPmusr+igiR+MzP2E5aQPt5p6C7Vv/tt6JWOIf7VGw+Lht
 a218MJtvjBEUnEZsA0ACuzcsjchJNVjTpWWHLxGJ6d2wmuiemaoLsXrPAdna5jYfTh+dtj7VXgt
 d7LgeXIcdRtwWQrJhaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030034

On 2026-08-03 08:52:24 Mon, Nikhil Kumar Singh wrote:
> 
> 
> On 29/07/26 20:24, Mahesh Salgaonkar wrote:
> 
> > +	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > 16) &&
> > +	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
> > +		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - 16;
> 
> 
> 
> Hi Mahesh,
> 
> The literal 16 appears twice. Please define a named macro,
> e.g.: #define CAS_MAX_PVR_ENTRIES 16

Sure, will do. Thanks for your review.

Thanks,
-Mahesh.
> 
> Thanks,
> ~ Nikhil
> 

-- 
Mahesh J Salgaonkar

