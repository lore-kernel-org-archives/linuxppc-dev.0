Return-Path: <linuxppc-dev+bounces-21902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94588CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:22:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV9291gspz2xy3;
	Tue, 02 Jun 2026 22:22:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780402945;
	cv=none; b=HyGB8BiMTFWA9bPHDDecTm/YFERdQnKHo6kFiUe9h1h/p5cG34TPmCZ9bi3Z9tgToO4y1m66F15t9vSo2w8ZlVUNOKZSI+Z5l0DR4eRjXokwR+i2QYXGZUzCpXwkOXJIomeb/5AexqrgixC9jAZoH42i4K60BJxf12xbzOz3BjUjKvVgNZVqYK2oxSkEjm1U2dOdOWbKjjZqhPXvcwfWGGq5lMkITRHyCwSspW/HVNJfMMEk35ge50v07ad7kPOpQc+qnkcigVRrloJw2tV8kRxeLwOxgwheo9YJ++vFZAOBoViXMN2e7Rc/7omkq4minVXjmFUri4Gw1Jk4rzytYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780402945; c=relaxed/relaxed;
	bh=WvpItkIxk7O+KSLlxiz4ovif/KSLN+p/7G84lynS3r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4YCBpY8kOc0wkdxd3eYj66hijgqW86TNH7/FTHVucjweLyggGvm9zL6a9FukLPSV3gn25xaRkuIqbU7SmgAlHX+EzEJCpJRbMTrV8PoP86CNr9dDTsBIza36AfFHn1k2RrcQRm3ckD6sztG0KrRtx4KKztxdEy7sE0ZrR1f1aoZ3FFzGIpbxh2aDfF5NGQLr4mwIX5//2R4fr+JlcOwJgYB4m0Yuo/+r1egYjJfP9sjZuvFGNDSvPLgpj+V0hQoVZMtC6pr+RTLofuv6O2zlSFxIA/TDj9yGkqKO5D24dXu/Y1ugRrOPlxHyO5TjdC6RcxuKjZMmsPFjY8/oenDJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bAPvDEDR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bAPvDEDR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV92674S0z2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 22:22:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6526Omu82292567;
	Tue, 2 Jun 2026 12:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WvpItkIxk7O+KSLlxiz4ovif/KSLN+
	p/7G84lynS3r0=; b=bAPvDEDRzjsNC8ctlZP53zdyFTGgAmELukpaARgAQOQFH9
	jb0njRksh7SrrPFkYKU9mUAbASkHb4VzNCvQlqLrfOR+7ukf/5+0esNSvK+C1kgu
	NlbbO1LgOXub7Y4ubtDRYLC7VLX6rGoxK8mpCGBs/ctyqy2pAvSuR0dbm8UX7Ufs
	owsTUF76FWl65xHXIRqdvv2jJc0gw9AUs9TO18et1YSRW78pBqyQlwlmF2QJwtPY
	Z9k1en5SQf7y9yGWzEQDNltqerwAC+HVuAsIsbVqkPWK8vFkAmgUybfbFnqW1Ofm
	PK73kWHPrGcVaHvSkIl1CtFoxnPjoEpPIcNXZlcA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq5sn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:22:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C9AvU023497;
	Tue, 2 Jun 2026 12:22:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3690-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:22:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652CM7ir53412202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 12:22:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDE4E20043;
	Tue,  2 Jun 2026 12:22:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 741A620040;
	Tue,  2 Jun 2026 12:22:04 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 12:22:04 +0000 (GMT)
Date: Tue, 2 Jun 2026 17:51:58 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm exit
 reasons
Message-ID: <ah7K5vMDDiOPTn0V@mac.bl1-in.ibm.com>
References: <20260518125041.39286-1-gautam@linux.ibm.com>
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
In-Reply-To: <20260518125041.39286-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Tk7D4a_Htk6jOPGOgc8f3kj8fCqAmXI7
X-Proofpoint-GUID: ihViwG1SwYWkBn98Vbdzm9Y9lrnyJgSH
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1ecaf2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=HR90um4bXCwT2XOkuecA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX39orDy2nf3QN
 Ilzrpalc4r9Gux7s6SR3vAoESVYxaDaGr7eOdnzM08PonXnunpcCOjvcIC06so41Z3Ww1hA9kXs
 oogmu/IDSpU9bl3cCrxiUvUxhdDoYdIZWhx94LuOoE7AnWEKHIS56WqOBUroYFkrVieb4lpjxze
 D1kYNm2qKqLi/xiar9mjLodgJr+sHSxk750bXJaXY7sNXJw0nkEfE7SefEbgQJbVwATSeZOHpbe
 ApjiOAW++Y3wFXwzWdDlu/Udau6KpkmgFneXz6+h43njEanhaLjciAKV2yUvNop1yL/JI9KchXi
 g3kJ9ek7PDRL5ljG3uMGLe4glHvxs+VQfaoUhMWsABSItdkPQYm3EBNCmzu8bJKQSXVq0kcW/4c
 3AhDPtNauD9U6+pOMp4Q41u2xlzcJ7nCttmwKjXkDl1uYjKnY1pYVwm8GLLj3tAT44Y+GdUa+zS
 XKZJ1HoC1pFRQr/YRow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116

On Mon, May 18, 2026 at 06:20:38PM +0530, Gautam Menghani wrote:
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the exit trap vectors and their names. Add mappings for H_FAC_UNAVAIL
> and H_VIRT so that exit reasons are displayed as string instead of
> vector numbers when using perf kvm stat.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Update the patch title and description to remove dependency on
> another file trace_book3s.h
> 
>  tools/perf/util/kvm-stat-arch/book3s_hv_exits.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> index 2011376c7ab5..2688ca7d0399 100644
> --- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> +++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> @@ -26,8 +26,10 @@
>  	{0xe00, "H_DATA_STORAGE"}, \
>  	{0xe20, "H_INST_STORAGE"}, \
>  	{0xe40, "H_EMUL_ASSIST"}, \
> +	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}
>  
>  #endif
> -- 

Hi,

Please review this and let me known if any changes are needed.

Thanks

