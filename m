Return-Path: <linuxppc-dev+bounces-23928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C10C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:15:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwsnj1dWnz3cJQ;
	Thu, 09 Jul 2026 21:15:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595721;
	cv=none; b=GcTb1gEKiYf9sBrn9rJFv7ZigKJYGMVEFjzYPqCQokHJVw1qFFJ0D5XXSW5lvXXYHBnlTb8NnrY+oNIgKPnfe3kILWZ+sY7OHnDK+bIRpVuQPwN9g2tHxmSfzvT7g8pK/VjEA+W0NVpawI8m9PBQtv7bjOLGyAMuP/DZa5S/Z/8+3u9aXSAIbT7k6PSg7N+v0XM7zWwlu9LmI1wfolYEcPq4dZOtDwOudqJadYHWZdBiCJpuuyuksrY7kwa5W5heRFCX0ENjhmKoL+gkcnZW+tz08t3GL+TgDnR7XUauCeoePblgX20Ok9OAGe6fUo42NJPXB76ou0zJJ19a/BVFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595721; c=relaxed/relaxed;
	bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7ViUYNAI6d03e1QA0Frgg9LLIuVn/zNbuEmHgu1+aud777yG/egF8C/tt0FooTyVRTup2Q7TOsemNGB3wf8QS/dyyfd9pNQ1gsP9swNAwbK8tVOy9skjKRAJbyCKNfJhGZ8ZYCk6rkUZf8lX7qf17w9OBmGuchVKLDlhLx3YJkPZ6bXacTEna1c4sLEI+Jfy6SdjTYHM5LFx2oP6r87vln2vUDIgshWus64lSjAh50tJIdc9xxSQZjx3YQPM8y6A+EkNxCDv0HZn/oNG5tY0QeUG4U5OFKeWFvKjbr+Jsv3rzcBMJFTsZltY6JII1y0mf8jMTjp56upnKRKYNI+QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QY+QAjG7; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YeHX22Cw; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QY+QAjG7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YeHX22Cw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsng67gMz3cJG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:15:19 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax8qS1434579
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=; b=QY+QAjG7JhI01DOL
	wrAWMBSfa2EsIJlZOBwNOpqR74GzzqMsWGKTL1nRLElce+kxLmPXGSEYyErRT9bs
	jrNUZ5qVhOMFlBS0g8+r8Lj5pkWx0HY2wr4Y4a6rA/soxkxGEv/GhwH6BfRMk7jC
	wxIkHw7CzIPD4C4hy06RY+nKd1hJsp9iQzkVAWdtTEM+7XcTYBvK6npbb6yBBaJ1
	CW4Qj8HEgGXE+RZq1+7fNu0Wd4ijs3A5FZcUaa9zPvqhQLDRRhC6VCASBWFqdB7d
	2iZ0nRAY5gwJd6YOiD4NmrqJffwjsCb4nFAr/D46CSDxbk0OC7RRzM/ZY22CoVf3
	XPhT6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftuwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:15:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07f25de2so15138151cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595716; x=1784200516; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
        b=YeHX22CwFeTjHkgFhTMkNO6WfUWrrr65GZhu+xaY7BnntSBaA2eR9ve/ZDKpI0fOoW
         WNUn5waTTo4vfgpHj79t1UM7jz49FBTrjf+uyHNAfyRxVD9gwAZa0KI3+HU2m+d8e5QY
         2erAklI8CPeh2y/KD66hqKvW4KYNesRiQBFAAB9wgbPtrOESt5Kj+Eyx4IFqCCZQcBeB
         I2mf75qK9iC8BtmLLjnz22/cmNBz7LYManQcQq6XL9AlMPXvFQVNmOOOFNh9ivmS08m/
         M7YPsfajcDkphw0qW0Pn/6XUgs+Ou8ePclY2vwKFmArTE0gO1qhDdJzQX6Hh0qwnFO0G
         mHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595716; x=1784200516;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
        b=bXty7lDF0hAXrDqvTUzrsAlst8gHi2m8UCFAlWWVOrWb+siNhi6WIr7GghzO1/p4m2
         YJZVvyYhZI0wjlj/78A8Kf9k0/dt31/Vg2MElMJQk2J7qPIYxLcjoqnB704rdoiqShki
         C+OcKGVIgUAtLaLaM6YgHG8foFEghahI5BjseAaMGlIq2zkU+LFNQj5SFU39oxzME6qK
         CaJhG7uMm7kg8Xvn2iA7wM8R0goHG3DTX2rgCsEqzsyP09grHAEgI2HkMuGqehRD8FT4
         wBmyFajo6BrCx3ERvkt4s5bVnzOmVZ8KLdvDVIk77TkK688qUoNTHDmU1DzcsJLjew3h
         pz4g==
X-Forwarded-Encrypted: i=1; AHgh+RoO4NeR0l9dYPnjFuN0YqnGQYwqK6XZQVvpit00kGREIo3zd6aRTRCAyVga2onQIo17G5/+yJHQCNzCLlE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4E6uUsE/It1e7au7ki+j5i1hM7UG8WijpmMo1C5oEvm/6dTcB
	dBzSyYAfliZsHT0mmMCX5T/Uhz5okH41ze0yzHpQWZG3+N6K0SjwI5aT30tPZEK3dW4Ke3F2CZQ
	enLT7dOILKs4Uk0YlhQhzwwyJhc02FMoS+vZrdY5OpvFEqKrquGnGTvNziUyJ84eZMl5a
X-Gm-Gg: AfdE7cm+8afuxaYrmVz9TWAB2Y5IN02+1hsv46amcYhf31J0/QyYLq3bxZjbzzAAfRF
	vCAIErK/KgYG0eK85U8N6YFW85XZvvnNT1otbUILvkijwoB+wxcrA/tB0Gi2+yHfukJ7ihGyzr4
	e+ov/Ql12Ex24caywZQwgo1USEE5SmCaJry8ubMsia+UcurTu09XDNlZmDjjN8m6nJXxbShOs1H
	cqPq6EiZiA44pv2cD3nxygD7PAd8HxPi3TGTQDbDiewkVfUZBTTDE1izSyK9EADL+bmA9kx404C
	no42ciTNBTUiA8MFJrb7MRW8VFmt7Fnf95Q8V81BrnH5eQnoigTwwViQ4E9uqOxzwDY5kZObk8Z
	VIpBNrODtCjlzs3okCGxYf2SWGqUhNGtGGdV1k7LT0GKV1sj+MDbQgvsPrDEiNw==
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr69627281cf.6.1783595716214;
        Thu, 09 Jul 2026 04:15:16 -0700 (PDT)
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr69626741cf.6.1783595715754;
        Thu, 09 Jul 2026 04:15:15 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm49838232f8f.14.2026.07.09.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:14 -0700 (PDT)
Message-ID: <954fe87d-9d43-4819-9f5a-eb0e5e5affea@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:11 +0200
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
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
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
 <20260707190253.816918647@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.816918647@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXwr9ktD5TElB1
 BmwUMIrUqTiO8mdUMmDA8DZJst7MMzb30opiaxZWetMTmrsLlq2b2mO3NdDmVmZiNBvmFOnXRZC
 EvS9hN066ijnD9XCykUV/uiJ2NrPxXHGH6LyCsD4D0XzggTvwDhOkenmQ2MIFYYn8D/i6sRN0UU
 1OCyiIwI1lX3GUdQc09hUCybIIh4hIril4dK+EgP949uXlKcrvCWjX7z/ICVxDGTKbTSHlE5zAz
 At/psrhN7/zKmt7mrjpq3SpCYeFLn1sHuzL5Ykfe1J8useXesva5rCI6FPQa40EmEwEbqP8azFC
 Yw3HpexOVgUaDvCmVLSHdtw/6LBTQQqNkscqB4jS+in/s82/rjuCPuvEdMYIB9kZOwCyHg/DN17
 ejmZMPPr/tAWSAHadcvqNpSeWkU35vKOXJTm9dhGjACAD6oCcT+yjurZ4Y3ZuOL16BDcuj8UTuC
 Xbx/JZNjQnDC77R4fpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX8/t+pww6Y5Mf
 zjnox0/6FzivAGdqtcLVDBts7d8NveEGe0kl5GaHJRv0JDs2YsuT9Z/vBiQFER1qsHV5LnEPQow
 YUPMlM8hsTVd4rbYMzk6iZ/zx/ldJR4=
X-Proofpoint-ORIG-GUID: KYpVwxfOoR0v1AkIe0XApPNfaq50MQ9A
X-Proofpoint-GUID: KYpVwxfOoR0v1AkIe0XApPNfaq50MQ9A
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f82c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vLKI4MkW7k7maJ7H7gsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
> 
> Provide two new macros to consolidate that:
> 
>    - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
> 
>    - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
>      
> to reduce boiler plate code.
> 
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |   56 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

