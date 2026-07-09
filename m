Return-Path: <linuxppc-dev+bounces-23930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC31C44508
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:16:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwsq23dqTz3c6f;
	Thu, 09 Jul 2026 21:16:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595790;
	cv=none; b=WroF/HdbAh16FMtLGvc0gy/wSDM51DE6A2D4PuVeyXnrpsPtSWb1Tr+J4NrwhRwQM7A7MNZLicrm8pi+qC8IMn3ZrsdSt4ZMtx12+hpFTDYkA07o2m07SP82zKLwRVy4aAfKQJ0GTYJ8Bu1xSj83snyXohQ6r8XLCp/nKbYcFEhc01TD4TbAAPbQCLz11sJlvnXKQuMub4CkRfUQ7l/m3PxmXVCbkMwPKslaShVWSKywaStE1tajOUvBQbjWfvBB37fr2zjFzAxJfdIizOUQwCAiav5EYofPazRm1oYuaqv7q3wHpEalYsRBcZCyRG9AOdoFuDJ7SvKvxI9RblqilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595790; c=relaxed/relaxed;
	bh=lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozQVI6m2yj1Ed2dp5ORnpzcZM8UERONyNscOGZHAmoMrUpFw2awBsiaaRTuWr63Ts5Pxx7jVU2vrFFm0OlCFG6if7Mdts2woCbGIw0Exzusfy0KzgnlgG5Gj0/wBD4dwv564WhleZHunGIfV5IC6bU7tw9BIMT/NJFssKkQvjHYr9ID8o++WsJBLfucSdMfyAbQKar/VMhDgm0zZX+0l+6dzRnBGkZk9BAleCbobV57zzLuwUqOrNCneWci88f9YifKeYkB5b3pQdEU9bM414kTyHYHAsP9evSAit568y+wAuIZLor/U1zOuBHqZE4EuTxMSznmWuX534HgxT+zq3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i6Z+l6cz; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i5DHayfM; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i6Z+l6cz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i5DHayfM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsq14Yvxz3byT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:16:28 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxFc01521479
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=; b=i6Z+l6cz0ADxMir5
	PP7gquUEvOGqieG+lf85k6tqb18XN99Vb/XbQueU32Nh4DFYdvrk7j7dFspHsXdS
	Cy7w+CsZ/lI338HKy004q1RoAkSXUYbZGedzGtf6/R1/0ogaog7QiT/r0AH6uhhW
	EGub/EAkoHwsQwiSwXadb/oYPAyoLb8nSMPbvA5/LtqwV8trHzPhgOS4T3OKYTVp
	y5/p6PBjRcCgw7xpwdmKpUFT5d7kIO23k48hxSlZ8uRGHGGnWe45xji+gjzdUnc9
	Wyi3IdVy9kYk4bNta4UN3ybii4hmT7hogdBdgOfzXklVyIt2UwzF5HAMNiWsF/IF
	edCxbw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwbw0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:16:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f45dde7595so21944256d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595786; x=1784200586; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=;
        b=i5DHayfM8YoOLSWNQM4nujeIQI2dw/jqTYNhyZ6mVYnObJxksn5z8n6u0sd84TBXBc
         d8fHip0n05IUF6ujR7xay9AAbwE5pC59eW8tYBCIFEEgjgOScXqj2qeQu1KGiRQNXz1/
         mM1rBex32Km607aW9kpDg9lFSLzcLmHCqdPFq2W+sEIJV1wCIiB9I8lb5ADqu6SejcX8
         +C6jMGEOg17PgjCVYIff6ABzvjw7JWT/Ol/Uv0hfDTK7+9OFWixuu2GHj5OR94qWPYpF
         /gfoRhIWajhBf74XFAdHXOEFiHeerE9SV0ISC2lqTqBWO1b7GKxh9EJ+Q891EF/MAzMw
         igEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595786; x=1784200586;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=;
        b=Kk1HdMiXHaaOwtUjShJ7FdUFoMwrwGpR0nq5vDmdVrhT/EHEzPgO3YakBj7TTfdY+o
         DmFDNLES2LcCF+AjbQh9LFDIVVmy3u99Sr1zQZawj70ViwPGFSUxaNzf4pW00cjc1Vj/
         IZlZsBLYyj2iRA5lyaUdagy0tQc5Mm2Ye4BzIhDprjH8OyU1KM5gfVFAdIP0lj7RnM3Y
         NfRM44smYMKy7PrAUT2xFJGNR9iGuVT1y4Qxx3vp9c/e9YWF6miznpQz3/0xW31tQrhZ
         vJC7uuyKrV8Xud6r0kEuiGqFxVRj7X0jpgY4GwGBMVyBtZ6UpwNlgYcT5Lsnj+q3p4Mm
         KWXA==
X-Forwarded-Encrypted: i=1; AHgh+RoYq2SLtWQ00jnbKaWbL0JATqv3QGG8SyzMiIliHPeCcT2INNeiKMBa/5D4JDgcEqsPDb984JHglOwIX1c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMnFkpNBfAh1TwCe3j96MgRvCuq65XejVB7xgfqKbB1u725bys
	DeKj9Dim5s4fo7UIqaukmba4N8DxQYyMQ87FPRnZGQ0K6hNdBiRC50370+mGcCJGO509N1mhZvs
	8FafzuMcUI1E7eXzyxiVffCaSpkK64OmK/TT298q/py1VGkApH0dZM92cZ+PXfGbcBoqv
X-Gm-Gg: AfdE7ckToxBzxFIOG4YhKUUirqd1jelR4F0MdpiIWYvznMfEyp8p10LNRUtW9q8wSJ0
	Yv5HFbIibxGcmGp2z2Cs9nY7TDgLnuvtzL/QhcJUXnv4dON/j82Wh/DtvqT1PzFV7TLu3+P6xGg
	NecwtzcEhmm4SvrAdNTvnnnLAvHbch3Q1hE7Qya8N14GJ0ORIf5M3Eo0il3OoVvB6OjY12qMJxg
	XPI+Rrojhydyy5YTZPcpqVSpa6aPBCh5IGMajBY9tBXGm7A4RMzJk5vy6CMYrQqJKRUckB76OFc
	p0wqG7sMg4y6yMwTSG+H91CcroQcN3pa1gLStPw7j/Xe3E6A6k+JtGi1ylYzIwzaSqEcvbSY8Bs
	PodL43pdQrdO4KbqAotnpzsY88Z/gGEy3JijNdT9rfJlmIZ1+dh7fj3Dvij+RpQ==
X-Received: by 2002:ac8:5a94:0:b0:51c:22c5:daf4 with SMTP id d75a77b69052e-51c8b3033demr72818201cf.28.1783595785863;
        Thu, 09 Jul 2026 04:16:25 -0700 (PDT)
X-Received: by 2002:ac8:5a94:0:b0:51c:22c5:daf4 with SMTP id d75a77b69052e-51c8b3033demr72817641cf.28.1783595785396;
        Thu, 09 Jul 2026 04:16:25 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm54261424f8f.1.2026.07.09.04.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:16:24 -0700 (PDT)
Message-ID: <b45abac8-0e8a-4005-a050-a0d37e1c8e2a@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:16:21 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.918861529@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.918861529@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9hPNLleOgIJL
 +Jye5TUswg4RxuMUiJ9c9rB4XtqykutYgK95mScibfD2FSEVDn/yt/e/hDmB9Jb4HMAukWWmWTZ
 BUDK0nWci9JU+3Pn3k3tSfM8jbbRoqoZiTdsfUDLtaTFqwVEOudPHMIO7CgSzB0podmTB7RFuHU
 w9YWLEg+sXUEpUmI3oLPAKKdX1EziB6MRPCLjH6ubFJ6PMCfShhLZWbcz59JYJMKhlGmr6Ahi3E
 u6yFpYsOnKWrIM3BmrgRcP8pHCTbfnNsdTb6kTWzCOpvnJcmPMzcM74NngFDf1t47uQgPsnoiZm
 AASrl2sSfpOsuuzWUKzchcuu3CpOgUAcHCpDPt9OVNyqLb3tEZb+70N8e3mtzF1+dBzgGJodgMJ
 J2AJ7BcexsyIFnC+Y5wQNaZ5QR1Gz7edWHVdL6LQBkjhVb3t8nH2OlB8Io1GjIL2YZdOOydaimc
 pgNtxBMtTJ0BRKh8fjg==
X-Proofpoint-GUID: ja-cs_gQobDVsNqNosQI4TkkD7fU2sf2
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f830a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: ja-cs_gQobDVsNqNosQI4TkkD7fU2sf2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX7acrjAKNWcka
 HvzY44cKO8emTbrrYqFlZyeDGgxfxODd/a4Ts0+m+expfsxc9qsIhn0C+EddHzyumc7xKMa8QzK
 NDiZwWncrRHxbrtR3Jsd6Jfvhv6N0O8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/syscall.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


