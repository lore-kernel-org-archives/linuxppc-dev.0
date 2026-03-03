Return-Path: <linuxppc-dev+bounces-17576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5BCEC1450
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 13:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQHHZ32qbz30Lw;
	Wed, 04 Mar 2026 00:50:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772545818;
	cv=none; b=O/0r9PbtFkR6jzBcO86eg5sQpc1PhWo/mZ58qykvYrLh2vRvO0xmdH2YPSiZUfH9fiWqyULwLogk6NH24gkFO2PYU4WERRw+BP6TMzLTbTdrSMMLpYxrFapND7MQjHEMu/OsdauouJrK34eTFuhxm3bTPn/g0MgPIlsowu5/dbT3Tbjx0F1UfMyuCZWt+G+jvkRYYd0B7uFzwExlrwkWzz/fQQX531fwvFnvrDUzQ4uNGC9a1/RcBlXseCyt3sr2EdpQQ2478QIpJnzh6s/rb+Xg9gwfVjr42XnVB90+kuKVjJB0oFWrAvSQPyMGcbU2gxl/xGht3El5TaLjcqfXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772545818; c=relaxed/relaxed;
	bh=Aqi1zJHEgCxD93XVPis4SJOY5QYTjxnzzWZE8TZunjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXRQWEStfCBWMRG80syz8MYFka97+HJffrc5a7koOsU+CBEi3XVk47uPt5JPCld/PA/tJWXb9sTH0WqkgaxWXXPYWrt5tAKAeUGMBvtl7r8pnTzXUFnJD4u2ZVwUShnlRmrh9YW+fKKgnh3DpHL1Z0XcZOQ8AbeHPrkX3AvGt8IKZIWvRK1uVO0stkWHFDrCVXWijFMd++bh7NKYdt7le4/Loa4LHlAOihNN0qxiLOU1SKWPj1x7yfAc4wOdObenb/d60JSGCCwdiz2rRrU8b7VNfh+FS+mf7qi4cz0jvhEGDRK1xsu714wXe0cfoDDKo/jvXYlPtHqhK8qTrh64QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hkv2aCae; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hkv2aCae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQHHY3ZMtz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 00:50:16 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622NYJMW1047037;
	Tue, 3 Mar 2026 13:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=Aqi1zJHEgCxD93XVPis4S
	JOY5QYTjxnzzWZE8TZunjU=; b=hkv2aCaeAy2ufry4ujbJ72bCpgGA86tRFf5om
	47bBg0BTmWZ+nayLCOAhP0PRnZEtVWHaQTpyDBU5mJEoTXSTpaKpaU8jmmSG3Sy7
	66MmaJ0sCSQ/awtgVds6x8UtGqXF4vPxmsaw3jmOg+aN/DsjcqP0OWbUM+3MYvNN
	cr1T3VYkBWP8rtJJMfN8gdk4nic1YpnPSDNqvtO5UFanCXsONtC2828gCc26qux2
	W1CRTezO86SqcROhA8pKbmB4K4HK3OMV6ApWgheiV+ea/3spQ8/TCc6AaIdJ52mp
	0LC3MBDtx2cpLac4Z0Q+XD9u+drfRVM1o7YWk8q0DLeIClHPQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmjxmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:49:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623AZ409010284;
	Tue, 3 Mar 2026 13:49:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k2e99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:49:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623DnmVl15663444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:49:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27E3A20049;
	Tue,  3 Mar 2026 13:49:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C41E20040;
	Tue,  3 Mar 2026 13:49:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.212.179])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Mar 2026 13:49:45 +0000 (GMT)
Date: Tue, 3 Mar 2026 19:19:43 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: Correct MSI allocation tracking
Message-ID: <aabh_084Q94oaiYl@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260302003948.1452016-1-namcao@linutronix.de>
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
In-Reply-To: <20260302003948.1452016-1-namcao@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEwOCBTYWx0ZWRfX59b61R1itBWJ
 Rxpso5b+0OJZungNvbhBV4onTYBMe+4qeDEDOqVVHAp/uwqAME2zKnU3AF1vETHjH1/4PlPVavf
 Ga3Bt2sAJ+ZMozpSk+8EeNl1iYLrXrYrau1kmPrFG+jfoWLdFPOVngxup3juBE3k4e6vRIiCzyX
 uT3e1ms3qwY+wZzFi/FcTkLP2Hagf3YdRx7AbCfvOSFbsRXujrgv1VGU0Yrqp1+SKaJaLPdB4j8
 K9d3gXSD14MTtevu/vbkn8iB1QXEoP85avh5AD6OtFDpH9HTvzJswOY1Nhde4ryUbq8L7rGaPE4
 Y1oLAKvKAHCrYi5kQjYYyJY6813rfjkg6slNYGtN7BoVWbyGeeYS+d3UMRBiN3ooSO0m75WLt1K
 jfGU5ExIgAfVat1R8f0BUP4ZspTx58K85w+H9QwIJnrRZzGgXv7kHxpByv0JoKHfLho9lxbdFMf
 vsU495rsqObAxSQGAvA==
X-Proofpoint-ORIG-GUID: wdaNAXr0V-udE02jb_k--k8s7YfGLu7h
X-Proofpoint-GUID: pqrVKaEsROHD71BvKXjX-paaCxtw4-LW
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a6e701 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LPlfM72s0PfGJSQ53tEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030108

On 2026-03-02 01:39:48 Mon, Nam Cao wrote:
> The per-device MSI allocation calculation in pseries_irq_domain_alloc()
> is clearly wrong. It can still happen to work when nr_irqs is 1.
> 
> Correct it.
> 
> Fixes: c0215e2d72de ("powerpc/pseries: Fix MSI-X allocation failure when quota is exceeded")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/powerpc/platforms/pseries/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 64ffc6476ad6..8285b9a29fbf 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -605,7 +605,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>  					      &pseries_msi_irq_chip, pseries_dev);
>  	}
>  
> -	pseries_dev->msi_used++;
> +	pseries_dev->msi_used += nr_irqs;

Yeah, msi_used was wronlgy incremented only once while allocating
nr_irqs interrupts from parent domain. Looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

>  	return 0;
>  
>  out:
> -- 
> 2.47.3
> 

-- 
Mahesh J Salgaonkar

