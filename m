Return-Path: <linuxppc-dev+bounces-23397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4599EC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grcKv05GYz2yqf;
	Thu, 02 Jul 2026 22:54:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782996016;
	cv=none; b=eaC/EeSwP/MiaSlTbTTEEY87ISq9bpP5eEFVwid5TDnXsnvlib9S4nhYAA9H3GyRarfjvW10jQmaGHxlrRI3GIGoMw/tHKO5eZ1OG247Q1EUAc8/dKlJhqnNuiTk9KIOvzunn3wV6Uys//UXZtKqhfCk/vFPqz4K2mW6kT90MjvFhPTh7bvsWKeEUDhGG1+XnN0Ue87O7d1xwWcbC2aL9tjX3xAYpucZ5emeblMyEWIUddbVmJlQ03yJLa6bHqG8Bp+AXoIaS7QgJLCFjtS5/w8+86ZRRVLn0aDSUeQuXFYLT88IZTnAkB0bnmBXudoS9zHQ/xVgXmfEK3Is2jXTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782996016; c=relaxed/relaxed;
	bh=hYveWjJ4hVAN65iKCtlqZBVIi/BG1r0MlKjEfqsoNak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un2119kuvu58q6QZcfv3Rw0iFN6GQX+SDMC9kvde/Y3Xk3H2hL8Af/3BsYz2DmFvu01DV9u9OWBuqaEMYm98lvtd0I0ErZCS5zizUFkrV0AVCSbADqbOgfFocppIJPkUit2UYu+3u8wRCN6o90G1kNG6dwBaAhNAVqxxvZUMbd7tAUHfkIWDJC2NZEZJUcXfipvm5GF+dyS5FtnkdW8xRuAnF9B8xwOEsloQZ7WQdhRS3C8aOXSuAHfs7ctRqbeJKR14c6R8pJvvBj4i/Bk66d29Q8P3ri1RD9pRx04tMAzzdTCGKXUwB/lAlTMrlOolNyLqSRxygh2A/7azAyKerQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rz/7Xvwa; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PfM77s5J; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ashok.raj@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rz/7Xvwa;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PfM77s5J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ashok.raj@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1372 seconds by postgrey-1.37 at boromir; Thu, 02 Jul 2026 22:40:14 AEST
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grc0t5Qtzz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:40:14 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629LI374117784
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2026 12:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hYveWjJ4hVAN65iKCtlqZBVI
	i/BG1r0MlKjEfqsoNak=; b=Rz/7XvwaNshea5Y4k2hhMHtM4e5Y9cM4D2R3cmPb
	FfmtptdugPGus/I/vyxnCV21VWya93TlCTd6l4ws7+T/oElFTci0J6zrlnY5ZTQg
	wltlTuDmuZ/Oeg+bhSn6SrP3yrUD3gD1wnBRFduhILtZjZ/Nq29ZvVyZBDHdgRjp
	BQtypZw/F2o1na2gGd76T9ZbeIt2qmXQOsp/HuAsy79cUmdzxkOTYMZdXUilR2WP
	USGkWo2xE4oEfHAJlxn7AAMKzrb9ufCUZQzn4Ne7YW0uiQN54GMUTrZbstixPmgX
	VuorAHNqKut7WKX7cjhJBpvYnBc4lVgMNgpW6LIR5Ozv7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgnbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 12:17:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894391f000so3505640a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994637; x=1783599437; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYveWjJ4hVAN65iKCtlqZBVIi/BG1r0MlKjEfqsoNak=;
        b=PfM77s5JRXdezI2H80Mq9h+UIF3cRz6frczyTfZCrRlPV3VYmOcRtNrkVGtW9qOU/r
         LJc3WPww30GEVOryhYMjAZjLuPDGTHNBd9XIa4JNL9Ypyt+bMA9zrcsdXnNLzumi57RW
         FRa4ka1gqR+BvooYCOreVPQqnO4PWENeTSwgN0eAvtoBdr5ozkGfebjdKacRlqIfSraW
         mx6LPYRqkd98+KX5T+GHHitbB0bpY+Xlg+OgE1/L3kas+dyi+wkgFmq6/ExZqwos6a/n
         MB7cjLjlTkKoxUXDv82eFuo0JlJiNKBck7SrM7z+QioRez8Y0HRZwdJNQdOSDRwC51Jv
         Aqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994637; x=1783599437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYveWjJ4hVAN65iKCtlqZBVIi/BG1r0MlKjEfqsoNak=;
        b=elLjJAQOviJJnJpPOtuvFeRaGYdy2WQ0yyN+m4v/CY6+roGOt+J3F80ZoN9OrHljyl
         EwHyE20OFcCLAwcdA2kKtSwOgLkoKmDHd/R0k+qvflPTchpQhJs5N6OCkAy1V99PJHEA
         dcba5bOOn/kUCPLUU69tX3nywKhDvDocy46EMU4ad5R39/ZRfTtOufNBy0Sq5nhkixEZ
         8pWxbbcdyiNwziV/sECFop7DhIYts75T8TerpLOwO6I89gpoEqZI9q6jkHbvQ3oNfxIZ
         1Ys6O+Ewi3y2sxUBOlV5CZuQdtMgjLlvzhgs040kCtvCmgJSmn1I5Nh4Eb9pDl25Hu2S
         MCzw==
X-Forwarded-Encrypted: i=1; AFNElJ+NMIqmAFZE7muKMfRHytYPsVsWuip4EI0huUwEbNTvTj7YOZSEBxYFdvVV9CcZ5HD2wPqSgqXU4uWKYQ8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnW3bOveBgWoOZm5lGLg0MKPzB4qMz4NQ0Kzkji5W26yZFQ7JT
	D1r/NbklWhEW/mHsEtEMg5IuPcuPBYKS39gTCMcezVqHrR82Lx7Y7qmcPRHr1iYlFy7vHyyFl02
	waOQuccA+adHYvED5tpBrdItaC+yLKoOoZ4NXpMVy/7CwdGba46HhlLXtWZ0A2AUV/ym6
X-Gm-Gg: AfdE7cn7VLDu67iDA96+0K7AvxreyB7HFRaG+LZBcs/bkXi8P5QMtZCphGnPignqhIz
	IM2aHZwyHB5EAjxt8z9ZpnktSZjE2Rj2RQXxeLWLKxaTmxCxXrI1XVfDyjDhfTX2guAZaPIJ0nc
	cVu37xCrqncU03rNxJfuU7alZVVko1dNCfMPEcc+RmDH72G/i7yB6HPq2X2dz5QAmsp2daRpOzK
	aF3ih88oscHum7UBcdKiMpRn6WtjIbCqdxyA2Rc6ZGdZaxWQgy4Mzb+KcQQcRLNT8kegJ8p95VI
	n0yLZ46OhtUI2QN2yp00HuBBg9qCvm1Zno3RQ4rigd6KFjpFHMrqh/hIsEUp9la1quV1GQkTe5w
	TuzafaO3G8i8Iv3Tf6xqcWl9FRqubOtr0MlPZ4WpvcsTYHXhSzuok8pNlru+p
X-Received: by 2002:a05:6a00:4488:b0:847:9c99:ea4f with SMTP id d2e1a72fcca58-847c510599emr5298469b3a.30.1782994637197;
        Thu, 02 Jul 2026 05:17:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:4488:b0:847:9c99:ea4f with SMTP id d2e1a72fcca58-847c510599emr5298433b3a.30.1782994636709;
        Thu, 02 Jul 2026 05:17:16 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9f4c67sm1282608b3a.59.2026.07.02.05.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:17:16 -0700 (PDT)
Date: Thu, 2 Jul 2026 05:17:13 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org,
        xueshuai@linux.alibaba.com, tongtiangen@huawei.com,
        james.morse@arm.com, robin.murphy@arm.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, ryabinin.a.a@gmail.com, glider@google.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
        naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v15 0/8] arm64: add ARCH_HAS_COPY_MC support
Message-ID: <akZWyYnAdnvlkZbi@hu-ashoraj-lv.qualcomm.com>
References: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
X-Proofpoint-ORIG-GUID: v8KX2jBtoRwaLqQLOypf2joVfh1N_ZIi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX5GgqgiHINvpK
 6S0THwRzbnpy8JUZKN2iTL/NBk+QUEpBNte2dgo9h6Vwkc7ZY4PAUNne3VFndlwbCUsy57FAhzk
 7hRD14tjQ6w99C7NzTEUVsGPRnuTw7I=
X-Proofpoint-GUID: v8KX2jBtoRwaLqQLOypf2joVfh1N_ZIi
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a4656cd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=efi387GsBp53Kk3SMt4A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX/kNDIrRvN+K5
 p49LYG7B5g/SLxB7CXJ4uPSKdtd5uF9RlQwRS61RKYub7WYAYlMCR60slYcISqriK5JhdItvPa+
 GH9BoRMhk5O75vou9YZ5ItO2F+OZphzsnLnRanfS7N5aUYvWAwaVX1ZnnLJTdhzD4EC5dgbY4it
 OHnNQnJ6kjFu+4jZDEWMJQ4oe7Z6aw6OtlCPLZi2uxqlyx8E6YsTKsYFIeFcXQcARpGvS3w3nBq
 5JA8qMYxgXWbuG+VK95h2Y+YwB/LFjNDBSfVlOvgWoc251nM+yY7PNwx8gQy7o+ueuqpAs0sKMf
 iwJNl6mTQ8EesMoLXSSm+FbXqs2gmgnzUcZ0KPJnKwtbvorxds7IWrgyXjcHN13IdZdDFqVzBUg
 wU7n7kfGHHPVE7PsrwiLedhO7q1avbrIcbxwyN1kqTQxXG1czYpWxIxs34XBcvMr/RjYEAjpQRf
 XxG2PVqnTd6ropjxgKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020128

On Thu, Jun 18, 2026 at 05:21:14PM +0800, Ruidong Tian wrote:
> This series continues Tong Tiangen's work on arm64 ARCH_HAS_COPY_MC
> support. We encounter the same problem, and from a forward-looking
> perspective, large-memory ARM machines will suffer more from this class
> of issues, which motivates us to push this feature upstream.
> 
> Problem
> =========
> With the increase of memory capacity and density, the probability of memory
> error also increases. The increasing size and density of server RAM in data
> centers and clouds have shown increased uncorrectable memory errors.
> 
> Currently, more and more scenarios that can tolerate memory errors, such as
> COW[1,2,8,9], KSM copy[3], coredump copy[4], khugepaged[5,6], uaccess copy[7],
> page migration[10,11], etc.
> 

Hi Ruidong,


just a minor editorial nit :-)

> [PATCH v15 0/8] arm64: add ARCH_HAS_COPY_MC support

the series has 9 patches, but Subject says 0/8.

Cheers,
Ashok

